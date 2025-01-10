-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 10/01/2025 às 20:14
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `faturas`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `cte`
--

CREATE TABLE `cte` (
  `id` int(11) NOT NULL,
  `fatura_id` int(11) NOT NULL,
  `dados` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`dados`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `faturas`
--

CREATE TABLE `faturas` (
  `id` int(11) NOT NULL,
  `transportadora_id` int(11) DEFAULT NULL,
  `numero_fatura` varchar(50) NOT NULL,
  `vencimento` date NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `boleto` varchar(255) DEFAULT NULL,
  `arquivos_cte` varchar(255) DEFAULT NULL,
  `relatorio` varchar(255) DEFAULT NULL,
  `data_lancamento` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `valor_total_notas` decimal(10,2) DEFAULT 0.00,
  `modificado_por` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `transportadora`
--

CREATE TABLE `transportadora` (
  `id` int(11) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `cnpj` varchar(20) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modificado_por` int(11) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `transportadora`
--

INSERT INTO `transportadora` (`id`, `codigo`, `cnpj`, `nome`, `updated_at`, `modificado_por`, `ativo`) VALUES
(181, '98238', '08848231002610', 'ATUAL CARGAS', '2024-12-30 16:35:52', 1, 1),
(182, '97777', '08848231000242', 'ATUAL CARGAS', '2024-12-30 16:24:38', 1, 1),
(183, '44186', '08848231001133', 'ATUAL CARGAS', '2024-12-30 16:09:29', 1, 1),
(184, '98591', '08848231002881', 'ATUAL CARGAS', '2024-12-30 16:35:48', 1, 1),
(185, '98336', '08848231003349', 'ATUAL CARGAS', '2024-12-30 16:09:29', 1, 1),
(186, '7152', '08848231000161', 'ATUAL CARGAS', '2024-12-30 16:09:29', 1, 1),
(187, '98987', '08848231003268', 'ATUAL CARGAS', '2024-12-30 16:09:29', 1, 1),
(188, '98429', '08848231002709', 'ATUAL CARGAS', '2024-12-30 16:09:29', 1, 1),
(189, '98891', '08848231001990', 'ATUAL CARGAS', '2024-12-30 16:09:29', 1, 1),
(190, '99233', '08848231002377', 'ATUAL CARGAS', '2024-12-30 16:09:29', 1, 1),
(191, '99421', '08848231002962', 'ATUAL CARGAS', '2024-12-30 16:09:29', 1, 1),
(192, '99365', '09296295000240', 'AZUL', '2024-12-30 16:09:29', 1, 1),
(193, '7445', '09296295001646', 'AZUL', '2024-12-30 16:09:29', 1, 1),
(194, '44222', '09296295002022', 'AZUL', '2024-12-30 16:09:29', 1, 1),
(195, '8852', '34184363000146', 'FLEX', '2024-12-30 16:09:29', 1, 1),
(196, '5487', '85348407000833', 'AZURE', '2024-12-30 16:09:29', 1, 1),
(197, '98384', '85348407001481', 'AZURE', '2024-12-30 16:09:29', 1, 1),
(198, '10920', '85348407000400', 'AZURE', '2024-12-30 16:09:29', 1, 1),
(199, '97890', '85348407000590', 'AZURE', '2024-12-30 16:09:29', 1, 1),
(200, '8951', '85348407000167', 'AZURE', '2024-12-30 16:09:29', 1, 1),
(201, '8991', '85348407000248', 'AZURE', '2024-12-30 16:09:29', 1, 1),
(202, '3470', '03115038000106', 'CAB', '2024-12-30 16:09:29', 1, 1),
(203, '4879', '03115038000150', 'CAB', '2024-12-30 16:09:29', 1, 1),
(204, '97752', '03115038000154', 'CAB', '2024-12-30 16:09:29', 1, 1),
(205, '40579', '93986032000199', 'CIVARDI', '2024-12-30 16:09:29', 1, 1),
(206, '9002', '93986032000431', 'CIVARDI', '2024-12-30 16:09:29', 1, 1),
(207, '3451', '34028316196091', 'CORREIOS', '2024-12-30 16:09:29', 1, 1),
(208, '6450', '34028316002823', 'CORREIOS', '2024-12-30 16:09:29', 1, 1),
(209, '98865', '34028316002661', 'CORREIOS', '2024-12-30 16:09:29', 1, 1),
(210, '99203', '13817856000791', 'FARIAZ FAZ', '2024-12-30 16:09:29', 1, 1),
(211, '95757', '13817856000104', 'FARIAZ FAZ', '2024-12-30 16:09:29', 1, 1),
(212, '95700', '04455308000182', 'FLYVILLE', '2024-12-30 16:09:29', 1, 1),
(213, '99009', '04455308000344', 'FLYVILLE', '2024-12-30 16:09:29', 1, 1),
(214, '98847', '28186408000119', 'K DAS CARGAS', '2024-12-30 16:09:29', 1, 1),
(215, '8801', '82666983000164', 'KELLER', '2024-12-30 16:09:29', 1, 1),
(216, '6090', '82666983000326', 'KELLER', '2024-12-30 16:09:29', 1, 1),
(217, '6107', '82666983000407', 'KELLER', '2024-12-30 16:09:29', 1, 1),
(218, '8847', '32947710000110', 'MF LOG', '2024-12-30 16:09:29', 1, 1),
(219, '8799', '27654604000108', 'MID', '2024-12-30 16:09:29', 1, 1),
(220, '9598', '27654604000370', 'MID', '2024-12-30 16:09:29', 1, 1),
(221, '9809', '27654604000299', 'MID', '2024-12-30 16:09:29', 1, 1),
(222, '8391', '27654604000450', 'MID', '2024-12-30 16:09:29', 1, 1),
(223, '98539', '28663998000123', 'MVT', '2024-12-30 16:09:29', 1, 1),
(224, '98495', '28663998001448', 'MVT', '2024-12-30 16:09:29', 1, 1),
(225, '99028', '28663998000395', 'MVT', '2024-12-30 16:09:29', 1, 1),
(226, '98254', '83083428005646', 'REUNIDAS', '2024-12-30 16:09:29', 1, 1),
(227, '592', '83083428000172', 'REUNIDAS', '2024-12-30 16:09:29', 1, 1),
(228, '4706', '83083428000253', 'REUNIDAS', '2024-12-30 16:09:29', 1, 1),
(229, '4674', '83083428000415', 'REUNIDAS', '2024-12-30 16:09:29', 1, 1),
(230, '7902', '00428307001160', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(231, '8214', '00428307001089', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(232, '97823', '00428307002212', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(233, '9933', '00428307000198', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(234, '5975', '00428307000350', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(235, '5637', '00428307000600', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(236, '5646', '00428307000430', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(237, '98200', '00428307002301', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(238, '9171', '00428307002050', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(239, '7981', '00428307001240', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(240, '6087', '00428307000279', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(241, '97661', '00428307001917', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(242, '5552', '00428307000511', 'SAO MIGUEL', '2024-12-30 16:09:29', 1, 1),
(243, '97297', '03098929000606', 'SETE LAGOAS', '2024-12-30 16:09:29', 1, 1),
(244, '98905', '03098929000789', 'SETE LAGOAS', '2024-12-30 16:09:29', 1, 1),
(245, '99303', '57130483000166', 'SLN', '2024-12-30 16:09:29', 1, 1),
(246, '98637', '37108041000106', 'TIMEX', '2024-12-30 16:09:29', 1, 1),
(247, '9806', '24821663000135', 'TISG', '2024-12-30 16:09:29', 1, 1),
(248, '40796', '77789477000122', 'TRANSPINHO', '2024-12-30 16:09:29', 1, 1),
(249, '98947', '77789477000203', 'TRANSPINHO', '2024-12-30 16:09:29', 1, 1),
(250, '5054', '82604042000520', 'TRANSVILE', '2024-12-30 16:09:29', 1, 1),
(251, '5056', '82604042000449', 'TRANSVILE', '2024-12-30 16:09:29', 1, 1),
(252, '5055', '82604042000600', 'TRANSVILE', '2024-12-30 16:09:29', 1, 1),
(253, '5057', '82604042000953', 'TRANSVILE', '2024-12-30 16:09:29', 1, 1),
(254, '5059', '82604042001097', 'TRANSVILE', '2024-12-30 16:09:29', 1, 1),
(255, '5061', '82604042000791', 'TRANSVILE', '2024-12-30 16:09:29', 1, 1),
(256, '5058', '82604042001259', 'TRANSVILE', '2024-12-30 16:09:29', 1, 1),
(257, '9339', '82604042001178', 'TRANSVILE', '2024-12-30 16:09:29', 1, 1),
(258, '4686', '82604042000104', 'TRANSVILE', '2024-12-30 16:09:29', 1, 1),
(259, '1105', '82604042000287', 'TRANSVILE', '2024-12-30 16:09:29', 1, 1),
(260, '99437', '26156506000269', 'SUL', '2024-12-30 16:09:29', 1, 1),
(261, '99452', '26156506000188', 'SUL', '2024-12-30 16:09:29', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `nivel_acesso` enum('superadministrador','administrador','usuario_leitura','usuario_edicao') NOT NULL,
  `criado_em` datetime DEFAULT current_timestamp(),
  `atualizado_em` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modificado_por` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `nivel_acesso`, `criado_em`, `atualizado_em`, `modificado_por`) VALUES
(1, 'Super Admin', 'superadmin@example.com', '$2y$10$p.SPT4k5D/XdskkJdALvfO4Gv6hVtzZPiofwYHrLf9KRB5HBoe2C.', 'superadministrador', '2024-12-16 16:36:38', '2024-12-26 11:20:39', NULL),
(3, 'User2', 'user@example.com', '$2y$10$p.SPT4k5D/XdskkJdALvfO4Gv6hVtzZPiofwYHrLf9KRB5HBoe2C.', 'usuario_leitura', '2024-12-16 16:36:38', '2025-01-10 13:10:23', 1),
(5, 'teste1', 'teste1@example.com', '$2y$10$npM6M/y3abHRl9n.0TfR0u6x3o.9pNjZl/1Jd/PyCajVocgDHE01y', 'usuario_leitura', '2025-01-06 16:48:13', '2025-01-08 09:30:25', 1),
(8, 'teste2', 'teste2@example.com', '$2y$10$FwTU4RSxqRb5uuC0j9OI9ejyOkz6DsgjIOMErFzWNiwtNpbdiSSiq', 'usuario_leitura', '2025-01-07 10:29:24', '2025-01-08 10:34:54', 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cte`
--
ALTER TABLE `cte`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fatura_id` (`fatura_id`);

--
-- Índices de tabela `faturas`
--
ALTER TABLE `faturas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_transportadora` (`transportadora_id`),
  ADD KEY `fk_modificado_por` (`modificado_por`);

--
-- Índices de tabela `transportadora`
--
ALTER TABLE `transportadora`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD UNIQUE KEY `cnpj` (`cnpj`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cte`
--
ALTER TABLE `cte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `faturas`
--
ALTER TABLE `faturas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `transportadora`
--
ALTER TABLE `transportadora`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=262;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `cte`
--
ALTER TABLE `cte`
  ADD CONSTRAINT `cte_ibfk_1` FOREIGN KEY (`fatura_id`) REFERENCES `faturas` (`id`);

--
-- Restrições para tabelas `faturas`
--
ALTER TABLE `faturas`
  ADD CONSTRAINT `faturas_ibfk_1` FOREIGN KEY (`transportadora_id`) REFERENCES `transportadora` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_modificado_por` FOREIGN KEY (`modificado_por`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `fk_transportadora` FOREIGN KEY (`transportadora_id`) REFERENCES `transportadora` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
