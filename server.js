const express = require('express')
const bodyParse = require('body-parser')
const multer = require('multer')
const cookieParser = require('cookie-parser')
const cookieSession = require('cookie-session')
const consolidate = require('consolidate')
const mysql = require('mysql')
const config = require('./config')

// 搭建服务器
let server = express()
server.listen(config.port)

// 数据库
const db = mysql.createPool({
  host: config.mysql_host,
  user: config.mysql_user,
  password: config.mysql_password,
  port: config.mysql_port,
  database: config.mysql_dbname
})

server.use((req, res, next) => {
  req.db = db
  req.cwd = __dirname

  res.showError = function(code){
    res.status(code)
    switch(code){
      case 404:
        res.render('404');
        break;
      case 500:
        res.render('500');
        break;  
      default:
        res.send('error')
    }
  }

  next()
})

// 中间件
// 普通POST数据
server.use(bodyParse.urlencoded({extended: false}))
// 文件POST数据
let multerObj = multer({dest: './upload'})
server.use(multerObj.any())

// cookie
server.use(cookieParser(require('./serct/cookie_key')))
// session
server.use(cookieSession({
  keys: require('./serct/sess_key')
}))

// 模板
server.set('html', consolidate.ejs)
server.set('view engine', 'ejs')
server.set('views', './template')

// 处理请求
server.use('/admin/', require('./routers/admin'))
server.use('/', require('./routers/www'))

// 静态文件
server.use(express.static('./www/'))

server.use((req, res) => {
  res.showError(404)
})

