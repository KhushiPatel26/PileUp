const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('pileup.db');

db.serialize(() => {
  // Create the users table
  db.run(`CREATE TABLE IF NOT EXISTS users (
    userId INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT,
    phoneNumber TEXT,
    password TEXT,
    userType TEXT,
    profilePicture BLOB,
    uid TEXT
  )`);

  console.log('Users table created successfully.');

  // Close the database connection
  db.close();
});
