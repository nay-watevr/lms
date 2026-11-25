-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 24, 2026 at 06:16 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lms_ptik`
--

-- --------------------------------------------------------

--
-- Table structure for table `forum_replies`
--

CREATE TABLE `forum_replies` (
  `id` int(10) UNSIGNED NOT NULL,
  `topic_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `isi` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forum_topics`
--

CREATE TABLE `forum_topics` (
  `id` int(10) UNSIGNED NOT NULL,
  `judul` varchar(200) NOT NULL,
  `isi` text NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `id` int(10) UNSIGNED NOT NULL,
  `judul` varchar(200) NOT NULL,
  `isi` mediumtext NOT NULL,
  `tautan` varchar(2048) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` int(10) UNSIGNED NOT NULL,
  `judul` varchar(200) NOT NULL,
  `deskripsi` text NOT NULL,
  `status` enum('draft','published') NOT NULL DEFAULT 'draft',
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `judul`, `deskripsi`, `status`, `created_by`, `created_at`) VALUES
(1, 'Kuis 1 — Dasar Manajemen Proyek TI', 'Pilih satu jawaban yang paling tepat.\r\nSetiap soal memiliki bobot yang sama.\r\nKuis hanya dapat dikirim satu kali.', 'published', 1, '2026-11-04 06:13:29'),
(2, 'Matematika Dasar', 'Hi', 'published', 1, '2026-11-04 06:29:53'),
(3, 'Matematika Lanjutan', 'Silakan Kerjakan dengan Jujur', 'published', 1, '2026-11-24 07:23:26');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_attempts`
--

CREATE TABLE `quiz_attempts` (
  `id` int(10) UNSIGNED NOT NULL,
  `quiz_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `jumlah_benar` int(10) UNSIGNED NOT NULL,
  `jumlah_soal` int(10) UNSIGNED NOT NULL,
  `nilai` decimal(5,2) NOT NULL,
  `jawaban_json` mediumtext NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_attempts`
--

INSERT INTO `quiz_attempts` (`id`, `quiz_id`, `user_id`, `jumlah_benar`, `jumlah_soal`, `nilai`, `jawaban_json`, `submitted_at`) VALUES
(1, 1, 2, 0, 2, 0.00, '{\"1\":\"D\",\"2\":\"C\"}', '2026-11-04 06:16:38'),
(2, 1, 3, 1, 2, 50.00, '{\"1\":\"A\",\"2\":\"B\"}', '2026-11-04 06:18:08'),
(3, 2, 2, 1, 2, 50.00, '{\"3\":\"C\",\"4\":\"B\"}', '2026-11-04 06:31:40'),
(4, 2, 3, 1, 2, 50.00, '{\"3\":\"B\",\"4\":\"B\"}', '2026-11-04 06:32:30'),
(5, 3, 2, 1, 1, 100.00, '{\"5\":\"C\"}', '2026-11-24 07:24:59');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `id` int(10) UNSIGNED NOT NULL,
  `quiz_id` int(10) UNSIGNED NOT NULL,
  `pertanyaan` text NOT NULL,
  `opsi_a` varchar(500) NOT NULL,
  `opsi_b` varchar(500) NOT NULL,
  `opsi_c` varchar(500) NOT NULL,
  `opsi_d` varchar(500) NOT NULL,
  `kunci` enum('A','B','C','D') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_questions`
--

INSERT INTO `quiz_questions` (`id`, `quiz_id`, `pertanyaan`, `opsi_a`, `opsi_b`, `opsi_c`, `opsi_d`, `kunci`) VALUES
(1, 1, 'Apa fungsi utama WBS dalam proyek?', 'Memecah pekerjaan proyek menjadi bagian yang lebih kecil', 'Mengganti seluruh anggota tim', 'Menghapus jadwal proyek', 'Menentukan warna aplikasi', 'A'),
(2, 1, 'Apa kegunaan Git dalam pengembangan aplikasi?', 'Menghitung nilai mahasiswa secara otomatis', 'Mengelola riwayat perubahan kode', 'Menggantikan database', 'Membuat koneksi internet', 'A'),
(3, 2, '1+1', '1', '2', '3', '4', 'D'),
(4, 2, '10x10=', '10', '100', '1000', 'Semua Benar', 'B'),
(5, 3, '10x10=', '1', '10', '100', '1000', 'C');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_sessions`
--

CREATE TABLE `quiz_sessions` (
  `quiz_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `started_at` bigint(20) UNSIGNED NOT NULL,
  `expires_at` bigint(20) UNSIGNED NOT NULL,
  `jawaban_json` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_sessions`
--

INSERT INTO `quiz_sessions` (`quiz_id`, `user_id`, `started_at`, `expires_at`, `jawaban_json`) VALUES
(2, 2, 1793773884, 1793774004, '{\"3\":\"C\",\"4\":\"B\"}'),
(2, 3, 1793773934, 1793774054, '{\"3\":\"B\",\"4\":\"B\"}'),
(3, 2, 1795505088, 1795505208, '{\"5\":\"C\"}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('pengajar','mahasiswa') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--
-- Password disimpan sebagai hash bcrypt untuk password_verify() di login.php.
--

INSERT INTO `users` (`id`, `nama`, `username`, `password`, `role`, `created_at`) VALUES
(1, 'Pengajar Demo', 'pengajar', '$2y$12$yxGX3g6FdjCKe75QTPaN5eDNub8bCBy4OE2Zm2ZbzQ9rJNwk.FgUi', 'pengajar', '2026-11-04 05:37:39'),
(2, 'Mahasiswa 01 (Demo)', 'mahasiswa01', '$2y$12$phsz/tky0LGdq2siJC/7m.c0wPG9jrUcMO4z7pSqfrOBdMK5p.3U.', 'mahasiswa', '2026-11-04 05:37:39'),
(3, 'Mahasiswa 02 (Demo)', 'mahasiswa02', '$2y$12$6iaLL0/lMHkQ8C2lIRJvTugrFcAUzymiHEtyJavq24kWGjekn6JAO', 'mahasiswa', '2026-11-04 05:49:51'),
(4, 'Mahasiswa 03 (Demo)', 'mahasiswa03', '$2y$12$GVRt40xAsqghwp1R.bKsne2pmeQkO/OFS096F.mW.dJaB1bolM4VO', 'mahasiswa', CURRENT_TIMESTAMP),
(5, 'Mahasiswa 04 (Demo)', 'mahasiswa04', '$2y$12$SqPr.IEJwm04uXJtCaJzKuhFA59JHz035WgBCv3B4uh9OUFRVPQ3y', 'mahasiswa', CURRENT_TIMESTAMP),
(6, 'Mahasiswa 05 (Demo)', 'mahasiswa05', '$2y$12$ppsb4tdMbEE2ahmGcIdF4ustX6y3LGTNyHG9C2i2eJ1TSGCiWn/oq', 'mahasiswa', CURRENT_TIMESTAMP);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `forum_replies`
--
ALTER TABLE `forum_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topic_id` (`topic_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `forum_topics`
--
ALTER TABLE `forum_topics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_materials_user` (`created_by`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `satu_percobaan` (`quiz_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `quiz_sessions`
--
ALTER TABLE `quiz_sessions`
  ADD PRIMARY KEY (`quiz_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `forum_replies`
--
ALTER TABLE `forum_replies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `forum_topics`
--
ALTER TABLE `forum_topics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `forum_replies`
--
ALTER TABLE `forum_replies`
  ADD CONSTRAINT `forum_replies_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_replies_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `forum_topics`
--
ALTER TABLE `forum_topics`
  ADD CONSTRAINT `forum_topics_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `fk_materials_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD CONSTRAINT `quiz_attempts_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`),
  ADD CONSTRAINT `quiz_attempts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD CONSTRAINT `quiz_questions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_sessions`
--
ALTER TABLE `quiz_sessions`
  ADD CONSTRAINT `quiz_sessions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_sessions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
