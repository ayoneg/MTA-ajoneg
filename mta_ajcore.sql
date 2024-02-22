-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 22 Lut 2024, 22:12
-- Wersja serwera: 10.1.48-MariaDB-0ubuntu0.18.04.1
-- Wersja PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `mta_ajcore`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_achievements`
--

CREATE TABLE `server_achievements` (
  `ments_id` int(11) NOT NULL,
  `ments_userID` int(11) NOT NULL,
  `ments_nameID` varchar(255) NOT NULL,
  `ments_data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_admins`
--

CREATE TABLE `server_admins` (
  `admin_id` int(11) NOT NULL,
  `admin_serial` varchar(255) NOT NULL,
  `admin_poziom` int(11) NOT NULL COMMENT 'poziom inaczej permisje, to będzie odpowiedzialne za uzywanie funkcji na serwerze'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_alljobs`
--

CREATE TABLE `server_alljobs` (
  `job_id` int(11) NOT NULL,
  `job_code` varchar(255) NOT NULL,
  `job_activeslot` int(11) NOT NULL,
  `job_maxslot` int(11) NOT NULL,
  `job_name` varchar(255) NOT NULL,
  `job_desc` varchar(255) NOT NULL,
  `job_wymPG` int(11) NOT NULL,
  `job_wymREP` int(11) NOT NULL COMMENT 'wymagana reputacja 0 - brak',
  `job_wymEXAM` varchar(255) NOT NULL,
  `job_um` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_cpn`
--

CREATE TABLE `server_cpn` (
  `cpn_id` int(11) NOT NULL,
  `cpn_cpid` int(11) NOT NULL,
  `cpn_xyz` varchar(255) NOT NULL,
  `cpn_dimint` varchar(255) NOT NULL,
  `cpn_size` int(11) NOT NULL,
  `cpn_icon` int(11) NOT NULL,
  `cpn_cost` int(11) NOT NULL,
  `cpn_name` varchar(255) NOT NULL,
  `cpn_value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_domy`
--

CREATE TABLE `server_domy` (
  `dom_id` int(11) NOT NULL,
  `dom_name` varchar(255) NOT NULL,
  `dom_cost` int(11) NOT NULL,
  `dom_zamek` int(11) NOT NULL,
  `dom_wejscieXYZ` varchar(255) NOT NULL,
  `dom_intXYZ` varchar(255) NOT NULL,
  `dom_XYZ` varchar(255) NOT NULL,
  `dom_wyjscieXYZ` varchar(255) NOT NULL,
  `dom_oddata` datetime NOT NULL,
  `dom_dodata` datetime NOT NULL,
  `dom_owner` int(11) NOT NULL,
  `dom_ownergroup` int(11) NOT NULL,
  `dom_dimID` int(11) NOT NULL,
  `dom_intID` int(11) NOT NULL,
  `dom_rootINT` int(11) NOT NULL,
  `dom_root` int(11) NOT NULL,
  `dom_audio` int(1) NOT NULL,
  `dom_audioXYZ` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_egzaminyum`
--

CREATE TABLE `server_egzaminyum` (
  `egzamin_id` int(11) NOT NULL,
  `egzamin_name` varchar(255) NOT NULL,
  `egzamin_cost` int(11) NOT NULL,
  `egzamin_minQue` int(11) NOT NULL,
  `egzamin_value` int(11) NOT NULL,
  `egzamin_zapytanie` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_egzaminyum_lista`
--

CREATE TABLE `server_egzaminyum_lista` (
  `el_id` int(11) NOT NULL,
  `el_pytanie` varchar(255) NOT NULL,
  `el_odpA` varchar(255) NOT NULL,
  `el_odpB` varchar(255) NOT NULL,
  `el_odpC` varchar(255) NOT NULL,
  `el_odpD` varchar(255) NOT NULL,
  `el_trueODP` int(11) NOT NULL,
  `el_egzaminID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_frakcje`
--

CREATE TABLE `server_frakcje` (
  `fra_id` int(11) NOT NULL,
  `fra_userid` int(11) NOT NULL,
  `fra_frakcjaid` varchar(255) NOT NULL COMMENT 'name-id-frakcji',
  `fra_poziom` int(11) NOT NULL,
  `fra_data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_jedna4mili`
--

CREATE TABLE `server_jedna4mili` (
  `mil_id` int(11) NOT NULL,
  `mil_uid` int(11) NOT NULL,
  `mil_time` int(11) NOT NULL,
  `mil_vehname` varchar(255) NOT NULL,
  `mil_data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_jobslog`
--

CREATE TABLE `server_jobslog` (
  `joblog_id` int(11) NOT NULL,
  `joblog_code` varchar(255) NOT NULL COMMENT 'kod pr acy',
  `joblog_data` datetime NOT NULL,
  `joblog_value` int(11) NOT NULL,
  `joblog_type` int(11) NOT NULL,
  `joblog_cfg` int(11) NOT NULL,
  `joblog_userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_logibankowe`
--

CREATE TABLE `server_logibankowe` (
  `lbank_id` int(11) NOT NULL,
  `lbank_userid` int(11) NOT NULL,
  `lbank_touserid` int(11) NOT NULL,
  `lbank_kwota` int(11) NOT NULL,
  `lbank_data` datetime NOT NULL,
  `lbank_desc` text NOT NULL,
  `lbank_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_nieudanelog`
--

CREATE TABLE `server_nieudanelog` (
  `nlog_id` int(11) NOT NULL,
  `nlog_nickname` varchar(255) NOT NULL,
  `nlog_serial` varchar(255) NOT NULL,
  `nlog_data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_organizacje`
--

CREATE TABLE `server_organizacje` (
  `org_id` int(11) NOT NULL,
  `org_name` varchar(30) NOT NULL,
  `org_shortname` varchar(4) NOT NULL,
  `org_webpage` varchar(200) NOT NULL,
  `org_colorHEX` varchar(6) NOT NULL,
  `org_desc` text NOT NULL,
  `org_createdata` datetime NOT NULL,
  `org_icon64` varchar(255) NOT NULL,
  `org_icon32` varchar(255) NOT NULL,
  `org_icon16` varchar(255) NOT NULL,
  `org_czlonkowie` int(11) NOT NULL,
  `org_bankocash` int(11) NOT NULL COMMENT 'banko org'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_organizacje_czlonkowie`
--

CREATE TABLE `server_organizacje_czlonkowie` (
  `orguser_id` int(11) NOT NULL,
  `orguser_orgid` int(11) NOT NULL,
  `orguser_userid` int(11) NOT NULL,
  `orguser_rank` int(11) NOT NULL,
  `orguser_joindata` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_organizacje_logibankomat`
--

CREATE TABLE `server_organizacje_logibankomat` (
  `orgbank_id` int(11) NOT NULL,
  `orgbank_desc` text NOT NULL,
  `orgbank_userid` int(11) NOT NULL,
  `orgbank_orgid` int(11) NOT NULL,
  `orgbank_data` datetime NOT NULL,
  `orgbank_cash` int(11) NOT NULL,
  `orgbank_value` int(11) NOT NULL COMMENT '0 wplata, 1 wyplata'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_organizacje_rangi`
--

CREATE TABLE `server_organizacje_rangi` (
  `orgrank_id` int(11) NOT NULL,
  `orgrank_orgid` int(11) NOT NULL,
  `orgrank_name` varchar(30) NOT NULL,
  `orgrank_value` int(11) NOT NULL COMMENT '1-lider, 2-vlider, 3-czlonek, 4-nowy, 5-rekrut, ... etc'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_pghistory`
--

CREATE TABLE `server_pghistory` (
  `pgh_id` int(11) NOT NULL,
  `pgh_admin` int(11) NOT NULL,
  `pgh_ilosc` int(11) NOT NULL,
  `pgh_data` datetime NOT NULL,
  `pgh_desc` varchar(255) NOT NULL,
  `pgh_foruser` int(11) NOT NULL,
  `pgh_job` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_premium`
--

CREATE TABLE `server_premium` (
  `p_id` int(11) NOT NULL,
  `p_userid` int(11) NOT NULL,
  `p_addtime` datetime NOT NULL,
  `p_days` datetime NOT NULL,
  `p_type` int(11) NOT NULL COMMENT '1 - premium, 2 - gold'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_rephistory`
--

CREATE TABLE `server_rephistory` (
  `rep_id` int(11) NOT NULL,
  `rep_userid` int(11) NOT NULL,
  `rep_value` varchar(25) NOT NULL,
  `rep_count` int(11) NOT NULL COMMENT 'ilosc',
  `rep_data` datetime NOT NULL,
  `rep_kaplicacode` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_users`
--

CREATE TABLE `server_users` (
  `user_id` int(11) NOT NULL,
  `user_plec` int(11) NOT NULL COMMENT '0 - boy 1 - girl',
  `user_nickname` varchar(255) NOT NULL,
  `user_pass` varchar(255) NOT NULL,
  `user_ppoints` int(11) NOT NULL,
  `user_money` int(11) NOT NULL,
  `user_bankmoney` bigint(20) NOT NULL,
  `user_polimoney` int(11) NOT NULL,
  `user_serial` varchar(255) NOT NULL,
  `user_pg` int(11) NOT NULL COMMENT 'punkty gry',
  `user_reputacja` int(11) NOT NULL COMMENT 'repka, odp za prace etc',
  `user_skin` int(11) NOT NULL,
  `user_regdata` datetime NOT NULL,
  `user_lastlogindata` datetime NOT NULL,
  `user_katA` int(11) NOT NULL,
  `user_katB` int(11) NOT NULL,
  `user_katC` int(11) NOT NULL,
  `user_katL` int(11) NOT NULL,
  `user_katH` int(11) NOT NULL,
  `user_minuty` int(11) NOT NULL,
  `user_carslot` int(11) NOT NULL,
  `user_EXusm` int(11) NOT NULL,
  `user_EXtaxi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_users_oldnicknames`
--

CREATE TABLE `server_users_oldnicknames` (
  `oldnick_id` int(11) NOT NULL,
  `oldnick_name` varchar(23) NOT NULL,
  `oldnick_userid` int(11) NOT NULL,
  `oldnick_data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_vehicles`
--

CREATE TABLE `server_vehicles` (
  `veh_id` int(11) NOT NULL,
  `veh_owner` int(11) NOT NULL,
  `veh_modelid` int(11) NOT NULL,
  `veh_przebieg` int(11) NOT NULL DEFAULT '0',
  `veh_paliwo` int(11) NOT NULL DEFAULT '25',
  `veh_maxpaliwo` int(11) NOT NULL DEFAULT '25' COMMENT 'domyślnie 25',
  `veh_parking` int(11) NOT NULL,
  `veh_position` varchar(255) NOT NULL,
  `veh_root` varchar(255) NOT NULL,
  `veh_frakcja` varchar(4) NOT NULL COMMENT 'nameID frakcji',
  `veh_owner2` varchar(255) NOT NULL,
  `veh_groupowner` int(11) NOT NULL COMMENT 'id grupy/prganizacji/frakcji',
  `veh_taxo` int(11) NOT NULL COMMENT '0- btak, 1- mozliwosc taxo',
  `veh_reczny` int(11) NOT NULL,
  `veh_color` tinytext NOT NULL,
  `veh_paintjob` int(11) NOT NULL,
  `veh_lampy` varchar(255) NOT NULL,
  `veh_variant1` int(11) NOT NULL DEFAULT '255',
  `veh_variant2` int(11) NOT NULL DEFAULT '255',
  `veh_tune` text NOT NULL,
  `veh_mk1` int(11) NOT NULL,
  `veh_mk2` int(11) NOT NULL,
  `veh_mk3` int(11) NOT NULL,
  `veh_SU1` int(11) NOT NULL,
  `veh_tablica` varchar(8) NOT NULL DEFAULT 'LV ',
  `veh_vopis` varchar(255) NOT NULL COMMENT 'Opis / vopis',
  `veh_usz1` varchar(255) NOT NULL,
  `veh_usz2` varchar(255) NOT NULL,
  `veh_usz3` int(11) NOT NULL DEFAULT '333',
  `veh_usz4` varchar(255) NOT NULL,
  `veh_usz5` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_vehicles_handing`
--

CREATE TABLE `server_vehicles_handing` (
  `handing_id` int(11) NOT NULL,
  `handing_vehid` int(11) NOT NULL,
  `handing_tunecfg` varchar(255) DEFAULT NULL,
  `handing_engineAcceleration` varchar(11) NOT NULL,
  `handing_maxVelocity` varchar(11) NOT NULL,
  `handing_mass` varchar(11) NOT NULL,
  `handing_turnMass` varchar(11) NOT NULL,
  `handing_tractionLoss` varchar(11) NOT NULL,
  `handing_brakeDeceleration` varchar(11) NOT NULL,
  `handing_steeringLock` varchar(11) NOT NULL,
  `handing_numberOfGears` int(11) NOT NULL,
  `handing_suspensionDamping` varchar(255) NOT NULL,
  `handing_tractionBias` varchar(255) NOT NULL,
  `handing_driveType` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_vehicle_driver`
--

CREATE TABLE `server_vehicle_driver` (
  `driver_id` int(11) NOT NULL,
  `driver_nickname` varchar(255) NOT NULL,
  `driver_carid` int(11) NOT NULL,
  `driver_czas` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `server_zakazy`
--

CREATE TABLE `server_zakazy` (
  `zakaz_id` int(11) NOT NULL,
  `zakaz_dodany` datetime NOT NULL,
  `zakaz_userserial` varchar(255) NOT NULL,
  `zakaz_type` int(11) NOT NULL,
  `zakaz_value` int(11) NOT NULL,
  `zakaz_czas` datetime NOT NULL,
  `zakaz_fromadmin` int(11) NOT NULL,
  `zakaz_desc` varchar(255) NOT NULL,
  `zakaz_note` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `server_achievements`
--
ALTER TABLE `server_achievements`
  ADD PRIMARY KEY (`ments_id`);

--
-- Indeksy dla tabeli `server_admins`
--
ALTER TABLE `server_admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indeksy dla tabeli `server_alljobs`
--
ALTER TABLE `server_alljobs`
  ADD PRIMARY KEY (`job_id`);

--
-- Indeksy dla tabeli `server_cpn`
--
ALTER TABLE `server_cpn`
  ADD PRIMARY KEY (`cpn_id`);

--
-- Indeksy dla tabeli `server_domy`
--
ALTER TABLE `server_domy`
  ADD PRIMARY KEY (`dom_id`);

--
-- Indeksy dla tabeli `server_egzaminyum`
--
ALTER TABLE `server_egzaminyum`
  ADD PRIMARY KEY (`egzamin_id`);

--
-- Indeksy dla tabeli `server_egzaminyum_lista`
--
ALTER TABLE `server_egzaminyum_lista`
  ADD PRIMARY KEY (`el_id`);

--
-- Indeksy dla tabeli `server_frakcje`
--
ALTER TABLE `server_frakcje`
  ADD PRIMARY KEY (`fra_id`);

--
-- Indeksy dla tabeli `server_jedna4mili`
--
ALTER TABLE `server_jedna4mili`
  ADD PRIMARY KEY (`mil_id`);

--
-- Indeksy dla tabeli `server_jobslog`
--
ALTER TABLE `server_jobslog`
  ADD PRIMARY KEY (`joblog_id`);

--
-- Indeksy dla tabeli `server_logibankowe`
--
ALTER TABLE `server_logibankowe`
  ADD PRIMARY KEY (`lbank_id`);

--
-- Indeksy dla tabeli `server_nieudanelog`
--
ALTER TABLE `server_nieudanelog`
  ADD PRIMARY KEY (`nlog_id`);

--
-- Indeksy dla tabeli `server_organizacje`
--
ALTER TABLE `server_organizacje`
  ADD PRIMARY KEY (`org_id`);

--
-- Indeksy dla tabeli `server_organizacje_czlonkowie`
--
ALTER TABLE `server_organizacje_czlonkowie`
  ADD PRIMARY KEY (`orguser_id`);

--
-- Indeksy dla tabeli `server_organizacje_logibankomat`
--
ALTER TABLE `server_organizacje_logibankomat`
  ADD PRIMARY KEY (`orgbank_id`);

--
-- Indeksy dla tabeli `server_organizacje_rangi`
--
ALTER TABLE `server_organizacje_rangi`
  ADD PRIMARY KEY (`orgrank_id`);

--
-- Indeksy dla tabeli `server_pghistory`
--
ALTER TABLE `server_pghistory`
  ADD PRIMARY KEY (`pgh_id`);

--
-- Indeksy dla tabeli `server_premium`
--
ALTER TABLE `server_premium`
  ADD PRIMARY KEY (`p_id`);

--
-- Indeksy dla tabeli `server_rephistory`
--
ALTER TABLE `server_rephistory`
  ADD PRIMARY KEY (`rep_id`);

--
-- Indeksy dla tabeli `server_users`
--
ALTER TABLE `server_users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indeksy dla tabeli `server_users_oldnicknames`
--
ALTER TABLE `server_users_oldnicknames`
  ADD PRIMARY KEY (`oldnick_id`);

--
-- Indeksy dla tabeli `server_vehicles`
--
ALTER TABLE `server_vehicles`
  ADD PRIMARY KEY (`veh_id`);

--
-- Indeksy dla tabeli `server_vehicles_handing`
--
ALTER TABLE `server_vehicles_handing`
  ADD PRIMARY KEY (`handing_id`);

--
-- Indeksy dla tabeli `server_vehicle_driver`
--
ALTER TABLE `server_vehicle_driver`
  ADD PRIMARY KEY (`driver_id`);

--
-- Indeksy dla tabeli `server_zakazy`
--
ALTER TABLE `server_zakazy`
  ADD PRIMARY KEY (`zakaz_id`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `server_achievements`
--
ALTER TABLE `server_achievements`
  MODIFY `ments_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_admins`
--
ALTER TABLE `server_admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_alljobs`
--
ALTER TABLE `server_alljobs`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_cpn`
--
ALTER TABLE `server_cpn`
  MODIFY `cpn_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_domy`
--
ALTER TABLE `server_domy`
  MODIFY `dom_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_egzaminyum`
--
ALTER TABLE `server_egzaminyum`
  MODIFY `egzamin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_egzaminyum_lista`
--
ALTER TABLE `server_egzaminyum_lista`
  MODIFY `el_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_frakcje`
--
ALTER TABLE `server_frakcje`
  MODIFY `fra_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_jedna4mili`
--
ALTER TABLE `server_jedna4mili`
  MODIFY `mil_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_jobslog`
--
ALTER TABLE `server_jobslog`
  MODIFY `joblog_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_logibankowe`
--
ALTER TABLE `server_logibankowe`
  MODIFY `lbank_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_nieudanelog`
--
ALTER TABLE `server_nieudanelog`
  MODIFY `nlog_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_organizacje`
--
ALTER TABLE `server_organizacje`
  MODIFY `org_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_organizacje_czlonkowie`
--
ALTER TABLE `server_organizacje_czlonkowie`
  MODIFY `orguser_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_organizacje_logibankomat`
--
ALTER TABLE `server_organizacje_logibankomat`
  MODIFY `orgbank_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_organizacje_rangi`
--
ALTER TABLE `server_organizacje_rangi`
  MODIFY `orgrank_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_pghistory`
--
ALTER TABLE `server_pghistory`
  MODIFY `pgh_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_premium`
--
ALTER TABLE `server_premium`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_rephistory`
--
ALTER TABLE `server_rephistory`
  MODIFY `rep_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_users`
--
ALTER TABLE `server_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_users_oldnicknames`
--
ALTER TABLE `server_users_oldnicknames`
  MODIFY `oldnick_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_vehicles`
--
ALTER TABLE `server_vehicles`
  MODIFY `veh_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_vehicles_handing`
--
ALTER TABLE `server_vehicles_handing`
  MODIFY `handing_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_vehicle_driver`
--
ALTER TABLE `server_vehicle_driver`
  MODIFY `driver_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `server_zakazy`
--
ALTER TABLE `server_zakazy`
  MODIFY `zakaz_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
