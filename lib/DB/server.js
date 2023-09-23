const express = require('express');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();

const app = express();
const port = 3000;

app.use(bodyParser.json());

const db = new sqlite3.Database('pileup.db');

// Create a new user
app.post('/users', (req, res) => {
  const { userId, name, email, phoneNumber, password, userType, uid } = req.body;

  const query =
    'INSERT INTO users (userId, name, email, phoneNumber, password, userType, uid) VALUES (?, ?, ?, ?, ?, ?, ?)';
  const values = [userId, name, email, phoneNumber, password, userType, uid];

  db.run(query, values, (err) => {
    if (err) {
      return res.status(500).send('Error creating user');
    }
    res.status(201).send('User created successfully');
  });
});


app.get('/User', (req, res) => {
  db.all('SELECT * FROM users', (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

app.post('/check-credentials', (req, res) => {
 const email = req.body.email;
 const password = req.body.password;

 db.get('SELECT * FROM users WHERE email = ?', [email], (err, row) => {
    if (err) {
      console.error(err.message);
      res.status(500).send('Server error');
    } else if (!row) {
      res.status(400).send('Email not registered');
    } else {
      const storedPassword = row.password; // Assuming you're storing plain text passwords
      if (password === storedPassword) {
        res.status(200).send('Credentials verified');
      } else {
        res.status(400).send('Incorrect password');
      }
    }
 });
});