-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3307
-- Generation Time: May 13, 2023 at 10:46 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nature`
--

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `gender` int(1) NOT NULL DEFAULT 0,
  `ssn` varchar(14) NOT NULL,
  `job_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `birth_date`, `gender`, `ssn`, `job_id`) VALUES
(1, '2001-09-25', 0, '45678912345678', 7),
(16, '1998-05-15', 0, '54984561619548', 11),
(17, '1996-10-17', 0, '87894564562148', 10),
(18, '1998-01-01', 1, '89794156419878', 8),
(19, '1999-09-07', 1, '45947897989556', 9);

-- --------------------------------------------------------

--
-- Table structure for table `farm`
--

CREATE TABLE `farm` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `product_type` varchar(50) NOT NULL,
  `no_of_employees` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `id` int(11) NOT NULL,
  `p_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `favorite`
--

INSERT INTO `favorite` (`id`, `p_id`, `u_id`) VALUES
(6, 5, 3),
(8, 7, 3),
(9, 9, 3),
(10, 10, 3);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `title`) VALUES
(7, 'Manager'),
(8, 'HR'),
(9, 'Sales Man'),
(10, 'Warehouse Manager'),
(11, 'Delivery Man');

-- --------------------------------------------------------

--
-- Table structure for table `job_permissions`
--

CREATE TABLE `job_permissions` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `job_permissions`
--

INSERT INTO `job_permissions` (`id`, `job_id`, `permission_id`) VALUES
(26, 7, 26),
(27, 7, 25),
(28, 7, 24),
(29, 7, 21),
(30, 7, 20),
(31, 7, 19),
(32, 7, 18),
(33, 7, 17),
(34, 7, 16),
(35, 7, 15),
(36, 7, 14),
(37, 7, 13),
(38, 7, 12),
(39, 7, 11),
(40, 7, 10),
(41, 7, 9),
(42, 7, 8),
(43, 7, 7),
(44, 7, 6),
(45, 7, 5),
(46, 7, 4),
(47, 7, 3),
(48, 7, 2),
(49, 7, 1),
(50, 8, 26),
(51, 8, 25),
(52, 8, 24),
(53, 8, 16),
(54, 8, 15),
(55, 8, 14),
(56, 8, 13),
(57, 8, 12),
(58, 8, 11),
(59, 8, 10),
(60, 8, 9),
(61, 8, 8),
(62, 9, 20),
(63, 9, 19),
(64, 9, 18),
(65, 9, 17),
(66, 9, 7),
(67, 9, 3),
(68, 9, 2),
(69, 9, 1),
(70, 10, 20),
(71, 10, 7),
(72, 10, 6),
(73, 10, 5),
(74, 10, 4),
(75, 10, 1),
(119, 11, 19),
(120, 11, 18),
(121, 11, 17),
(122, 11, 7);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `u_name` varchar(50) NOT NULL,
  `u_email` varchar(50) NOT NULL,
  `u_phone` varchar(11) NOT NULL,
  `message` text NOT NULL,
  `isRead` tinyint(1) NOT NULL DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `o_id` int(11) NOT NULL,
  `p_id` int(11) NOT NULL,
  `o_price` double NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `total` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `o_id`, `p_id`, `o_price`, `quantity`, `total`) VALUES
(13, 23, 6, 3, 3, 9),
(14, 23, 5, 10, 2, 20),
(15, 23, 7, 3.5, 3, 10.5),
(16, 23, 9, 5.2, 3, 15.600000000000001),
(17, 24, 5, 10, 1, 10),
(18, 24, 6, 3, 1, 3),
(29, 30, 7, 3.5, 1, 3.5),
(30, 31, 6, 3, 5, 15),
(31, 32, 6, 3, 7, 21),
(32, 32, 5, 10, 2, 20),
(33, 32, 7, 3.5, 2, 7),
(34, 32, 9, 5.2, 2, 10.4),
(35, 33, 5, 10, 3, 30),
(36, 33, 6, 3, 4, 12),
(37, 33, 7, 3.5, 2, 7),
(38, 34, 14, 12, 2, 24),
(39, 34, 6, 3, 2, 6),
(40, 34, 7, 3.5, 2, 7),
(41, 34, 18, 10, 1, 10),
(42, 34, 16, 5, 1, 5),
(43, 35, 5, 10, 3, 30),
(44, 35, 13, 15, 1, 15),
(45, 35, 17, 5.2, 1, 5.2),
(46, 36, 6, 3, 1, 3),
(47, 36, 7, 3.5, 1, 3.5);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `o_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `city` varchar(30) NOT NULL,
  `state` text NOT NULL,
  `street` varchar(30) NOT NULL,
  `building` varchar(30) NOT NULL,
  `flat` varchar(30) NOT NULL,
  `payment_method` varchar(30) DEFAULT NULL,
  `sub_total` double NOT NULL,
  `shipping_tax` double NOT NULL,
  `total` double NOT NULL,
  `o_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`o_id`, `u_id`, `city`, `state`, `street`, `building`, `flat`, `payment_method`, `sub_total`, `shipping_tax`, `total`, `o_date`) VALUES
(23, 2, 'cairo', 'Nasr City', 'Makram', '45', '2', 'pay_with_credit_card', 55.1, 5.51, 5.51, '2023-05-07 14:53:31'),
(24, 2, 'cairo', 'elsalam', 'alqudos', '6', '2', 'cash_on_delivery', 13, 1.3, 1.3, '2023-05-07 14:57:07'),
(28, 2, '', '', '', '', '', NULL, 3.5, 0.35, 0.35, '2023-05-07 15:57:28'),
(29, 2, 'Cairo', 'elsalam', 'alqudos', '756', '4', 'pay_with_credit_card', 5.2, 0.52, 0.52, '2023-05-07 15:58:02'),
(30, 3, 'London', 'state', 'street', '54', '8', 'pay_with_credit_card', 16.5, 1.65, 1.65, '2023-05-07 16:03:35'),
(31, 3, '', '', '', '', '', NULL, 15, 1.5, 1.5, '2023-05-07 16:09:29'),
(32, 3, 'cairo', 'elsalam', 'alqudos', '78', '5', 'pay_with_credit_card', 58.4, 5.84, 5.84, '2023-05-08 03:12:17'),
(33, 3, 'Cairo', 'Nasr City', 'me3za', '45', '2', 'pay_with_credit_card', 49, 4.9, 4.9, '2023-05-08 05:44:08'),
(34, 5, 'Helwan', 'Cairo', '9th', '45', '2', 'pay_with_credit_card', 52, 5.2, 57.2, '2023-05-09 22:57:22'),
(35, 2, 'Nasr City', 'Cairo', 'Makram', '45 Alnour', '2', 'pay_with_credit_card', 50.2, 5.02, 55.22, '2023-05-10 17:16:42'),
(36, 3, 'dsf', 'fdsa', 'fsad', 'fsad', 'fsda', 'cash_on_delivery', 6.5, 0.65, 7.15, '2023-05-11 20:25:41');

-- --------------------------------------------------------

--
-- Table structure for table `order_payment`
--

CREATE TABLE `order_payment` (
  `o_id` int(11) NOT NULL,
  `card_number` varchar(16) NOT NULL,
  `card_holder` varchar(30) NOT NULL,
  `card_cvv` varchar(4) NOT NULL,
  `expiration_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `order_payment`
--

INSERT INTO `order_payment` (`o_id`, `card_number`, `card_holder`, `card_cvv`, `expiration_date`) VALUES
(23, '5647987897897845', 'Thia Queen', '6545', '2023-05-18'),
(29, '6978978/98797978', 'Thia Queen', '5674', '2023-05-30'),
(30, '8795465231321984', 'Anna De Armas', '1231', '2023-05-16'),
(32, '4546655689875246', 'Anna De Armas', '8798', '2023-05-25'),
(33, '7878977879789779', 'Anna De Armas', '5464', '2024-04-15'),
(34, '5478897465454564', 'MIA FISHER', '4748', '2023-05-10'),
(35, '4564545498784651', 'Thia Queen', '4564', '2023-05-19');

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE `order_status` (
  `status_id` int(11) NOT NULL,
  `o_id` int(11) NOT NULL,
  `e_id` int(11) DEFAULT NULL,
  `status` varchar(30) NOT NULL,
  `status_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `order_status`
--

INSERT INTO `order_status` (`status_id`, `o_id`, `e_id`, `status`, `status_date`) VALUES
(5, 28, 1, 'pending', '2023-05-07 15:57:28'),
(6, 29, 1, 'completed', '2023-05-07 15:58:02'),
(7, 30, 1, 'completed', '2023-05-07 16:03:35'),
(8, 31, 1, 'pending', '2023-05-07 16:09:29'),
(9, 32, 1, 'completed', '2023-05-08 03:12:17'),
(10, 33, 1, 'completed', '2023-05-08 05:44:08'),
(11, 34, 1, 'completed', '2023-05-09 22:57:22'),
(12, 35, 1, 'completed', '2023-05-10 17:16:42'),
(13, 36, 1, 'pending', '2023-05-11 20:25:41');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`) VALUES
(1, 'Total Sales'),
(2, 'New Orders'),
(3, 'View Orders'),
(4, 'Add Product'),
(5, 'Update Product'),
(6, 'Delete Product'),
(7, 'View Products'),
(8, 'Add Member'),
(9, 'Member Jobs'),
(10, 'View Members'),
(11, 'View Profile'),
(12, 'View Jobs'),
(13, 'Add Job'),
(14, 'Update Job'),
(15, 'Update Job Permissions'),
(16, 'Update Profile'),
(17, 'Print Order'),
(18, 'View Order Details'),
(19, 'Cancel Order'),
(20, 'View Notifications'),
(21, 'View Messages'),
(24, 'Delete Permission'),
(25, 'Add Permission'),
(26, 'Update Permission');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `price` double NOT NULL,
  `image` varchar(50) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category`, `price`, `image`, `date`) VALUES
(5, 'Cabbage', 'Vegetables', 10, 'product-4 - Copy.png', '2023-05-04 11:29:21'),
(6, 'Apple', 'Fruits', 3, 'apple.png', '2023-05-04 11:29:21'),
(7, 'Watermelon', 'Fruits', 3.5, 'watermelon.png', '2023-05-04 11:29:21'),
(8, 'Banana', 'Fruits', 4.5, 'banana - Copy.png', '2023-05-04 11:29:21'),
(9, 'JFAD', 'flowers', 10.5, 'carrot - Copy.png', '2023-05-04 11:29:21'),
(10, 'Tomato', 'Vegetables', 2.5, 'tomato.png', '2023-05-04 11:29:21'),
(12, 'Strawbary', 'friuts', 20, 'strawberry.png', '2023-05-09 22:06:25'),
(13, 'Green Grapes', 'friuts', 15, 'green grapes.png', '2023-05-09 22:06:56'),
(14, 'Broccoli', 'Vegetables', 12, 'broccoli.png', '2023-05-09 22:07:23'),
(15, 'Onion', 'Vegetables', 10, 'cart-img-2.png', '2023-05-09 22:08:15'),
(16, 'Carrots', 'Vegetables', 5, 'carrot.png', '2023-05-09 22:08:32'),
(17, 'Papper', 'Vegetables', 5.2, 'red papper - Copy.png', '2023-05-09 22:10:26'),
(18, 'Orange', 'friuts', 10, 'orange.png', '2023-05-09 22:10:51');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` text DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `group_id` int(11) NOT NULL,
  `image` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `address`, `password`, `group_id`, `image`, `created_at`) VALUES
(1, 'Abdo Goda', 'abdogoda@gmail.com', '01142366716', '77 The Crescent\nPERTH\nPH97 9YG', '123456', 0, '5.png', '2023-04-24 20:58:42'),
(2, 'Thia Queen', 'thia@gmail.com', '01212465456', '9010 New Street\nCARLISLE\nCA71 1GL', '123456', 1, '6.png', '2023-04-24 21:06:20'),
(3, 'Anna De Armas', 'anna@gmail.com', '01234567894', '742 Mill Lane\nTWICKENHAM\nTW48 7XN', '123456', 1, 'th.jpg', '2023-04-24 21:14:31'),
(4, 'John Wick', 'john@gamil.com', '01019135059', '89 Kingsway\nLUTON\nLU73 4WC', '123456', 1, '9.jpg', '2023-04-24 21:16:43'),
(5, 'Mia Fisher', 'mia@gmail.com', '01045789635', NULL, '123456', 1, 'c2.jpg', '2023-04-24 21:40:51'),
(7, 'dasfdsaf', 'fdsfds@gmail.com', '01010262040', 'user1 address', '123456', 1, 'chefs-03.jpg', '2023-05-04 17:52:52'),
(16, 'Peter Dinklage', 'peter@gmail.com', '01123454687', '849 Stanley Road SUTTON SM21 7BZ', '1234', 0, 'peter.jpg', '2023-05-13 19:35:14'),
(17, 'Kit Harington', 'kit@gmail.com', '01212465456', '12 Windsor Road MANCHESTER M4 0QE', '1234', 0, 'kit.jpg', '2023-05-13 19:50:44'),
(18, 'Emilia Clarke', 'emilia@gmail.com', '01241624564', '9555 Grange Road YORK YO55 2LC', '1234', 0, 'emilia.jpg', '2023-05-13 19:54:22'),
(19, 'Olivia Cooke', 'olivia@gmail.com', '01234567891', '64 Church Street EDINBURGH EH3 2TQ', '1345', 0, 'olivia.jpg', '2023-05-13 19:57:25');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD UNIQUE KEY `employee_id` (`employee_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `farm`
--
ALTER TABLE `farm`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `p_id` (`p_id`),
  ADD KEY `u_id` (`u_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_permissions`
--
ALTER TABLE `job_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_id` (`job_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `o_id` (`o_id`),
  ADD KEY `p_id` (`p_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`o_id`),
  ADD KEY `u_id` (`u_id`);

--
-- Indexes for table `order_payment`
--
ALTER TABLE `order_payment`
  ADD KEY `o_id` (`o_id`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`status_id`),
  ADD KEY `order_status_ibfk_1` (`o_id`),
  ADD KEY `e_is` (`e_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `farm`
--
ALTER TABLE `farm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `job_permissions`
--
ALTER TABLE `job_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `o_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `order_status`
--
ALTER TABLE `order_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employee_id_fk` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`);

--
-- Constraints for table `favorite`
--
ALTER TABLE `favorite`
  ADD CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`p_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `favorite_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `job_permissions`
--
ALTER TABLE `job_permissions`
  ADD CONSTRAINT `job_permissions_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`),
  ADD CONSTRAINT `job_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`o_id`) REFERENCES `order_details` (`o_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`p_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_payment`
--
ALTER TABLE `order_payment`
  ADD CONSTRAINT `order_payment_ibfk_1` FOREIGN KEY (`o_id`) REFERENCES `order_details` (`o_id`);

--
-- Constraints for table `order_status`
--
ALTER TABLE `order_status`
  ADD CONSTRAINT `order_status_ibfk_1` FOREIGN KEY (`o_id`) REFERENCES `order_details` (`o_id`),
  ADD CONSTRAINT `order_status_ibfk_2` FOREIGN KEY (`e_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
