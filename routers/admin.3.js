const express = require('express')
const config = require('../config')
const common = require('../libs/common')
const fs = require('fs')

let router = express.Router()

module.exports = router

// 进入所有的admin相关的页面之前，都要校验用户身份--如果没登陆过，滚去登陆(/admin/login)
// 所有的,除了“/admin/login”
router.use((req, res, next) => {

  // token检测用户信息
  if (!req.cookies['admin_token'] && req.path != '/login') {
    res.redirect(`/admin/login?ref=${req.url}`)
  } else {
    if (req.path == '/login') {
      next()
    } else {
      req.db.query(`SELECT * FROM admin_token_table WHERE ID='${req.cookies['admin_token']}'`, (err, data) => {
        if (err) {
          res.status(500)
        } else if (data.length == 0) {
          res.redirect(`/admin/login?ref=${req.url}`)
        } else {
          req.admin_ID = data[0]['admin_ID']
          next()
        }
      })
    }
  }

})

// 展现login页面
router.get('/login', (req, res, next) => {
  res.render('login', { 'error_msg': '', ref: req.query['ref'] || '' })
})
// 提交登陆请求
router.post('/login', (req, res, next) => {
  let { username, password } = req.body

  function setToken(id) {
    let ID = common.uuid()

    let oDate = new Date()
    oDate.setMinutes(oDate.getMinutes() + 20)

    let t = Math.floor(oDate.getTime() / 1000)

    req.db.query(`INSERT INTO admin_token_table (ID,admin_ID,expires) VALUES('${ID}', '${id}', ${t})`, err => {
      if (err) {
        res.sendStatus(500)
      } else {
        res.cookie('admin_token', ID)

        let ref = req.query['ref']
        if (!ref) {
          ref = ''
        }
        res.redirect(`/admin${ref}`)
      }
    })
  }

  // 判断两次
  if (username === config.root_username) {
    if (common.md5(password) === config.root_password) {
      setToken(1)
    } else {
      showError("用户名或密码有错")
    }
  } else {
    req.db.query(`SELECT * FROM admin_table WHERE username='${username}'`, (err, data) => {
      if (err) {
        showError("数据库出错，请稍后重试")
      } else if (data.length === 0) {
        showError("用户名或密码有错")
      } else {
        if (data[0].password == common.md5(password)) {
          setToken(data[0].ID)
        } else {
          showError("用户名或密码有错")
        }
      }
    })
  }

  function showError(msg) {
    res.render('login', { 'error_msg': msg, ref: req.query['ref'] || '' })
  }

})

router.get('/', (req, res) => {
  res.redirect('/admin/house')
})





// 获取
router.get('/house', (req, res) => {

  // 分页
  const size = 10;
  let page = req.query.page

  if (!page) {
    page = 1
  } else if (!/^[1-9]\d*$/.test(page)) {
    page = 1
  }

  let start = (page - 1) * size

  // 搜索
  let like_seg = '1=1';
  if (req.query.keyword) {
    let keys = req.query.keyword.split(/\s+/g);

    // ['a', '禾', ...] => ["'%a%'", "'%禾%'" ...]
    like_seg = keys.map(item => `title LIKE '%${item}%'`).join(' OR ');
  }


  // 1.获取数据
  req.db.query(`SELECT ID,title,ave_price,tel FROM house_table WHERE ${like_seg} LIMIT ${start}, ${size}`, (err, house_data) => {
    if (err) {
      res.sendStatus(500)
    } else {
      // 2.获取总数据量
      req.db.query(`SELECT COUNT(*) AS c FROM house_table WHERE ${like_seg}`, (err, data) => {
        if (err) {
          res.sendStatus(500);
        } else if (data.length == 0) {
          res.sendStatus(500);
        } else {
          res.render('index', {
            data: house_data,
            show_page_count: 9,
            cur_page: parseInt(page),
            page_count: Math.ceil(data[0].c / size),
            keyword: req.query.keyword
          })
        }
      })

    }
  })
})
// 添加 || 修改
router.post('/house', (req, res) => {

  req.body['sale_time'] = Math.floor(new Date(req.body['sale_time']).getTime() / 1000)
  req.body['submit_time'] = Math.floor(new Date(req.body['submit_time']).getTime() / 1000)

  if (req.body.is_mod == 'true') {

    const fields = ['title', 'sub_title', 'postion_main', 'postion_secound', 'ave_price', 'area_min', 'area_max', 'tel', 'sale_time', 'submit_time', 'building_type', 'property_types']

    let arr = []

    fields.forEach(key => {
      arr.push(`${key}='${req.body[key]}'`)
    })

    let sql = `UPDATE house_table SET ${arr.join(',')} WHERE ID='${req.body['old_id']}'`

    req.db.query(sql, err => {
      if (err) {
        console.log(err)
        res.sendStatus(500)
      } else {
        res.redirect('/admin/house')
      }
    })

  } else {
    // 时间

    let aImgPath = []
    let aImgRealPath = []

    for (let i = 0; i < req.files.length; i++) {
      switch (req.files[i].fieldname) {
        case 'main_img':
          req.body['main_img_path'] = req.files[i].filename
          req.body['main_img_real_path'] = req.files[i].path.replace(/\\/g, '\\\\')
          break;
        case 'img':
          aImgPath.push(req.files[i].filename)
          aImgRealPath.push(req.files[i].path.replace(/\\/g, '\\\\'))
          break;
        case 'property_img':
          req.body['property_img_paths'] = req.files[i].filename
          req.body['property_img_real_paths'] = req.files[i].path.replace(/\\/g, '\\\\')
          break;
      }
    }

    req.body['ID'] = common.uuid()
    req.body['admin_ID'] = req.admin_ID

    req.body['img_paths'] = aImgPath.join(',');
    req.body['img_real_paths'] = aImgRealPath.join(',');

    arrField = [];
    arrValue = [];
    for (let name in req.body) {
      arrField.push(name)
      arrValue.push(req.body[name])
    }

    let sql = `INSERT INTO house_table (${arrField.join(',')}) VALUES('${arrValue.join("','")}')`

    req.db.query(sql, err => {
      if (err) {
        res.sendStatus(500)
      } else {
        res.redirect('/admin/house')
      }
    })
  }

})

// 删除
router.get('/house/delete', (req, res) => {

  let ID = req.query['id']

  let aId = ID.split(',')

  let b_err = false
  aId.forEach(item => {
    if (!/^(\d|[a-f]){32}$/.test(item)) {
      b_err = true
    }
  })

  if (b_err) {
    res.sendStatus(400)
  } else {
    let id_index = 0
    _next()
    function _next() {
      let ID = aId[id_index++]

      // 1.删除关联图片
      req.db.query(`SELECT * FROM house_table WHERE ID='${ID}'`, (err, data) => {
        if (err) {
          res.sendStatus(500)
        } else if (data.length == 0) {
          res.status(404, 'no this data')
        } else {
          let arr = []


          data[0]['main_img_real_path'] && arr.push(data[0]['main_img_real_path']);
          if (data[0]['img_real_paths']) {
            data[0]['img_real_paths'].split(',').forEach(item => {
              arr.push(item)
            })
          }
          if (data[0]['property_img_real_paths']) {
            data[0]['property_img_real_paths'].split(',').forEach(item => {
              arr.push(item)
            })
          }

          function deleteFromDB() {
            // 删除文件完事
            // 2.删除数据本身
            req.db.query(`DELETE FROM house_table WHERE ID='${ID}'`, err => {
              if (err) {
                res.sendStatus(500)
              } else {
                if (id_index < aId.length) {
                  _next()
                } else {
                  res.redirect('/admin/house')
                }
              }
            })
          }

          if (arr.length > 0) {
            let i = 0

            next()
            function next() {
              fs.unlink(arr[i], err => {
                if (err) {
                  res.sendStatus(500)
                } else {
                  i++

                  if (i >= arr.length) {
                    deleteFromDB()
                  } else {
                    next()
                  }
                }
              })
            }
          } else {
            deleteFromDB()
          }



        }
      })

    }


  }


})

// 接口
router.get('/house/get_data', (req, res) => {
  let id = req.query.id;

  if (!id) {
    res.sendStatus(404);
  } else if (!/^[\da-f]{32}$/.test(id)) {
    res.sendStatus(400);
  } else {
    req.db.query(`SELECT * FROM house_table WHERE ID='${id}'`, (err, data) => {
      if (err) {
        res.sendStatus(500);
      } else if (data.length == 0) {
        res.sendStatus(404);
      } else {
        res.send(data[0])
      }
    })
  }

})
