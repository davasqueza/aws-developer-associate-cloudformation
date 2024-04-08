const express = require('express')
const app = express()
const port = process.env.PORT || 3000

app.enable('trust proxy')

app.get('/', (req, res) => {
    res.send(`Hello World! From ${req.ips}`)
})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})
