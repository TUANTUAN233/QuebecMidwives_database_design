
CONNECT TO cs421;


CREATE TABLE HealthcIns
(
  Hemail VARCHAR(50) NOT NULL,
  phonenum VARCHAR(30),
  website VARCHAR(50),
  name VARCHAR(50) NOT NULL,
  address VARCHAR(50),
  PRIMARY KEY (Hemail)
);

CREATE TABLE CommunityClinics
(
  Hemail VARCHAR(50) NOT NULL,
  PRIMARY KEY (Hemail),
  FOREIGN KEY (Hemail) REFERENCES HealthcIns(Hemail)
);

CREATE TABLE BirthingCenters
(
  Hemail VARCHAR(50) NOT NULL,
  PRIMARY KEY (Hemail),
  FOREIGN KEY (Hemail) REFERENCES HealthcIns(Hemail)
);

CREATE TABLE Midwives
(
  pracid INTEGER NOT NULL,
  name VARCHAR(50) NOT NULL,
  Memail VARCHAR(50),
  phonenum VARCHAR(30),
  Hemail VARCHAR(50) NOT NULL,
  PRIMARY KEY (pracid),
  FOREIGN KEY (Hemail) references HealthcIns(Hemail)

);

CREATE TABLE Mothers
(
  healthid INTEGER NOT NULL,
  phonenum VARCHAR(30) NOT NULL,
  address VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL,
  bdate DATE NOT NULL,
  bloodtype VARCHAR(3),----booldtype might not be known?
  email VARCHAR(50) NOT NULL,
  cprofession VARCHAR(50),
  PRIMARY KEY (healthid)
);

CREATE TABLE Fathers
(
  healthid INTEGER NOT NULL,
  phonenum VARCHAR(30) NOT NULL,
  address VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL,
  bdate DATE NOT NULL,
  bloodtype VARCHAR(3),
  email VARCHAR(50),
  cprofession VARCHAR(50) ,
  PRIMARY KEY (healthid)
);

CREATE TABLE Couples
(
  coupleid INTEGER NOT NULL,
  Mhealthid INTEGER NOT NULL,
  Fhealthid INTEGER,
  PRIMARY KEY (coupleid),
  FOREIGN KEY (Mhealthid) REFERENCES Mothers(healthid),
  FOREIGN KEY (Fhealthid) REFERENCES Fathers(healthid)
);

CREATE TABLE InfoSession
(
  infoid INTEGER NOT NULL,
  date DATE NOT NULL,
  time TIME NOT NULL,
  language VARCHAR(10) NOT NULL,
  pracid INTEGER NOT NULL,
  PRIMARY KEY (infoid),
  FOREIGN KEY (pracid) REFERENCES Midwives(pracid)
);

CREATE TABLE Registration
(
  infoid INTEGER NOT NULL,
  coupleid INTEGER NOT NULL,
  ifattended VARCHAR(1),
  PRIMARY KEY(infoid,coupleid),
  FOREIGN KEY (infoid) REFERENCES InfoSession(infoid),
  FOREIGN KEY (coupleid) REFERENCES Couples(coupleid)
);

CREATE TABLE Pregnancies
(
  coupleid INTEGER NOT NULL,
  nthnum INTEGER NOT NULL,
  expectedtimebirth DATE,
  numbabies INTEGER,
  finalduedate DATE,
  duedatebasedultrasound DATE,
  duedatebasedmenstrual DATE,
  ppracid INTEGER,
  bpracid INTEGER,
  Hemail VARCHAR(50),
  PRIMARY KEY (coupleid,nthnum),
  FOREIGN KEY (coupleid) REFERENCES Couples(coupleid),
  FOREIGN KEY (ppracid) REFERENCES Midwives(pracid),
  FOREIGN KEY (bpracid) REFERENCES Midwives(pracid),
  FOREIGN KEY (Hemail) REFERENCES BirthingCenters(Hemail)
);

CREATE TABLE Appointments
(
  appointid INTEGER NOT NULL,
  date DATE NOT NULL,
  time TIME NOT NULL,
  pracid INTEGER NOT NULL,
  nthnum INTEGER NOT NULL,
  coupleid INTEGER NOT NULL,
  PRIMARY KEY (appointid),
  FOREIGN KEY (pracid) REFERENCES Midwives(pracid),
  FOREIGN KEY (coupleid,nthnum) REFERENCES Pregnancies
);

CREATE TABLE Notes
(
  Ntime time NOT NULL,
  appointid INTEGER NOT NULL,
  PRIMARY KEY (appointid,Ntime),
  FOREIGN KEY (appointid) REFERENCES Appointments
);

CREATE TABLE Technicians
(
  id INTEGER NOT NULL,
  phonenum VARCHAR(30),
  name VARCHAR(50),
  PRIMARY KEY (id)
);

CREATE TABLE Tests
(
  testid INTEGER NOT NULL,
  type VARCHAR(50) NOT NULL,
  appointid INTEGER,
  datesampe DATE,
  datelab DATE,
  result VARCHAR(50),
  id INTEGER,
  PRIMARY KEY (testid),
  FOREIGN KEY (id) REFERENCES Technicians,
  FOREIGN KEY (appointid) REFERENCES Appointments
);

CREATE TABLE Babies
(
  babyid INTEGER NOT NULL,
  name VARCHAR(30),
  gender VARCHAR(1),
  datebirth DATE,
  bloodtype VARCHAR(3),
  coupleid INTEGER,
  nthnum INTEGER,
  Hemail VARCHAR(50),
  PRIMARY KEY (babyid),
  FOREIGN KEY (coupleid,nthnum) REFERENCES Pregnancies(coupleid,nthnum)

);






