const express = require('express');

const app = express();

const port = process.env.PORT || 8080


app.use(express.static(__dirname + '/build'));

app.get('/', function(req, res) {
    res.sendFile('index.html');
});

app.listen(port, () => console.log('Listening on 8080!'));
