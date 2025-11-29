-- ============================================================
-- 📁 HEALTHCARE PROJECT — DATABASE SCHEMA
-- ============================================================
-- This file contains the full SQL structure (DDL) for:
--   • patients
--   • clinic
--   • visit
--   • visit_condition
--   • medical_condition
--   • voucher
--
-- ============================================================

-- ============================================================
-- 🧑‍⚕️ TABLE: patients
-- ============================================================
--

CREATE TABLE `patients` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(20) NOT NULL,
  `insurance` tinyint(1) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `uq_patients_phone` (`phone`),
  UNIQUE KEY `uq_patients_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ============================================================

-- ============================================================
-- 🏥 TABLE: clinic
-- ============================================================
--

CREATE TABLE `clinic` (
  `clinic_id` int NOT NULL,
  `clinic_name` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `address` varchar(150) NOT NULL,
  `city` varchar(80) NOT NULL,
  `state` varchar(10) NOT NULL,
  PRIMARY KEY (`clinic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ============================================================

-- ============================================================
-- 📝 TABLE: visit
-- ============================================================
--

CREATE TABLE `visit` (
  `visit_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `clinic_id` int NOT NULL,
  `visit_date` date NOT NULL,
  `total_bill` decimal(10,2) NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `amount_due` decimal(10,2) NOT NULL,
  `due_date` date NOT NULL,
  PRIMARY KEY (`visit_id`),
  KEY `idx_visit_patient` (`patient_id`),
  KEY `idx_visit_clinic` (`clinic_id`),
  CONSTRAINT `fk_visit_clinic` FOREIGN KEY (`clinic_id`) REFERENCES `clinic` (`clinic_id`),
  CONSTRAINT `fk_visit_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=701 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ============================================================

-- ============================================================
-- 🔗 TABLE: visit_condition
-- ============================================================
--

CREATE TABLE `visit_condition` (
  `visit_condition_id` char(6) NOT NULL,
  `visit_id` int NOT NULL,
  `condition_id` int NOT NULL,
  PRIMARY KEY (`visit_condition_id`),
  KEY `idx_vc_visit` (`visit_id`),
  KEY `idx_vc_condition` (`condition_id`),
  CONSTRAINT `fk_vc_condition` FOREIGN KEY (`condition_id`) REFERENCES `medical_condition` (`condition_id`),
  CONSTRAINT `fk_vc_visit` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ============================================================

-- ============================================================
-- 🏷️ TABLE: medical_condition
-- ============================================================
--

CREATE TABLE `medical_condition` (
  `condition_id` int NOT NULL AUTO_INCREMENT,
  `condition_name` varchar(100) NOT NULL,
  PRIMARY KEY (`condition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ============================================================




-- ============================================================
-- 🎟️ TABLE: voucher
-- ============================================================
--

CREATE TABLE `voucher` (
  `voucher_id` char(5) NOT NULL,
  `patient_id` int NOT NULL,
  `visit_id` int NOT NULL,
  `voucher_amount` decimal(10,2) NOT NULL,
  `voucher_date` date NOT NULL,
  `expiration_date` date NOT NULL,
  PRIMARY KEY (`voucher_id`),
  KEY `idx_voucher_patient` (`patient_id`),
  KEY `idx_voucher_visit` (`visit_id`),
  CONSTRAINT `fk_voucher_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `fk_voucher_visit` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ============================================================

-- END OF SCHEMA