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

db.run(`
    CREATE TABLE IF NOT EXISTS ToDoTasks (
        taskId INTEGER PRIMARY KEY AUTOINCREMENT,
        usId TEXT,
        taskName TEXT,
        taskDesc TEXT,
        percent DOUBLE,
        startDate TEXT,
        dueDate TEXT,
        priority TEXT,
        remind TEXT,
        status TEXT,
        category TEXT,
        labels TEXT,
        createDate TEXT,
        subtask TEXT,
        FOREIGN KEY (usId) REFERENCES Users(uid)
    )`);

    db.run(`
CREATE TABLE IF NOT EXISTS Comp_Mem (
    companyCode TEXT,
    uid TEXT,
    FOREIGN KEY (companyCode) REFERENCES Companies(companyCode),
    FOREIGN KEY (uid) REFERENCES Users(uid)
)
    `);

db.run(`
CREATE TABLE IF NOT EXISTS Companies (
    userId TEXT,
    companyCode TEXT PRIMARY KEY,
    companyName TEXT,
    companyEmail TEXT,
    companyAddress TEXT,
    companyNumber INTEGER,
    companyWebsite TEXT,
    companySocialIds TEXT,
    companyDescription TEXT,
    industry TEXT,
    founder TEXT,
    foundingYear INTEGER,
    services TEXT,
    logo BLOB,
    FOREIGN KEY (userId) REFERENCES Users (uid)
)
`);

db.run(`
CREATE TABLE IF NOT EXISTS Project (
    projectId INTEGER PRIMARY KEY AUTOINCREMENT,
    userId TEXT,
    projectHead TEXT,
    name TEXT,
    description TEXT,
    creationDate DATE,
    dueDate DATE,
    priority TEXT,
    status TEXT,
    progress REAL,
    tags TEXT,
    FOREIGN KEY (userId) REFERENCES Users(uid)
)
`);

db.run(`
CREATE TABLE IF NOT EXISTS Proj_Mem (
    projectId INTEGER,
    uid TEXT,
    FOREIGN KEY (projectId) REFERENCES Project(projectId),
    FOREIGN KEY (uid) REFERENCES Users(uid)
)
`);

db.run(`
CREATE TABLE IF NOT EXISTS Reminder (
    remId TEXT PRIMARY KEY,
    userId TEXT REFERENCES Users(uid),
    description TEXT,
    eventDate DATE,
    doRemind BOOLEAN,
    remindTime TEXT
)
`);

db.run(`CREATE TABLE IF NOT EXISTS Subtasks (
    taskId INTEGER,
    subtaskName TEXT,
    subtaskDescription TEXT,
    isCompleted TEXT,
    FOREIGN KEY(taskId) REFERENCES ToDoTasks(taskId)
)`);
  console.log('All tables created successfully.');

  // Close the database connection
  db.close();
});
