const express = require('express')

let router = express.Router()

module.exports = router

router.get('/', (req, res) => {
  res.send('bbb')
  res.end()
})