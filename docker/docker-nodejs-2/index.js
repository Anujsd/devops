const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');

const fs = require('fs').promises;
const exits = require('fs').existsSync;

const PORT = process.env.PORT | 8081;

const app = express();

app.use(express.static('public'));
app.use('/feedback', express.static('feedback'));
// to get body field in req
app.use(bodyParser.urlencoded({ extended: false }));

app.get('/', (req, res) => {
  const filePath = path.join(__dirname, 'pages', 'feedback.html');
  res.sendFile(filePath);
});

app.get('/exists', (req, res) => {
  const filePath = path.join(__dirname, 'pages', 'exits.html');
  res.sendFile(filePath);
});

app.post('/create', async (req, res) => {
  const title = req.body.title;
  const content = req.body.text;

  const newTitle = title.replaceAll(' ', '-');

  const tempFilePath = path.join(__dirname, 'temp', newTitle + '.txt');
  const finalFilePath = path.join(__dirname, 'feedback', newTitle + '.txt');

  await fs.writeFile(tempFilePath, content);

  const ext = exits(finalFilePath);

  if (ext) {
    res.redirect('/exists');
  } else {
    await fs.copyFile(tempFilePath, finalFilePath);
    await fs.unlink(tempFilePath);
    res.redirect('/');
  }
});

app.listen(PORT, () => {
  console.log(`Server listening on PORT: ${PORT}`);
});
