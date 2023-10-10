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
        subtask INTEGER,
        FOREIGN KEY (usId) REFERENCES Users(uid)
    )`);

    db.run(`
    CREATE TABLE IF NOT EXISTS Comp_Mem (
    companyCode TEXT,
    uid TEXT,
    isHead TEXT,
    FOREIGN KEY (companyCode) REFERENCES Companies(companyCode),
    FOREIGN KEY (uid) REFERENCES Users(uid)
)
    `);

db.run(`
CREATE TABLE IF NOT EXISTS Companies (
    companyCode TEXT PRIMARY KEY,
    companyName TEXT,
    companyEmail TEXT,
    companyAddress TEXT,
    companyNumber TEXT,
    companyWebsite TEXT,
    companySocialIds TEXT,
    companyDescription TEXT,
    logo BLOB
)
`);

db.run(`
CREATE TABLE IF NOT EXISTS Project (
    projectId INTEGER PRIMARY KEY AUTOINCREMENT,
    compCode TEXT,
    name TEXT,
    description TEXT,
    creationDate TEXT,
    dueDate TEXT,
    priority TEXT,
    progress REAL,
    tags TEXT,
     FOREIGN KEY (compCode) REFERENCES Companies(companyCode)
)
`);

db.run(`
CREATE TABLE IF NOT EXISTS Proj_Mem (
    projectId INTEGER,
    uid TEXT,
    isHead TEXT,
    FOREIGN KEY (projectId) REFERENCES Project(projectId),
    FOREIGN KEY (uid) REFERENCES Users(uid)
)
`);

db.run(`CREATE TABLE IF NOT EXISTS Subtasks (
    stId INTEGER PRIMARY KEY AUTOINCREMENT,
    taskId INTEGER,
    subtaskName TEXT,
    subtaskDescription TEXT,
    priority TEXT,
    isCompleted TEXT,
    FOREIGN KEY(taskId) REFERENCES ToDoTasks(taskId)
)`);

db.run(`
  CREATE TABLE IF NOT EXISTS contacts (
    userId TEXT PRIMARY KEY,
    contname TEXT,
    phnnumber BIGINT,
    emailaddr TEXT,
    companyId INTEGER,
    tag TEXT,
    label TEXT,
    bday TEXT
  )
`);

db.run(
`    CREATE TABLE IF NOT EXISTS reminder (
         rid INTEGER PRIMARY KEY AUTOINCREMENT,
         uid TEXT,
         rname TEXT,
         rdesc TEXT,
         isevent TEXT,
         startdate TEXT,
         duedate TEXT,
         dorem TEXT,
         remtime TEXT,
         color TEXT
     )`
);

db.run(
`
CREATE TABLE IF NOT EXISTS notes (
    uid TEXT,
    nid INTEGER PRIMARY KEY AUTOINCREMENT,
    ntitle TEXT,
    ncontent TEXT,
    nbgcolor TEXT,
    ncreate TEXT,
    ncategory TEXT,
    nlabel TEXT,
    ispw TEXT,
    pw TEXT,
    ispinned TEXT
)
`);
db.run(`CREATE TABLE IF NOT EXISTS Messages (msgid INTEGER PRIMARY KEY AUTOINCREMENT, Pid INTEGER, Uid TEXT, Msg TEXT, isfile TEXT, timing TEXT)`);
db.run(`CREATE TABLE  IF NOT EXISTS AssTask (pid INTEGER,Assid INTEGER PRIMARY KEY AUTOINCREMENT, postedBy TEXT, Msg TEXT, Desc TEXT, Duedate TEXT, Priority TEXT, issubtask TEXT, isfile TEXT, timing TEXT)`);
db.run(`CREATE TABLE  IF NOT EXISTS Assmem (Assid INTEGER, Uid TEXT)`);
db.run(`CREATE TABLE IF NOT EXISTS Asssubtask (
                       Assid INTEGER,
                       subtask TEXT,
                       isCompleted TEXT)`);
db.run(
`
CREATE TABLE IF NOT EXISTS Notebook (
    uid TEXT,
    nbid INTEGER PRIMARY KEY AUTOINCREMENT,
    nbname TEXT,
    nbcategory TEXT,
    nblabel TEXT,
    nbcolor TEXT,
    nbcreate TEXT,
    pw TEXT,
    isimp TEXT
)
`);

db.run(
`
CREATE TABLE IF NOT EXISTS NotebookPage (
    npgid INTEGER PRIMARY KEY AUTOINCREMENT,
    nbid INTEGER,
    pgtitle TEXT,
    pgcontent TEXT,
    pgbgcolor TEXT,
    pgcreate TEXT,
    FOREIGN KEY (nbid) REFERENCES Notebook(nbid)
)
`
);

db.run(`CREATE TABLE  IF NOT EXISTS pscontact (
    cid INTEGER PRIMARY KEY AUTOINCREMENT,
    uid TEXT,
    fname TEXT,
    lname TEXT,
    phnnum TEXT,
    email TEXT,
    category TEXT,
    label TEXT
)`);

  console.log('All tables created successfully.');
  // Close the database connection
  db.close();
});
