var express = require('express');
var app = express();

app.get('/', function (req, res) {
  if (Math.random() * 5 > 4) {
    return res.status(500).send()
  }
  res.status(200).send('Pong!');
});



app.listen(3000, function () {
  console.log('App listening on port 3000!');
});


