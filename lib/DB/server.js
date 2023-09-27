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

app.get('/user', (req, res) => {
  const email = req.params.email;
  const query = 'SELECT * FROM users WHERE email = ?';

  db.get(query, [email], (err, row) => {
    if (err) {
      res.status(500).send('Server error');
      return;
    }

    if (!row) {
      res.status(404).send('User not found');
      return;
    }

    res.status(200).json(row);
  });
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

app.post('/insertData', (req, res) => {
  const { usId, taskName, taskDesc, percent, startDate, dueDate, priority, remind, status, category, labels, createDate, subtask } = req.body;

  const query = `
    INSERT INTO ToDoTasks (usId, taskName, taskDesc, percent, startDate, dueDate, priority, remind, status, category, labels, createDate, subtask)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

  db.run(query, [usId, taskName, taskDesc, percent, startDate, dueDate, priority, remind, status, category, labels, createDate, subtask], (err) => {
    if (err) {
      console.error('Error inserting data:', err);
      res.status(500).json({ error: 'Error inserting data' });
    } else {
      console.log('Data inserted successfully');
      res.status(200).json({ message: 'Data inserted successfully' });
    }
  });
});

app.get('/retrieveTasks', (req, res) => {
  const query = 'SELECT * FROM ToDoTasks';

  db.all(query, (err, rows) => {
    if (err) {
      console.error('Error retrieving data:', err);
      res.status(500).json({ error: 'Error retrieving data' });
    } else {
      console.log('Data retrieved successfully');
      res.status(200).json({ data: rows });
    }
  });
});

app.get('/Tasks', (req, res) => {
  db.all('SELECT * FROM ToDoTasks', (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});


app.post('/subtasks', (req, res) => {
  const { subtaskName, subtaskDescription, priority, isCompleted, taskId } = req.body;

  // Assuming you have a SQLite database connection named 'db'
  db.run('INSERT INTO Subtasks (subtaskName, subtaskDescription, priority, isCompleted, taskId) VALUES (?, ?, ?, ?, ?)',
    [subtaskName, subtaskDescription, priority, isCompleted, taskId],
    function (err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.json({ id: this.lastID });
    }
  );
});

// Read all items
app.get('/readsubtask', (req, res) => {
  db.all('SELECT * FROM subtasks', (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

app.put('/updateSubtask/:taskId', (req, res) => {
   const { taskId } = req.params;
   const { isSubtask } = req.body;
   console.log('Received subtask:', isSubtask);

   const updateQuery = `
     UPDATE Todotasks
     SET subtask = ?
     WHERE taskId = ?;
   `;

   db.run(updateQuery, [isSubtask, taskId], function(err) {
     if (err) {
       return res.status(500).json({ error: err.message });
     }
console.log(isSubtask);
     res.json({ message: 'Percentage updated successfully', isSubtask });
   });
 });

app.put('/updatePercentage/:taskId', (req, res) => {
   const { taskId } = req.params;
   const { newPercentage } = req.body;
   console.log('Received newPercentage:', newPercentage);

   const updateQuery = `
     UPDATE Todotasks
     SET percent = ?
     WHERE taskId = ?;
   `;

   db.run(updateQuery, [newPercentage, taskId], function(err) {
     if (err) {
       return res.status(500).json({ error: err.message });
     }
console.log(newPercentage);
     res.json({ message: 'Percentage updated successfully', newPercentage });
   });
 });

 app.put('/updateCompleted/:stId', (req, res) => {
    const { stId } = req.params;
    const { isdone } = req.body;
    console.log('Received:', isdone);

    const updateQuery = `
      UPDATE Subtasks
      SET isCompleted = ?
      WHERE stId = ?;
    `;

    db.run(updateQuery, [isdone, stId], function(err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
 console.log(isdone);
      res.json({ message: 'isCompleted updated successfully', isdone });
    });
  });
