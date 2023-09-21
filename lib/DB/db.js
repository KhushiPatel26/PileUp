const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('database.db');

db.serialize(() => {
  db.run(`
    CREATE TABLE IF NOT EXISTS ToDoTask (
      usId INTEGER,
      taskId INTEGER,
      taskName TEXT,
      taskDesc TEXT,
      startDate TEXT,
      dueDate TEXT,
      priority TEXT,
      remind TEXT,
      status TEXT,
      category TEXT,
      labels TEXT,
      createDate TEXT
    )
  `);
    console.log("Tables Created");
});

module.exports = db;
