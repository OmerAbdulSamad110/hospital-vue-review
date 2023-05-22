-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 09, 2022 at 08:56 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `proj`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `email`, `email_verified_at`, `password`, `employee_id`, `remember_token`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin@gmail.com', NULL, '$2y$10$69YKDYnW7bYI9IgVbSFUuePRxRtdJdHiepA.ocAJl.Qln.MwIl4yu', 1, 'spKBLF0yBUuyiCQhSlYTu6lv5zZomCCffrBG12LF7jF6MNYQra9xDsiCaxQc', 1, '2021-03-30 12:35:27', '2021-03-30 12:35:27'),
(21, 'csdga@gmail.com', NULL, '$2y$10$69YKDYnW7bYI9IgVbSFUuePRxRtdJdHiepA.ocAJl.Qln.MwIl4yu', 2, NULL, 1, '2021-12-21 07:38:00', '2022-02-03 06:26:23');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Computer', 1, '2021-04-27 07:28:34', '2021-04-27 07:28:34'),
(2, 'Beds', 1, '2021-04-27 07:28:34', '2021-04-27 07:28:34'),
(3, 'Medical Equipment', 1, '2021-04-27 07:28:34', '2021-04-27 07:28:34'),
(4, 'Measuring', 1, '2021-04-27 02:29:32', '2021-04-27 02:31:08'),
(5, 'Books', 1, '2021-04-27 02:30:56', '2021-04-27 02:30:56'),
(6, 'yellow', 0, '2021-05-20 05:25:57', '2021-12-08 14:42:42'),
(7, 'أدخل الاسم الكامل', 1, '2022-02-02 04:59:48', '2022-02-02 04:59:48'),
(8, 'Invitation', 1, '2022-02-02 05:00:31', '2022-02-02 05:00:31'),
(9, 'Telephone Number', 1, '2022-02-04 05:38:03', '2022-02-04 05:38:03');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `title`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Dabb', 0, '2021-03-18 01:24:09', '2021-12-08 15:58:48'),
(2, 'IT', 0, '2021-03-18 06:47:48', '2022-02-03 05:40:28'),
(3, 'Dolores', 1, '2021-04-29 03:48:40', '2022-02-03 05:38:23'),
(4, 'Singer Updated', 1, '2021-04-29 03:48:50', '2021-04-29 03:48:50'),
(5, 'stub', 1, '2021-12-08 15:58:58', '2021-12-08 15:58:58');

-- --------------------------------------------------------

--
-- Table structure for table `department_role`
--

CREATE TABLE `department_role` (
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `department_role`
--

INSERT INTO `department_role` (`department_id`, `role_id`) VALUES
(5, 9);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` tinyint(4) NOT NULL DEFAULT 1,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `picture`, `name`, `number`, `email`, `phone`, `gender`, `department_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, '/storage/images/dps/S68mtI00ct3fHAonGw3hcIBozWYh5KW0M9hKCLjM.jpg', 'Super Admin P', 'admin400', 'admin@gmail.com', '1223344566', 1, NULL, 1, '2021-06-25 09:34:52', '2021-12-08 16:51:30'),
(2, NULL, 'Adam', '124556', 'csdga@gmail.com', '222222222222', 2, 5, 3, '2021-06-25 09:34:52', '2021-12-21 07:38:00'),
(3, NULL, 'Kareem Day', '577', 'sajane@mailinator.com', '+1775649145', 2, 5, 5, '2021-06-25 08:14:44', '2021-12-21 07:37:07');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_engineer_id` bigint(20) UNSIGNED NOT NULL,
  `installation_date` datetime NOT NULL,
  `warrenty` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`id`, `name`, `serial_no`, `model`, `department_id`, `sub_category_id`, `supplier_engineer_id`, `installation_date`, `warrenty`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Kitra Weis', 'Porro laborum autem', 'Et blanditiis ration', 5, 6, 2, '2021-12-31 22:16:00', '2025-01-01 13:40:00', 1, '2021-12-31 01:31:09', '2021-12-31 04:40:51'),
(15, 'Astra Lindsay', 'Enim sapiente maiore', 'Natus vero dolor est', 4, 5, 2, '1973-06-03 09:43:00', '2021-01-09 09:29:00', 1, '2022-01-04 05:52:24', '2022-01-04 05:52:24'),
(16, 'Rhona Adkins', 'Qui et rerum omnis l', 'Placeat iusto volup', 4, 1, 2, '2005-02-22 02:07:00', '1998-02-07 01:06:00', 1, '2022-01-04 05:53:43', '2022-01-04 05:53:43'),
(17, 'Stella Riggs', 'Eu quis occaecat imp', 'Non omnis ex id non', 5, 6, 1, '1973-09-20 06:48:00', '2019-09-02 05:33:00', 1, '2022-02-02 06:02:54', '2022-02-02 06:02:54'),
(19, 'Rylee Steele', 'Modi in dolores ut i', 'Enim nemo et aute bl', 5, 2, 2, '1996-12-02 23:18:00', '2022-02-03 03:25:00', 1, '2022-02-02 06:29:22', '2022-02-02 06:29:22'),
(20, 'Althea Evans', 'Velit in nulla moles', 'Eaque quis rerum aut', 5, 1, 4, '1979-01-21 09:12:00', '2008-02-09 23:42:00', 1, '2022-03-08 06:28:27', '2022-03-08 06:28:27');

-- --------------------------------------------------------

--
-- Table structure for table `equipment_services`
--

CREATE TABLE `equipment_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `last_date` datetime DEFAULT NULL,
  `next_date` datetime DEFAULT NULL,
  `cost` double NOT NULL,
  `equipment_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `equipment_services`
--

INSERT INTO `equipment_services` (`id`, `last_date`, `next_date`, `cost`, `equipment_id`, `created_at`, `updated_at`) VALUES
(1, NULL, '2023-01-01 14:43:00', 4000, 1, '2022-01-04 09:44:05', '2022-01-04 05:23:56'),
(2, '2022-02-03 16:08:00', '2023-01-04 11:57:00', 1, 15, '2022-01-04 05:52:24', '2022-01-04 05:52:24'),
(3, '2022-02-03 10:14:00', '2023-10-04 07:20:00', 9100, 16, '2022-01-04 05:53:44', '2022-01-04 05:53:44'),
(4, NULL, '2022-11-16 16:17:00', 1000, 1, '2022-01-04 06:17:48', '2022-01-04 06:17:48'),
(5, NULL, '2022-11-16 16:17:00', 2000, 1, '2022-01-05 06:17:48', '2022-01-05 06:17:48'),
(6, '2022-02-03 10:37:00', '2022-02-16 15:56:00', 62, 17, '2022-02-02 06:02:54', '2022-02-02 06:02:54'),
(8, '2022-02-03 10:08:00', '2022-02-09 05:09:00', 94, 19, '2022-02-02 06:29:22', '2022-02-02 06:29:22'),
(9, '2022-03-08 14:29:00', '2022-03-09 09:55:00', 16, 20, '2022-03-08 06:28:27', '2022-03-08 06:28:27');

-- --------------------------------------------------------

--
-- Table structure for table `factories`
--

CREATE TABLE `factories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `factories`
--

INSERT INTO `factories` (`id`, `name`, `address`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Dell', 'Ex possimus velit c', 1, '2021-06-25 06:32:51', '2021-12-08 16:49:29'),
(2, 'Lenovo', NULL, 1, '2021-06-25 01:49:25', '2021-06-25 01:49:25'),
(3, 'Hp', 'Japan', 1, '2021-06-25 01:50:11', '2021-06-25 01:50:30'),
(4, 'Jason Osborn', 'Quod eaque delectus', 1, '2021-12-08 16:50:08', '2021-12-08 16:50:08');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `factory_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `description`, `sub_category_id`, `factory_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Lapitop', 'laptop', 1, 1, 1, '2021-06-25 02:19:41', '2022-02-03 06:38:01'),
(2, 'Owen Middleton', 'Maiores ad molestiae', 2, 4, 1, '2021-12-10 03:12:35', '2021-12-29 06:37:57');

-- --------------------------------------------------------

--
-- Table structure for table `item_qrs`
--

CREATE TABLE `item_qrs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `assigned_date` datetime DEFAULT NULL,
  `assignor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assignee_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unique_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `purchased_at` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_qrs`
--

INSERT INTO `item_qrs` (`id`, `assigned_date`, `assignor_id`, `assignee_id`, `unique_value`, `item_id`, `department_id`, `supplier_id`, `purchased_at`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, 'yelllw', 1, 5, 3, '2021-06-24', '2021-06-25 08:35:26', '2021-12-10 05:46:42'),
(2, NULL, NULL, NULL, 'Ut sit temporibus ve', 1, 2, 3, '1992-05-06', '2021-12-10 03:01:15', '2021-12-10 03:01:15'),
(3, NULL, NULL, NULL, 'Sunt animi exercita', 1, 2, 3, '1992-05-06', '2021-12-10 03:01:15', '2021-12-10 03:01:15'),
(4, NULL, NULL, NULL, 'hhhhhhhhhhhh', 2, 5, 4, '2022-02-03', '2022-02-03 07:15:18', '2022-02-03 07:19:59');

-- --------------------------------------------------------

--
-- Table structure for table `medicines`
--

CREATE TABLE `medicines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `uses` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `side_effects` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_quantity` bigint(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicines`
--

INSERT INTO `medicines` (`id`, `name`, `description`, `uses`, `side_effects`, `min_quantity`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Panadol', 'Qui expedita sunt i', 'Corporis molestiae i', 'Alfreda Bird', 20, 1, '2022-02-10 03:12:48', '2022-02-10 08:03:14'),
(2, 'Clementine Little', 'Id est architecto e', 'Aliqua Qui rerum au', 'Id eius nihil eum a', 499, 1, '2022-02-21 07:02:48', '2022-02-21 07:02:48'),
(3, 'Vanna Franco', 'Voluptatem temporibu', 'Molestiae beatae qui', 'Incidunt dolor mole', 437, 1, '2022-02-21 07:03:38', '2022-02-21 07:03:38'),
(4, 'Sawyer Kirkland', 'Minus ipsa ad aliqu', 'Esse vitae fugiat t', 'Adipisci et pariatur', 11, 1, '2022-02-22 05:27:10', '2022-02-22 05:27:47');

-- --------------------------------------------------------

--
-- Table structure for table `medicine_dispensings`
--

CREATE TABLE `medicine_dispensings` (
  `request_id` bigint(20) UNSIGNED NOT NULL,
  `inventory_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicine_dispensings`
--

INSERT INTO `medicine_dispensings` (`request_id`, `inventory_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 5, '2022-03-01 07:15:35', '2022-03-01 07:15:35'),
(1, 2, 5, '2022-03-01 07:15:35', '2022-03-01 07:15:35');

-- --------------------------------------------------------

--
-- Table structure for table `medicine_inventories`
--

CREATE TABLE `medicine_inventories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patch_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` bigint(20) NOT NULL,
  `expired_at` date NOT NULL,
  `produced_at` date NOT NULL,
  `medicine_id` bigint(20) UNSIGNED NOT NULL,
  `medicine_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicine_inventories`
--

INSERT INTO `medicine_inventories` (`id`, `patch_no`, `quantity`, `expired_at`, `produced_at`, `medicine_id`, `medicine_order_id`, `created_at`, `updated_at`) VALUES
(1, 'Elit laboriosam na', 5, '1981-08-31', '2014-11-01', 1, NULL, '2022-02-14 07:21:39', '2022-02-14 07:21:39'),
(2, 'Aut qui quod ut aute', 20, '1971-02-22', '2001-09-05', 1, 1, '2022-02-14 07:30:53', '2022-02-14 07:36:41'),
(3, 'Aut qui quod ut', 40, '1971-02-22', '2001-09-05', 1, NULL, '2022-02-14 07:30:53', '2022-02-14 07:36:41'),
(4, 'ED-34-109', 20, '2024-06-04', '2025-10-21', 4, NULL, '2022-02-22 05:28:37', '2022-02-22 05:28:37');

-- --------------------------------------------------------

--
-- Table structure for table `medicine_orders`
--

CREATE TABLE `medicine_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quantity` bigint(20) NOT NULL,
  `total_price` double NOT NULL,
  `supplied_at` datetime DEFAULT NULL,
  `medicine_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicine_orders`
--

INSERT INTO `medicine_orders` (`id`, `quantity`, `total_price`, `supplied_at`, `medicine_id`, `supplier_id`, `created_at`, `updated_at`) VALUES
(1, 5000, 1000, NULL, 1, 3, '2022-02-11 05:56:38', '2022-02-14 07:36:41'),
(2, 10, 100, '2022-02-02 15:31:00', 4, 17, '2022-02-22 05:31:34', '2022-02-22 05:31:34'),
(3, 10, 100, NULL, 4, 17, '2022-02-22 05:31:35', '2022-02-22 07:02:47'),
(4, 761, 192, '2011-12-03 16:06:00', 1, 17, '2022-03-01 07:03:29', '2022-03-01 07:03:29'),
(5, 779, 549, '1974-10-06 01:54:00', 4, 16, '2022-03-01 07:03:51', '2022-03-01 07:03:51'),
(6, 36, 933, '1985-09-05 09:10:00', 3, 17, '2022-03-01 07:13:45', '2022-03-01 07:13:45');

-- --------------------------------------------------------

--
-- Table structure for table `medicine_requests`
--

CREATE TABLE `medicine_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `approver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `requester_id` bigint(20) UNSIGNED NOT NULL,
  `hod_id` bigint(20) UNSIGNED NOT NULL,
  `hon_id` bigint(20) UNSIGNED NOT NULL,
  `pharmacist_id` bigint(20) UNSIGNED NOT NULL,
  `medicine_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` bigint(20) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicine_requests`
--

INSERT INTO `medicine_requests` (`id`, `department_id`, `approver_id`, `requester_id`, `hod_id`, `hon_id`, `pharmacist_id`, `medicine_id`, `quantity`, `type`, `created_at`, `updated_at`) VALUES
(1, 5, 2, 2, 2, 2, 2, 1, 10, 0, '2022-03-01 11:18:39', '2022-03-01 11:18:39');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(4, '2021_03_08_061357_create_roles_table', 1),
(6, '2021_03_08_120826_create_panels_table', 1),
(7, '2021_03_08_121733_create_panel_role_table', 1),
(8, '2021_03_09_061709_create_permission_role_table', 1),
(9, '2021_03_11_104951_create_departments_table', 1),
(11, '2021_03_11_104953_create_sub_categories_table', 1),
(12, '2021_03_12_100716_create_rooms_table', 1),
(13, '2021_03_12_102043_create_users_table', 1),
(14, '2021_03_12_143300_create_suppliers_table', 1),
(16, '2021_03_17_073217_create_item_supplier_table', 1),
(17, '2021_03_22_063215_create_orders_table', 2),
(19, '2021_03_24_062348_create_unique_fields_table', 4),
(25, '2021_03_30_121434_create_accounts_table', 6),
(27, '2021_03_11_104952_create_categories_table', 8),
(32, '2021_03_16_054043_create_factories_table', 12),
(33, '2021_03_17_064514_create_items_table', 13),
(34, '2021_03_30_121420_create_employees_table', 14),
(35, '2021_03_22_074337_create_item_qrs_table', 15),
(36, '2021_12_30_090228_create_supplier_engineers_table', 16),
(39, '2021_12_30_121541_create_equipments_table', 17),
(40, '2021_12_30_135000_create_equipment_table', 18),
(41, '2021_12_31_102400_create_equipment_services_table', 19),
(42, '2022_01_26_092006_create_workshops_table', 20),
(43, '2022_02_10_063830_create_medicines_table', 21),
(45, '2022_02_10_132337_create_medicine_orders_table', 23),
(46, '2022_02_10_132338_create_medicine_inventories_table', 24),
(48, '2022_02_14_123745_create_medicine_requests_table', 25),
(49, '2022_02_16_101327_create_medicine_dispensings_table', 26),
(56, '2021_03_08_121733_create_panel_permission_table', 29),
(57, '2021_03_08_121733_create_department_role_table', 30),
(58, '2021_03_08_120945_create_permissions_table', 31);

-- --------------------------------------------------------

--
-- Table structure for table `panels`
--

CREATE TABLE `panels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `panels`
--

INSERT INTO `panels` (`id`, `title`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Admin Panel', 'admin.home', '2021-03-18 01:24:09', '2021-03-18 01:24:09'),
(2, 'Inventory Management', 'inventory.home', '2021-03-18 01:24:09', '2021-03-18 01:24:09'),
(3, 'Temperature Monitoring', 'temperature.monitoring.home', '2021-03-18 01:24:09', '2021-03-18 01:24:09'),
(4, 'Pharmacy', 'pharmacy.home', '2021-03-18 01:24:09', '2021-03-18 01:24:09'),
(5, 'Newborn Protection', 'protect.newborn.home', '2021-03-18 01:24:09', '2021-03-18 01:24:09'),
(6, 'Medical Devices Maintenance', 'medical.devices.home', '2021-03-18 01:24:09', '2021-03-18 01:24:09'),
(7, 'Equipment Management', 'equipments.home', '2021-03-18 01:24:09', '2021-03-18 01:24:09');

-- --------------------------------------------------------

--
-- Table structure for table `panel_permission`
--

CREATE TABLE `panel_permission` (
  `panel_id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `panel_permission`
--

INSERT INTO `panel_permission` (`panel_id`, `permission_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 18),
(1, 19),
(1, 20),
(1, 21),
(1, 22),
(1, 23),
(1, 24),
(1, 25),
(1, 26),
(1, 27),
(1, 28),
(1, 29),
(1, 30),
(1, 31),
(1, 32),
(1, 33),
(1, 34),
(1, 35),
(1, 36),
(1, 37),
(1, 38),
(1, 39),
(1, 40),
(1, 41),
(1, 42),
(1, 43),
(1, 44),
(1, 45),
(1, 46),
(1, 47),
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(2, 33),
(2, 34),
(2, 35),
(2, 36),
(2, 37),
(2, 38),
(2, 39),
(2, 40),
(4, 60),
(4, 61),
(4, 62),
(4, 63),
(4, 64),
(4, 65),
(4, 66),
(4, 67),
(4, 68),
(4, 69),
(4, 70),
(4, 71),
(4, 72),
(4, 73),
(4, 74),
(4, 75),
(4, 76),
(4, 77),
(7, 48),
(7, 49),
(7, 50),
(7, 51),
(7, 52),
(7, 53),
(7, 54),
(7, 55),
(7, 56),
(7, 57),
(7, 58),
(7, 59);

-- --------------------------------------------------------

--
-- Table structure for table `panel_role`
--

CREATE TABLE `panel_role` (
  `panel_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `panel_role`
--

INSERT INTO `panel_role` (`panel_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2021-03-18 06:24:41', '2021-03-18 06:24:41'),
(1, 9, NULL, NULL),
(2, 1, '2021-03-18 06:24:41', '2021-03-18 06:24:41'),
(4, 1, '2021-12-08 16:49:00', '2021-12-08 16:49:00'),
(4, 10, NULL, NULL),
(5, 8, '2021-12-08 16:44:12', '2021-12-08 16:44:12'),
(7, 1, '2021-03-18 06:24:41', '2021-03-18 06:24:41'),
(7, 3, '2022-03-01 04:38:36', '2022-03-01 04:38:36');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `title`, `slug`, `parent_id`) VALUES
(1, 'View Employees', 'view.employees', NULL),
(2, 'Create Employees', 'create.employees', 1),
(3, 'Edit Employees', 'edit.employees', 1),
(4, 'Toggle Employees', 'toggle.employees', 1),
(5, 'Change Employee Password', 'change.employee.password', 1),
(6, 'View Categories', 'view.categories', NULL),
(7, 'Create Categories', 'create.categories', 6),
(8, 'Edit Categories', 'edit.categories', 6),
(9, 'Toggle Categories', 'toggle.categories', 6),
(10, 'View Departments', 'view.departments', NULL),
(11, 'Create Departments', 'create.departments', 10),
(12, 'Edit Departments', 'edit.departments', 10),
(13, 'Toggle Departments', 'toggle.departments', 10),
(14, 'View Rooms', 'view.rooms', NULL),
(15, 'Create Rooms', 'create.rooms', 14),
(16, 'Edit Rooms', 'edit.rooms', 14),
(17, 'Toggle Rooms', 'toggle.rooms', 14),
(18, 'View Inventory Suppliers', 'view.suppliers.inventory', NULL),
(19, 'Create Inventory Suppliers', 'create.suppliers.inventory', 18),
(20, 'Edit Inventory Suppliers', 'edit.suppliers.inventory', 18),
(21, 'Toggle Inventory Suppliers', 'toggle.suppliers.inventory', 18),
(22, 'View Equipment Suppliers', 'view.suppliers.equipment', NULL),
(23, 'Create Equipment Suppliers', 'create.suppliers.equipment', 22),
(24, 'Edit Equipment Suppliers', 'edit.suppliers.equipment', 22),
(25, 'Toggle Equipment Suppliers', 'toggle.suppliers.equipment', 22),
(26, 'View Equipment Supplier Engineers', 'view.equipment.supplier.engineers', 22),
(27, 'Create Equipment Supplier Engineers', 'create.equipment.supplier.engineers', 26),
(28, 'Edit Equipment Supplier Engineers', 'edit.equipment.supplier.engineers', 26),
(29, 'View Medicine Suppliers', 'view.suppliers.medicine', NULL),
(30, 'Create Medicine Suppliers', 'create.suppliers.medicine', 29),
(31, 'Edit Medicine Suppliers', 'edit.suppliers.medicine', 29),
(32, 'Toggle Medicine Suppliers', 'toggle.suppliers.medicine', 29),
(33, 'View Items', 'view.items', NULL),
(34, 'Create Items', 'create.items', 33),
(35, 'Edit Items', 'edit.items', 33),
(36, 'Toggle Items', 'toggle.items', 33),
(37, 'Toggle Items Assignment', 'toggle.items.assign', 33),
(38, 'View Item Qrs', 'view.item.qrs', 33),
(39, 'Create Item Qrs', 'create.item.qrs', 33),
(40, 'Edit Item Qrs', 'edit.item.qrs', 33),
(41, 'View Employee Roles', 'view.roles', NULL),
(42, 'Create Employee Roles', 'create.roles', 41),
(43, 'Edit Employee Roles', 'edit.roles', 41),
(44, 'View Factories', 'view.factories', NULL),
(45, 'Create Factories', 'create.factories', 44),
(46, 'Edit Factories', 'edit.factories', 44),
(47, 'Toggle Factories', 'toggle.factories', 44),
(48, 'View Equipments', 'view.equipments', NULL),
(49, 'Create Equipments', 'create.equipments', 48),
(50, 'Edit Equipments', 'edit.equipments', 48),
(51, 'Toggle Equipments', 'toggle.equipments', 48),
(52, 'View Equipment Details', 'view.equipment.details', 48),
(53, 'Create Equipment Services', 'create.equipment.services', 48),
(54, 'View Equipment Services', 'view.equipment.services', 48),
(55, 'Edit Equipment Services', 'edit.equipment.services', 54),
(56, 'View Workshops', 'view.workshops', NULL),
(57, 'Create Workshops', 'create.workshops', 56),
(58, 'Edit Workshops', 'edit.workshops', 56),
(59, 'Delete Workshops', 'toggle.workshops', 56),
(60, 'View Medicines', 'view.medicines', NULL),
(61, 'Create Medicines', 'create.medicines', 60),
(62, 'Edit Medicines', 'edit.medicines', 60),
(63, 'Toggle Medicines', 'toggle.medicines', 60),
(64, 'View Medicines Inventories', 'view.medicines.inventories', NULL),
(65, 'Create Medicines Inventories', 'create.medicines.inventories', 64),
(66, 'Edit Medicines Inventories', 'edit.medicines.inventories', 64),
(67, 'View Medicines Orders', 'view.medicines.orders', NULL),
(68, 'Create Medicines Orders', 'create.medicines.orders', 67),
(69, 'Edit Medicines Orders', 'edit.medicines.orders', 67),
(70, 'Toggle Medicines Orders', 'toggle.medicines.orders', 67),
(71, 'View Medicines Requests', 'view.medicines.requests', NULL),
(72, 'Create Medicines Requests', 'create.medicines.requests', 71),
(73, 'Edit Medicines Requests', 'edit.medicines.requests', 71),
(74, 'Approve Medicines Requests', 'approve.medicines.requests', 71),
(75, 'Dispense Medicines Requests', 'dispense.medicines.requests', 71),
(76, 'View Medicines Movement Report', 'view.medicines.movement', NULL),
(77, 'View Medicines Expiry Report', 'view.medicines.expiration', NULL),
(78, 'View Medicines Departments Request', 'view.medicines.departments.request', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 9),
(14, 9),
(48, 3),
(49, 3),
(50, 3),
(60, 10);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_user` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `is_user`, `created_at`, `updated_at`) VALUES
(1, 'super admin', 1, '2021-03-18 01:24:09', '2021-03-18 01:24:09'),
(2, 'sub admin', 1, '2021-03-18 01:24:09', '2021-03-18 01:24:09'),
(3, 'department manager', 1, '2021-03-18 06:27:53', '2021-03-18 06:27:53'),
(4, 'room manager', 1, '2021-04-28 10:32:09', '2021-04-28 10:32:09'),
(5, 'peon', 0, '2021-04-28 10:32:09', '2021-04-28 10:32:09'),
(6, 'Nurse', 1, '2021-06-08 07:31:17', '2021-06-08 07:45:46'),
(7, 'Bangi', 0, '2021-06-08 07:42:04', '2021-06-08 07:54:56'),
(8, 'Teli', 1, '2021-12-08 16:44:04', '2021-12-08 16:44:04'),
(9, 'matthew finch', 1, '2022-03-03 08:06:56', '2022-03-03 08:06:56'),
(10, 'head of pharmacy', 1, '2022-03-03 08:09:09', '2022-03-03 08:09:09');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `title`, `department_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Singer', 1, 1, '2021-03-26 05:41:23', '2021-03-26 05:41:23'),
(2, 'Voucher Off 30', 1, 1, '2021-03-26 05:41:30', '2021-12-08 16:01:29'),
(3, 'Voucher Off 30', 3, 1, '2021-05-17 01:29:00', '2021-05-17 01:29:00'),
(4, 'Room 1', 1, 1, '2021-05-17 01:32:33', '2021-12-08 16:01:19'),
(5, 'Voucher Off 3', 3, 1, '2021-05-17 01:49:33', '2021-05-17 01:52:01');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `name`, `category_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Laptop Computers', 1, 1, '2021-03-18 07:29:53', '2021-12-08 15:50:37'),
(2, 'Monitors', 1, 1, '2021-03-18 03:19:51', '2021-03-18 03:19:51'),
(3, 'Sleeping beds', 2, 1, '2021-03-18 07:27:27', '2021-03-18 07:27:27'),
(4, 'Medical beds', 2, 1, '2021-03-18 07:27:38', '2021-03-18 07:27:38'),
(5, 'Thermometer', 3, 1, '2021-03-18 08:36:50', '2021-03-18 08:36:50'),
(6, 'Chemi', 2, 1, '2021-04-27 04:02:24', '2022-02-03 08:09:40'),
(7, 'registeration', 9, 1, '2022-02-04 05:41:55', '2022-02-04 05:41:55'),
(8, 'الكامل', 8, 1, '2022-02-04 05:43:08', '2022-02-04 05:43:08');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `locale` tinyint(4) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `email`, `phone`, `address`, `locale`, `type`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Shoshana Leon', 'nidanuj@mailinator.com', '+1328893833', 'Aperiam et veniam v', 1, 1, 1, '2021-03-24 04:28:34', '2021-12-30 03:51:46'),
(2, 'Idola Morin', 'zolave@mailinator.com', '+1863181822', 'Eos amet voluptas e', 0, 2, 1, '2021-03-24 04:28:39', '2022-01-03 05:01:59'),
(3, 'Rooney', 'mizycotuli@mailinator.com', '+1408567658', 'Consequat Et volupt', 2, 1, 1, '2021-04-23 04:06:26', '2022-02-10 01:55:34'),
(4, 'Akeem Hard', 'xuhinorydo@mailinator.com', '+1605872237', 'Nam ut at libero nec', 0, 1, 0, '2021-04-23 04:54:30', '2021-12-08 16:32:16'),
(13, 'Adele Stuart', 'vosew@mailinator.com', '03075972239', 'Consectetur labore s', 1, 2, 1, '2021-12-30 03:51:21', '2022-02-03 06:24:39'),
(14, 'Tanisha Mccullough', 'pumy@mailinator.com', '03050458889', 'Quaerat commodi aute', 2, 1, 1, '2022-01-05 03:01:56', '2022-01-05 03:01:56'),
(15, 'Elton Mitchell', 'lymagu@mailinator.com', '03079490356', 'Dolor et ea anim quo', 0, 1, 1, '2022-02-10 01:56:21', '2022-02-10 01:56:21'),
(16, 'Oliver Meyer', 'xidureny@mailinator.com', '03056165856', 'Laborum Qui cumque', 0, 3, 1, '2022-02-22 05:30:26', '2022-02-22 05:30:26'),
(17, 'Sean Mosley', 'hurejapo@mailinator.com', '03060675854', 'Enim harum reprehend', 1, 3, 1, '2022-02-22 05:30:33', '2022-02-22 05:30:40');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_engineers`
--

CREATE TABLE `supplier_engineers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `supplier_engineers`
--

INSERT INTO `supplier_engineers` (`id`, `name`, `email`, `phone`, `supplier_id`, `created_at`, `updated_at`) VALUES
(1, 'Odysseus Hamilton', 'mezucum@mailinator.com', '03064193436', 2, '2021-12-30 06:19:50', '2021-12-30 06:19:50'),
(2, 'Nina Wino', 'rypela@mailinator.com', '03016819638', 2, '2021-12-30 06:24:08', '2021-12-30 06:25:00'),
(3, 'Georgia Madden', 'cuvukasi@mailinator.com', '03088723551', 1, '2022-02-03 06:25:06', '2022-02-03 06:25:06'),
(4, 'Danielle Thornton', 'quvabogo@mailinator.com', '03070248188', 13, '2022-03-02 03:10:56', '2022-03-02 03:10:56');

-- --------------------------------------------------------

--
-- Table structure for table `workshops`
--

CREATE TABLE `workshops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `manager` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `engineer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `workshops`
--

INSERT INTO `workshops` (`id`, `name`, `manager`, `engineer`, `date`, `created_at`, `updated_at`) VALUES
(1, 'Maggie Larson', 'Occaecat', 'Qui placeat aut exc', '2021-06-25 03:53:00', '2022-01-26 06:24:03', '2022-01-26 06:37:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_email_unique` (`email`),
  ADD KEY `accounts_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `departments_title_unique` (`title`);

--
-- Indexes for table `department_role`
--
ALTER TABLE `department_role`
  ADD PRIMARY KEY (`department_id`,`role_id`),
  ADD KEY `department_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_number_unique` (`number`),
  ADD UNIQUE KEY `employees_email_unique` (`email`),
  ADD UNIQUE KEY `employees_phone_unique` (`phone`),
  ADD KEY `employees_department_id_foreign` (`department_id`),
  ADD KEY `employees_role_id_foreign` (`role_id`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `equipment_name_serial_no_unique` (`name`,`serial_no`),
  ADD KEY `equipment_department_id_foreign` (`department_id`),
  ADD KEY `equipment_sub_category_id_foreign` (`sub_category_id`),
  ADD KEY `equipment_supplier_engineer_id_foreign` (`supplier_engineer_id`);

--
-- Indexes for table `equipment_services`
--
ALTER TABLE `equipment_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `equipment_services_equipment_id_foreign` (`equipment_id`);

--
-- Indexes for table `factories`
--
ALTER TABLE `factories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `factories_name_unique` (`name`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `items_sub_category_id_foreign` (`sub_category_id`),
  ADD KEY `items_factory_id_foreign` (`factory_id`);

--
-- Indexes for table `item_qrs`
--
ALTER TABLE `item_qrs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `item_qrs_item_id_unique_value_unique` (`item_id`,`unique_value`),
  ADD KEY `item_qrs_supplier_id_foreign` (`supplier_id`),
  ADD KEY `item_qrs_assignor_id_foreign` (`assignor_id`),
  ADD KEY `item_qrs_assignee_id_foreign` (`assignee_id`),
  ADD KEY `item_qrs_department_id_foreign` (`department_id`);

--
-- Indexes for table `medicines`
--
ALTER TABLE `medicines`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `medicine_dispensings`
--
ALTER TABLE `medicine_dispensings`
  ADD PRIMARY KEY (`request_id`,`inventory_id`),
  ADD KEY `medicine_dispensings_inventory_id_foreign` (`inventory_id`);

--
-- Indexes for table `medicine_inventories`
--
ALTER TABLE `medicine_inventories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `medicine_inventories_patch_no_unique` (`patch_no`),
  ADD KEY `medicine_inventories_medicine_id_foreign` (`medicine_id`),
  ADD KEY `medicine_inventories_medicine_order_id_foreign` (`medicine_order_id`);

--
-- Indexes for table `medicine_orders`
--
ALTER TABLE `medicine_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medicine_orders_medicine_id_foreign` (`medicine_id`),
  ADD KEY `medicine_orders_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `medicine_requests`
--
ALTER TABLE `medicine_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medicine_requests_department_id_foreign` (`department_id`),
  ADD KEY `medicine_requests_approver_id_foreign` (`approver_id`),
  ADD KEY `medicine_requests_requester_id_foreign` (`requester_id`),
  ADD KEY `medicine_requests_hod_id_foreign` (`hod_id`),
  ADD KEY `medicine_requests_hon_id_foreign` (`hon_id`),
  ADD KEY `medicine_requests_pharmacist_id_foreign` (`pharmacist_id`),
  ADD KEY `medicine_requests_medicine_id_foreign` (`medicine_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `panels`
--
ALTER TABLE `panels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `panel_permission`
--
ALTER TABLE `panel_permission`
  ADD PRIMARY KEY (`panel_id`,`permission_id`),
  ADD KEY `panel_permission_permission_id_foreign` (`permission_id`);

--
-- Indexes for table `panel_role`
--
ALTER TABLE `panel_role`
  ADD PRIMARY KEY (`panel_id`,`role_id`),
  ADD KEY `panel_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_slug_unique` (`slug`),
  ADD KEY `permissions_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rooms_title_department_id_unique` (`title`,`department_id`),
  ADD KEY `rooms_department_id_foreign` (`department_id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `suppliers_email_unique` (`email`),
  ADD UNIQUE KEY `suppliers_phone_unique` (`phone`);

--
-- Indexes for table `supplier_engineers`
--
ALTER TABLE `supplier_engineers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `supplier_engineers_email_unique` (`email`),
  ADD UNIQUE KEY `supplier_engineers_phone_unique` (`phone`),
  ADD KEY `supplier_engineers_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `workshops`
--
ALTER TABLE `workshops`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `equipment_services`
--
ALTER TABLE `equipment_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `factories`
--
ALTER TABLE `factories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `item_qrs`
--
ALTER TABLE `item_qrs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `medicines`
--
ALTER TABLE `medicines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `medicine_inventories`
--
ALTER TABLE `medicine_inventories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `medicine_orders`
--
ALTER TABLE `medicine_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `medicine_requests`
--
ALTER TABLE `medicine_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `panels`
--
ALTER TABLE `panels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `supplier_engineers`
--
ALTER TABLE `supplier_engineers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `workshops`
--
ALTER TABLE `workshops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `department_role`
--
ALTER TABLE `department_role`
  ADD CONSTRAINT `department_role_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `department_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `employees_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `equipment_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `equipment_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `equipment_supplier_engineer_id_foreign` FOREIGN KEY (`supplier_engineer_id`) REFERENCES `supplier_engineers` (`id`);

--
-- Constraints for table `equipment_services`
--
ALTER TABLE `equipment_services`
  ADD CONSTRAINT `equipment_services_equipment_id_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_factory_id_foreign` FOREIGN KEY (`factory_id`) REFERENCES `factories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `items_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `item_qrs`
--
ALTER TABLE `item_qrs`
  ADD CONSTRAINT `item_qrs_assignee_id_foreign` FOREIGN KEY (`assignee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `item_qrs_assignor_id_foreign` FOREIGN KEY (`assignor_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `item_qrs_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `item_qrs_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `item_qrs_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `medicine_dispensings`
--
ALTER TABLE `medicine_dispensings`
  ADD CONSTRAINT `medicine_dispensings_inventory_id_foreign` FOREIGN KEY (`inventory_id`) REFERENCES `medicine_inventories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicine_dispensings_request_id_foreign` FOREIGN KEY (`request_id`) REFERENCES `medicine_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `medicine_inventories`
--
ALTER TABLE `medicine_inventories`
  ADD CONSTRAINT `medicine_inventories_medicine_id_foreign` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicine_inventories_medicine_order_id_foreign` FOREIGN KEY (`medicine_order_id`) REFERENCES `medicine_orders` (`id`);

--
-- Constraints for table `medicine_orders`
--
ALTER TABLE `medicine_orders`
  ADD CONSTRAINT `medicine_orders_medicine_id_foreign` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicine_orders_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`);

--
-- Constraints for table `medicine_requests`
--
ALTER TABLE `medicine_requests`
  ADD CONSTRAINT `medicine_requests_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `medicine_requests_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicine_requests_hod_id_foreign` FOREIGN KEY (`hod_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `medicine_requests_hon_id_foreign` FOREIGN KEY (`hon_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `medicine_requests_medicine_id_foreign` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicine_requests_pharmacist_id_foreign` FOREIGN KEY (`pharmacist_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `medicine_requests_requester_id_foreign` FOREIGN KEY (`requester_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `panel_permission`
--
ALTER TABLE `panel_permission`
  ADD CONSTRAINT `panel_permission_panel_id_foreign` FOREIGN KEY (`panel_id`) REFERENCES `panels` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `panel_permission_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `panel_role`
--
ALTER TABLE `panel_role`
  ADD CONSTRAINT `panel_role_panel_id_foreign` FOREIGN KEY (`panel_id`) REFERENCES `panels` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `panel_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `permissions_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `supplier_engineers`
--
ALTER TABLE `supplier_engineers`
  ADD CONSTRAINT `supplier_engineers_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
