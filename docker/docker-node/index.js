const express = require('express');

const app = express();

const PORT = process.env.PORT || 8085;

app.get('/', (req, res) => {
  res.json({ message: 'message from NodeJS container' });
});

app.listen(PORT, () => {
  console.log(`Server Started on PORT: ${PORT}`);
});
