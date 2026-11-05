-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2026 at 02:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `property_sales_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `agent`
--

CREATE TABLE `agent` (
  `agent_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `broker_id` int(11) NOT NULL,
  `commission_rate` decimal(5,2) NOT NULL,
  `license_no` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `agent`
--

INSERT INTO `agent` (`agent_id`, `user_id`, `broker_id`, `commission_rate`, `license_no`) VALUES
(1, 3, 1, 3.00, 'AGT-2024-0101'),
(2, 4, 1, 2.50, 'AGT-2024-0102');

-- --------------------------------------------------------

--
-- Table structure for table `agent_assignment`
--

CREATE TABLE `agent_assignment` (
  `assignment_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `assignment_date` datetime NOT NULL DEFAULT current_timestamp(),
  `end_date` datetime DEFAULT NULL,
  `active_buyer_id` int(11) GENERATED ALWAYS AS (case when `end_date` is null then `buyer_id` else NULL end) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `agent_assignment`
--

INSERT INTO `agent_assignment` (`assignment_id`, `agent_id`, `buyer_id`, `status_id`, `assignment_date`, `end_date`) VALUES
(1, 2, 1, 9, '2026-01-05 10:30:00', '2026-02-01 09:00:00'),
(2, 1, 1, 8, '2026-02-01 09:00:00', NULL),
(3, 1, 2, 8, '2026-02-20 10:00:00', NULL),
(4, 2, 3, 8, '2026-10-15 09:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `amenity`
--

CREATE TABLE `amenity` (
  `amenity_id` int(11) NOT NULL,
  `amenity_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `amenity`
--

INSERT INTO `amenity` (`amenity_id`, `amenity_name`, `description`) VALUES
(1, 'Clubhouse', 'Community clubhouse'),
(2, 'Swimming Pool', 'Shared pool'),
(3, 'Perimeter Fence', 'Fenced subdivision'),
(4, '24/7 Security', 'Guarded gate');

-- --------------------------------------------------------

--
-- Table structure for table `application`
--

CREATE TABLE `application` (
  `application_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `submission_date` datetime NOT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `application`
--

INSERT INTO `application` (`application_id`, `lead_id`, `agent_id`, `property_id`, `status_id`, `submission_date`, `notes`) VALUES
(1, 1, 1, 1, 20, '2026-02-25 09:00:00', 'Housing loan financing'),
(2, 2, 1, 2, 20, '2026-03-10 09:00:00', 'Full payment');

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointment_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `appointment_type_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `appointment_date` datetime NOT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointment_id`, `lead_id`, `agent_id`, `appointment_type_id`, `status_id`, `appointment_date`, `notes`) VALUES
(1, 1, 1, 1, 16, '2026-02-15 10:00:00', 'Viewed Villa A'),
(2, 2, 1, 1, 16, '2026-03-05 14:00:00', 'Viewed Villa B'),
(3, 3, 2, 1, 15, '2026-11-10 09:00:00', 'Scheduled viewing of Townhouse C');

-- --------------------------------------------------------

--
-- Table structure for table `appointment_type`
--

CREATE TABLE `appointment_type` (
  `appointment_type_id` int(11) NOT NULL,
  `type_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appointment_type`
--

INSERT INTO `appointment_type` (`appointment_type_id`, `type_name`, `description`) VALUES
(1, 'Site Viewing', 'On-site property viewing'),
(2, 'Office Meeting', 'Meeting at the association office'),
(3, 'Online Consultation', 'Video or phone consultation');

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `record_id` int(11) NOT NULL COMMENT 'polymorphic reference; not a direct FK',
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `log_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_log`
--

INSERT INTO `audit_log` (`log_id`, `user_id`, `action`, `table_name`, `record_id`, `old_value`, `new_value`, `log_date`) VALUES
(1, 1, 'INSERT', 'property', 1, NULL, '{\"property_name\":\"Evangelista Villa A\",\"price\":3500000.00}', '2026-01-15 09:00:00'),
(2, 1, 'UPDATE', 'property', 1, '{\"status_id\":4}', '{\"status_id\":5}', '2026-03-01 09:50:00'),
(3, 1, 'UPDATE', 'property', 2, '{\"status_id\":5}', '{\"status_id\":6}', '2026-04-20 11:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `barangay`
--

CREATE TABLE `barangay` (
  `barangay_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `barangay_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barangay`
--

INSERT INTO `barangay` (`barangay_id`, `city_id`, `barangay_name`) VALUES
(2, 1, 'Carmen'),
(3, 1, 'Kauswagan'),
(1, 1, 'Patag'),
(4, 2, 'Poblacion');

-- --------------------------------------------------------

--
-- Table structure for table `broker`
--

CREATE TABLE `broker` (
  `broker_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `license_no` varchar(50) NOT NULL,
  `company` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `broker`
--

INSERT INTO `broker` (`broker_id`, `user_id`, `license_no`, `company`) VALUES
(1, 2, 'BRK-2024-0001', 'Reyes Realty');

-- --------------------------------------------------------

--
-- Table structure for table `buyer`
--

CREATE TABLE `buyer` (
  `buyer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL COMMENT 'current assigned agent; NULL until first assignment'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `buyer`
--

INSERT INTO `buyer` (`buyer_id`, `user_id`, `location_id`, `agent_id`) VALUES
(1, 5, 4, 1),
(2, 6, 2, 1),
(3, 7, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `buyer_document`
--

CREATE TABLE `buyer_document` (
  `document_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `document_type_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `file_url` varchar(500) NOT NULL,
  `upload_date` datetime NOT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `buyer_document`
--

INSERT INTO `buyer_document` (`document_id`, `application_id`, `document_type_id`, `status_id`, `file_url`, `upload_date`, `notes`) VALUES
(1, 1, 1, 23, '/uploads/docs/app1/valid_id.pdf', '2026-02-26 10:00:00', NULL),
(2, 1, 2, 23, '/uploads/docs/app1/income.pdf', '2026-02-26 10:05:00', NULL),
(3, 2, 1, 23, '/uploads/docs/app2/valid_id.pdf', '2026-03-11 10:00:00', NULL),
(4, 2, 2, 22, '/uploads/docs/app2/income.pdf', '2026-03-11 10:05:00', 'Awaiting verification');

-- --------------------------------------------------------

--
-- Table structure for table `cash_receipt`
--

CREATE TABLE `cash_receipt` (
  `receipt_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `issued_by` int(11) NOT NULL,
  `receipt_number` varchar(50) NOT NULL,
  `issue_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_receipt`
--

INSERT INTO `cash_receipt` (`receipt_id`, `payment_id`, `issued_by`, `receipt_number`, `issue_date`) VALUES
(1, 1, 1, 'OR-2026-0001', '2026-03-01 09:45:00'),
(2, 3, 1, 'OR-2026-0002', '2026-03-10 09:45:00'),
(3, 2, 1, 'OR-2026-0003', '2026-04-08 09:15:00'),
(4, 4, 1, 'OR-2026-0004', '2026-04-23 09:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `city_id` int(11) NOT NULL,
  `province_id` int(11) NOT NULL,
  `city_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`city_id`, `province_id`, `city_name`) VALUES
(1, 1, 'Cagayan de Oro City'),
(2, 1, 'El Salvador City');

-- --------------------------------------------------------

--
-- Table structure for table `commission`
--

CREATE TABLE `commission` (
  `commission_id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `commission_rate` decimal(5,2) NOT NULL,
  `commission_amount` decimal(15,2) NOT NULL,
  `earned_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `commission`
--

INSERT INTO `commission` (`commission_id`, `sale_id`, `agent_id`, `status_id`, `commission_rate`, `commission_amount`, `earned_date`) VALUES
(1, 2, 1, 48, 3.00, 84000.00, '2026-04-23 09:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `document_type`
--

CREATE TABLE `document_type` (
  `document_type_id` int(11) NOT NULL,
  `document_type_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `document_type`
--

INSERT INTO `document_type` (`document_type_id`, `document_type_name`, `description`) VALUES
(1, 'Valid ID', 'Government-issued ID'),
(2, 'Proof of Income', 'Payslip or income tax return'),
(3, 'TIN', 'Tax identification document'),
(4, 'Proof of Billing', 'Recent utility bill');

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

CREATE TABLE `expense` (
  `expense_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  `expense_name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `expense_date` datetime NOT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `expense`
--

INSERT INTO `expense` (`expense_id`, `category_id`, `user_id`, `payment_method_id`, `expense_name`, `description`, `amount`, `expense_date`, `reference_no`, `created_date`) VALUES
(1, 3, 1, 1, 'Electricity Bill October 2026', 'Clubhouse and street lights', 12450.75, '2026-10-31 10:00:00', 'BILL-2026-10', '2026-11-04 21:09:01'),
(2, 2, 1, 1, 'Gate Repair Materials', 'Cement and fittings', 5300.00, '2026-10-15 09:00:00', 'PO-2026-002', '2026-11-04 21:09:01'),
(3, 1, 1, 2, 'Bond Paper Purchase', 'Office supply restock', 25000.00, '2026-10-01 09:00:00', 'PO-2026-001', '2026-11-04 21:09:01');

-- --------------------------------------------------------

--
-- Table structure for table `external_payment_allocation`
--

CREATE TABLE `external_payment_allocation` (
  `external_allocation_id` int(11) NOT NULL,
  `external_payment_id` int(11) NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `amount_allocated` decimal(15,2) NOT NULL,
  `allocation_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `external_payment_allocation`
--

INSERT INTO `external_payment_allocation` (`external_allocation_id`, `external_payment_id`, `schedule_id`, `amount_allocated`, `allocation_date`) VALUES
(1, 1, 1, 20875.40, '2026-05-06 14:05:00'),
(2, 2, 2, 20875.40, '2026-06-06 14:05:00');

-- --------------------------------------------------------

--
-- Table structure for table `external_payment_record`
--

CREATE TABLE `external_payment_record` (
  `external_payment_id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `recorded_by` int(11) NOT NULL COMMENT 'admin staff (user)',
  `status_id` int(11) NOT NULL COMMENT 'reported / verified / rejected',
  `institution_receipt_no` varchar(100) NOT NULL,
  `amount_reported` decimal(15,2) NOT NULL,
  `institution_payment_date` date NOT NULL,
  `receipt_received_at` datetime NOT NULL,
  `recorded_at` datetime NOT NULL DEFAULT current_timestamp(),
  `verified_at` datetime DEFAULT NULL,
  `receipt_file_url` varchar(500) DEFAULT NULL COMMENT 'optional scanned proof',
  `verification_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `external_payment_record`
--

INSERT INTO `external_payment_record` (`external_payment_id`, `loan_id`, `recorded_by`, `status_id`, `institution_receipt_no`, `amount_reported`, `institution_payment_date`, `receipt_received_at`, `recorded_at`, `verified_at`, `receipt_file_url`, `verification_notes`) VALUES
(1, 1, 1, 45, 'NHMFC-OR-000123', 20875.40, '2026-05-04', '2026-05-06 09:30:00', '2026-05-06 09:45:00', '2026-05-06 14:00:00', '/uploads/external/nhmfc-or-000123.jpg', 'Matches lender statement'),
(2, 1, 1, 45, 'NHMFC-OR-000187', 20875.40, '2026-06-04', '2026-06-06 09:30:00', '2026-06-06 09:45:00', '2026-06-06 14:00:00', '/uploads/external/nhmfc-or-000187.jpg', 'Matches lender statement'),
(3, 1, 1, 44, 'NHMFC-OR-000301', 21292.91, '2026-08-12', '2026-08-13 10:00:00', '2026-08-13 10:15:00', NULL, '/uploads/external/nhmfc-or-000301.jpg', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `financing_institution`
--

CREATE TABLE `financing_institution` (
  `institution_id` int(11) NOT NULL,
  `institution_name` varchar(150) NOT NULL,
  `contact_number` varchar(30) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `financing_institution`
--

INSERT INTO `financing_institution` (`institution_id`, `institution_name`, `contact_number`, `address`) VALUES
(1, 'National Home Mortgage Finance Corporation', '0000-000-0000', 'Sample address only'),
(2, 'Sample Bank', '0000-000-0001', 'Sample address only');

-- --------------------------------------------------------

--
-- Table structure for table `financing_type`
--

CREATE TABLE `financing_type` (
  `financing_type_id` int(11) NOT NULL,
  `financing_type_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `financing_type`
--

INSERT INTO `financing_type` (`financing_type_id`, `financing_type_name`, `description`) VALUES
(1, 'Housing Loan', 'Long-term housing loan'),
(2, 'Bank Loan', 'Commercial bank loan');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_category`
--

CREATE TABLE `inventory_category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory_category`
--

INSERT INTO `inventory_category` (`category_id`, `category_name`, `description`) VALUES
(1, 'Office Supplies', 'Paper, pens, folders'),
(2, 'Maintenance Materials', 'Repair and maintenance items'),
(3, 'Utilities', 'Electricity, water and similar bills');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_item`
--

CREATE TABLE `inventory_item` (
  `item_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `item_name` varchar(150) NOT NULL,
  `unit_of_measure` varchar(30) NOT NULL,
  `quantity_on_hand` decimal(12,2) NOT NULL DEFAULT 0.00,
  `reorder_level` decimal(12,2) NOT NULL DEFAULT 0.00,
  `unit_cost` decimal(15,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `inventory_item`
--

INSERT INTO `inventory_item` (`item_id`, `category_id`, `item_name`, `unit_of_measure`, `quantity_on_hand`, `reorder_level`, `unit_cost`, `is_active`) VALUES
(1, 1, 'Bond Paper A4', 'ream', 50.00, 10.00, 250.00, 1),
(2, 1, 'Ballpoint Pen', 'box', 20.00, 5.00, 120.00, 1),
(3, 2, 'LED Bulb 9W', 'piece', 40.00, 10.00, 85.00, 1),
(4, 2, 'Cement 40kg', 'bag', 30.00, 10.00, 260.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `lead`
--

CREATE TABLE `lead` (
  `lead_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `lead_source` varchar(100) NOT NULL,
  `submission_date` datetime NOT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lead`
--

INSERT INTO `lead` (`lead_id`, `buyer_id`, `agent_id`, `property_id`, `status_id`, `lead_source`, `submission_date`, `notes`) VALUES
(1, 1, 1, 1, 13, 'Website', '2026-02-10 10:00:00', 'Interested in 3-bedroom unit'),
(2, 2, 1, 2, 13, 'Referral', '2026-03-01 11:00:00', 'Referred by existing homeowner'),
(3, 3, 2, 3, 11, 'Walk-In', '2026-10-20 13:30:00', 'Asked about townhouse financing');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `loan_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `financing_type_id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL COMMENT 'external lender',
  `status_id` int(11) NOT NULL,
  `loan_amount` decimal(15,2) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL COMMENT 'annual percent',
  `loan_term_months` int(11) NOT NULL,
  `loan_application_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`loan_id`, `application_id`, `financing_type_id`, `institution_id`, `status_id`, `loan_amount`, `interest_rate`, `loan_term_months`, `loan_application_date`) VALUES
(1, 1, 1, 1, 37, 2800000.00, 6.50, 240, '2026-04-05 11:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `barangay_id` int(11) NOT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_id`, `barangay_id`, `address`) VALUES
(1, 1, 'Camp Evangelista Road'),
(2, 2, 'Carmen Public Market Area'),
(3, 4, 'Poblacion Main Street'),
(4, 3, 'Kauswagan Highway');

-- --------------------------------------------------------

--
-- Table structure for table `media_type`
--

CREATE TABLE `media_type` (
  `media_type_id` int(11) NOT NULL,
  `media_type_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media_type`
--

INSERT INTO `media_type` (`media_type_id`, `media_type_name`, `description`) VALUES
(1, 'Photo', 'Still photograph'),
(2, 'Video', 'Walkthrough video'),
(3, 'Floor Plan', 'Layout drawing');

-- --------------------------------------------------------

--
-- Table structure for table `owner`
--

CREATE TABLE `owner` (
  `owner_id` int(11) NOT NULL,
  `owner_name` varchar(150) NOT NULL,
  `contact_number` varchar(30) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `owner`
--

INSERT INTO `owner` (`owner_id`, `owner_name`, `contact_number`, `email`, `address`) VALUES
(1, 'Camp Evangelista Movants Homeowners Association', '09170001000', 'admin@campevangelista-hoa.example.com', 'Camp Evangelista, Patag, Cagayan de Oro City');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `reservation_id` int(11) DEFAULT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `payment_method_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `payment_type` varchar(30) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `reference_no` varchar(100) DEFAULT NULL COMMENT 'check number for CHECK payments',
  `recorded_by` int(11) NOT NULL COMMENT 'admin staff (user)',
  `recorded_at` datetime NOT NULL DEFAULT current_timestamp(),
  `cleared_at` datetime DEFAULT NULL COMMENT 'CHECK payments only',
  `evidence_url` varchar(500) DEFAULT NULL COMMENT 'optional scan'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `reservation_id`, `sale_id`, `payment_method_id`, `status_id`, `payment_type`, `amount`, `payment_date`, `reference_no`, `recorded_by`, `recorded_at`, `cleared_at`, `evidence_url`) VALUES
(1, 1, NULL, 1, 33, 'RESERVATION_FEE', 20000.00, '2026-03-01 09:30:00', NULL, 1, '2026-03-01 09:45:00', NULL, NULL),
(2, 1, 1, 2, 33, 'DOWN_PAYMENT', 700000.00, '2026-04-05 10:30:00', 'CHK-001245', 1, '2026-04-05 10:45:00', '2026-04-08 09:00:00', '/uploads/evidence/chk-001245.jpg'),
(3, 2, NULL, 1, 33, 'RESERVATION_FEE', 20000.00, '2026-03-10 09:30:00', NULL, 1, '2026-03-10 09:45:00', NULL, NULL),
(4, 2, 2, 2, 33, 'FULL_PAYMENT', 2780000.00, '2026-04-20 10:30:00', 'CHK-009871', 1, '2026-04-20 10:45:00', '2026-04-23 09:00:00', '/uploads/evidence/chk-009871.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `payment_allocation`
--

CREATE TABLE `payment_allocation` (
  `allocation_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL COMMENT 'association-received payments only',
  `schedule_id` int(11) NOT NULL COMMENT 'association-managed schedules only',
  `amount_allocated` decimal(15,2) NOT NULL,
  `allocation_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `payment_method_id` int(11) NOT NULL,
  `method_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`payment_method_id`, `method_name`, `description`) VALUES
(1, 'Cash', 'Cash paid at the office'),
(2, 'Check', 'Check payment, pending until cleared');

-- --------------------------------------------------------

--
-- Table structure for table `payment_schedule`
--

CREATE TABLE `payment_schedule` (
  `schedule_id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `installment_number` int(11) NOT NULL,
  `due_date` date NOT NULL,
  `principal_due` decimal(15,2) NOT NULL,
  `interest_due` decimal(15,2) NOT NULL,
  `amount_due` decimal(15,2) NOT NULL,
  `penalty_rate` decimal(5,4) NOT NULL DEFAULT 0.0200 COMMENT '0.02 = 2 percent; lender imposed',
  `penalty_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `penalty_applied` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `payment_schedule`
--

INSERT INTO `payment_schedule` (`schedule_id`, `loan_id`, `status_id`, `installment_number`, `due_date`, `principal_due`, `interest_due`, `amount_due`, `penalty_rate`, `penalty_amount`, `penalty_applied`) VALUES
(1, 1, 42, 1, '2026-05-05', 5708.73, 15166.67, 20875.40, 0.0200, 0.00, 0),
(2, 1, 42, 2, '2026-06-05', 5739.66, 15135.74, 20875.40, 0.0200, 0.00, 0),
(3, 1, 43, 3, '2026-07-05', 5770.74, 15104.66, 20875.40, 0.0200, 417.51, 1);

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE `property` (
  `property_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `property_type_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `property_name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `lot_area` decimal(10,2) NOT NULL,
  `floor_area` decimal(10,2) NOT NULL,
  `bedrooms` int(11) DEFAULT NULL,
  `bathrooms` int(11) DEFAULT NULL,
  `parking_slots` int(11) DEFAULT NULL,
  `listing_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `property`
--

INSERT INTO `property` (`property_id`, `owner_id`, `property_type_id`, `status_id`, `location_id`, `property_name`, `description`, `address`, `price`, `lot_area`, `floor_area`, `bedrooms`, `bathrooms`, `parking_slots`, `listing_date`) VALUES
(1, 1, 2, 5, 1, 'Evangelista Villa A', '3-bedroom house and lot near the clubhouse', 'Block 3 Lot 12, Camp Evangelista, Patag, Cagayan de Oro City', 3500000.00, 120.00, 80.00, 3, 2, 1, '2026-01-15 09:00:00'),
(2, 1, 2, 6, 1, 'Evangelista Villa B', '2-bedroom house and lot', 'Block 3 Lot 14, Camp Evangelista, Patag, Cagayan de Oro City', 2800000.00, 100.00, 65.00, 2, 1, 1, '2026-01-15 09:30:00'),
(3, 1, 3, 4, 1, 'Evangelista Townhouse C', 'Corner townhouse unit', 'Block 5 Lot 2, Camp Evangelista, Patag, Cagayan de Oro City', 2200000.00, 80.00, 70.00, 2, 2, 1, '2026-06-01 10:00:00'),
(4, 1, 4, 4, 1, 'Commercial Unit C1', 'Roadside commercial space', 'Main Gate Row 1, Camp Evangelista, Patag, Cagayan de Oro City', 4800000.00, 200.00, 150.00, NULL, 2, 4, '2026-06-01 10:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `property_amenity`
--

CREATE TABLE `property_amenity` (
  `property_amenity_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `amenity_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property_amenity`
--

INSERT INTO `property_amenity` (`property_amenity_id`, `property_id`, `amenity_id`) VALUES
(1, 1, 1),
(2, 1, 3),
(3, 1, 4),
(4, 2, 3),
(5, 2, 4),
(6, 3, 1),
(7, 3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `property_media`
--

CREATE TABLE `property_media` (
  `media_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `media_type_id` int(11) NOT NULL,
  `media_url` varchar(500) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property_media`
--

INSERT INTO `property_media` (`media_id`, `property_id`, `media_type_id`, `media_url`, `description`) VALUES
(1, 1, 1, '/uploads/property/1/front.jpg', 'Front view'),
(2, 1, 3, '/uploads/property/1/floorplan.pdf', 'Ground floor plan'),
(3, 3, 1, '/uploads/property/3/front.jpg', 'Front view');

-- --------------------------------------------------------

--
-- Table structure for table `property_recommendation`
--

CREATE TABLE `property_recommendation` (
  `recommendation_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `match_score` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `property_recommendation`
--

INSERT INTO `property_recommendation` (`recommendation_id`, `buyer_id`, `property_id`, `match_score`) VALUES
(1, 1, 1, 88.00),
(2, 2, 2, 85.50),
(3, 3, 3, 92.50);

-- --------------------------------------------------------

--
-- Table structure for table `property_type`
--

CREATE TABLE `property_type` (
  `property_type_id` int(11) NOT NULL,
  `property_type_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property_type`
--

INSERT INTO `property_type` (`property_type_id`, `property_type_name`, `description`) VALUES
(1, 'Residential Lot', 'Vacant residential lot'),
(2, 'House and Lot', 'Single detached house with lot'),
(3, 'Townhouse', 'Attached townhouse unit'),
(4, 'Commercial Unit', 'Commercial space');

-- --------------------------------------------------------

--
-- Table structure for table `province`
--

CREATE TABLE `province` (
  `province_id` int(11) NOT NULL,
  `province_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `province`
--

INSERT INTO `province` (`province_id`, `province_name`) VALUES
(1, 'Misamis Oriental');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `reservation_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `reservation_fee` decimal(15,2) NOT NULL,
  `down_payment` decimal(15,2) NOT NULL,
  `total_price` decimal(15,2) NOT NULL,
  `reservation_date` datetime NOT NULL,
  `expiry_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`reservation_id`, `application_id`, `status_id`, `reservation_fee`, `down_payment`, `total_price`, `reservation_date`, `expiry_date`) VALUES
(1, 1, 26, 20000.00, 700000.00, 3500000.00, '2026-03-01 09:00:00', '2026-03-31 23:59:59'),
(2, 2, 26, 20000.00, 2780000.00, 2800000.00, '2026-03-10 09:00:00', '2026-04-10 23:59:59');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role_name`, `description`) VALUES
(1, 'Admin', 'Administrative staff: records payments, verifies documents, manages inventory'),
(2, 'Broker', 'Licensed broker supervising agents'),
(3, 'Agent', 'Sales agent handling buyers and leads'),
(4, 'Buyer', 'Registered buyer / prospect');

-- --------------------------------------------------------

--
-- Table structure for table `sale`
--

CREATE TABLE `sale` (
  `sale_id` int(11) NOT NULL,
  `reservation_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `payment_arrangement` varchar(20) NOT NULL,
  `total_price` decimal(15,2) NOT NULL,
  `down_payment` decimal(15,2) NOT NULL,
  `sale_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `sale`
--

INSERT INTO `sale` (`sale_id`, `reservation_id`, `status_id`, `payment_arrangement`, `total_price`, `down_payment`, `sale_date`) VALUES
(1, 1, 29, 'FINANCING', 3500000.00, 700000.00, '2026-04-05 10:00:00'),
(2, 2, 30, 'FULL', 2800000.00, 2780000.00, '2026-04-20 10:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `status_id` int(11) NOT NULL,
  `status_type` varchar(50) NOT NULL,
  `status_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`status_id`, `status_type`, `status_name`, `description`) VALUES
(1, 'USER', 'Active', 'Account can log in'),
(2, 'USER', 'Inactive', 'Account disabled'),
(3, 'USER', 'Suspended', 'Account temporarily blocked'),
(4, 'PROPERTY', 'Available', 'Open for sale'),
(5, 'PROPERTY', 'Reserved', 'Reserved by a buyer'),
(6, 'PROPERTY', 'Sold', 'Sale completed'),
(7, 'PROPERTY', 'Unavailable', 'Withdrawn from listing'),
(8, 'ASSIGNMENT', 'Active', 'Current agent assignment'),
(9, 'ASSIGNMENT', 'Ended', 'Assignment closed'),
(10, 'LEAD', 'New', NULL),
(11, 'LEAD', 'Contacted', NULL),
(12, 'LEAD', 'Qualified', NULL),
(13, 'LEAD', 'Converted', 'Lead became an application'),
(14, 'LEAD', 'Closed', NULL),
(15, 'APPOINTMENT', 'Scheduled', NULL),
(16, 'APPOINTMENT', 'Completed', NULL),
(17, 'APPOINTMENT', 'Cancelled', NULL),
(18, 'APPLICATION', 'Submitted', NULL),
(19, 'APPLICATION', 'Under Review', NULL),
(20, 'APPLICATION', 'Approved', NULL),
(21, 'APPLICATION', 'Rejected', NULL),
(22, 'DOCUMENT', 'Pending', NULL),
(23, 'DOCUMENT', 'Verified', NULL),
(24, 'DOCUMENT', 'Rejected', NULL),
(25, 'RESERVATION', 'Active', NULL),
(26, 'RESERVATION', 'Converted', 'Converted to a sale'),
(27, 'RESERVATION', 'Expired', NULL),
(28, 'RESERVATION', 'Cancelled', NULL),
(29, 'SALE', 'Ongoing', 'Payments still being completed'),
(30, 'SALE', 'Completed', NULL),
(31, 'SALE', 'Cancelled', NULL),
(32, 'PAYMENT', 'Pending', 'e.g. check not yet cleared'),
(33, 'PAYMENT', 'Verified', NULL),
(34, 'PAYMENT', 'Rejected', NULL),
(35, 'LOAN', 'Pending', NULL),
(36, 'LOAN', 'Approved', NULL),
(37, 'LOAN', 'Active', NULL),
(38, 'LOAN', 'Fully Paid', NULL),
(39, 'LOAN', 'Rejected', NULL),
(40, 'SCHEDULE', 'Unpaid', NULL),
(41, 'SCHEDULE', 'Partially Paid', NULL),
(42, 'SCHEDULE', 'Paid', NULL),
(43, 'SCHEDULE', 'Overdue', NULL),
(44, 'EXTERNAL_PAYMENT', 'Reported', 'Receipt recorded, not yet verified'),
(45, 'EXTERNAL_PAYMENT', 'Verified', 'Confirmed against lender record'),
(46, 'EXTERNAL_PAYMENT', 'Rejected', NULL),
(47, 'COMMISSION', 'Pending', NULL),
(48, 'COMMISSION', 'Released', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `stock_transaction`
--

CREATE TABLE `stock_transaction` (
  `transaction_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_type` varchar(20) NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `unit_cost` decimal(15,2) NOT NULL,
  `transaction_date` datetime NOT NULL DEFAULT current_timestamp(),
  `reference_no` varchar(100) DEFAULT NULL,
  `remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `stock_transaction`
--

INSERT INTO `stock_transaction` (`transaction_id`, `item_id`, `user_id`, `transaction_type`, `quantity`, `unit_cost`, `transaction_date`, `reference_no`, `remarks`) VALUES
(1, 1, 1, 'IN', 100.00, 250.00, '2026-10-01 09:00:00', 'PO-2026-001', 'Initial stock'),
(2, 1, 1, 'OUT', 50.00, 250.00, '2026-10-10 14:00:00', 'REQ-2026-014', 'Used for monthly printing'),
(3, 2, 1, 'IN', 20.00, 120.00, '2026-10-01 09:10:00', 'PO-2026-001', 'Initial stock'),
(4, 3, 1, 'IN', 40.00, 85.00, '2026-10-02 10:00:00', 'PO-2026-002', 'Street light replacements'),
(5, 4, 1, 'IN', 30.00, 260.00, '2026-10-02 10:30:00', 'PO-2026-002', 'Gate repair stock');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `registration_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `role_id`, `status_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone`, `registration_date`) VALUES
(1, 1, 1, 'Maria', 'Santos', 'maria.santos@example.com', '$2y$10$DUMMYHASHADMINxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '09170000001', '2026-01-02 08:00:00'),
(2, 2, 1, 'Jose', 'Reyes', 'jose.reyes@example.com', '$2y$10$DUMMYHASHBROKERxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '09170000002', '2026-01-02 08:30:00'),
(3, 3, 1, 'Ana', 'Cruz', 'ana.cruz@example.com', '$2y$10$DUMMYHASHAGENT1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '09170000003', '2026-01-03 09:00:00'),
(4, 3, 1, 'Carlo', 'Mendoza', 'carlo.mendoza@example.com', '$2y$10$DUMMYHASHAGENT2xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '09170000004', '2026-01-03 09:15:00'),
(5, 4, 1, 'Liza', 'Ramos', 'liza.ramos@example.com', '$2y$10$DUMMYHASHBUYER1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '09170000005', '2026-01-05 10:00:00'),
(6, 4, 1, 'Paolo', 'Garcia', 'paolo.garcia@example.com', '$2y$10$DUMMYHASHBUYER2xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '09170000006', '2026-02-18 11:00:00'),
(7, 4, 1, 'Rina', 'Flores', 'rina.flores@example.com', '$2y$10$DUMMYHASHBUYER3xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '09170000007', '2026-10-14 14:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agent`
--
ALTER TABLE `agent`
  ADD PRIMARY KEY (`agent_id`),
  ADD UNIQUE KEY `uq_agent_user` (`user_id`),
  ADD UNIQUE KEY `uq_agent_license` (`license_no`),
  ADD KEY `fk_agent_broker` (`broker_id`);

--
-- Indexes for table `agent_assignment`
--
ALTER TABLE `agent_assignment`
  ADD PRIMARY KEY (`assignment_id`),
  ADD UNIQUE KEY `uq_one_active_assignment_per_buyer` (`active_buyer_id`),
  ADD KEY `fk_assignment_agent` (`agent_id`),
  ADD KEY `fk_assignment_buyer` (`buyer_id`),
  ADD KEY `fk_assignment_status` (`status_id`);

--
-- Indexes for table `amenity`
--
ALTER TABLE `amenity`
  ADD PRIMARY KEY (`amenity_id`),
  ADD UNIQUE KEY `uq_amenity_name` (`amenity_name`);

--
-- Indexes for table `application`
--
ALTER TABLE `application`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `fk_application_lead` (`lead_id`),
  ADD KEY `fk_application_agent` (`agent_id`),
  ADD KEY `fk_application_property` (`property_id`),
  ADD KEY `fk_application_status` (`status_id`);

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `fk_appointment_lead` (`lead_id`),
  ADD KEY `fk_appointment_agent` (`agent_id`),
  ADD KEY `fk_appointment_type` (`appointment_type_id`),
  ADD KEY `fk_appointment_status` (`status_id`);

--
-- Indexes for table `appointment_type`
--
ALTER TABLE `appointment_type`
  ADD PRIMARY KEY (`appointment_type_id`),
  ADD UNIQUE KEY `uq_appointment_type_name` (`type_name`);

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `fk_audit_log_user` (`user_id`);

--
-- Indexes for table `barangay`
--
ALTER TABLE `barangay`
  ADD PRIMARY KEY (`barangay_id`),
  ADD UNIQUE KEY `uq_barangay_city_name` (`city_id`,`barangay_name`);

--
-- Indexes for table `broker`
--
ALTER TABLE `broker`
  ADD PRIMARY KEY (`broker_id`),
  ADD UNIQUE KEY `uq_broker_user` (`user_id`),
  ADD UNIQUE KEY `uq_broker_license` (`license_no`);

--
-- Indexes for table `buyer`
--
ALTER TABLE `buyer`
  ADD PRIMARY KEY (`buyer_id`),
  ADD UNIQUE KEY `uq_buyer_user` (`user_id`),
  ADD KEY `fk_buyer_location` (`location_id`),
  ADD KEY `fk_buyer_agent` (`agent_id`);

--
-- Indexes for table `buyer_document`
--
ALTER TABLE `buyer_document`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `fk_buyer_document_application` (`application_id`),
  ADD KEY `fk_buyer_document_type` (`document_type_id`),
  ADD KEY `fk_buyer_document_status` (`status_id`);

--
-- Indexes for table `cash_receipt`
--
ALTER TABLE `cash_receipt`
  ADD PRIMARY KEY (`receipt_id`),
  ADD UNIQUE KEY `uq_cash_receipt_payment` (`payment_id`),
  ADD UNIQUE KEY `uq_cash_receipt_number` (`receipt_number`),
  ADD KEY `fk_cash_receipt_issued_by` (`issued_by`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_id`),
  ADD UNIQUE KEY `uq_city_province_name` (`province_id`,`city_name`);

--
-- Indexes for table `commission`
--
ALTER TABLE `commission`
  ADD PRIMARY KEY (`commission_id`),
  ADD KEY `fk_commission_sale` (`sale_id`),
  ADD KEY `fk_commission_agent` (`agent_id`),
  ADD KEY `fk_commission_status` (`status_id`);

--
-- Indexes for table `document_type`
--
ALTER TABLE `document_type`
  ADD PRIMARY KEY (`document_type_id`),
  ADD UNIQUE KEY `uq_document_type_name` (`document_type_name`);

--
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`expense_id`),
  ADD KEY `fk_expense_category` (`category_id`),
  ADD KEY `fk_expense_user` (`user_id`),
  ADD KEY `fk_expense_method` (`payment_method_id`);

--
-- Indexes for table `external_payment_allocation`
--
ALTER TABLE `external_payment_allocation`
  ADD PRIMARY KEY (`external_allocation_id`),
  ADD KEY `fk_ext_alloc_payment` (`external_payment_id`),
  ADD KEY `fk_ext_alloc_schedule` (`schedule_id`);

--
-- Indexes for table `external_payment_record`
--
ALTER TABLE `external_payment_record`
  ADD PRIMARY KEY (`external_payment_id`),
  ADD UNIQUE KEY `uq_external_loan_receipt` (`loan_id`,`institution_receipt_no`),
  ADD KEY `fk_external_recorded_by` (`recorded_by`),
  ADD KEY `fk_external_status` (`status_id`);

--
-- Indexes for table `financing_institution`
--
ALTER TABLE `financing_institution`
  ADD PRIMARY KEY (`institution_id`),
  ADD UNIQUE KEY `uq_institution_name` (`institution_name`);

--
-- Indexes for table `financing_type`
--
ALTER TABLE `financing_type`
  ADD PRIMARY KEY (`financing_type_id`),
  ADD UNIQUE KEY `uq_financing_type_name` (`financing_type_name`);

--
-- Indexes for table `inventory_category`
--
ALTER TABLE `inventory_category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `uq_inventory_category_name` (`category_name`);

--
-- Indexes for table `inventory_item`
--
ALTER TABLE `inventory_item`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `fk_item_category` (`category_id`);

--
-- Indexes for table `lead`
--
ALTER TABLE `lead`
  ADD PRIMARY KEY (`lead_id`),
  ADD KEY `fk_lead_buyer` (`buyer_id`),
  ADD KEY `fk_lead_agent` (`agent_id`),
  ADD KEY `fk_lead_property` (`property_id`),
  ADD KEY `fk_lead_status` (`status_id`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`loan_id`),
  ADD UNIQUE KEY `uq_loan_application` (`application_id`),
  ADD KEY `fk_loan_financing` (`financing_type_id`),
  ADD KEY `fk_loan_institution` (`institution_id`),
  ADD KEY `fk_loan_status` (`status_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `fk_location_barangay` (`barangay_id`);

--
-- Indexes for table `media_type`
--
ALTER TABLE `media_type`
  ADD PRIMARY KEY (`media_type_id`),
  ADD UNIQUE KEY `uq_media_type_name` (`media_type_name`);

--
-- Indexes for table `owner`
--
ALTER TABLE `owner`
  ADD PRIMARY KEY (`owner_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_payment_reservation` (`reservation_id`),
  ADD KEY `fk_payment_sale` (`sale_id`),
  ADD KEY `fk_payment_method` (`payment_method_id`),
  ADD KEY `fk_payment_status` (`status_id`),
  ADD KEY `fk_payment_recorded_by` (`recorded_by`);

--
-- Indexes for table `payment_allocation`
--
ALTER TABLE `payment_allocation`
  ADD PRIMARY KEY (`allocation_id`),
  ADD KEY `fk_alloc_payment` (`payment_id`),
  ADD KEY `fk_alloc_schedule` (`schedule_id`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`payment_method_id`),
  ADD UNIQUE KEY `uq_payment_method_name` (`method_name`);

--
-- Indexes for table `payment_schedule`
--
ALTER TABLE `payment_schedule`
  ADD PRIMARY KEY (`schedule_id`),
  ADD UNIQUE KEY `uq_schedule_loan_installment` (`loan_id`,`installment_number`),
  ADD KEY `fk_schedule_status` (`status_id`);

--
-- Indexes for table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`property_id`),
  ADD KEY `fk_property_owner` (`owner_id`),
  ADD KEY `fk_property_type` (`property_type_id`),
  ADD KEY `fk_property_status` (`status_id`),
  ADD KEY `fk_property_location` (`location_id`);

--
-- Indexes for table `property_amenity`
--
ALTER TABLE `property_amenity`
  ADD PRIMARY KEY (`property_amenity_id`),
  ADD UNIQUE KEY `uq_property_amenity` (`property_id`,`amenity_id`),
  ADD KEY `fk_property_amenity_amenity` (`amenity_id`);

--
-- Indexes for table `property_media`
--
ALTER TABLE `property_media`
  ADD PRIMARY KEY (`media_id`),
  ADD KEY `fk_property_media_property` (`property_id`),
  ADD KEY `fk_property_media_type` (`media_type_id`);

--
-- Indexes for table `property_recommendation`
--
ALTER TABLE `property_recommendation`
  ADD PRIMARY KEY (`recommendation_id`),
  ADD UNIQUE KEY `uq_recommendation_buyer_property` (`buyer_id`,`property_id`),
  ADD KEY `fk_recommendation_property` (`property_id`);

--
-- Indexes for table `property_type`
--
ALTER TABLE `property_type`
  ADD PRIMARY KEY (`property_type_id`),
  ADD UNIQUE KEY `uq_property_type_name` (`property_type_name`);

--
-- Indexes for table `province`
--
ALTER TABLE `province`
  ADD PRIMARY KEY (`province_id`),
  ADD UNIQUE KEY `uq_province_name` (`province_name`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservation_id`),
  ADD UNIQUE KEY `uq_reservation_application` (`application_id`),
  ADD KEY `fk_reservation_status` (`status_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `uq_role_name` (`role_name`);

--
-- Indexes for table `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`sale_id`),
  ADD UNIQUE KEY `uq_sale_reservation` (`reservation_id`),
  ADD KEY `fk_sale_status` (`status_id`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `uq_status_type_name` (`status_type`,`status_name`);

--
-- Indexes for table `stock_transaction`
--
ALTER TABLE `stock_transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `fk_stock_item` (`item_id`),
  ADD KEY `fk_stock_user` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uq_user_email` (`email`),
  ADD KEY `fk_user_role` (`role_id`),
  ADD KEY `fk_user_status` (`status_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agent`
--
ALTER TABLE `agent`
  MODIFY `agent_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `agent_assignment`
--
ALTER TABLE `agent_assignment`
  MODIFY `assignment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `amenity`
--
ALTER TABLE `amenity`
  MODIFY `amenity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `application`
--
ALTER TABLE `application`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `appointment_type`
--
ALTER TABLE `appointment_type`
  MODIFY `appointment_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `barangay`
--
ALTER TABLE `barangay`
  MODIFY `barangay_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `broker`
--
ALTER TABLE `broker`
  MODIFY `broker_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `buyer`
--
ALTER TABLE `buyer`
  MODIFY `buyer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `buyer_document`
--
ALTER TABLE `buyer_document`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cash_receipt`
--
ALTER TABLE `cash_receipt`
  MODIFY `receipt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `commission`
--
ALTER TABLE `commission`
  MODIFY `commission_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_type`
--
ALTER TABLE `document_type`
  MODIFY `document_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `external_payment_allocation`
--
ALTER TABLE `external_payment_allocation`
  MODIFY `external_allocation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `external_payment_record`
--
ALTER TABLE `external_payment_record`
  MODIFY `external_payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `financing_institution`
--
ALTER TABLE `financing_institution`
  MODIFY `institution_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `financing_type`
--
ALTER TABLE `financing_type`
  MODIFY `financing_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inventory_category`
--
ALTER TABLE `inventory_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory_item`
--
ALTER TABLE `inventory_item`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lead`
--
ALTER TABLE `lead`
  MODIFY `lead_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `media_type`
--
ALTER TABLE `media_type`
  MODIFY `media_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `owner`
--
ALTER TABLE `owner`
  MODIFY `owner_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_allocation`
--
ALTER TABLE `payment_allocation`
  MODIFY `allocation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment_schedule`
--
ALTER TABLE `payment_schedule`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
  MODIFY `property_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property_amenity`
--
ALTER TABLE `property_amenity`
  MODIFY `property_amenity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `property_media`
--
ALTER TABLE `property_media`
  MODIFY `media_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `property_recommendation`
--
ALTER TABLE `property_recommendation`
  MODIFY `recommendation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property_type`
--
ALTER TABLE `property_type`
  MODIFY `property_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `province`
--
ALTER TABLE `province`
  MODIFY `province_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sale`
--
ALTER TABLE `sale`
  MODIFY `sale_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `stock_transaction`
--
ALTER TABLE `stock_transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agent`
--
ALTER TABLE `agent`
  ADD CONSTRAINT `fk_agent_broker` FOREIGN KEY (`broker_id`) REFERENCES `broker` (`broker_id`),
  ADD CONSTRAINT `fk_agent_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `agent_assignment`
--
ALTER TABLE `agent_assignment`
  ADD CONSTRAINT `fk_assignment_agent` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`agent_id`),
  ADD CONSTRAINT `fk_assignment_buyer` FOREIGN KEY (`buyer_id`) REFERENCES `buyer` (`buyer_id`),
  ADD CONSTRAINT `fk_assignment_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `application`
--
ALTER TABLE `application`
  ADD CONSTRAINT `fk_application_agent` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`agent_id`),
  ADD CONSTRAINT `fk_application_lead` FOREIGN KEY (`lead_id`) REFERENCES `lead` (`lead_id`),
  ADD CONSTRAINT `fk_application_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`),
  ADD CONSTRAINT `fk_application_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `fk_appointment_agent` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`agent_id`),
  ADD CONSTRAINT `fk_appointment_lead` FOREIGN KEY (`lead_id`) REFERENCES `lead` (`lead_id`),
  ADD CONSTRAINT `fk_appointment_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`),
  ADD CONSTRAINT `fk_appointment_type` FOREIGN KEY (`appointment_type_id`) REFERENCES `appointment_type` (`appointment_type_id`);

--
-- Constraints for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `fk_audit_log_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `barangay`
--
ALTER TABLE `barangay`
  ADD CONSTRAINT `fk_barangay_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `broker`
--
ALTER TABLE `broker`
  ADD CONSTRAINT `fk_broker_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `buyer`
--
ALTER TABLE `buyer`
  ADD CONSTRAINT `fk_buyer_agent` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`agent_id`),
  ADD CONSTRAINT `fk_buyer_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `fk_buyer_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `buyer_document`
--
ALTER TABLE `buyer_document`
  ADD CONSTRAINT `fk_buyer_document_application` FOREIGN KEY (`application_id`) REFERENCES `application` (`application_id`),
  ADD CONSTRAINT `fk_buyer_document_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`),
  ADD CONSTRAINT `fk_buyer_document_type` FOREIGN KEY (`document_type_id`) REFERENCES `document_type` (`document_type_id`);

--
-- Constraints for table `cash_receipt`
--
ALTER TABLE `cash_receipt`
  ADD CONSTRAINT `fk_cash_receipt_issued_by` FOREIGN KEY (`issued_by`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `fk_cash_receipt_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`);

--
-- Constraints for table `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `fk_city_province` FOREIGN KEY (`province_id`) REFERENCES `province` (`province_id`);

--
-- Constraints for table `commission`
--
ALTER TABLE `commission`
  ADD CONSTRAINT `fk_commission_agent` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`agent_id`),
  ADD CONSTRAINT `fk_commission_sale` FOREIGN KEY (`sale_id`) REFERENCES `sale` (`sale_id`),
  ADD CONSTRAINT `fk_commission_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `expense`
--
ALTER TABLE `expense`
  ADD CONSTRAINT `fk_expense_category` FOREIGN KEY (`category_id`) REFERENCES `inventory_category` (`category_id`),
  ADD CONSTRAINT `fk_expense_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_method_id`),
  ADD CONSTRAINT `fk_expense_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `external_payment_allocation`
--
ALTER TABLE `external_payment_allocation`
  ADD CONSTRAINT `fk_ext_alloc_payment` FOREIGN KEY (`external_payment_id`) REFERENCES `external_payment_record` (`external_payment_id`),
  ADD CONSTRAINT `fk_ext_alloc_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `payment_schedule` (`schedule_id`);

--
-- Constraints for table `external_payment_record`
--
ALTER TABLE `external_payment_record`
  ADD CONSTRAINT `fk_external_loan` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`),
  ADD CONSTRAINT `fk_external_recorded_by` FOREIGN KEY (`recorded_by`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `fk_external_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `inventory_item`
--
ALTER TABLE `inventory_item`
  ADD CONSTRAINT `fk_item_category` FOREIGN KEY (`category_id`) REFERENCES `inventory_category` (`category_id`);

--
-- Constraints for table `lead`
--
ALTER TABLE `lead`
  ADD CONSTRAINT `fk_lead_agent` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`agent_id`),
  ADD CONSTRAINT `fk_lead_buyer` FOREIGN KEY (`buyer_id`) REFERENCES `buyer` (`buyer_id`),
  ADD CONSTRAINT `fk_lead_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`),
  ADD CONSTRAINT `fk_lead_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `fk_loan_application` FOREIGN KEY (`application_id`) REFERENCES `application` (`application_id`),
  ADD CONSTRAINT `fk_loan_financing` FOREIGN KEY (`financing_type_id`) REFERENCES `financing_type` (`financing_type_id`),
  ADD CONSTRAINT `fk_loan_institution` FOREIGN KEY (`institution_id`) REFERENCES `financing_institution` (`institution_id`),
  ADD CONSTRAINT `fk_loan_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `fk_location_barangay` FOREIGN KEY (`barangay_id`) REFERENCES `barangay` (`barangay_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_payment_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_method_id`),
  ADD CONSTRAINT `fk_payment_recorded_by` FOREIGN KEY (`recorded_by`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `fk_payment_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`),
  ADD CONSTRAINT `fk_payment_sale` FOREIGN KEY (`sale_id`) REFERENCES `sale` (`sale_id`),
  ADD CONSTRAINT `fk_payment_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `payment_allocation`
--
ALTER TABLE `payment_allocation`
  ADD CONSTRAINT `fk_alloc_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`),
  ADD CONSTRAINT `fk_alloc_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `payment_schedule` (`schedule_id`);

--
-- Constraints for table `payment_schedule`
--
ALTER TABLE `payment_schedule`
  ADD CONSTRAINT `fk_schedule_loan` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`),
  ADD CONSTRAINT `fk_schedule_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `fk_property_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `fk_property_owner` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`),
  ADD CONSTRAINT `fk_property_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`),
  ADD CONSTRAINT `fk_property_type` FOREIGN KEY (`property_type_id`) REFERENCES `property_type` (`property_type_id`);

--
-- Constraints for table `property_amenity`
--
ALTER TABLE `property_amenity`
  ADD CONSTRAINT `fk_property_amenity_amenity` FOREIGN KEY (`amenity_id`) REFERENCES `amenity` (`amenity_id`),
  ADD CONSTRAINT `fk_property_amenity_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`);

--
-- Constraints for table `property_media`
--
ALTER TABLE `property_media`
  ADD CONSTRAINT `fk_property_media_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`),
  ADD CONSTRAINT `fk_property_media_type` FOREIGN KEY (`media_type_id`) REFERENCES `media_type` (`media_type_id`);

--
-- Constraints for table `property_recommendation`
--
ALTER TABLE `property_recommendation`
  ADD CONSTRAINT `fk_recommendation_buyer` FOREIGN KEY (`buyer_id`) REFERENCES `buyer` (`buyer_id`),
  ADD CONSTRAINT `fk_recommendation_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `fk_reservation_application` FOREIGN KEY (`application_id`) REFERENCES `application` (`application_id`),
  ADD CONSTRAINT `fk_reservation_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `sale`
--
ALTER TABLE `sale`
  ADD CONSTRAINT `fk_sale_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`),
  ADD CONSTRAINT `fk_sale_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `stock_transaction`
--
ALTER TABLE `stock_transaction`
  ADD CONSTRAINT `fk_stock_item` FOREIGN KEY (`item_id`) REFERENCES `inventory_item` (`item_id`),
  ADD CONSTRAINT `fk_stock_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  ADD CONSTRAINT `fk_user_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);
-- --------------------------------------------------------
-- Exact-value validation for fixed-choice columns
-- BINARY makes these comparisons case-sensitive.
-- --------------------------------------------------------

ALTER TABLE `lead`
  ADD CONSTRAINT `chk_lead_source`
  CHECK (BINARY `lead_source` IN (BINARY 'Website', BINARY 'Referral', BINARY 'Walk-In'));

ALTER TABLE `payment`
  ADD CONSTRAINT `chk_payment_type`
  CHECK (BINARY `payment_type` IN (BINARY 'RESERVATION_FEE', BINARY 'DOWN_PAYMENT', BINARY 'FULL_PAYMENT'));

ALTER TABLE `sale`
  ADD CONSTRAINT `chk_sale_payment_arrangement`
  CHECK (BINARY `payment_arrangement` IN (BINARY 'FINANCING', BINARY 'FULL'));

ALTER TABLE `stock_transaction`
  ADD CONSTRAINT `chk_stock_transaction_type`
  CHECK (BINARY `transaction_type` IN (BINARY 'IN', BINARY 'OUT'));

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
