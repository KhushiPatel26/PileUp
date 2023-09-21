const express = require('express');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();

const app = express();
const port = 3000;

app.use(bodyParser.json());

const db = new sqlite3.Database('pileup.db');

// Create a new user
app.post('/users', (req, res) => {
  const { userId, name, email, phoneNumber, password, userType } = req.body;

  const query =
    'INSERT INTO users (userId, name, email, phoneNumber, password, userType) VALUES (?, ?, ?, ?, ?, ?)';
  const values = [userId, name, email, phoneNumber, password, userType];

  db.run(query, values, (err) => {
    if (err) {
      return res.status(500).send('Error creating user');
    }
    res.status(201).send('User created successfully');
  });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
