const express = require('express');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();

const app = express();
app.use(bodyParser.json());

const db = new sqlite3.Database('pileup.db');

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT} (crud2.js)`);
});

//Create
app.post('/create', (req, res) => {
  const tableName = req.body.tableName;  // Replace with the actual table name
  const data = req.body.data;  // Replace with the actual data

  const keys = Object.keys(data);
  const values = Object.values(data);
  const placeholders = Array(keys.length).fill('?');
console.log('Keys:', keys);
console.log('Values:', values);
  const sql = `INSERT INTO ${tableName} (${keys.join(',')}) VALUES (${placeholders})`;

  db.run(sql, values, function (err) {
  console.log('SQL Query:', sql);

      if (err) {
        res.status(500).json({ error: err.message });
        console.error('Error in inserting:', err.message);
      } else {
        res.json({ message: `Record inserted with ID: ${this.lastID}` });
        console.log('Successfully inserted');
      }
    });
});

//Read
app.get('/read/:tableName', (req, res) => {
  const tableName = req.params.tableName;  // Replace with the actual table name

const sql=`SELECT * FROM ${tableName}`;
  db.all(sql, (err, rows) => {
  console.log('SQL Query:', sql);
    if (err) {
      res.status(500).json({ error: err.message });
      console.log('error in retreving');
    } else {
      res.json({ records: rows });
      console.log('successfully retriveed');
    }
  });
});

//Update
app.put('/update/:tableName/:id', (req, res) => {
  const tableName = req.params.tableName;  // Replace with the actual table name
  const id = req.params.id;  // Replace with the actual record ID
  const data = req.body.data;  // Replace with the actual data

  const keys = Object.keys(data);
  const values = Object.values(data);

  const updateQuery = keys.map((key) => `${key} = ?`).join(', ');

  const sql = `UPDATE ${tableName} SET ${updateQuery} WHERE id = ?`;

  db.run(sql, [...values, id], function (err) {
  console.log('SQL Query:', sql);
    if (err) {
      res.status(500).json({ error: err.message });
      console.log('error in updating');
    } else {
      res.json({ message: `Record updated: ${this.changes} row(s) affected` });
      console.log('successfully updated');
    }
  });
});

//Delete
app.delete('/delete/:tableName/:id', (req, res) => {
  const tableName = req.params.tableName;  // Replace with the actual table name
  const id = req.params.id;  // Replace with the actual record ID

  const sql = `DELETE FROM ${tableName} WHERE id = ?`;

  db.run(sql, id, function (err) {
  console.log('SQL Query:', sql);
    if (err) {
      res.status(500).json({ error: err.message });
      console.log('error in deleting');
    } else {
      res.json({ message: `Record deleted: ${this.changes} row(s) affected` });
      console.log('successfully deleted');
    }
  });
});
