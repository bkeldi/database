
CREATE TABLE `epidemiological_data` (
  `Data_ID` int NOT NULL,
  `Location_ID` int DEFAULT NULL,
  `Recorded_Date` date DEFAULT NULL,
  `Cases_Per_Thousand_People` int DEFAULT NULL,
  `Rainfall` int DEFAULT NULL,
  `Average_Temperature` decimal(5,2) DEFAULT NULL,
  `Update_Date` date DEFAULT NULL,
  `Added_By` int DEFAULT NULL,
  PRIMARY KEY (`Data_ID`),
  KEY `Location_ID` (`Location_ID`),
  CONSTRAINT `epidemiological_data_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `geographical_location` (`Location_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `facility_type` (
  `Facility_Type_ID` int NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Description` text,
  `Date_Added` date DEFAULT NULL,
  `Date_Updated` date DEFAULT NULL,
  PRIMARY KEY (`Facility_Type_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `geographical_location` (
  `Location_ID` int NOT NULL,
  `Village` varchar(100) DEFAULT NULL,
  `Parish` varchar(100) DEFAULT NULL,
  `Sub_County` varchar(100) DEFAULT NULL,
  `County` varchar(100) DEFAULT NULL,
  `Region` varchar(50) DEFAULT NULL,
  `Population` int DEFAULT NULL,
  `Coordinates` varchar(100) DEFAULT NULL,
  `Malaria_Risk_Level` varchar(50) DEFAULT NULL,
  `Health_Facilities_Count` int DEFAULT NULL,
  `ITN_Coverage` decimal(5,2) DEFAULT NULL,
  `Reported_Cases` int DEFAULT NULL,
  PRIMARY KEY (`Location_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `health_facility` (
  `Facility_ID` int NOT NULL,
  `Facility_Name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Location_ID` int DEFAULT NULL,
  `Facility_Type_ID` int DEFAULT NULL,
  `Capacity` int DEFAULT NULL,
  `Contact_Details` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Date_Added` date DEFAULT NULL,
  PRIMARY KEY (`Facility_ID`),
  KEY `Location_ID` (`Location_ID`),
  KEY `Facility_Type_ID` (`Facility_Type_ID`),
  CONSTRAINT `health_facility_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `geographical_location` (`Location_ID`),
  CONSTRAINT `health_facility_ibfk_2` FOREIGN KEY (`Facility_Type_ID`) REFERENCES `facility_type` (`Facility_Type_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `interventions` (
  `Intervention_ID` int NOT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Location_ID` int DEFAULT NULL,
  `Start_Date` date DEFAULT NULL,
  `End_Date` date DEFAULT NULL,
  `Outcome` varchar(50) DEFAULT NULL,
  `Date_Added` date DEFAULT NULL,
  `Update_Date` date DEFAULT NULL,
  PRIMARY KEY (`Intervention_ID`),
  KEY `Location_ID` (`Location_ID`),
  CONSTRAINT `interventions_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `geographical_location` (`Location_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `laboratory_tests` (
  `Test_ID` int NOT NULL,
  `Case_ID` int DEFAULT NULL,
  `Test_Type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Test_Result` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Test_Date` date DEFAULT NULL,
  `Technician_ID` int DEFAULT NULL,
  PRIMARY KEY (`Test_ID`),
  KEY `Case_ID` (`Case_ID`),
  CONSTRAINT `laboratory_tests_ibfk_1` FOREIGN KEY (`Case_ID`) REFERENCES `malaria_cases` (`Case_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `malaria_cases` (
  `Case_ID` int NOT NULL,
  `Patient_ID` int DEFAULT NULL,
  `Facility_ID` int DEFAULT NULL,
  `Date_of_Diagnosis` date DEFAULT NULL,
  `Type_of_Malaria` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Treatment_ID` int DEFAULT NULL,
  PRIMARY KEY (`Case_ID`),
  KEY `Patient_ID` (`Patient_ID`),
  KEY `Facility_ID` (`Facility_ID`),
  KEY `Treatment_ID` (`Treatment_ID`),
  CONSTRAINT `malaria_cases_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `patient_data` (`Patient_ID`),
  CONSTRAINT `malaria_cases_ibfk_2` FOREIGN KEY (`Facility_ID`) REFERENCES `health_facility` (`Facility_ID`),
  CONSTRAINT `malaria_cases_ibfk_3` FOREIGN KEY (`Treatment_ID`) REFERENCES `treatment` (`Treatment_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `malaria_type` (
  `Type_ID` int NOT NULL,
  `Type_Name` varchar(50) DEFAULT NULL,
  `Description` text,
  `Date_Added` date DEFAULT NULL,
  `Added_By` int DEFAULT NULL,
  `Update_Date` date DEFAULT NULL,
  PRIMARY KEY (`Type_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `patient_data` (
  `Patient_ID` int NOT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `Date_of_Birth` date DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Phone_Number` varchar(15) DEFAULT NULL,
  `Next_of_Kin` varchar(100) DEFAULT NULL,
  `Location_ID` int DEFAULT NULL,
  `Date_Added` date DEFAULT NULL,
  `Update_Date` date DEFAULT NULL,
  PRIMARY KEY (`Patient_ID`),
  KEY `Location_ID` (`Location_ID`),
  CONSTRAINT `patient_data_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `geographical_location` (`Location_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `patient_visits` (
  `Visit_ID` int NOT NULL,
  `Patient_ID` int DEFAULT NULL,
  `Facility_ID` int DEFAULT NULL,
  `Visit_Date` date DEFAULT NULL,
  PRIMARY KEY (`Visit_ID`),
  KEY `Patient_ID` (`Patient_ID`),
  KEY `Facility_ID` (`Facility_ID`),
  CONSTRAINT `patient_visits_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `patient_data` (`Patient_ID`),
  CONSTRAINT `patient_visits_ibfk_2` FOREIGN KEY (`Facility_ID`) REFERENCES `health_facility` (`Facility_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `referrals` (
  `Referral_ID` int NOT NULL,
  `User_ID` int DEFAULT NULL,
  `Referred_Facility_ID` int DEFAULT NULL,
  `Date_Referred` date DEFAULT NULL,
  `Date_Added` date DEFAULT NULL,
  PRIMARY KEY (`Referral_ID`),
  KEY `User_ID` (`User_ID`),
  KEY `Referred_Facility_ID` (`Referred_Facility_ID`),
  CONSTRAINT `referrals_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`),
  CONSTRAINT `referrals_ibfk_2` FOREIGN KEY (`Referred_Facility_ID`) REFERENCES `health_facility` (`Facility_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `resource` (
  `Resource_ID` int NOT NULL,
  `Facility_ID` int DEFAULT NULL,
  `Resource_Type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Date_Added` date DEFAULT NULL,
  PRIMARY KEY (`Resource_ID`),
  KEY `Facility_ID` (`Facility_ID`),
  CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`Facility_ID`) REFERENCES `health_facility` (`Facility_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `supply_chain` (
  `Supply_ID` int NOT NULL,
  `Resource_ID` int DEFAULT NULL,
  `Quantity_Shipped` int DEFAULT NULL,
  `Shipment_Date` date DEFAULT NULL,
  `Expected_Arrival_Date` date DEFAULT NULL,
  `Quantity_Received` int DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Update_Date` date DEFAULT NULL,
  PRIMARY KEY (`Supply_ID`),
  KEY `Resource_ID` (`Resource_ID`),
  CONSTRAINT `supply_chain_ibfk_1` FOREIGN KEY (`Resource_ID`) REFERENCES `resource` (`Resource_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `system_log` (
  `Log_ID` int NOT NULL,
  `User_ID` int DEFAULT NULL,
  `Activity` text COLLATE utf8mb4_general_ci,
  `Timestamp` datetime DEFAULT NULL,
  `IP_Address` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Location` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`Log_ID`),
  KEY `User_ID` (`User_ID`),
  CONSTRAINT `system_log_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `training` (
  `Training_ID` int NOT NULL,
  `User_ID` int DEFAULT NULL,
  `Training_Name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Training_Date` date DEFAULT NULL,
  `Completion_Status` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`Training_ID`),
  KEY `User_ID` (`User_ID`),
  CONSTRAINT `training_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `treatment` (
  `Treatment_ID` int NOT NULL,
  `Treatment_Name` varchar(50) DEFAULT NULL,
  `Treatment_Description` text,
  `Dosage` varchar(50) DEFAULT NULL,
  `Side_Effects` text,
  `Date_Added` date DEFAULT NULL,
  `Update_Date` date DEFAULT NULL,
  PRIMARY KEY (`Treatment_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `treatment_outcome` (
  `Outcome_ID` int NOT NULL,
  `Outcome_Name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Outcome_Description` text COLLATE utf8mb4_general_ci,
  `Date_Added` date DEFAULT NULL,
  `Update_Date` date DEFAULT NULL,
  PRIMARY KEY (`Outcome_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `treatment_outcomes` (
  `Outcome_ID` int NOT NULL,
  `Outcome_Name` varchar(50) DEFAULT NULL,
  `Outcome_Description` text,
  `Date_Added` date DEFAULT NULL,
  `Added_By` int DEFAULT NULL,
  `Update_Date` date DEFAULT NULL,
  PRIMARY KEY (`Outcome_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `User_ID` int NOT NULL,
  `First_Name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Last_Name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Role_ID` int DEFAULT NULL,
  `Password` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Facility_ID` int DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  KEY `Role_ID` (`Role_ID`),
  KEY `Facility_ID` (`Facility_ID`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`Role_ID`) REFERENCES `user_role` (`Role_ID`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`Facility_ID`) REFERENCES `health_facility` (`Facility_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `user_role` (
  `Role_ID` int NOT NULL,
  `Role_Name` varchar(50) DEFAULT NULL,
  `Role_Description` text,
  `Date_Added` date DEFAULT NULL,
  `Update_Date` date DEFAULT NULL,
  PRIMARY KEY (`Role_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `visit_record` (
  `Visit_ID` int NOT NULL,
  `Patient_ID` int DEFAULT NULL,
  `Visit_Date` date DEFAULT NULL,
  `Facility_ID` int DEFAULT NULL,
  PRIMARY KEY (`Visit_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;






















