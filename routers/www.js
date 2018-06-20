const express = require('express')
const url = require('url')

let router = express.Router()

module.exports = router

router.get('/', (req, res) => {
  let {page} = req.query

  page  = parseInt(page)

  if(isNaN(page) || page < 1) {
    page  = 1
  }

  //
  let page_size  = 2
  let page_start = (page - 1) * page_size

  const sql = `SELECT ID,title,sub_title,postion_main,postion_secound,property_types,area_min,area_max,ave_price,main_img_path FROM house_table LIMIT ${page_start}, ${page_size}`
  req.db.query(sql, (err, res1) => {
    if(err) {
      res.showError(500)
    }else {
      //
      req.db.query(`SELECT COUNT(*) AS c FROM house_table`, (err, res2) => {
        if(err) {
          res.showError(500)
        } else {
          res.render('list', {
            list_data: res1,
            cur_page: page,
            page_count: Math.ceil(res2[0].c/page_size)
          })
        }
      })

    }
    
  })

})

router.get('/detail/:id', (req, res) => {
  let {id} = req.params

  const sql = `SELECT * FROM house_table WHERE ID='${id}'`
  req.db.query(sql, (err, data) => {
    if(err) {
      res.showError(500)
    } else {
      res.render('detail', {
        data: data[0]
      })
    }
  })
})

// 访问控制
router.get('/static_img/:img_path', (req, res) => {
  let {img_path} = req.params

  let obj = url.parse(req.headers['referer'])

  // 如果访问者是localhost：8080这个而服务器就让访问
  if(obj.host != 'localhost:8080') {
    res.res.showError(404);
  } else {
    res.sendFile(`${req.cwd}\\upload\\${img_path}`)
  }
})