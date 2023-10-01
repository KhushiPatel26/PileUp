const express = require('express');
const sqlite3 = require('sqlite3');

const app = express();
const db = new sqlite3.Database('pileup.db');

app.use(express.json());

db.serialize(() => {
    db.run(
    `
      CREATE TABLE IF NOT EXISTS example3 (
        tid INTEGER PRIMARY KEY AUTOINCREMENT,
        tname TEXT,
        isCompleted TEXT DEFAULT 'false',
        subtask INTEGER DEFAULT 0
      )
    `
    );
console.log('All tables created successfully.');
});

// Create a record in a specific table
app.post('/create/:table', (req, res) => {
  const table = req.params.table;
  const data = req.body; // assuming the request body contains the data
  const columns = Object.keys(data).join(', ');
  const placeholders = Object.keys(data).map(() => '?').join(', ');

  db.run(`INSERT INTO ${table} (${columns}) VALUES (${placeholders})`,
    Object.values(data),
    function(err) {
      if (err) {
        return res.status(500).send(err.message);
      }
      res.json({ id: this.lastID });
    });
});

// Read all records from a specific table
app.get('/read/:table', (req, res) => {
  const table = req.params.table;
  db.all(`SELECT * FROM ${table}`, (err, rows) => {
    if (err) {
      return res.status(500).send(err.message);
    }
    res.json(rows);
  });
});

// Update a record in a specific table
app.put('/update/:table', (req, res) => {
  const table = req.params.table;
  const data = req.body.data;
const condition = req.body.condition;
  const updateQuery = Object.keys(data).map(key => `${key} = ?`).join(', ');
  const params = [...Object.values(data)];

  db.run(`UPDATE ${table} SET ${updateQuery} WHERE ${condition}`,
    params,
    function(err) {
      if (err) {
        return res.status(500).send(err.message);
      }
      res.json({ message: `Record updated in ${table}` });
    });
});

// Delete a record from a specific table with a dynamic WHERE condition
app.delete('/delete/:table', (req, res) => {
  const table = req.params.table;
  const condition = req.body.condition;

  db.run(`DELETE FROM ${table} WHERE ${condition}`, function(err) {
    if (err) {
      return res.status(500).send(err.message);
    }
    res.json({ message: `Records deleted from ${table}` });
  });
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running at http://192.168.133.43:${PORT}`);
});