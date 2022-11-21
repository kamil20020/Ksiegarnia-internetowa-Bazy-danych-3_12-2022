-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: bookshop.mysql.database.azure.com    Database: bookshopdb
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookauthors`
--

DROP TABLE IF EXISTS `bookauthors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookauthors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `surname` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookauthors`
--

LOCK TABLES `bookauthors` WRITE;
/*!40000 ALTER TABLE `bookauthors` DISABLE KEYS */;
INSERT INTO `bookauthors` VALUES (2,'Jon','Duckett');
/*!40000 ALTER TABLE `bookauthors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookauthorships`
--

DROP TABLE IF EXISTS `bookauthorships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookauthorships` (
  `book_id` int NOT NULL,
  `book_author_id` int NOT NULL,
  KEY `book_author_id` (`book_author_id`),
  KEY `book_id_idx` (`book_id`),
  CONSTRAINT `book_author_id` FOREIGN KEY (`book_author_id`) REFERENCES `bookauthors` (`id`),
  CONSTRAINT `book_id` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookauthorships`
--

LOCK TABLES `bookauthorships` WRITE;
/*!40000 ALTER TABLE `bookauthorships` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookauthorships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookcategories`
--

DROP TABLE IF EXISTS `bookcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookcategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(22) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookcategories`
--

LOCK TABLES `bookcategories` WRITE;
/*!40000 ALTER TABLE `bookcategories` DISABLE KEYS */;
INSERT INTO `bookcategories` VALUES (1,'Informatyka');
/*!40000 ALTER TABLE `bookcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookcovers`
--

DROP TABLE IF EXISTS `bookcovers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookcovers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookcovers`
--

LOCK TABLES `bookcovers` WRITE;
/*!40000 ALTER TABLE `bookcovers` DISABLE KEYS */;
INSERT INTO `bookcovers` VALUES (1,'miękka');
/*!40000 ALTER TABLE `bookcovers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookitems`
--

DROP TABLE IF EXISTS `bookitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `code` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `fk_bookitems_1_idx` (`book_id`),
  CONSTRAINT `fk_bookitems_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookitems`
--

LOCK TABLES `bookitems` WRITE;
/*!40000 ALTER TABLE `bookitems` DISABLE KEYS */;
INSERT INTO `bookitems` VALUES (1,1,7),(2,2,3),(3,1,197),(4,2,75);
/*!40000 ALTER TABLE `bookitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_category_id` int NOT NULL,
  `publisher_id` int NOT NULL,
  `book_cover_id` int NOT NULL,
  `language_id` int NOT NULL,
  `title` varchar(100) COLLATE utf8_polish_ci NOT NULL,
  `description` text COLLATE utf8_polish_ci,
  `isbn` varchar(20) COLLATE utf8_polish_ci DEFAULT NULL,
  `release_number` int DEFAULT NULL,
  `release_date` datetime NOT NULL,
  `size` varchar(11) COLLATE utf8_polish_ci NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `is_available` tinyint(1) NOT NULL,
  `num_of_book_items` int NOT NULL,
  `number_of_pages` varchar(20) COLLATE utf8_polish_ci DEFAULT NULL,
  `avatar` blob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `book_category_id_idx` (`book_category_id`),
  KEY `publisher_id_idx` (`publisher_id`),
  KEY `book_cover_id_idx` (`book_cover_id`),
  KEY `language_id_idx` (`language_id`),
  CONSTRAINT `book_category_id` FOREIGN KEY (`book_category_id`) REFERENCES `bookcategories` (`id`),
  CONSTRAINT `book_cover_id` FOREIGN KEY (`book_cover_id`) REFERENCES `bookcovers` (`id`),
  CONSTRAINT `language_id` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`),
  CONSTRAINT `publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,1,1,1,1,'JavaScript i jQuery. Interaktywne strony WWW dla każdego. Podręcznik Front-End Developera','Jeżeli chcesz poznać potencjał tego duetu i zacząć tworzyć atrakcyjne aplikacje internetowe, nie możesz obejść się bez tej książki. Pomoże Ci ona szybko stworzyć pierwszy skrypt. W trakcie lektury poznasz niuanse składni JavaScriptu, sposoby obsługi zdarzeń oraz obiektowy model strony. Dzięki dalszym rozdziałom zdobędziesz wiedzę na temat jQuery oraz możliwości tej biblioteki. Z pomocą duetu JavaScript i jQuery błyskawicznie rozwiążesz każdy problem — asynchroniczne pobieranie danych z serwera, atrakcyjny interfejs użytkownika, zaawansowana obsługa formularzy to tylko niektóre z poruszanych tu tematów. Książka ta jest doskonałym źródłem informacji dla czytelników chcących opanować JavaScript oraz związane z nim narzędzia!','978-83-283-4478-5',1,'2018-03-27 00:00:00','big',62.34,1,2,'648',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0	\Z!\Z\"$\"$�\�\0C��\0\0\�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\0B\0\0\0\0\0\0!1AQ�\�\"aq�2#BRb��3Sr��$%C\�4c���\�\��\�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\01\0\0\0\0\0\0\0\0!1AQa\"�2���#q�\�\�\�\��\�\0\0\0?\0\�\�*\�>%k\�)\�\�\�\r\�\��^Qa�x��\�C\�\�_�yC/(\�\�\�~he\����\�+\�FL��\�\�\�%R\\P X+2N��l���\�jn^��Nb�\'(%��L�E	!AM��l69o�7�I\�\��]](\�\�0\�sI��\�9J�.�NB=.\��tm\�m\�\�e�a]\\U���\�f^�2��U�:�\�ZR�1�;��Y>��d/kG��R���&�g\r�¢,\�	\�\�ǂ.*�\�\�qW\�^P\�\�.\"���4<\\U����2\�.*�\�T�\\x���^PN�M`\�z\�.�7�\�\�\0eІ]{�{��Bt!\�a\�`]e�\�\�\�\�<�\�En:\�0\�0\r\�eІ]{�{��Bt!\�a\�`]\'Q\�sN�\�\0�\�z\�.�7�MaoH�FtaoH[\�\0eц][\�\�taaх�\"�>Nb~q�IV�ǜ6H�<\0\�\�R�6\�\"\�(�J�4��X�\�\�.�f֩sT�\�\�M \\f��\�q?xyH·�(��\�UR\�Yb�*\��42\�\�.�-\�zEŃ.�2\�\�ސ��\0ˣM�=x\�-\�\�4\�\0oV�ß(oW�9�|�ϔ9Ü\0\�\��C�}6��\�[m\nZ\�BR���l\0\�‿K���\�X�\�\�ܙ��XCM f��\���\�gJ6�\�۳3I\nq\�\�\�\��]};.ƻ8oJ��H�ks-l8i�A̶��F\�i^Vk\�\�\���\'g+���Q`��\�-e(�Wӆd\�x\�g�U^\\�KU�s��\�\�\�\�v\Z4\�\�y��\�r!�a\�\�I5\��\�H\�m\�?t�>�B7\�GZ�NQ\�OS\�\�-�\�\�xP:)\'x;�O�M�Q\�\0�\����n�\�m\�x\�F_�ZǸN[\�Ŕ��I�w�\�?��)?�ύ��*\Z�\�\��\'�XŪQ\�m�,}W\��>P\�\�.\�˿\'6\��\�ji\�VP\��P\�E�q8y\�N��9\�>P\�p(9\�F�\�9\�S�\�X�\�\����^�\�H��2�ZC\�@�н�\�n\�.Q�M^��\04w\�(˩�£r\��\"�y��\�\�\��gR\��K�\'d9N�pg}\�(n� \�\�\�t\�\�r�M;�e\�]qVJ3*&<\��u�ej�6�\�\�\�t:^��\�\��/r\�f�!F�\�T�s)���Nӎ+;\0jI\��1\�.ӱ�\�4���̄�)���\�\�\���+�a���k��Lc:�\�\��J�\�\�b\�\�V8�\�\�2c�\�H�\�\�g��<\�\���ߙ��jz��|+\�6�Z�=��ȨH���\�J6K�ޓ��\�O�v�\'\\��R�]\�px�O��\�I\���\�͝i\���\�\�TL4V䣄	�prq<E\�P\�}�1\�K}l\�gѵwg_rO���IO�\�\�~AS\�-%5V\�\�\0|BG\�>|	\�\�\�8��\�\�u\nC�QJ��AI\Z��=3L���H3=\"\�^�y;M�o\�<Ѝ\�\�\����VJ�T�\�\�6�߲��\�F�~1��0/�{����oHW��7\�K�R\�\�y@u�:\�7$e\�\�hzí\"�\�z�ޯX@\�X[��\��aݛ\n�\�ĵ��Je\�\�K��\0��ʸ6�\0��4�j�\��X��g�l�����\�\�\��I<7��Z�\�䬻2\�\�KK2��i\r�\�vR���@\Z(\�{Q\�/,���\��\�O\�\�Mizw��Y�\�\\$\0T�\0\�$\�\�\�G��o\�X�qt*;�M]Ϭq&\�\�?7\��߯\�vՏ���o\�(�e)pϼ��|!%Km6�		%G}�\�g\�\�+r\�\�婳N�R�2\�KJ<3�\�B\�6���c\�g<$�.W��)\�\��\�.\�5�b�\�\�`B3d)IԶ�:|\�\�ɴI#aژX%-\�@\�3$p�%��\�\�%(s�OȨ�m��\�aA[6]\�\0\�d\�9\�w�A�hF晅15JVjfB�=0̢\�\�\�Kv\�Z+E�JH��\�\rD}��1CT6\�nP\'\�1\�\�uA\0��\�j67	Uŉ�7�3{:Ŏa����r�2�ߠfPt$q\�\�\�Nү�3,\�̻�u�P\�\�rRN`�\�\�\�f,�:n�0\�@\�ɸ\�s.�\�\�\��\�@7\�}�h\�\�\"\�^��\�\"�MKṕ$�6ꓲ�Y\�B\�$��.7^�g}i\�\�,�\�M�k>PL�/wO\��\�c%)�\�t�K��=\\H�\0\�{�\�G��AM�\n\\\��\�Cݪ࿣]j�����2�U\�C\�D[\�\�\�g\�tn\�n`[8�r>��G�R\�^	�X\�9!�^��#*��\�l���s��coH}���\�\�.�k]I\\q�B#\�;�m\�\�q-�n��{1\�4Z\�����ܒ��CN\�$[��^)9\�\�\�8N\��J�?�0�ŧ\n\'\�Pse\'V�~��Gp\�S��\rNJeu		\�U\�-��\�D(X\��e��\�֩\�4ʃ�\�J+Q\�\�\�x	��\�\�\�9m7�T\�r\�%\�N\��>o�#kL\�r��\�7�������3�ZKӕy���\�1\'4̴�%��.\�8\�l\�;(��/�49GQ;�py��\n\�\�U\Z��\�\�9J�)\�Z3\��-,l�\�x\\t\�+F6\�Ѷ�\�*\�\�-1)\�\n�U˚�\���vy\�6c��\�H��\�E)9+O�2����\0\n\�\�z�;��+�\�\r%D%d�Xf#\��\�W&\'e*\r\�$*4\�6jtڽ9UFf¶~�i\�QYB���Ҕ	3\�����#KO\�Yy6�u��-R\�u\�-���Nm��]\��c����ɵ�k��=I��qD�}\�l�2��\��\�\�ʥUf\�\�\�\�V�\�\�\�p���q�&\�Rj�\�sȓ�vQsa�_S�)%&\�w0�m��h\�ђ\�7\�awe%�\�\�\�o�i�K�%��sm�\�����t��Č\�6O\�x\��8Õ�\';I�\�d\�+^}�\�䬻�rc�	i��l��.%[y_H\�\�\�*\�g\����Uó�NQ\�L\�\�:Fja��47f\�w\�76���;F�� \�jl�\�_銼ԵBd8�H�4��\"\�\nR�U\�_d\�8Z�\�\�K\r\�e\�g\�ɜ\��=\��H�\�t�\�A�V�\�o>\�\r�*��u�#IR\ne6\�\�RagCf\�6F@�\�\�DL���$\\\0,7\��r$�\�\�\�8�\rbc�2��7�rd�\�~\�\�N�-R�E\�%\�VfBT��\�\�\�f-�q�;a�CWe�����S* m!)\�R�䁙�\0s��\��\�&�Z*T\�%,��V\�\0�}�����d\0/|\�4)��\�\�\�Ӧ�/7\��2\�4R\�W7*\��W\�\�\'D.\�X瓨\�X���NZ�Iq�\�K\�M$�\r+E\r\�>C/{Db�\�s�2\�ۧi�\�\�\�F\�\�\�7�]b�R�����pxE7�\���i5�Ix^�\�RD%	KO�\0q��r���#\"�J��\�&\0\n�\�\�\�\�\�DgO�~Fq��e\�8�q��\���\�uYz��\�26��h��+��%-\�Z{�y\�z\�.�:��mS��\���i=(��ے�((u�b8�\�q6��p��$\�f\�,\�ww��#kkA�\�o\�߱ĴtU\�J\�f[ͧ����\�o2ò\�K\�6[u�e$\�9�q��e�\�4jQgukz\�]\r\�r8E\�5\n��x��\�\�)*����\�;o&׋+�\�ͥIQ�2\�A�H\�^ʬ�a�ƾG-\�S)71#6\�̫����t(Z\��\��\�\�\���p,$\�0.�/h\\[<ʕx��v�\�[������o�]].\�	o\n\�HH�w\�\�\�\�/��0\�N���Hed��	(&\�\�\�\�\�\�{X��\�\�\�\�bͭ6I`��-��h�s\�3\�LNM�~^\�6�&\�Xta�\�t\�6)©i\�-\��\�ݒ�;\�\�\��9$\�\��=m:Jn�>Ą���3s\r�\�Ե\0\�(��a驆��Y[Ｐ�\�m%JZ��\0\rI1\�Ļ;F���,��4>�䯅G\�x�\�5\�A��\�g\�V\0�\�E�\�Y�\'\�&��{�p@<ȹ\�m�hx���\�\�\�\�RT�YB�*eϺ<�\�\0\�\"2\�~\"�\�jՊ�\�7\�Jm�Vod Tm\�\0�\�G�\�\�*�\����\��\�J�\�],4Hԝ\�\�(3SU���T_��\�\�QV\���|���#@#|\�]b�A:�X\"�T\�ycz�a֐ޭu�8i�z�\�.y3R\�1�\�tZx��>p\���K\�1\�\�\�e2X�\�KԤ�5,��Z��N\�|\�Y�(I����r:\�\�_G\07	?\�\��\�\�\�\';\��[+�y��<�\�\�\\�\���\�\�8e�t�\�x��Jg�\�F\�\�A�S��<��\�#/�\'�\niA��JUv�W|\"�4�)��l~\�;Z\�\�\�~1�&m�\�\�6~)9���ގ?\�?X\�9\�t\�8\�\�=J\�i\�`RP\���O��\�Y�A�\�\��W9��\�\�U���]\� \�\�Y\��k�I�װ\�\Zq�|]�eԥ\�e\\\rX\�s\�\�k<�\'\�W\�\�\�#ٳ�G��\�@�>��yp��ұ�?\�6� ��6�kU9\Z-n�Qx1\'*\�q\�-{�o$\���E\�٩y9G�&\�b]�u\�Y(H̒c\���v�1��^I\�Z�\�,�f�\�ӾX\�w\�2b�=�Mi\�棍�_�,HK�	)Q��N�D|\�6>\�!�ZC�9����G�S��\�X�^�\�XoV�\�\�@��Z\�\�C\�@��\���H�(sir���@̤�\�\�\�4\�\��\�+t<�^\�\�+��R��K\�8��C�,8\��RT��DrXҀ����`�]\�ө�`Q\�\�5\�B�\�k�	6�\�,�\��\��x�x\�\�3ɗF\�d)Ŧ\��p�N�\�\�y�V\�z\�q\��\Z\�\�}�\�l\�^q�Q^�E4v\�\�u7��\�Y\�I\�?���R��)kRR���)F��<G=�c���\��\�\�\��p	��|�nXv�q׆\�\�\�8\�\��<��I,\�fR/\�(\�A���>c��8��t�3\�m.���I\�i�r\�(b�����I�˹w\n�Ƭ�o�7�υ�޵�({�\�k������kN�׌S\�A:�5�\�\���\�zÜ\0\�Hu�9Ü\0\�Hu�9Ü\0\�H\�P�A�JL,\��Q�>G\��F��9\�\�\�\�yF�\�wq8\��\0��TS\n�yG���\�\�	@�s\�/�C�9\�Io,�\�\�;8Tt|\�1֐\�Hs�8�\�i��8s�i\�=a\�*�G�M\�\��7�\�\�\0�=\�({�P\��\�9@\0	��M�\�\�l�@\�윣eL�\�S�KR�0\0_xTv�R\��\�\�[M\��qw\���f^�PaN�AY\�P\"\r�6$�nM\�79�\�5!* �M���<!���N�\0\�W�F\�8�}*B�ܺvP\�#`*\�X�\�\����\Z��\�F�?;0�\�9�ߗJ��(\'\�\0\n\��\0�EvF�/(@i�\�q\�(!\�9C\�r�T\�=b�\��\�\�\07�\�\�\�t�I�\�\�x�\�8s��\�x�wI\�`\\\�\�.\�I\�a\�\'��-s�8�\�\'��t�&\0�\�\�\�t�&\�x�\�8s��\�x�wI\�`\\\�\�.\�I\�a\�\'��-s�u\Z\�{�\�1P\�S��\�'),(2,1,1,1,1,'Wysoko wydajne MySQL. Sprawdzone strategie działania na dużą skalę. Wydanie 4','MySQL od lat jest najbardziej znaną i lubianą bazą danych typu open source. Wciąż spełnia oczekiwania użytkowników, staje się bowiem coraz bardziej zaawansowanym rozwiązaniem bazodanowym. Równocześnie rośnie złożoność tego oprogramowania, pojawiają się nowe funkcje i narzędzia. Ewoluuje też rola administratora bazy danych, podobnie jak zmienia się podejście do pracy zespołowej. Efektem tych zmian powinno być dostarczenie aplikacji o wysokiej wartości biznesowej, takiej, która będzie się skalowała wraz z organizacją. Warunkiem osiągnięcia tego celu jest jednak gruntowna znajomość MySQL.\n\nTen starannie zaktualizowany przewodnik pozwoli Ci poznać zaawansowane techniki pracy z serwerem MySQL: począwszy od tworzenia obiektów, poprzez projektowanie schematów, indeksów i zapytań, skończywszy na optymalizacji serwera, sprzętu i systemu operacyjnego. Opisano tu bezpieczne i praktyczne sposoby skalowania aplikacji za pomocą replikacji. Pokazano, jak można zapewnić równoważenie obciążenia i sprawić, że aplikacja będzie działała nawet w razie awarii. Omówiono najnowsze trendy pracy z serwerami MySQL (w tym bazy pracujące w chmurze), a także nowe funkcje i narzędzia. Nie zabrakło najlepszych praktyk w zakresie zapewniania bezpieczeństwa bazy, jej wydajności i stabilności. Dzięki temu przewodnikowi zdobędziesz pełną wiedzę o tym, jak nowoczesne firmy używają MySQL na dużą skalę.','\n978-83-283-9294-6',4,'2022-11-15 00:00:00','medium',60.00,1,2,'368',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0	\Z!\Z\"$\"$�\�\0C��\0\0\�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\0>\0\0\0\0\0\0!1\"AQq2a#3BR����\�%b�$7u���\��\�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\0+\0\0\0\0\0\0\0\0\0!1AQ\"#a\�$2���\��\�\0\0\0?\0\�\�;�u^�\��=�\�/\�a�\�|\�X\�I�%����\�e\�D24�#�;p\�w����<\n\�To�O,\�M*\�Y[S\��S\��\�\�z\�[�ձOCH^\�\"m\�ے\r\�\�p-l=ͭs*\�<�K\�E;S\�.]0YU��H\�\�5�\�ۡ��\�u\�\�Y\�\�\�\��,��z(��l_\�?�c�I��$\�w\�n�\��͍O4\�h��l_\�?�z��<\�_\�?�\��\��`;\��\�\Z�0�r�D*\r�d\�a�\�V��hf�: �9f\�\Z�\'ӓ\�\�fl\�k�1\�V2�@�[���\�a\�!\�TjIZx�ѿ1G�\�}q��rZMM�䠘�\�\n�r4a��Sup��A\�_�|���\"I\Z\�\�mu#�\�J<mt�\�[� :/S\�YV�m�\'�j�\�j6*�-\�[�$n\�A\��d�2!�>�`��X\�]�\\$�=�\"\�\���`\�˟Tf\�^s/��ǉԊ��\�c+k��{Z\��9��}N\0>�\rtz�(�\������\�s<����Q�\n˻��Z\�;I�\�np\�|\0lK\�L\�f�\�\�󜞠\�P\�n\�\�Wv\�*x �F\0r��࿾\00`��s\�\�,\�㤓3�0-ed4P��\�+mE\�qs\�\�`,\�$�l\�}�	6\�1��3��\0#�\�r\�;RU&���<Ok�\�8�:0�\0�i6\�)�(&7q�~�\�\�2�R\�\�-i�\�5>M\�L\�\�	)��h\\ta\�\��\�\0\�OG\�y����K�\�T��H\�\�3�\�h\�\�\�g\"\�v\�.A\�\�\�e��*\��;\�?\�ƱF#\�\0�X\�\��m�3=Sڞ�\��\�r\�ik5LR����b�G�Z�+\�#��\�1\���\��G\�&�\�$\�ٶC GY�ڥm\�x\�nB����֗�\�Bf]�OTO��iUF���ˠ�\�&��\�$\�A~�F\�\rmVW[�s\�E�\�\�9�l�{ÓGWYN�\�Mf\�)e�\�\�3f@P�pF㋛Y\��;L�\�o0���r�X�\�\�1�A6\��1NA\����\�8\�*\0�:{z`e\����j4;smJ����x�|�F�\��,�\�!ȄA���,^\�d\�9�j\�]R�Y�-|yq92Q\�\�X\�xK\n��\�]\�]SaN����Ady�\�r\�\r-�s̻&��\�\�z\nm\�\� �շ�\�\�z\�M�;^\�:kIeZ�\�ə�\�0�5%FJ�\�@ \"uEɵ�n�`\�\�ʮ�|\�RA��,\�3\�%?\�\���\�Tw\�\�\������+\rA�v��3<ɲ\�s)败MF�һ\Z��4�O9$��E\��G8��8\�/\�\Z�-/���w����M6mū\0\\�\��n�\0�\�\�)�h5�\�:r��x�ӕAQ$�\�+Kx\n۞\�\n�?\�3\�3���\�(�ҧ,\�\"�uKU9jV�\nkv�;���\�~b޸�5e%V�ȅnc�d\�\�\nc�($35*�\'���ݤ@w}\�!�o~m\�\�KeGY�\0�&Z�\�$��X��GO �w\�k.\�\�\�[\����`Nҙ�VڻIlϵ\\�\�l\�n���Z�O�纺�\�Ea\�\n\�����\�*�V��̳<\�Q�FO�i�\Z&�2��Y+J\�\�?�ûQc~:�ź�=\�\�Ͳz̶J��U���y�e1L��]\\r�\��1i\\�+\�:r�O\�\�\�\�_A�e��ԞI\�$��\�y�y�+{N�l\�8z\rM<\�{i�\�Z\�S�q\�\��6�Tf2	{\�u\�}\�\�o�\�sn�\�\�[�n�>�\\\�TY���(\�\���\�#\�m\�\�8\�\�:��H�X-�=\'\�lrw�\�x�\�h��\�H̙��՟`PI��jdC\�=.m\�7y\�\�\��h\��\�\�Sf\�u5Rͨk\�uJ\�Wln%��Xy\�\0sV�\�\�0�\�;I\�\�5sê5nA�\�\�ՂVY\"�e]�0�\�`8\�9v�\���Mv\�D��d:�5�~��9\�M\�\�\r�\�p!�\�S�>}q\�\�\�\�\�\�S�枳\�rZ\Z�h`�i�E�\��o#�a�v|�\0�mQ\�v��\�\�f�\�K�RW�Z���%�\�\�(�@}y�\�\��\�\�Ƭ\���\�ZVij����\�OT�f�\�%�<q`AƯf��Oj�\0�&�\�5��Ag��\Zr\n�\0�e�֢8�\�p����:\�}O\�l\����̳,�Q\�\\��6��̲���%=Acv\��$�9�q\�$���-\r�\�<�H\�KUGO�&ܮ��r�\�\���\�<��O<X����M�i\�G\�Pf\Z\�&\�z\�p\���Y��~<x\�\�\�\�\�\�18\�[�\0;{c�\0\�(?��\r�\�\�+\�\�6Y�$\���1\�\��ȧ����%=\�^\�ف\�$͹�\\nk/�\�K�\��o�Ʊ\�\�ENk*\�Q]Z�\�u@���</�=N\0��cCNe��dBT\�U-4t\�z�\�,�\r\�|\�\�\��\�\00`�0�����G�\�\0\"~X\�c�\�9k#�K=)Y��6�N\�\�$�e<\�\�?,{Dc�MM�����y\�iI�ZD�n$\��\�~<<c,�j�\�c+\�O�\�Sd�ң\�	\�\�dWVR�H �A|b�\�9K\�/3\���s\�(��q\�\�\�\�L1\���j��@֎Fr��L��m�\"\�\�}y\�Ҳ�H!\��IC�\�Y<\�m\��.2Y\'\��X׉Pj,�z�飮S,���\r\�\�\��\�zcMM��\�\�\�;B!rx���m��̕�V�z\nԍ��\�l7Yc\�\�\�̌9\�dy}0��,u\nͼ\��-\�\�\�\��g9p\�G�w�i#\�y\0~4�Ą�l7\�\�\�\���q\�R\�e\�+2�Ic\�^�ӎ9�\\kf\ZG-��Jzuzg+�qp�\����A�O�\�\�Y�\��*r�\Zi\�i�\��$t�\0a�]\�ވkN\�f�^ZP4�X�1�4lD,7\�\�\�\�\�y\�8\�O�r�!\�^�`%�xY��b���#��0��rgGG��\�\�[t\�ny\�ד��z�K䐰h\�d\�?�\��\���&\�S�\�fWX$�P�#\'��؃Ў<�\�ܣ$˲�$����i\0\r\�\'�\�,k���1�M��1b������G�\�\0$�=�\Z\�N\�iZ�b\�PX~! \�\�<�c�\�\�?�{z\�8�\�h\�ǆ0�r���Z\�\�^\�_/,{]3C\�\�A#L\�UʲȆC\�A=H&\�\�\�\�)ڇ�\�\�\�\�ḧ�i�YŮ%o	���\\Xz˩�%4\�+Lc@�F\�\�u\'\��\�]i�\�:N\�5�E���4\�A�[z!�\0Q���\�1\�\"%�sU\'d�\ZY\�o�d\�oW�\�\�QS��i\'� �\�׮9�Zv\�׽E=\�w$�\�\�vJlH\ndnO>\0:\�En��¤U\��\0̪g�0�p\\�\�\�B\�|$z\�=:\�Y\n,\�a\�gf�1�=K�{4�7�\�c�Sv١ġ)\�\�j\�\�Z\Z6�>�+c��2�z�4\��\�\�O�!�\�\�\�\�Ǒ�\�\�\�,�\�1\�\�#���\�:�\�~IP�\�ӝ�i\�u��\��vM\�\\f\�\�[\�O\�\�^�pn1�T\�\�40���\�t��6�l8\���\�\�웵\�\�*����\�VV\�\�\�\�\�	\�=l.\�A����Ph\�\�IQ\rU,U4\�,�ʁ\�u7�\\\��2b\��\0#{ap�\�7�\0H�A\�1\�c��Ǭ\0`��3�\�\�\�NTUim/�\�h\��\0\�VqIqpti,G\'���\�\0����\��C�)�rl��\Z��\0iV��)>�:�\�?�\��uNs�gY�Vd��L\�s!WrC�7X�n,:t򵅆\�Zzj��\�?�{\�\��\�Ǜ\�\�\�\�y8@��\�B�Y�\��ȶ\�`I[9\�\r�ı\�vUIe3�H\�L\\Ň7��\�kc�Rbf��s \����B\0ן\��q�<\�\�\�F\�I\r3���Ɵ�)^�\\\�ߛ\�~��\�X�(\�Y\����(R|6۸~�?HrQV\�#\'H�hL��9`�3hޚ�-�\n\�T�=�\�~�\�.O\�d��$Yt��\�\�J�\�@�<@���\�Y��~�\�Ö�\�ގ�VA-L��G�\�n9H�\\��덜�\0(���\�D�\�#��$���H���/u#}Ǯ\�<�\�攲\�l\�\�\�ʑ���v<hw�G��a�m\�\�\�>�\�$ԫ	\�=B$�%\���6\�	\�tq��B\�Z�W�>uEsQ��\�BY��Tn��E�:�(�h:M����I\'�4jUe��h�\�\'�\�\�ܢ\�\��e�œԭ��\�\�L&�(��\�:\�J�:Z�\�*�Z&�]��\�=\�\��\�\���iZ쟴|�M�G[$$���b\�\�� �ͷ\��M\�:�c؋�\�|��F\�\�\�\�olIG\�a�X\�\�=�#]�\�?��\���}X���)\�ԃ5K�}��V?\�:��Bv��\0t,���\�\��\�P#�ٿS\�\�h\�\�r�-���¾L\�3�\�_S?}<ҹ2;���\�\�[aߴNҳM}�\�s�@��.�Q\�I��>�ݭ\�<]�r~��xL���X\�T=ٽ�\�\'\��\0��3l\�*��M:S\�DIQ\�\r\�\�\�(׸c}ޝ\rϝ��<\�\�M$���Io;|�qo\�u\�\�a]v�շ�&\�ۋmAk��o\�9Fo�L>ꊠ;{\�%\�H\��\�\�\��)Q#�T=@�:r\�2��\�)��b\�\�\�ť\���G5u=��ny\�\\tM� 䛐��]+�eʨ~75�\�ZЉ6�@G7\�\�\�a\�B\0\�o�׬4\�\�\�[#\�\�+_yk�܁}�XpT\�69rM\�-�\��\��c�\�ˠ���jh��Ȳlbp\�쿸|�\�{����k\�(�I�R\�9T\n\�\��TH9=\�\�T�܋o\�\�%\ZS�\�Y��9�WJUv�\�\�m�-k\\\�pE�.m-�2�9��&YN0\�̒�,?�\�<�����Ni\�K�L�s)�\�\�JL��\n\�\�\�#K��n��I�?S�][�\�\�E�KI]\�h\�$\'ɔ�6<1��\�9\�s\�ۦ\�--&c�\�\�\"yj�z�y!o;)\�w\�l!Tz\�\���\0G�\������\�^�\�ڏ8����\�w;���<ٍ�\�\�v��sNѵs\�<\�3L�����%%)�7\�ߋ�\r\�����;{�ͨ{D���<ͳ��3\Z\ZR�\'���\�A6Q�\0-\�|qWmy\r�A��\�rx\�7G+\�Q�$�Gvv�ĵٷ�`\�e\�)$\���\�(�\r?���p��<_�\�\�d9�mT�H�D\��N\�v�2E��\�F��\n�J<�-��\���\�\�ӟ_s�KHd�y5=\r�SǙ\�B��\�j�\�b9\�s\�l1D]�0\�}ٞK\�%-vq$\�]\�3\�l�ovǀ\0\�6\'�3oKٙ-^d�\�\�\"jj`\�\�}����\�%\��X�}dC55QC*,{Q6�X�\�[�mbG6wB\r\�\�\�W4\�\�NH\�5R,kG\�\��bm\�q\�9P�\�(\�smk��[��9SZj\�O\�\�\�#�\�\� �y�7��7V�\�YfCJR�\�ܖ�r�|�I\'�!rl��|li���#\�i\�\�DP�/��\�\�\�\�s\�\'�9b\�\�%6\�\0-�\\�`��\00`��F\�\�\�\�ol\��L�A\�\�b\�ϜV�]H[��\�\�E�$�\0x\��\00\�s��\�|֢L\�6��\�\�F&\�P�@\0��\�k}I�j|\�]A�\�,�\�\��p�\��\�j	\��\�{�\���3vF���\�J\�<�*2�F!\\y�\�:(�\�kg����\"�\�t����4��/�(b�M��\'\�1\�|��瓌\�\�%mmcW\��UTS�g�6�\�Y�A^>e\�>^X\�	\�\��6Or�\�C\�\����%Ҵ�Ƕ?��V\n�܎��\01�5��d����KG�N�\�\�\�\�BL\�`lW�\�;�C�\�\�\�/��9\�{�\�|\���\n\�BeK0 �v\0�A;@\�_\�\\�\ZT�b��Us�@�\"�X�\�c\�\���\�{c�2��C�\�}zH�Zrq���!S�,l0c�\�0`��0`\0\�?\�\�\�\\#��\�9S\�\�`\�]5n�ˉʡ�I�E0\�\�H/����\�~�zu\���ƶ�L�.\�\�%%<@�HH\�E�P\0\��5Wj��oK�#��I�+\�.�\�G����\�8F>�n\�,\�eU,X\0\�=)\�\�;K\�u�d�\rixZ	j6\Z��\�bO$�\0\�$q��\�\�\�$��3ϳ*\�\0�~(EďҊ��\�c\�Ϟ+\�=!<��uc�-\�\�\0�l_\�8g$_p�>�\�pO,;i\�{7�-�Q�\�~�#ힺ�*�I!\�e��v%A���E-\�\�	\0s\�\���v�D��K�V@�+40\�\�w���`\�\0��IA\�()�Yx*��i뻆z���\�\�+`	\n[|\�\\c\�U\�⎜%�WRt�\�\0��\�c\�\�ɥ\�t\'\�n;\�\�\�2�\�U�m�\���rڈ\�\'3F\�o!�\�r@��u�\��\0��\�ٕ&m�A�P\�&��wF\�\�\"\�\�\�\�%d\�N�ʩe�&Ԓơ���|V#�Q�Ф�\0Ý&a�r:��\�Ȏ�a���i:9�fE��+���\�:㖡J擋\�ૌ\Z�y��]q��6�\�h\�-\��O��\�*�}M����\�.\�=�eY�j��\�\�oz�Z6��r>�[\�\�bN\�\�\�\r�DSk\�m\�\�]�V�1\\k܋�QY~Q�eTt\�S�jey7�ц,x-\�;�\����,�\�{\\q�YXnR\��Ζ\�3\�,RkjZ�\�=LUjd;ܼrƗ\0���2A\�K�\�Ni��|�l�=[F�/�U�*g�a�\n\�:($0g�%\��ar\�q����^\�<�5]CI�ũ\�\�7\�\n�%\�Պ�V>��[�O%��\'�\�\0s�m��\�f�\�F�+WP�����@ �<��\�,Ň0\�\�aMKN\�P�D�wB!\�$}\�\0T\\�\�o\�\�\�1��2G�\\\�`��\�b�\�I\\\�\�v?\�\�:y�vm��#\0\�m#\�T}@�Ƒu�$)�\�j��?���\�RWc!I{\�O�<\��˪v�-<\�\�ΑH\�\�\�0�\�Q~H\�\�Ϡ��;C�\�G���>\\Y�\��\�E,�N�J�c�\�\�*��D\�6�7ʥ\�38&\����b�ź\�/\���YP2\�녪⚒(ꬥ��\0�u\�$�x�?\�a��Te\�\�+\�\"��\�����\�2\�r�)�:\�T�\\G`\�!\n�>V\"\�\�Ī �vq�g�veK�w}\�x�\�\�\�$\�Ʒ�`\�.O<�9�\0�\�2�\�\\\�r\�E�B��\�{le$\�1[[�a\�qȫ*sE�Lޡg���㦀T�&(�T n�����\�\�ah#Jp���\�.\�\'�\�\�b�H�Y�s\n\�\�\�\�\�\"�y\r}\�\�6e,E\����a\�<\�a�Ue\�S\�<\�O	\r4{��ma�u\�\�n,-\�L�&\�c� ��\��U\�\�E+\�l֑�ʿ�\'�,_�,��pr	Q\�>g-nUS@��XD`�k�b�\�\Z\�S�4��\�AT��WH\�\�m��tv=:N�\�1����Ꚗ�-���\�\�\��\�ϛ�\�\\\\�\�=�M隼\�h\Zx\�E6$3��zn��\�Km\�lp�I(E[{\"\";\'\� \�i*\�&�{���E`\�EQ�\�wl\0\�\'�\�xu\�ݟeY�\�jʺ�;�pi\ne@���\���#\�\�͐�\�$\�\�I%dl{\�w,���\�Y���\r�\���1v����8i��j\�,�\��\�xJ�\�KX!v	��\\\�%�\�\�/�\�c\�6z\�=�e�sQÚ\�UM/t�	��ܐ7[\�B�\�6��\��\��e\�\�P\��\�\�\�\�Qe�\�\'{$�\�T+mh�!�ʗ\�?�\�y�Y\�\�7�/	��F\Z�&M&N\�N\�\�kHևRe5\�=����\�\�Ǻ{\�\�\�\'\��v�rj�\�\�\�ko�+\�\�Ǯ,߶a;\�L��@�OOAެl\r�bo\�<��\0X�\�g�����Wgu\�\�\�lM�9\'NM6\�Vn־\�\�I]L�xn\0\�\�\0?\����NOK).\�1ߒ̲\���p\�\Z�%���.k�M�F��q�,��X�,\�C��	\�\�q�\"\�\�K ��du\�\��{c\�s���X���ӎ׭�\���\�t�\�.ֿ��h�w��,\�ޘ_�f\�Ŭ�ύ+P\�T\��-T4�Z3�|`�տ�Ls&�\�\��\�\0\�$%�0;�\�\�\�+[<*�e.c���\�ϜL\�\Z��\�5\�G��F\�\�H�یKi\"8���2b�m�F���\�\��\�H�0\�4\�\�ՑI���Ud\�O-���#�\�\�`\�KU\�A#y�W>\"\0ש\�&\��\�o��8���\�@�Rķ$\�\��\�=1\���_T�.n̥�\�g���Ip\�r�Ý�An<�\n�t�\�AWO\�\�S\�\�6e���\�\�qɽ�TO4�4�J\� \�\�浀\�\�ltޑ����T\\�o��\�G\'\�\�\�\�D�m>C�;3>U@\�\��&�	`I6<s\�\'�8X�,�\'g�*����1Zd��s\�[��\0\��\�\�\�\�pw\�踭\"�\��f\Z,�,��\�IAK�[|p��zq�\��\�;\�\�\\#L\�O\�U�ݶ�\�');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `personal_data_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `personal_data_id_idx` (`personal_data_id`),
  CONSTRAINT `personal_data_id` FOREIGN KEY (`personal_data_id`) REFERENCES `personaldata` (`id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (2,'angielski'),(3,'niemiecki'),(1,'polski');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `book_item_id` int NOT NULL,
  `price` decimal(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `book_item_id` (`book_item_id`),
  CONSTRAINT `book_item_id` FOREIGN KEY (`book_item_id`) REFERENCES `bookitems` (`id`),
  CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_status_id` int NOT NULL,
  `client_id` int NOT NULL,
  `reveiver_data_id` int DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `total_price` decimal(9,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_status_id` (`order_status_id`),
  KEY `receiver_data_id` (`reveiver_data_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `order_status_id` FOREIGN KEY (`order_status_id`) REFERENCES `orderstatuses` (`id`),
  CONSTRAINT `receiver_data_id` FOREIGN KEY (`reveiver_data_id`) REFERENCES `receiverdata` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderstatuses`
--

DROP TABLE IF EXISTS `orderstatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderstatuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(10) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderstatuses`
--

LOCK TABLES `orderstatuses` WRITE;
/*!40000 ALTER TABLE `orderstatuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderstatuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personaldata`
--

DROP TABLE IF EXISTS `personaldata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personaldata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_polish_ci DEFAULT NULL,
  `surname` varchar(32) COLLATE utf8_polish_ci DEFAULT NULL,
  `email` varchar(64) COLLATE utf8_polish_ci DEFAULT NULL,
  `tel` varchar(25) COLLATE utf8_polish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personaldata`
--

LOCK TABLES `personaldata` WRITE;
/*!40000 ALTER TABLE `personaldata` DISABLE KEYS */;
/*!40000 ALTER TABLE `personaldata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishers`
--

LOCK TABLES `publishers` WRITE;
/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
INSERT INTO `publishers` VALUES (1,'Helion');
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receiverdata`
--

DROP TABLE IF EXISTS `receiverdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receiverdata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personal_data_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `personal_data_id_idx` (`personal_data_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receiverdata`
--

LOCK TABLES `receiverdata` WRITE;
/*!40000 ALTER TABLE `receiverdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `receiverdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `password` char(255) COLLATE utf8_polish_ci NOT NULL,
  `is_employee` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-21 22:53:10
