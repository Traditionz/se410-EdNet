-- MySQL script to instantiate the SQL Database for EdNet
--
-- Host: localhost   Database: EdNet

-- -------------------------------------------------------

DROP TABLE IF EXISTS `modulematerialslink`;
DROP TABLE IF EXISTS `materials`;
DROP TABLE IF EXISTS `modulecategories`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `moduletypes`;
DROP TABLE IF EXISTS `types`;
DROP TABLE IF EXISTS `modulecomments`;
DROP TABLE IF EXISTS `moduleauthors`;
DROP TABLE IF EXISTS `otherresources`;
DROP TABLE IF EXISTS `seealso`;
DROP TABLE IF EXISTS `currentlogins`;
DROP TABLE IF EXISTS `modules`;
DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
	`UserID` int(11) NOT NULL AUTO_INCREMENT,
  	`FirstName` varchar(45) DEFAULT NULL,
  	`LastName` varchar(45) DEFAULT NULL,
  	`Email` varchar(45) DEFAULT NULL,
  	`Password` varchar(128) DEFAULT NULL,
  	`Type` enum("Viewer","SuperViewer","Submitter","Editor","Admin","Disabled","Deleted","Pending") DEFAULT "Viewer",
  	`Groups` enum("None", "Temp", "Student", "Teacher", "Professor", "Principal", "Dean", "President", "Admin") NOT NULL DEFAULT "Temp",
  	`Locked` enum("FALSE","TRUE") NOT NULL DEFAULT "FALSE",
  	PRIMARY KEY (`UserID`)
);

CREATE TABLE `modules` (
	`ModuleID` int(10) NOT NULL,
	`DateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Description` longtext NOT NULL,
	`Language` enum("chi", "eng", "fra", "ger", "hin", "ita", "jpn", "rus", "spa", "zxx") DEFAULT "eng", 
  	`EducationLevel` enum("Pre-Kindergarten", "Elementary School", "Middle School", "High School", "Higher Education", "Informal", "Vocational") DEFAULT "Higher Education",
  	`Minutes` int(10) DEFAULT NULL,
  	`AuthorComments` longtext,
  	`Status` enum("InProgress","PendingModeration","Active","Locked") NOT NULL DEFAULT "InProgress",
  	`MinimumUserType` enum("Unregistered","Viewer","SuperViewer","Submitter","Editor","Admin") NOT NULL DEFAULT "Viewer",
  	`BaseID` int(10) NOT NULL,
  	`Version` int(10) NOT NULL,
  	`SubmitterUserID` int(11) DEFAULT NULL,
  	`CheckInComments` longtext NOT NULL,
  	`Restrictions` enum("None", "Temp", "Student", "Teacher", "Professor", "Principal", "Dean", "President", "Admin") NOT NULL DEFAULT "Temp",
  	`Rating` double NOT NULL DEFAULT "0",
  	`NumRatings` int(10) NOT NULL DEFAULT "0",
  	PRIMARY KEY (`ModuleID`),
  	FOREIGN KEY (`SubmitterUserID`) REFERENCES `users` (`UserID`)
);

CREATE TABLE `materials` (
	`MaterialID` int(10) NOT NULL AUTO_INCREMENT,
  	`Name` varchar(45) DEFAULT NULL,
  	`Type` enum("LocalFile","ExternalURL") NOT NULL,
  	`Content` varchar(200) NOT NULL,
  	`File` varchar(50) NOT NULL,
  	`DateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	`Format` varchar(50),
  	`AccessFlag` int(10) NOT NULL DEFAULT "-1",
  	PRIMARY KEY (`MaterialID`)
);

CREATE TABLE `modulematerialslink` (
	`ModuleID` int(10) NOT NULL,
  	`MaterialID` int(10) NOT NULL,
  	`OrderID` int(10) NOT NULL,
  	PRIMARY KEY (`ModuleID`,`MaterialID`),
  	FOREIGN KEY (`ModuleID`) REFERENCES `modules` (`ModuleID`), 
  	FOREIGN KEY (`MaterialID`) REFERENCES `materials` (`MaterialID`)
);


CREATE TABLE `categories` (
	`CategoryID` int(10) NOT NULL AUTO_INCREMENT,
  	`Name` varchar(45) DEFAULT NULL,
  	`Description` varchar(150) DEFAULT NULL,
  	PRIMARY KEY (`CategoryID`)
);

CREATE TABLE `modulecategories` (
	`ModuleID` int(10) NOT NULL,
  	`CategoryID` int(10) NOT NULL,
  	FOREIGN KEY (`ModuleID`) REFERENCES `modules` (`ModuleID`),
  	FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`)
);

CREATE TABLE `types` (
	`TypeID` int(10) NOT NULL AUTO_INCREMENT,
  	`Name` varchar(45) NOT NULL,
  	PRIMARY KEY (`TypeID`)
);

CREATE TABLE `moduletypes` (
	`ModuleID` int(10) NOT NULL,
  	`TypeID` int(10) NOT NULL,
  	FOREIGN KEY (`ModuleID`) REFERENCES `modules` (`ModuleID`),
  	FOREIGN KEY (`TypeID`) REFERENCES `types` (`TypeID`)
);

CREATE TABLE `modulecomments` (
	`ModuleID` int(10) NOT NULL,
	`Comments` varchar(1000) NOT NULL,
  	`Subject` varchar(250) NOT NULL,
  	`Rating` int(10) NOT NULL,
  	`Author` varchar(50) NOT NULL,
  	FOREIGN KEY (`ModuleID`) REFERENCES `modules` (`ModuleID`)
);

CREATE TABLE `moduleauthors` (
	`ModuleID` int(10) NOT NULL,
	`AuthorName` varchar(50) NOT NULL,
	FOREIGN KEY (`ModuleID`) REFERENCES `modules` (`ModuleID`)
);

CREATE TABLE `otherresources` (
	`ModuleID` int(10) NOT NULL,
  	`Description` varchar(400) NOT NULL,
  	`ResourceLink` varchar(200) DEFAULT NULL,
  	`OrderID` int(10) NOT NULL,
  	PRIMARY KEY (`ModuleID`,`OrderID`),
  	FOREIGN KEY (`ModuleID`) REFERENCES `modules` (`ModuleID`)
);

CREATE TABLE `seealso` (
	`ModuleID` int(10) DEFAULT NULL,
	`seeModuleID` int(10) DEFAULT NULL,
  	`Description` varchar(200) DEFAULT NULL,
  	`OrderID` int(10) DEFAULT NULL,
  	FOREIGN KEY (`ModuleID`) REFERENCES `modules` (`ModuleID`)
);

CREATE TABLE `currentlogins` (
	`CurrentLoginID` int(11) NOT NULL AUTO_INCREMENT,
  	`UserID` int(11) DEFAULT NULL,
  	`AuthenticationToken` bigint(20) NOT NULL,
  	`Expires` datetime NOT NULL,
  	PRIMARY KEY (`CurrentLoginID`),
  	FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
);







