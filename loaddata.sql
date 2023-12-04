
CONNECT TO cs421;



INSERT INTO HealthcIns(Hemail,  phonenum,  website,  name,  address) VALUES
('ComClincA@email',  '4389410001', 'www.clinicA.com', 'ClincA', 'Aroad')
,  ('ComClincB@email',  '4389410002', 'www.clinicB.com', 'ClincB', 'Broad')
,  ('ComClincC@email',  '4389410003', 'www.clinicC.com', 'ClincC', 'Croad')
,  ('ComClincD@email',  '4389410004', 'www.clinicD.com', 'ClincD', 'Droad')
,  ('ComClincE@email',  '4389410005', 'www.clinicE.com', 'ClincE', 'Eroad')
,  ('BCenter1@email',  '1389999', 'www.Bcenter1.com', 'BCenter1', '1road')
,  ('BCenter2@email',  '2389999', 'www.Bcenter2.com', 'BCenter2', '2road')
,  ('BCenter3@email',  '3389999', 'www.Bcenter3.com', 'BCenter3', '3road')
,  ('BCenter4@email',  '4389999', 'www.Bcenter4.com', 'BCenter4', '4road')
,  ('BCenter5@email',  '5389999', 'www.Bcenter5.com', 'Lac-Saint-Louis', '5road')
;

INSERT INTO CommunityClinics (Hemail) VALUES
('ComClincA@email')
,  ('ComClincB@email')
,  ('ComClincC@email')
,  ('ComClincD@email')
,  ('ComClincE@email')
;

INSERT INTO BirthingCenters (Hemail) VALUES
 ('BCenter1@email')
,  ('BCenter2@email')
,  ('BCenter3@email')
,  ('BCenter4@email')
,  ('BCenter5@email')
;

INSERT INTO Midwives(pracid, name, Memail, phonenum, Hemail) VALUES
(002, 'Marion Girard', 'MG@email', '88881', 'ComClincD@email')---Marion Girard
,  (001, 'J Girard', 'JG@email', '88882', 'ComClincA@email')
,  (003, 'Anna M', 'AM@email', '88883', 'BCenter5@email')
,  (004, 'Alex D', 'AD@email', '88884', 'BCenter5@email')
,  (005, 'Amy Tang', 'AT@email', '88885', 'BCenter1@email')
;

INSERT INTO Mothers(healthid, phonenum, address, name, bdate, bloodtype, email, cprofession) VALUES
(1001, '99991', 'SaintCath', 'Cathy Chen', '1980-08-08', 'A+', 'CCMother@email', 'Teacher')
, (1002, '99992', 'SaintMathe', 'Victoria Gutierrez', '1990-02-02', 'B-', 'VGMother@email', 'Sales')---Victoria Gutierrez
, (1003, '99993', 'Sherbroke', 'Cindy Yan', '1990-07-02', 'B+', 'CYmother@email', 'Teacher')
, (1004, '99994', 'Sherbroke', 'Alice Yu', '1996-07-07', 'A-', 'AYmother@email', NULL)
, (1005, '99995', 'Atwater', 'Helen Xu', '1996-07-19', 'B+', 'HXmother@email', NULL)
, (1011, '999911', 'Quebec', 'Annie Gu', '1996-07-23', 'O+', 'AGmother@email', 'Student')
;

INSERT INTO Fathers(healthid, phonenum, address, name, bdate, bloodtype, email, cprofession) VALUES
(1006, '99996', 'SaintCath', 'Tom Feng', '1990-06-08', 'O-', 'TFfather@email', 'Driver')
, (1007, '99997', 'Bishop', 'Tim Gutierrez', '1993-02-08', 'B-', 'TGfather@email', 'Chef')
, (1008, '99998', 'Du fort', 'Alex Norin', '1993-07-02', 'B+', 'AlexFather@email', 'Policeman')
, (1009, '99999', 'Sherbroke', 'Yuan Yu', '1996-07-07', 'B-', 'YYfather@email', 'Policeman')
, (1010, '999910', 'Mont-royal', 'Joseph D', '1996-07-19', 'B+', 'JDfather@email', 'Policeman')
;

INSERT INTO Couples(coupleid, Fhealthid, Mhealthid) VALUES
(0001, 1006, 1001)
, (0002, 1007, 1002)--VIctoria Gutierrez
, (0003, 1008, 1003)
, (0004, 1009, 1004)
, (0005, NULL, 1011)
;

INSERT INTO InfoSession(infoid, date, time, language, pracid) VALUES
(001, '2022-02-02', '14:00:00', 'French', 001)
, (002, '2022-01-08', '15:00:00', 'French', 003)
, (003, '2021-12-08', '15:00:00', 'English', 003)
, (004, '2022-02-08', '16:00:00', 'English', 005)
, (005, '2022-02-09', '16:00:00', 'English', 004)
;

INSERT INTO Registration(infoid, coupleid, ifattended) VALUES
(001, 0002, 'Y')
, (002, 0003, 'Y')
, (002, 0004, 'Y')
, (002, 0005, 'Y')
, (003, 0001, 'Y')
;

INSERT INTO Pregnancies(coupleid, nthnum, expectedtimebirth, numbabies, finalduedate, duedatebasedultrasound, duedatebasedmenstrual, ppracid, bpracid, Hemail) VALUES
(0001, 2, '2021-02-01', 1, '2021-02-07', '2021-02-08', '2021-02-07', 003, 001, NULL)
, (0002, 2, '2022-02-01', 1, '2022-02-07', '2022-02-08', '2022-02-07', 003, 001, NULL)---Victoria Gutierrez
, (0002, 1, '2019-02-01', 2, '2019-02-07', '2019-02-08', '2019-02-07', 002, 001, 'BCenter1@email')---2 babies--Marion Girard ---Victoria Gutierrez
, (0003, 1, '2019-07-01', 1, '2019-07-07', '2019-07-08', '2019-07-07', 004, 002, 'BCenter2@email')--Marion Girard
, (0004, 2, '2022-07-01', 2, '2022-07-07', '2022-07-08', '2022-07-07', 005, 002, 'BCenter3@email')---2 babies --Marion Girard
, (0003, 2, '2022-04-01', 2, '2022-04-07', '2022-04-08', '2022-04-07', 004, NULL, NULL)--2 babies
, (0005, 2, '2022-06-01', 2, '2022-06-07', '2022-06-08', '2022-06-07', 005, 002, NULL)--Marion Girard
;

INSERT INTO Appointments(appointid, date, time, pracid, coupleid, nthnum) VALUES
(2101, '2021-01-01', '18:00:00', 003,  0001, 2)
, (2102, '2022-03-21', '16:00:00', 002, 0004, 2)
, (2103, '2022-03-23', '17:00:00', 002, 0004, 2)
, (2104, '2022-03-24', '13:00:00', 002, 0005, 2)
, (2105, '2019-01-24', '13:00:00', 001, 0002, 1)---Victoria Gutierrez
, (2106, '2022-01-01', '14:00:00', 002, 0002, 2)---Victoria Gutierrez
;

INSERT INTO Notes(Ntime, appointid) VALUES
('18:07:00', 2101)
, ('16:07:00', 2102)
, ('16:30:00', 2102)
, ('16:30:00', 2104)
, ('16:30:00', 2105)
;

INSERT INTO Technicians(id, name, phonenum) VALUES
(8001, 'Smith Tech', '090909')
, (8002, 'Smith J', '082092')
, (8003, 'Smith H', '902738493')
, (8004, 'Smith I', '838349893')
, (8005, 'Smith F', '863492673894')
;

INSERT INTO Tests(testid, appointid, type, datesampe, datelab,result, id) VALUES
(3101, 2101, 'blood iron', '2021-01-01','2021-01-01', 'jiasdijaiw', 8001)
, (3102, 2106, 'blood iron', '2022-01-02', '2022-01-02','iahsihde', 8001)
, (3103, 2106, 'blood iron', '2022-01-04', '2022-01-04','result2', 8002)
, (3104, 2101, 'blood type', '2021-01-02','2021-01-02', 'jijaiw', 8003)
, (3105, 2101, 'ultrasound', '2021-01-02', '2021-01-02','jijaiw', 8004)
;



INSERT INTO Babies(babyid, coupleid, nthnum, name, gender, datebirth, bloodtype) VALUES
(8801, 0001, 2, 'Tommy', 'M', '2021-08-06', 'A-')
, (8802, 0002, 2, 'Evan', 'M', '2022-02-08', 'B+')
, (8803, 0002, 1, 'Emma', 'F', '2019-02-01', 'O+')
, (8804, 0002, 1, 'Eva', 'F', '2019-02-01', 'O+')
, (8805, 0003, 1, 'Tom', 'M', '2019-07-07', 'A+')
, (8806, 0004, 2, 'Aysa', 'M', NULL, NULL)
, (8807, 0004, 2, 'Alice', 'M', NULL, NULL)
, (8808, 0003, 2, 'Tory', 'M', NULL, NULL)
, (8809, 0003, 2, 'Tim', 'M', NULL, NULL)
, (8810, 0005, 2, 'Happer', 'M', NULL, NULL)
, (8811, 0005, 2, 'Henni', 'M', NULL, NULL)
;
