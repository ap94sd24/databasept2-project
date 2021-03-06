﻿-- Comments 
CREATE TABLE STUDENT(
    SSN INT NOT NULL,
    SID INT NOT NULL,
    STATUS VARCHAR(20) NOT NULL,
    FIRSTNAME VARCHAR(20) NOT NULL,
    MIDDLENAME VARCHAR(20),
    LASTNAME VARCHAR(20) NOT NULL,
    CONSTRAINT PK_SSN PRIMARY KEY(SSN)
);

CREATE TABLE DEPARTMENT (
	DEPTNAME VARCHAR(20) NOT NULL, 
	CONSTRAINT PK_DEPT PRIMARY KEY(DEPTNAME)
);

CREATE TABLE FACULTY(
    FNAME VARCHAR(50) NOT NULL,
    TITLE VARCHAR(20) NOT NULL,
    DEPTNAME VARCHAR(20) NOT NULL references DEPARTMENT(DEPTNAME),
    CONSTRAINT PK_FNAME PRIMARY KEY(FNAME)
);


CREATE TABLE DEGREE(
	DEGREE_ID INT not null,
	TOTAL_UNITS INT not null,
	DEGREE_NAME VARCHAR(256) not null,
	DEGREE_LVL VARCHAR(20) not null,
	CONCENTRATION_REQ VARCHAR(256),
	DEPTNAME VARCHAR(256) references department(deptname),
	CATEG_DEGREE_ID INT not null,
	CONSTRAINT PK_DEGREQ PRIMARY KEY (DEGREE_ID)
);

CREATE TABLE MAJOR (
	MAJOR_TITLE VARCHAR(20) NOT NULL, 
	DEPTNAME VARCHAR(20) NOT NULL references DEPARTMENT(DEPTNAME), 
	DEGREE_ID INT NOT NULL references DEGREE(DEGREE_ID), 
	CONSTRAINT PK_MAJOR PRIMARY KEY (MAJOR_TITLE)
); 


CREATE TABLE MINOR (
	MINOR_TITLE VARCHAR(20) NOT NULL, 
	DEPTNAME VARCHAR(20) NOT NULL references DEPARTMENT(DEPTNAME), 
	DEGREE_ID INT NOT NULL references DEGREE(DEGREE_ID),
	CONSTRAINT PK_MINOR PRIMARY KEY (MINOR_TITLE)
);

CREATE TABLE PREREQ_LIST(
    PREREQ_LIST_ID INT NOT NULL,
    CONSTRAINT PK_PLIST PRIMARY KEY(PREREQ_LIST_ID)
);

CREATE TABLE PREREQ_COURSES(
   PREREQ_LIST_ID INT NOT NULL references PREREQ_LIST(PREREQ_LIST_ID), 
   P_COURSES VARCHAR(20) NOT NULL
);


CREATE TABLE COURSES(
    COURSE_NO VARCHAR(20) NOT NULL,
    PREREQ_LIST_ID INT NOT NULL references PREREQ_LIST(PREREQ_LIST_ID),
    UNITS INT NOT NULL,
    TYPE VARCHAR(20) NOT NULL,
    GRADE_OPT VARCHAR(7),
    LAB_REQ BOOLEAN NOT NULL,
    CONSTRAINT PK_COURSE PRIMARY KEY(COURSE_NO)
);


CREATE TABLE CLASSES (
	COURSE_NO VARCHAR(256)  NOT NULL references COURSES(COURSE_NO), 
	TITLE VARCHAR(20) NOT NULL, 
	CONSTRAINT PK_STD4 PRIMARY KEY(TITLE)
);

CREATE TABLE POSSIBLE_CLASSES (
    POSSIBLE_CLASSES_ID INT not null,
    TITLE VARCHAR(256) NOT NULL references CLASSES(TITLE)
);


CREATE TABLE LABS (
	LAB_ID INT NOT NULL,
	LAB_DATE VARCHAR(20), 
	L_TIME_START TIME NOT NULL, 
	L_TIME_STOP TIME NOT NULL,
	L_ROOM VARCHAR(20) NOT NULL, 
	L_BUILDING VARCHAR(20) NOT NULL,
	L_CAPA INT NOT NULL,
	QUARTER VARCHAR(20) NOT NULL,
	YEAR INT NOT NULL,
	CONSTRAINT PK_LAB PRIMARY KEY(LAB_ID)
); 

CREATE TABLE REVIEW_SES(
	REV_ID INT NOT NULL, 
	R_DATE VARCHAR(20) NOT NULL,
	R_TIME_START TIME NOT NULL,
	R_TIME_END TIME NOT NULL,
	CONSTRAINT PK_REVSS PRIMARY KEY(REV_ID)
);

CREATE TABLE SECTION (
	SECT_ID INT NOT NULL,
	TITLE VARCHAR(256) NOT NULL references CLASSES(TITLE), 
	FNAME VARCHAR(50) NOT NULL references FACULTY(FNAME), 
	COURSE_NO VARCHAR(20) NOT NULL references COURSES(COURSE_NO),
	LECT_DATE_ID VARCHAR (20),
	DIS_DATE_ID VARCHAR (20),
	BUILDING VARCHAR(20) NULL, 
	ROOM VARCHAR(20)  NULL,
	MAXCAP INT NULL,
	LAB_ID INT references LABS(LAB_ID),
	LECT_TIME_START TIME NOT NULL, 
	LECT_TIME_END TIME NOT NULL, 
	DIS_TIME_START TIME NOT NULL, 
	DIS_TIME_END TIME NOT NULL, 
	REV_ID INT references REVIEW_SES(REV_ID),
	QUARTER VARCHAR(20) NOT NULL,
	YEAR INT NOT NULL,
	CONSTRAINT PK_STD2 PRIMARY KEY(SECT_ID)
); 


CREATE TABLE SECTION_STATUS (
	SECT_ID INT NOT NULL references SECTION(SECT_ID),
	SECTVAL INT NOT NULL, 
	WAITLISTED INT NOT NULL,  
	CONSTRAINT PK_ST PRIMARY KEY (SECT_ID,SECTVAL)
);

CREATE TABLE COURSECLASS (
	TITLE VARCHAR(256) NOT NULL references CLASSES(TITLE),
	COURSE_NO VARCHAR(20) NOT NULL references COURSES(COURSE_NO),
	CONSTRAINT PK_CC PRIMARY KEY (TITLE,COURSE_NO) 
);


CREATE TABLE PROBATION(
    SSN INT NOT NULL references STUDENT(SSN),
    START_QUARTER VARCHAR(6) NOT NULL, 
    START_YEAR INT NOT NULL, 
    END_QUARTER VARCHAR(6) NOT NULL, 
    END_YEAR INT NOT NULL, 
    REASON VARCHAR(256),
    CONSTRAINT PK_PROB PRIMARY KEY(SSN,START_QUARTER,START_YEAR)
);

 
CREATE TABLE thesis_committee(
	SSN int not null references STUDENT(SSN),
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
	SSN int not null references STUDENT(SSN), 
	FNAME VARCHAR(20) not null references FACULTY(FNAME), 
	CONSTRAINT PK_ADV PRIMARY KEY (SSN, FNAME)
);

CREATE TABLE RESEARCH (
	R_ID int not null,
	SUBJECTS VARCHAR(20) not null, 
	CONSTRAINT PK_RE PRIMARY KEY(R_ID)
);

CREATE TABLE PARTICIPATE (
	SSN int not null references STUDENT(SSN), 
	R_ID int not null references RESEARCH(R_ID), 
	CONSTRAINT PK_PART PRIMARY KEY (SSN, R_ID)
);

 
CREATE TABLE UNDERGRADUATES (
	SSN int not null references STUDENT(SSN), 
	COLLEGE VARCHAR(20) not null, 
	MAJOR_TITLE VARCHAR(20) not null references MAJOR(MAJOR_TITLE),
	MINOR_TITLE VARCHAR(20) references MINOR(MINOR_TITLE),
	CONSTRAINT PK_C PRIMARY KEY (SSN,COLLEGE)
);

CREATE TABLE GRADUATES (
	SSN int not null references STUDENT(SSN), 
	TYPE VARCHAR(20) not null, 
	CONCENTRATION VARCHAR(20) not null, 
	DEGREE_ID INT not null references DEGREE(DEGREE_ID), 
	CONSTRAINT PK_GRAD PRIMARY KEY (SSN, TYPE) 
);

CREATE TABLE REGISTER (
	SSN int not null references STUDENT(SSN), 
	SECT_ID int not null references SECTION(SECT_ID), 
	GRADE_OPT VARCHAR(7) NOT NULL,
	UNITS INT NOT NULL,
	CONSTRAINT PK_REG PRIMARY KEY (SSN, SECT_ID)
);

CREATE TABLE PREV_DEGREE (
	SSN int not null references STUDENT(SSN), 
	INSTITUTION VARCHAR(20) not null, 
	DEGREETYPE VARCHAR(20) not null,
	DEGREENAME VARCHAR(20) not null,
    CONSTRAINT PK_PREV PRIMARY KEY(INSTITUTION,DEGREETYPE, DEGREENAME)
);

CREATE TABLE PAST_STUDENT_ENROLLMENT(
    SSN INT NOT NULL references STUDENT(SSN),
    COURSE_NO VARCHAR(20) NOT NULL references COURSES(COURSE_NO),
    SECT_ID INT NOT NULL references SECTION(SECT_ID), 
    GRADE VARCHAR(2) NOT NULL, 
	QUARTER VARCHAR(10) not null, 
	YEAR INT not null,
	CONSTRAINT PK_PASTENROLL PRIMARY KEY(SSN, SECT_ID, QUARTER, YEAR)
);

CREATE TABLE CURR_STUDENT_ENROLLMENT(
    SSN int not null references STUDENT(SSN)
); 

CREATE TABLE CATEGORY_CLASSES(
    CATEG_CLASS_ID INT not null, 
    MIN_UNITS INT not null, 
    POSSIBLE_CLASSES_ID INT not null, 
    IS_CONCENT BOOLEAN not null,
    GPA_MIN numeric(3,1) not null,
    CONSTRAINT PK_CATEG_CLASSES PRIMARY KEY (CATEG_CLASS_ID)
);

CREATE TABLE CATEGORY_DEGREE(
    CATEG_DEGREE_ID INT not null, 
    CATEG_CLASS_ID INT not null references CATEGORY_CLASSES(CATEG_CLASS_ID),
    CONSTRAINT PK_CATEGDEG PRIMARY KEY (CATEG_DEGREE_ID)
);

CREATE TABLE PREV_CLASSES(
	TITLE VARCHAR(256) NOT NULL references CLASSES(TITLE),
	QUARTER VARCHAR(20) NOT NULL,
	YEAR VARCHAR(20) NOT NULL
);

 


 
