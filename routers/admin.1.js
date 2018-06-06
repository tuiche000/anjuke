const express = require('express')
const config = require('../config')
const common = require('../libs/common')

let router = express.Router()

module.exports = router

// 进入所有的admin相关的页面之前，都要校验用户身份--如果没登陆过，滚去登陆(/admin/login)
// 所有的,除了“/admin/login”
router.use((req, res, next) => {
  session检测用户信息
  if(!req.session['admin_ID'] && req.url != '/login' ) {
    res.redirect('/admin/login')
  } else {
    next()
  }
  
})

// 展现login页面
router.get('/login', (req, res, next) => {
  console.log('get')
  res.render('login', {'error_msg': ''})
})
// 提交登陆请求
router.post('/login', (req, res, next) => {
  let { username, password } = req.body

  // 判断两次
  if(username === config.root_username) {
    if(common.md5(password) === config.root_password) {
      console.log('超级管理员已登陆')
      req.session['admin_ID'] = '1'
      res.redirect('/admin/')
    } else {
      console.log('超级管理员登陆失败')
      showError("用户名或密码有错")
    }
  } else {
    req.db.query(`SELECT * FROM admin_table WHERE username='${username}'`, (err, data) => {
      if(err) {
        console.log(err)
        showError("数据库出错，请稍后重试")
      } else if (data.length === 0) {
        showError("用户名或密码有错")
      } else {
        if(data[0].password == common.md5(password)) {
          req.session['admin_ID'] = data[0].ID
          console.log('普通管理员登陆成功')
          res.redirect('/admin/')
        } else {
          showError("用户名或密码有错")
        }
      }
    })
  }

  function showError(msg) {
    res.render('login', {'error_msg': msg})
  }

})

router.get('/', (req, res) => {
  res.redirect('/admin/house')
})

router.get('/house', (req, res) => {
  req.db.query(`SELECT ID,title,ave_price,tel FROM house_table`, (err, data) => {
    if(err) {
      res.sendStatus(500)
    } else {
      res.render('index', {data})
    }
  })
})
