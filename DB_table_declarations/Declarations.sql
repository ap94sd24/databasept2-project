﻿-- Comments 
CREATE TABLE STUDENT(
    SSN INT NOT NULL,
    SID INT NOT NULL,
    STATUS VARCHAR(20) NOT NULL,
    FIRSTNAME VARCHAR(20) NOT NULL,
    MIDDLENAME VARCHAR(20),
    LASTNAME VARCHAR(20) NOT NULL,
    CONSTRAINT PK_SSN UNIQUE(SSN),
    CONSTRAINT PK_SID PRIMARY KEY(SID)
);

CREATE TABLE DEPARTMENT (
	DEPTNAME VARCHAR(20) NOT NULL, 
	CONSTRAINT PK_DEPT PRIMARY KEY(DEPTNAME)
);

CREATE TABLE DEGREE(
	DEGREEID INT not null,
	TOTAL_UNITS INT not null,
	DEGREE_NAME VARCHAR(20) not null,
	DEGREE_LVL VARCHAR(20) not null,
	CONCENTRATION_REQ VARCHAR(20),
	DEPTNAME VARCHAR(20) references department(deptname),
	CATEG_LIST VARCHAR(20) not null,
	CONSTRAINT PK_DEGREQ PRIMARY KEY (DEGREEID)
);

CREATE TABLE MAJOR (
	SSN INT NOT NULL references STUDENT(SSN), 
	SID INT NOT NULL references STUDENT(SID),
	MTITLE VARCHAR(20) NOT NULL, 
	DEPTNAME VARCHAR(20) NOT NULL references DEPARTMENT(DEPTNAME), 
	DEGREEID INT NOT NULL references DEGREE(DEGREEID), 
	CONSTRAINT PK_MAJOR PRIMARY KEY (MTITLE)
); 


CREATE TABLE MINOR (
 	SSN INT NOT NULL references STUDENT(SSN), 
	SID INT NOT NULL references STUDENT(SID),
	TITLE VARCHAR(20) NOT NULL, 
	DEPTNAME VARCHAR(20) NOT NULL references DEPARTMENT(DEPTNAME), 
	DEGREEID INT NOT NULL references DEGREE(DEGREEID),
	CONSTRAINT PK_MINOR PRIMARY KEY (TITLE)
);

CREATE TABLE PREREQ(
	CID VARCHAR(20) NOT NULL, 
	PREREQID VARCHAR(20) NOT NULL, 
	CONSTRAINT PK_PREREQ PRIMARY KEY(PREREQID)
);

CREATE TABLE COURSES(
    CID VARCHAR(20) NOT NULL,
    PREREQID VARCHAR(20) NOT NULL references PREREQ(PREREQID),
    UNITS INT NOT NULL,
    TYPE VARCHAR(20) NOT NULL,
    GRADE VARCHAR(2),
    LAB_REQ BOOLEAN NOT NULL,
    CONSTRAINT PK_COURSE PRIMARY KEY(CID)
);


CREATE TABLE CLASSES (
	CID VARCHAR(20)  NOT NULL references COURSES(CID), 
	TITLE VARCHAR(20) NOT NULL, 
	QUARTER VARCHAR(20) NOT NULL, 
	YEAR INT NOT NULL, 
	CONSTRAINT PK_STD4 PRIMARY KEY(TITLE)
);

CREATE TABLE POSSIBLE_CLASSES (
    POSS_CLASSES_ID VARCHAR(20) not null,
    TITLE VARCHAR(20) NOT NULL references CLASSES(TITLE),
    CONSTRAINT PK_POSS PRIMARY KEY(POSS_CLASSES_ID)
);


CREATE TABLE LAB (
	LAB_ID VARCHAR(20) NOT NULL,
	l_DATE DATE NOT NULL, 
	l_TIME_START TIME NOT NULL, 
	l_TIME_STOP TIME NOT NULL,
	l_ROOM VARCHAR(20) NOT NULL, 
	l_BUILDING VARCHAR(20) NOT NULL,
	l_CAPA INT NOT NULL,
	CONSTRAINT PK_LAB PRIMARY KEY(LAB_ID)
); 

CREATE TABLE REVIEW_SES(
	REV_ID VARCHAR(20) NOT NULL, 
	SECTIONID INT NOT NULL,
	R_DATE_START DATE NOT NULL,
	R_DATE_END DATE NOT NULL,
	R_TIME_START TIME NOT NULL,
	R_TIME_END TIME NOT NULL,
	CONSTRAINT PK_REVSS PRIMARY KEY(REV_ID)
);
 
CREATE TABLE SECTION (
	SECTID INT NOT NULL,
	TITLE VARCHAR(20) NOT NULL references CLASSES(TITLE), 
	LECTDATE DATE NOT NULL, 
	DISCDATE DATE NOT NULL, 
	BUILDING VARCHAR(20) NULL, 
	ROOM VARCHAR(20)  NULL,
	MAXCAP INT NULL,
	LAB_ID VARCHAR(20) references LAB(LAB_ID),
	LEC_TIME_START TIME NOT NULL, 
	LECT_TIME_END TIME NOT NULL, 
	DIS_TIME_START TIME NOT NULL, 
	DIS_TIME_END TIME NOT NULL, 
	REV_ID VARCHAR(20) references REVIEW_SES(REV_ID),
	CONSTRAINT PK_STD2 PRIMARY KEY(SECTID)
); 


CREATE TABLE SECTIONSTATUS (
	SECTID INT NOT NULL references SECTION(SECTID),
	SECTVAL INT NOT NULL, 
	WAITLISTED INT NOT NULL,  
	CONSTRAINT PK_ST PRIMARY KEY (SECTID,SECTVAL)
);

CREATE TABLE COURSECLASS (
	TITLE VARCHAR(20) NOT NULL references CLASSES(TITLE),
	CID VARCHAR(20) NOT NULL references COURSES(CID),
	CONSTRAINT PK_CC PRIMARY KEY (TITLE,CID) 
);


CREATE TABLE PROBATION(
    SID INT NOT NULL references STUDENT(SID),
    START_QUARTER VARCHAR(6) NOT NULL, 
    START_YEAR INT NOT NULL, 
    END_QUARTER VARCHAR(6) NOT NULL, 
    END_YEAR INT NOT NULL, 
    REASON BOOLEAN NOT NULL,
    CONSTRAINT PK_PROB PRIMARY KEY(SID,START_QUARTER,START_YEAR)
);

 
CREATE TABLE thesis_committee(
	SID int not null references STUDENT(SID),
	TCID int not null, 
	p1 varchar(20) not null,
	p2 varchar(20) not null,
	p3 varchar(20) not null,
	p4 varchar(20), 
	CONSTRAINT PK_TCID PRIMARY KEY(TCID)
);


CREATE TABLE FACULTY(
    FNAME VARCHAR(20) NOT NULL,
    TITLE VARCHAR(20) NOT NULL,
    DEPTNAME VARCHAR(20) NOT NULL references DEPARTMENT(DEPTNAME),
    CONSTRAINT PK_FNAME PRIMARY KEY(FNAME)
);

CREATE TABLE ADVISES (
	SID int not null references STUDENT(SID), 
	FNAME VARCHAR(20) not null references FACULTY(FNAME), 
	CONSTRAINT PK_ADV PRIMARY KEY (SID, FNAME)
);

CREATE TABLE RESEARCH (
	R_ID int not null,
	SUBJECTS VARCHAR(20) not null, 
	CONSTRAINT PK_RE PRIMARY KEY(R_ID)
);

CREATE TABLE PARTICIPATE (
	SID int not null references STUDENT(SID), 
	R_ID int not null references RESEARCH(R_ID), 
	CONSTRAINT PK_PART PRIMARY KEY (SID, R_ID)
);

 
CREATE TABLE UNDERGRADUATES (
	SID int not null references STUDENT(SID), 
	COLLEGE VARCHAR(20) not null, 
	MTITLE VARCHAR(20) not null references MAJOR(MTITLE),
	TITLE VARCHAR(20) not null references MINOR(TITLE),
	CONSTRAINT PK_C PRIMARY KEY (SID,COLLEGE)
);

CREATE TABLE GRADUATES (
	SID int not null references STUDENT(SID), 
	TYPE VARCHAR(20) not null, 
	CONCENTRATION VARCHAR(20) not null, 
	DEGREEID INT not null references DEGREE(DEGREEID), 
	CONSTRAINT PK_GRAD PRIMARY KEY (SID, TYPE) 
);

CREATE TABLE REGISTER (
	SID int not null references STUDENT(SID), 
	SECTID int not null references SECTION(SECTID), 
	ATTENDANCE VARCHAR(20) not null, 
	PASTQUARTER VARCHAR(20) not null, 
	CONSTRAINT PK_REG PRIMARY KEY (SID, SECTID)
);

CREATE TABLE PREV_DEGREE (
	SID int not null references STUDENT(SID), 
	INSTITUTION VARCHAR(20) not null, 
	DEGREETYPE VARCHAR(20) not null,
	DEGREENAME VARCHAR(20) not null,
    CONSTRAINT PK_PREV PRIMARY KEY(INSTITUTION,DEGREETYPE, DEGREENAME)
);

CREATE TABLE PAST_STUDENT_ENROLLMENT(
    SID INT NOT NULL references STUDENT(SID),
    CID VARCHAR(20) NOT NULL references COURSES(CID),
    SECTID INT NOT NULL references SECTION(SECTID), 
    GRADE VARCHAR(2) NOT NULL, 
	QUARTER VARCHAR(10) not null, 
	YEAR INT not null,
	CONSTRAINT PK_PASTENROLL PRIMARY KEY(SID, CLASS_TKN_ID)
);

CREATE TABLE CURR_STUDENT_ENROLLMENT(
    SID int not null references STUDENT(SID),
    SECTID int not null references SECTION(SECTID),
    CONSTRAINT PK_CURR PRIMARY KEY (SID,SECTID)
); 

CREATE TABLE CATEGORY(
    CATEG_ID VARCHAR(20) not null, 
    MIN_UNITS INT not null, 
    POSSIBLE_CLASSESID VARCHAR(20) not null, 
    IS_CONCENT BOOLEAN not null, 
    GPA_MIN numeric(2,1) not null,
    CONSTRAINT PK_CATE PRIMARY KEY(CATEG_ID)
);

CREATE TABLE CATEGORY_LIST(
    CATEG_LIST VARCHAR(20) not null, 
    DEGREEID INT not null references DEGREE(DEGREEID),
    CATEG_ID VARCHAR(20) not null references CATEGORY(CATEG_ID),
    CONSTRAINT PK_LIST PRIMARY KEY (CATEG_LIST)
);

 


 
