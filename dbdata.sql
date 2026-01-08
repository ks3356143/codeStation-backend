-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: codestation
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add 用户表',4,'add_user'),(14,'Can change 用户表',4,'change_user'),(15,'Can delete 用户表',4,'delete_user'),(16,'Can view 用户表',4,'view_user'),(17,'Can add issue2 type',5,'add_issue2type'),(18,'Can change issue2 type',5,'change_issue2type'),(19,'Can delete issue2 type',5,'delete_issue2type'),(20,'Can view issue2 type',5,'view_issue2type'),(21,'Can add issue type',6,'add_issuetype'),(22,'Can change issue type',6,'change_issuetype'),(23,'Can delete issue type',6,'delete_issuetype'),(24,'Can view issue type',6,'view_issuetype'),(25,'Can add issue',7,'add_issue'),(26,'Can change issue',7,'change_issue'),(27,'Can delete issue',7,'delete_issue'),(28,'Can view issue',7,'view_issue'),(29,'Can add comment',8,'add_comment'),(30,'Can change comment',8,'change_comment'),(31,'Can delete comment',8,'delete_comment'),(32,'Can view comment',8,'view_comment'),(33,'Can add quiz',9,'add_quiz'),(34,'Can change quiz',9,'change_quiz'),(35,'Can delete quiz',9,'delete_quiz'),(36,'Can view quiz',9,'view_quiz'),(37,'Can add book',10,'add_book'),(38,'Can change book',10,'change_book'),(39,'Can delete book',10,'delete_book'),(40,'Can view book',10,'view_book');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (2,'auth','group'),(1,'auth','permission'),(3,'contenttypes','contenttype'),(10,'issue','book'),(8,'issue','comment'),(7,'issue','issue'),(5,'issue','issue2type'),(6,'issue','issuetype'),(9,'issue','quiz'),(4,'user','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-03-26 12:12:32.581484'),(2,'contenttypes','0002_remove_content_type_name','2025-03-26 12:12:32.676243'),(3,'auth','0001_initial','2025-03-26 12:12:33.066676'),(4,'auth','0002_alter_permission_name_max_length','2025-03-26 12:12:33.151909'),(5,'auth','0003_alter_user_email_max_length','2025-03-26 12:12:33.157855'),(6,'auth','0004_alter_user_username_opts','2025-03-26 12:12:33.163900'),(7,'auth','0005_alter_user_last_login_null','2025-03-26 12:12:33.170878'),(8,'auth','0006_require_contenttypes_0002','2025-03-26 12:12:33.177318'),(9,'auth','0007_alter_validators_add_error_messages','2025-03-26 12:12:33.184176'),(10,'auth','0008_alter_user_username_max_length','2025-03-26 12:12:33.191309'),(11,'auth','0009_alter_user_last_name_max_length','2025-03-26 12:12:33.199074'),(12,'auth','0010_alter_group_name_max_length','2025-03-26 12:12:33.217597'),(13,'auth','0011_update_proxy_permissions','2025-03-26 12:12:33.225433'),(14,'auth','0012_alter_user_first_name_max_length','2025-03-26 12:12:33.233014'),(15,'user','0001_initial','2025-03-26 12:12:33.667776'),(16,'user','0002_alter_user_options_rename_uid_user_id','2025-03-26 14:04:07.900814'),(17,'user','0003_user_role','2025-03-27 13:27:54.725771'),(18,'issue','0001_initial','2025-03-28 14:14:45.597526'),(19,'issue','0002_alter_issue_update_date','2025-03-28 15:06:06.208887'),(20,'issue','0003_issue_commentnumber_issue_scannumber','2025-03-31 16:47:50.675717'),(21,'issue','0004_remove_issue_type','2025-03-31 17:23:16.007095'),(22,'user','0004_user_points','2025-04-02 17:27:34.063496'),(23,'issue','0005_comment','2025-04-08 15:59:41.723189'),(24,'issue','0006_comment_type','2025-04-08 16:06:52.671651'),(25,'issue','0007_alter_comment_commenttype_alter_comment_issue','2025-04-08 16:46:10.354494'),(26,'issue','0008_alter_comment_commenttype_quiz','2025-04-11 10:45:08.217116'),(27,'issue','0009_book','2025-04-12 16:53:19.798118'),(28,'issue','0010_book_commentnumber_book_scannumber','2025-04-12 17:39:11.883186'),(29,'issue','0011_book_create_date','2025-04-13 13:57:44.029002'),(30,'issue','0012_comment_book','2025-04-13 15:27:06.806359'),(31,'issue','0013_alter_comment_commenttype','2025-04-13 16:36:04.179422'),(32,'user','0005_user_enabled_user_permission_alter_user_role','2025-11-27 15:40:37.297862'),(33,'user','0006_user_intro_user_qq_user_wechat','2025-12-30 10:23:27.754005');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_book`
--

DROP TABLE IF EXISTS `issue_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_book` (
  `id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `picture` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `downloadLink` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bookInfo` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `requirePoints` int NOT NULL,
  `type_id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `commentNumber` int NOT NULL,
  `scanNumber` int NOT NULL,
  `create_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_book_type_id_a9e3ae0b_fk_issue_issuetype_id` (`type_id`),
  CONSTRAINT `issue_book_type_id_a9e3ae0b_fk_issue_issuetype_id` FOREIGN KEY (`type_id`) REFERENCES `issue_issuetype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_book`
--

LOCK TABLES `issue_book` WRITE;
/*!40000 ALTER TABLE `issue_book` DISABLE KEYS */;
INSERT INTO `issue_book` VALUES ('Basduhwouboab213','《Java性能权威指南》pdf高清中文电子版','book_imgs/javaqwzhi.jpeg','https://pan.baidu.com/s/1PRm7ekjpEXOudWbVCCuGzQ','对于有经验的程序员来说，关于一般性能优化的开始讨论不是很有用。例如，“编写更好的算法”的建议并不是我在一本关于Java性能的书中真正想要的。对于没有经验的程序员来说，这是一个很好的起点。 此外，本书的另一个亮点是提供了关于Java EE API和JDK本身的调整和性能改进的提示，在那里解释了Java本身的各种改进。 这本书的结构比较清楚。就像标题所说的，这确实是一本权威的指南。一本完整的指南，以一种明朗的方式涵盖了关于Java和HotSpot JVM性能工程的大部分内容。 总之，强烈推荐阅读，不仅对那些想开始改进和调整Java应用程序的人，而且对那些想更好地编码的开发人员。',0,'TmeaASSrwLTY92Sb3FVAD1',2,4,'2025-04-13 13:57:43.989449'),('emqkvnCbBdXfnWTSUxkqPj','笨版本学python3','book_imgs/eec540461f72415fbb7a6fdfcfc1a375.jpg','https://url89.ctfile.com/f/31084289-1357016419-cf9c7e?pwd=8866','### 内容简介\n本书是一本编程技术入手，最终体验到软件开发的基本过程\n### 作者介绍\nZed A.Shaw是一位狂热的吉他手、程序员和编程书作家。他的这本书在全世界有数百万的读者。他写的软件大大小小的公司都在使用。他的文章经常被众多极客圈里的人阅读和引用。他是一名活跃而有趣的作家，他会让你大笑，也会让你思考。',20,'TmeaASSrwLTY92Sb3FVAD7',0,32,'2026-01-04 13:30:16.951949'),('NjVUGBVREiVBvQNgqtqLrh','用Python写网络爬虫（第2版）','book_imgs/pythonpc.jpg','https://590m.com/dir/14804066-30823849-7607c8','本书包括网络爬虫的定义以及如何爬取网站，如何使用几种库从网页中抽取数据，如何通过缓存结果避免重复下载的问题，如何通过并行下载来加速数据抓取，如何利用不同的方式从动态网站中抽取数据，如何使用叔叔及导航等表达进行搜索和登录，如何访问被验证码图像保护的数据，如何使用 Scrapy 爬虫框架进行快速的并行抓取，以及使用 Portia 的 Web 界面构建网路爬虫。',0,'TmeaASSrwLTY92Sb3FVAD7',10,3,'2025-04-13 13:57:43.989449');
/*!40000 ALTER TABLE `issue_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_comment`
--

DROP TABLE IF EXISTS `issue_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_comment` (
  `id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `commentType` smallint NOT NULL,
  `commentContent` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `issue_id` varchar(22) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `book_id` varchar(22) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_comment_user_id_25957a0a_fk_user_user_id` (`user_id`),
  KEY `issue_comment_issue_id_d0195e35_fk_issue_issue_id` (`issue_id`),
  KEY `issue_comment_book_id_0ad91fc6_fk_issue_book_id` (`book_id`),
  CONSTRAINT `issue_comment_book_id_0ad91fc6_fk_issue_book_id` FOREIGN KEY (`book_id`) REFERENCES `issue_book` (`id`),
  CONSTRAINT `issue_comment_issue_id_d0195e35_fk_issue_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issue_issue` (`id`),
  CONSTRAINT `issue_comment_user_id_25957a0a_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_comment`
--

LOCK TABLES `issue_comment` WRITE;
/*!40000 ALTER TABLE `issue_comment` DISABLE KEYS */;
INSERT INTO `issue_comment` VALUES ('2yd3iKX8322VHkNB5ihano',1,'<p>啊撒大声地</p>','2025-04-09 10:40:19.970743','2025-04-09 10:40:19.970756','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('34WeddMoky8BqFfMdQDoXJ',1,'<p>我这是一个评论哟~~~</p>','2025-04-09 09:18:49.339233','2025-04-09 09:18:49.339264','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('3C3rRqbJBkruwY7VpXJN2S',2,'<p>可以的</p>','2025-11-18 10:55:11.086042','2025-11-18 10:55:11.086057',NULL,'TmeaVHSrwLTY92Sb3FVAD7','Basduhwouboab213'),('3mMHCLAG8Fg3tdunXSYSNh',1,'<p>阿萨德夸感受到</p>','2025-04-09 09:34:26.534129','2025-04-09 09:34:26.534140','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('3Ro4cBGTPR67ZofBBy7N2B',1,'<p>1212阿萨德阿达阿萨德</p>','2025-04-09 10:12:29.293353','2025-04-09 10:12:29.293368','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('3S3ymbBnY6eDKytLeKe4bK',1,'<p>who is good brother</p>','2025-04-09 09:25:24.653332','2025-04-09 09:25:24.653350','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('3XD5r53K3k2hbkCewshGQP',1,'<p>我先评论一个再说</p>','2025-04-12 17:27:14.723239','2025-04-12 17:27:14.723250','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('4x5umrfgqaTmfaMaoCXNXp',2,'<p>12412312</p>','2025-04-13 18:03:56.114864','2025-04-13 18:03:56.114883',NULL,'TmeaVHSrwLTY92Sb3FVAD7','NjVUGBVREiVBvQNgqtqLrh'),('5bRf8kFqxktjmq4w8StiZS',1,'<p>啊实打实大</p>','2025-04-09 10:50:28.662887','2025-04-09 10:50:28.662902','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('7qRtd8vPBDY259Lc2ZNkHk',1,'<p>谁是税费111</p>','2025-04-09 09:38:16.312197','2025-04-09 09:38:16.312215','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('7WjxxJsTfnvJt2RYcgiNih',1,'<p>这下就不会报错了把</p>','2025-04-09 09:27:20.856719','2025-04-09 09:27:20.856732','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('8ncE4Eejz5r53QfKwtkHqP',1,'<p>啊实打实大师大</p>','2025-04-09 10:57:59.474497','2025-04-09 10:57:59.474506','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('9589epVyPEDELeKgQDmwH2',1,'<p><br></p>','2025-04-09 10:41:55.094166','2025-04-09 10:41:55.094174','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('9mZxmETJTQvPoUNDdARLRC',2,'<p>1241241</p>','2025-04-13 17:55:53.854564','2025-04-13 17:55:53.854572',NULL,'TmeaVHSrwLTY92Sb3FVAD7','NjVUGBVREiVBvQNgqtqLrh'),('abhsePPN2XJR7aSCFbr7up',2,'<p>112312412</p>','2025-04-13 17:55:49.258284','2025-04-13 17:55:49.258292',NULL,'TmeaVHSrwLTY92Sb3FVAD7','NjVUGBVREiVBvQNgqtqLrh'),('AMFR6CySkH5WbTCzxxKa9S',1,'<p>啊实打实</p>','2025-04-09 09:36:22.505284','2025-04-09 09:36:22.505292','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('ANTUdHtGaQema4KiqPmDAH',1,'<p>123123</p>','2025-04-13 18:05:38.406486','2025-04-13 18:05:38.406496','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('atnRCLLYwtKcYoRLk8RFgf',1,'<p>这非常有用的</p>','2025-04-09 09:21:00.378701','2025-04-09 09:21:00.378715','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('ayLqcTFa7ySP65ej8BkAjy',1,'<p>啊撒大声地</p>','2025-04-09 10:38:58.742459','2025-04-09 10:38:58.742471','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('B9oPxo2DXj9MxwvPciGXRf',1,'<p>我进行了一个评论123123123</p>','2025-04-12 17:29:42.904554','2025-04-12 17:29:42.904564','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('cAbJu76GoS2JFkDjXWXGor',1,'<p>这是晨晨的评论</p>','2025-04-09 09:23:08.492932','2025-04-09 09:23:08.492979','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('CWjot34YeMVKBj888Sxp9U',1,'<p>这会是乐观ok吗</p>','2025-04-09 09:31:13.190906','2025-04-09 09:31:13.190916','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('D2UQfMB9vq6cFE9NFTBAYR',1,'<p>这下就不会报错了把111</p>','2025-04-09 09:27:29.799767','2025-04-09 09:27:29.799781','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('DbCdtuuy9BUd8zSG6LqcxF',1,'<p>我评论了内容</p>','2025-04-09 09:42:11.626436','2025-04-09 09:42:11.626451','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('dCg4ktLZYMRPFoc2P3zXE5',1,'<p>啊实打实大撒大声地</p>','2025-04-09 10:41:23.437206','2025-04-09 10:41:23.437215','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('dfc7R6AfRyQASE4mkqRsPA',2,'<p>阿萨大大</p>','2025-04-13 18:04:01.309733','2025-04-13 18:04:01.309742',NULL,'TmeaVHSrwLTY92Sb3FVAD7','NjVUGBVREiVBvQNgqtqLrh'),('dKng7cADPJBjEiNNk9chSw',1,'<p>是12噢二12123</p>','2025-04-09 10:39:38.855180','2025-04-09 10:39:38.855193','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti2k8G7rEUUpUQAhg9YY',1,'这是评论内容呀','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti3k8G7rEUUpUQAhg9YY',1,'这是评论内容呀1','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti5k8G7rEUUpUQAhg9YY',1,'这是评论内容呀2','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti7k1G7rEUUpUQAhg9YY',1,'这是评论内容呀3','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti7k2G7rEUUpUQAhg9YY',1,'这是评论内容呀4','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti7k3G7rEUUpUQAhg9YY',1,'这是评论内容呀5','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti7k4G7rEUUpUQAhg9YY',1,'这是评论内容呀6','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti7k5G7rEUUpUQAhg9YY',1,'这是评论内容呀7','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti7k6G7rEUUpUQAhg9YY',1,'这是评论内容呀8','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti7k8G7rEUUpUQAhg9YY',1,'这是评论内容呀9','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Dmti8k8G7rEUUpUQAhg9YY',1,'这是评论内容呀10','2025-04-08 16:03:51.522358','2025-04-08 16:03:51.522378','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('dSDRs9Cunka5Qgit3kPyF5',1,'<p><br></p>','2025-04-09 10:41:23.563186','2025-04-09 10:41:23.563194','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('EMTXrZjJM2dsLwtpJn89g4',1,'<p>ASDAWD</p>','2025-04-08 20:16:25.585920','2025-04-08 20:16:25.585929','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('eoekztrMen5SuZG3Fp9NUg',2,'<p>123123</p>','2025-04-13 17:55:46.152551','2025-04-13 17:55:46.152559',NULL,'TmeaVHSrwLTY92Sb3FVAD7','NjVUGBVREiVBvQNgqtqLrh'),('EsxA9yFS2wPudajyQTqU9k',1,'<p><br></p>','2025-04-09 10:41:55.382700','2025-04-09 10:41:55.382709','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('FQTKYfvG6gyb3pxk2BXLx9',1,'<p>啊实打实大师大</p>','2025-04-09 10:41:53.750596','2025-04-09 10:41:53.750605','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('gB2LN6FpagGQu4TH9YLLm6',2,'<p>我第一个评论</p>','2025-04-13 17:55:30.654896','2025-04-13 17:55:30.654904',NULL,'TmeaVHSrwLTY92Sb3FVAD7','Basduhwouboab213'),('HBfWyoBUwcLqH4CCABiUKe',1,'<p>123123</p>','2025-04-13 17:49:51.110619','2025-04-13 17:49:51.110629','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('ismozitXkjxY3cECda9Srf',1,'<p>123123123</p>','2025-04-09 10:38:51.454844','2025-04-09 10:38:51.454859','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('iU9PnQeevm7smKTNLMse9y',1,'<p>啊撒大声地</p>','2025-04-13 15:36:12.653203','2025-04-13 15:36:12.653214','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('jaRNuXZv4HxSntnHsthudk',1,'<p><br></p>','2025-04-09 10:42:17.404655','2025-04-09 10:42:17.404663','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('JEUTY5uwQfYz8B9psdwyV2',1,'<p>谁是英雄</p>','2025-04-09 09:26:16.897079','2025-04-09 09:26:16.897093','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('jppRqHPtkevgCDFz2i3x3R',1,'<p>123123阿达</p>','2025-04-09 09:33:46.666131','2025-04-09 09:33:46.666141','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('JrfaTiEzMpVg9euDPchUGk',1,'<p>123123</p>','2025-04-08 20:12:05.799890','2025-04-08 20:12:05.799901','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('k7zfvrJsYoFAt2W8vGjgtH',1,'<p>这不该是乐观更新</p>','2025-04-09 09:28:16.472092','2025-04-09 09:28:16.472105','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('KaE6maPAV9q5xcUEZ9SZyX',2,'<p>12312</p>','2025-04-13 17:50:19.730288','2025-04-13 17:50:19.730295',NULL,'TmeaVHSrwLTY92Sb3FVAD7','NjVUGBVREiVBvQNgqtqLrh'),('LfBnwjEEaRGrBXCJzYfYHy',1,'<p>我爱等大声道</p>','2025-04-08 20:13:41.720999','2025-04-08 20:13:41.721012','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('LGfFEkf5xWw7PyptqLK8fL',1,'<p>不错的评论~~~</p>','2025-04-13 16:25:24.937420','2025-04-13 16:25:24.937431','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('LTbTB3LxXmy9WAAYqWq8eY',1,'<p>啊撒大声地</p>','2025-04-09 10:58:27.567444','2025-04-09 10:58:27.567452','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('LzmM7HmXNvLoLWADAmwDbp',1,'<p>啊撒大声地</p>','2025-04-09 10:24:35.358961','2025-04-09 10:24:35.358973','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('MFrKiHDLsw2fLK8fSF4BJb',2,'<p>123</p>','2025-04-13 16:36:56.324428','2025-04-13 16:36:56.324444',NULL,'TmeaVHSrwLTY92Sb3FVAD7','NjVUGBVREiVBvQNgqtqLrh'),('MHZXRU29YxgzCf7dFiLVWB',1,'<p>这是乐观更新吗</p>','2025-04-09 09:27:44.529975','2025-04-09 09:27:44.529984','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('MnpvpBNX2Pso6bjtg6ykKQ',1,'<p>我进行了一个评论123</p>','2025-04-12 17:28:29.916634','2025-04-12 17:28:29.916644','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('MVTT6vY7VhZCC65vSiCFAq',1,'<p>阿达啊撒大声地</p>','2025-04-09 10:40:36.935698','2025-04-09 10:40:36.935713','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('n67c9b7PTgockrUELQnn8k',1,'<p>谁是大哥</p>','2025-04-09 09:25:02.883573','2025-04-09 09:25:02.883589','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('NcvyqouW5vmMLCW9N93SfB',2,'<p>我是第四个评论</p>','2025-04-13 17:55:03.565256','2025-04-13 17:55:03.565264',NULL,'TmeaVHSrwLTY92Sb3FVAD7','NjVUGBVREiVBvQNgqtqLrh'),('nFiQop4Gp3JcrnLCt6mLXX',1,'<p><br></p>','2025-04-09 10:08:16.098747','2025-04-09 10:08:16.098772','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('NNVWEDe232hRAz2BPqQjgF',1,'<p>嘻嘻</p>','2025-04-09 09:37:03.608420','2025-04-09 09:37:03.608430','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Pqz3p9vvQdhJvT7h5Hdp9T',1,'<p><br></p>','2025-04-09 10:41:55.235731','2025-04-09 10:41:55.235740','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Q6yb6M9KhbonS8tNUbXujD',1,'<p>谁是主宰</p>','2025-04-09 09:39:16.927097','2025-04-09 09:39:16.927111','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Qo54AroJnv5ZVmkYXooRc5',1,'<p>我是一个评论</p>','2025-04-08 20:12:25.215978','2025-04-08 20:12:25.215986','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('RjR5zjdUarMwB8N6QEnYjh',1,'<p>啊实打实大师大</p>','2025-04-09 10:47:05.506812','2025-04-09 10:47:05.506835','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('RkrG3DFXUc6CKNTkWQD9dB',1,'<p>啊所发生的</p>','2025-04-09 10:24:39.764441','2025-04-09 10:24:39.764454','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('S4ioAGebSrzMpdohV4wdP2',1,'<p>谁是税费</p>','2025-04-09 09:37:35.470635','2025-04-09 09:37:35.470643','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('SDiDPFaRerzBzMCaugpZBS',1,'<p>我进行了一个评论</p>','2025-04-12 17:28:13.271406','2025-04-12 17:28:13.271415','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('SWfxCphY4eL6ZzBLoHe4SJ',1,'<p>123123123</p>','2025-04-09 10:24:26.926668','2025-04-09 10:24:26.926695','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('TdWBjvM9jAVoEqJRomezre',1,'<p>啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊</p>','2025-04-09 10:48:54.729486','2025-04-09 10:48:54.729495','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('UoLZo3z8eySb5mn5G58zxe',1,'<p>谁是税费111123</p>','2025-04-09 09:38:19.595122','2025-04-09 09:38:19.595137','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('UXr7BHEtssaw5GsZ2gkNy3',1,'<p>111111111111111</p>','2025-04-09 10:47:18.740055','2025-04-09 10:47:18.740064','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('UZ6T949359ESYQAbxQYJhZ',2,'<p>zzzzzzzzzzzzzzzzzzzzzzzz</p>','2025-04-13 18:04:37.488240','2025-04-13 18:04:37.488257',NULL,'TmeaVHSrwLTY92Sb3FVAD7','NjVUGBVREiVBvQNgqtqLrh'),('VUaqim4LQGNHynAhdfzae7',1,'<p>123123123</p>','2025-04-09 10:57:52.759752','2025-04-09 10:57:52.759769','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('X3GpUdzNjjK9sGywtvvPrS',1,'<p>这会是乐观ok吗123</p>','2025-04-09 09:32:30.997684','2025-04-09 09:32:30.997692','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('X584GGEGnqZAhWgX4MweHy',1,'<p>123123</p>','2025-04-09 09:32:38.114139','2025-04-09 09:32:38.114150','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('XWyCrUAkf7Kie5EUUawWo9',1,'<p>我是第二十一个</p>','2025-04-13 17:52:23.327340','2025-04-13 17:52:23.327353','i6xtcNW9aWf8gCvYzDRY8h','TmeaVHSrwLTY92Sb3FVAD7',NULL),('Yi5JhbsLzUa92DsGfUhRq8',1,'<p>非常好的东西</p>','2025-04-08 20:14:55.570644','2025-04-08 20:14:55.570653','ZRDtwHH3Ca5RKsAk5wYPtb','TmeaVHSrwLTY92Sb3FVAD7',NULL),('ZAU4RALGE7kCcdDLe8KREL',2,'<p>我开始评论了</p>','2025-04-13 16:36:22.929138','2025-04-13 16:36:22.929148',NULL,'TmeaVHSrwLTY92Sb3FVAD7','NjVUGBVREiVBvQNgqtqLrh');
/*!40000 ALTER TABLE `issue_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_comment_type`
--

DROP TABLE IF EXISTS `issue_comment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_comment_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment_id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `issuetype_id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issue_comment_type_comment_id_issuetype_id_5f32db9b_uniq` (`comment_id`,`issuetype_id`),
  KEY `issue_comment_type_issuetype_id_40127004_fk_issue_issuetype_id` (`issuetype_id`),
  CONSTRAINT `issue_comment_type_comment_id_f91ceedc_fk_issue_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `issue_comment` (`id`),
  CONSTRAINT `issue_comment_type_issuetype_id_40127004_fk_issue_issuetype_id` FOREIGN KEY (`issuetype_id`) REFERENCES `issue_issuetype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_comment_type`
--

LOCK TABLES `issue_comment_type` WRITE;
/*!40000 ALTER TABLE `issue_comment_type` DISABLE KEYS */;
INSERT INTO `issue_comment_type` VALUES (37,'2yd3iKX8322VHkNB5ihano','TmeaASSrwLTY92Sb3FVAD7'),(7,'34WeddMoky8BqFfMdQDoXJ','TmeaASSrwLTY92Sb3FVAD7'),(78,'3C3rRqbJBkruwY7VpXJN2S','TmeaASSrwLTY92Sb3FVAD1'),(21,'3mMHCLAG8Fg3tdunXSYSNh','TmeaASSrwLTY92Sb3FVAD7'),(30,'3Ro4cBGTPR67ZofBBy7N2B','TmeaASSrwLTY92Sb3FVAD7'),(11,'3S3ymbBnY6eDKytLeKe4bK','TmeaASSrwLTY92Sb3FVAD7'),(74,'4x5umrfgqaTmfaMaoCXNXp','TmeaASSrwLTY92Sb3FVAD7'),(49,'5bRf8kFqxktjmq4w8StiZS','TmeaASSrwLTY92Sb3FVAD7'),(25,'7qRtd8vPBDY259Lc2ZNkHk','TmeaASSrwLTY92Sb3FVAD7'),(13,'7WjxxJsTfnvJt2RYcgiNih','TmeaASSrwLTY92Sb3FVAD7'),(51,'8ncE4Eejz5r53QfKwtkHqP','TmeaASSrwLTY92Sb3FVAD7'),(42,'9589epVyPEDELeKgQDmwH2','TmeaASSrwLTY92Sb3FVAD7'),(73,'9mZxmETJTQvPoUNDdARLRC','TmeaASSrwLTY92Sb3FVAD7'),(72,'abhsePPN2XJR7aSCFbr7up','TmeaASSrwLTY92Sb3FVAD7'),(22,'AMFR6CySkH5WbTCzxxKa9S','TmeaASSrwLTY92Sb3FVAD7'),(77,'ANTUdHtGaQema4KiqPmDAH','TmeaASSrwLTY92Sb3FVAD7'),(8,'atnRCLLYwtKcYoRLk8RFgf','TmeaASSrwLTY92Sb3FVAD7'),(35,'ayLqcTFa7ySP65ej8BkAjy','TmeaASSrwLTY92Sb3FVAD7'),(58,'B9oPxo2DXj9MxwvPciGXRf','TmeaASSrwLTY92Sb3FVAD7'),(9,'cAbJu76GoS2JFkDjXWXGor','TmeaASSrwLTY92Sb3FVAD7'),(17,'CWjot34YeMVKBj888Sxp9U','TmeaASSrwLTY92Sb3FVAD7'),(14,'D2UQfMB9vq6cFE9NFTBAYR','TmeaASSrwLTY92Sb3FVAD7'),(28,'DbCdtuuy9BUd8zSG6LqcxF','TmeaASSrwLTY92Sb3FVAD7'),(39,'dCg4ktLZYMRPFoc2P3zXE5','TmeaASSrwLTY92Sb3FVAD7'),(75,'dfc7R6AfRyQASE4mkqRsPA','TmeaASSrwLTY92Sb3FVAD7'),(36,'dKng7cADPJBjEiNNk9chSw','TmeaASSrwLTY92Sb3FVAD7'),(1,'Dmti2k8G7rEUUpUQAhg9YY','TmeaASSrwLTY92Sb3FVAD7'),(40,'dSDRs9Cunka5Qgit3kPyF5','TmeaASSrwLTY92Sb3FVAD7'),(6,'EMTXrZjJM2dsLwtpJn89g4','TmeaASSrwLTY92Sb3FVAD7'),(71,'eoekztrMen5SuZG3Fp9NUg','TmeaASSrwLTY92Sb3FVAD7'),(44,'EsxA9yFS2wPudajyQTqU9k','TmeaASSrwLTY92Sb3FVAD7'),(41,'FQTKYfvG6gyb3pxk2BXLx9','TmeaASSrwLTY92Sb3FVAD7'),(70,'gB2LN6FpagGQu4TH9YLLm6','TmeaASSrwLTY92Sb3FVAD1'),(65,'HBfWyoBUwcLqH4CCABiUKe','TmeaASSrwLTY92Sb3FVAD7'),(34,'ismozitXkjxY3cECda9Srf','TmeaASSrwLTY92Sb3FVAD7'),(61,'iU9PnQeevm7smKTNLMse9y','TmeaASSrwLTY92Sb3FVAD7'),(45,'jaRNuXZv4HxSntnHsthudk','TmeaASSrwLTY92Sb3FVAD7'),(12,'JEUTY5uwQfYz8B9psdwyV2','TmeaASSrwLTY92Sb3FVAD7'),(20,'jppRqHPtkevgCDFz2i3x3R','TmeaASSrwLTY92Sb3FVAD7'),(2,'JrfaTiEzMpVg9euDPchUGk','TmeaASSrwLTY92Sb3FVAD7'),(16,'k7zfvrJsYoFAt2W8vGjgtH','TmeaASSrwLTY92Sb3FVAD7'),(67,'KaE6maPAV9q5xcUEZ9SZyX','TmeaASSrwLTY92Sb3FVAD7'),(4,'LfBnwjEEaRGrBXCJzYfYHy','TmeaASSrwLTY92Sb3FVAD7'),(62,'LGfFEkf5xWw7PyptqLK8fL','TmeaASSrwLTY92Sb3FVAD7'),(52,'LTbTB3LxXmy9WAAYqWq8eY','TmeaASSrwLTY92Sb3FVAD7'),(32,'LzmM7HmXNvLoLWADAmwDbp','TmeaASSrwLTY92Sb3FVAD7'),(64,'MFrKiHDLsw2fLK8fSF4BJb','TmeaASSrwLTY92Sb3FVAD7'),(15,'MHZXRU29YxgzCf7dFiLVWB','TmeaASSrwLTY92Sb3FVAD7'),(38,'MVTT6vY7VhZCC65vSiCFAq','TmeaASSrwLTY92Sb3FVAD7'),(10,'n67c9b7PTgockrUELQnn8k','TmeaASSrwLTY92Sb3FVAD7'),(69,'NcvyqouW5vmMLCW9N93SfB','TmeaASSrwLTY92Sb3FVAD7'),(29,'nFiQop4Gp3JcrnLCt6mLXX','TmeaASSrwLTY92Sb3FVAD7'),(23,'NNVWEDe232hRAz2BPqQjgF','TmeaASSrwLTY92Sb3FVAD7'),(43,'Pqz3p9vvQdhJvT7h5Hdp9T','TmeaASSrwLTY92Sb3FVAD7'),(27,'Q6yb6M9KhbonS8tNUbXujD','TmeaASSrwLTY92Sb3FVAD7'),(3,'Qo54AroJnv5ZVmkYXooRc5','TmeaASSrwLTY92Sb3FVAD7'),(46,'RjR5zjdUarMwB8N6QEnYjh','TmeaASSrwLTY92Sb3FVAD7'),(33,'RkrG3DFXUc6CKNTkWQD9dB','TmeaASSrwLTY92Sb3FVAD7'),(24,'S4ioAGebSrzMpdohV4wdP2','TmeaASSrwLTY92Sb3FVAD7'),(31,'SWfxCphY4eL6ZzBLoHe4SJ','TmeaASSrwLTY92Sb3FVAD7'),(48,'TdWBjvM9jAVoEqJRomezre','TmeaASSrwLTY92Sb3FVAD7'),(26,'UoLZo3z8eySb5mn5G58zxe','TmeaASSrwLTY92Sb3FVAD7'),(47,'UXr7BHEtssaw5GsZ2gkNy3','TmeaASSrwLTY92Sb3FVAD7'),(76,'UZ6T949359ESYQAbxQYJhZ','TmeaASSrwLTY92Sb3FVAD7'),(50,'VUaqim4LQGNHynAhdfzae7','TmeaASSrwLTY92Sb3FVAD7'),(18,'X3GpUdzNjjK9sGywtvvPrS','TmeaASSrwLTY92Sb3FVAD7'),(19,'X584GGEGnqZAhWgX4MweHy','TmeaASSrwLTY92Sb3FVAD7'),(68,'XWyCrUAkf7Kie5EUUawWo9','TmeaASSrwLTY92Sb3FVAD7'),(5,'Yi5JhbsLzUa92DsGfUhRq8','TmeaASSrwLTY92Sb3FVAD7'),(63,'ZAU4RALGE7kCcdDLe8KREL','TmeaASSrwLTY92Sb3FVAD7');
/*!40000 ALTER TABLE `issue_comment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_issue`
--

DROP TABLE IF EXISTS `issue_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_issue` (
  `update_date` datetime(6) NOT NULL,
  `id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `issueTitle` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `issueContent` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `user_id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `commentNumber` int NOT NULL,
  `scanNumber` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_issue_user_id_aa5991a4_fk_user_user_id` (`user_id`),
  CONSTRAINT `issue_issue_user_id_aa5991a4_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_issue`
--

LOCK TABLES `issue_issue` WRITE;
/*!40000 ALTER TABLE `issue_issue` DISABLE KEYS */;
INSERT INTO `issue_issue` VALUES ('2026-01-05 17:47:05.140264','2j9nmq9VoDnjTNMdfY9bas','某问题10','某问题8的内容10','2025-03-30 14:39:03.607518',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-03-30 14:38:42.770945','6osUwe8FR44hhc7NuKjtJx','某问题6','某问题2的内容6','2025-03-30 14:38:42.770931',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-03-30 14:38:53.014403','6yEMR5dkGWr28L2wCScJgV','某问题8','某问题8的内容8','2025-03-30 14:38:53.014389',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-03-30 14:38:38.394989','anYR56sJHmWPwBHZAFXDjT','某问题5','某问题2的内容5','2025-03-30 14:38:38.394974',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-04-13 18:14:19.970683','bdLT49QHa7WqFxhVo7qqv8','这是一个标题哟','这是问题的内容哟','2025-04-08 09:51:41.096766',1,'TmeaVHSrwLTY92Sb3FVAD7',0,1),('2025-03-28 15:06:11.458872','E9BUQAYSJb5veGkLRhDzSi','测试问题1号','问题ninja_extra的问题内容','2025-03-28 15:06:11.458861',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-03-30 14:39:08.806413','eu8E9VWQvPQJVeWvxzKdCp','某问题11','某问题8的内容11','2025-03-30 14:39:08.806398',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-11-18 10:55:20.960411','i6xtcNW9aWf8gCvYzDRY8h','Python 成员变量在多个子类实例间共享，如何避免？','<p>请教一下，Python版本为3.9.6，然后运行如下的代码，为什么会出现<code>SlaveTwo</code>类的对象<code>modelTwo</code>打印自身的成员变量<code>storeDataArr</code>的结果是<code>[\'data1\', \'data2\']</code>，不应该是<code>[\'data2\']</code>？</p><p>哪个大神知道请指导一下，万分感谢?</p><div data-language=\"text\" class=\"toastui-editor-ww-code-block\"><pre><code>class BaseClass():\n    storeDataArr: list = []\n\n\nclass SlaveOne(BaseClass):\n\n    def __init__(self):\n        self.storeDataArr.append(\"data1\")\n\n\nclass SlaveTwo(BaseClass):\n\n    def __init__(self):\n        self.storeDataArr.append(\"data2\")\n\n\nmodelOne = SlaveOne()\nprint(modelOne.storeDataArr)\nmodelTwo = SlaveTwo()\nprint(modelTwo.storeDataArr)\n\n# 打印结果\n[\'data1\']\n[\'data1\', \'data2\']</code></pre></div><p>然后尝试在两个子类中也都定义了一下成员变量<code>storeDataArr</code>，代码如下，然后打印出来的结果就是我想要的样子了，但是这样定义的话，继承就没有了意义</p><div data-language=\"text\" class=\"toastui-editor-ww-code-block\"><pre><code>class BaseClass():\n    storeDataArr: list = []\n\n\nclass SlaveOne(BaseClass):\n\n    def __init__(self):\n        self.storeDataArr.append(\"data1\")\n\n\nclass SlaveTwo(BaseClass):\n    storeDataArr: list = []\n\n    def __init__(self):\n        self.storeDataArr.append(\"data2\")\n\n\nmodelOne = SlaveOne()\nprint(modelOne.storeDataArr)\nmodelTwo = SlaveTwo()\nprint(modelTwo.storeDataArr)\n\n# 打印结果\n[\'data1\']\n[\'data2\']</code></pre></div>','2025-04-08 13:44:01.319642',1,'TmeaVHSrwLTY92Sb3FVAD7',33,5),('2025-03-30 14:38:24.595609','LUHZNmBoQ9yDntVMk2Rr2C','某问题2','某问题2的内容2','2025-03-30 14:38:24.595588',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-03-30 14:39:17.071198','nariVYYsGkbZBt2TyrzZ4x','某问题13','某问题8的内容13','2025-03-30 14:39:17.071182',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-03-30 14:38:47.991987','RVKD3eVcBPtEkkEygcNHFN','某问题7','某问题7的内容7','2025-03-30 14:38:47.991972',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-03-30 14:39:13.264957','SN3xSTPXf7LBFENWAzkDXe','某问题12','某问题8的内容12','2025-03-30 14:39:13.264942',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-03-30 14:38:34.999751','UDFuhuuNnro8rTLg8MbPcS','某问题4','某问题2的内容4','2025-03-30 14:38:34.999737',1,'TmeaVHSrwLTY92Sb3FVAD7',0,0),('2025-04-13 18:14:13.138324','ZRDtwHH3Ca5RKsAk5wYPtb','python打包exe执行，把exe放在别的目录执行闪退 为什么？','<p>python 打包成exe执行闪退。</p><p>代码如下</p><div data-language=\"text\" class=\"toastui-editor-ww-code-block\"><pre><code>import logging\nfrom datetime import datetime\nimport pymysql\nfrom pymysql import cursors, Error as PyMysqlError\nimport pytz\nfrom apscheduler.schedulers.blocking import BlockingScheduler\n\n# 日志配置保持不变\n\n# 日志配置\nlogging.basicConfig(\n    filename=\'sync22.log\',\n    level=logging.INFO,\n    format=\'%(asctime)s - %(levelname)s - %(message)s\'\n)\n\n#logging = logging.getlogging(__name__)\n\n# 修正后的数据库配置\nDB_CONFIG = {\n    \'source\': {\n        \'host\': \'localhost\',\n        \'port\': 3306,\n        \'user\': \'root\',\n        \'password\': \'root\',\n        \'db\': \'report\',\n        \'charset\': \'utf8\',\n        \'cursorclass\': cursors.DictCursor  # 明确指定字典游标\n    },\n    \'target\': {\n        \'host\': \'localhost\',\n        \'port\': 3306,\n        \'user\': \'root\',\n        \'password\': \'root\',\n        \'db\': \'report\',\n        \'charset\': \'utf8\',\n        \'cursorclass\': cursors.DictCursor\n    }\n}\n\n\n# --------------------- 数据库连接修正 ---------------------\ndef get_mdb_connection():\n    \"\"\"修复时区设置\"\"\"\n    try:\n        conn = pymysql.connect(**DB_CONFIG[\'source\'])\n        with conn.cursor() as cursor:\n            cursor.execute(\"SET time_zone = \'+00:00\'\")  # 通过SQL设置时区\n        return conn\n    except PyMysqlError as err:\n        logging.error(f\"源数据库连接失败: {err}\", exc_info=True)\n        raise\n\n\ndef get_target_db_connection():\n    \"\"\"修复目标库配置错误\"\"\"\n    try:\n        conn = pymysql.connect(**DB_CONFIG[\'target\'])  # 修正为 target\n        with conn.cursor() as cursor:\n            cursor.execute(\"SET time_zone = \'+00:00\'\")\n        return conn\n    except PyMysqlError as err:\n        logging.error(f\"目标数据库连接失败: {err}\", exc_info=True)\n        raise\n\n\n# --------------------- 关键逻辑修正 ---------------------\ndef check_record_exists(uid):\n    \"\"\"修复游标类型\"\"\"\n    try:\n        with get_target_db_connection() as conn:\n            with conn.cursor(cursors.DictCursor) as cursor:  # 明确指定游标类型\n                cursor.execute(\n                    \"SELECT id FROM my_peiliao WHERE uid = %s\",\n                    (uid,)\n                )\n                return bool(cursor.fetchone())\n    except PyMysqlError as err:\n        logging.error(f\"存在性检查失败: {err}\", exc_info=True)\n        return False\n\ndef insert_record(record_data):\n    \"\"\"插入新记录（优化事务处理）\"\"\"\n    columns = [\n        \'zlcode\', \'order_number\', \'weight\', \'date\',\n        \'d\', \'f\', \'h\', \'e\', \'uid\'\n    ]\n    sql = f\"\"\"\n    INSERT INTO my_peiliao\n    ({\', \'.join(columns)})\n    VALUES ({\', \'.join([\'%s\'] * len(columns))})\n    \"\"\"\n\n    try:\n        with get_target_db_connection() as conn:\n            cursor = conn.cursor()\n            cursor.execute(sql, record_data)\n            conn.commit()\n    except PyMysqlError as err:\n        logging.error(f\"Insert error: {err}\")\n        conn.rollback()\n        raise\n\ndef scheduled_task():\n    \"\"\"修复时区一致性\"\"\"\n    logging.info(\"---------- 任务开始 ----------\")\n    start_time = datetime.now(pytz.utc)  # 统一使用UTC时区\n\n    try:\n        with get_mdb_connection() as conn:\n            with conn.cursor(cursors.DictCursor) as cursor:\n                query = \"\"\"\n                SELECT *\n                FROM zg_size_report\n                WHERE T = \'T\'\n                ORDER BY time DESC\n                LIMIT 10\n                \"\"\"\n                cursor.execute(query)\n\n                processed = 0\n                for row in cursor:\n                    try:\n                        uid = row[\'ID\']\n                        if not check_record_exists(uid):\n                            record_data = (\n                                row[\'neibuzhilianghao\'],\n                                row[\'dingdanhao\'],\n                                row[\'total_weight\'],\n                                row[\'time\'],\n                                row[\'kehu\'],\n                                row[\'n_num\'],\n                                row[\'j_num\'],\n                                row[\'peiliaoyuan\'],\n                                uid\n                            )\n                            insert_record(record_data)\n                            logging.info(f\"已插入新记录: {uid}\")\n                            processed += 1\n                    except Exception as e:\n                        logging.error(f\"单条记录处理失败: {e}\", exc_info=True)\n\n                logging.info(f\"处理完成: 成功{processed}条/总共{cursor.rowcount}条\")\n\n    except PyMysqlError as err:\n        logging.error(f\"数据库错误: {err}\", exc_info=True)\n    except Exception as e:\n        logging.error(f\"任务异常: {e}\", exc_info=True)\n    finally:\n        elapsed = (datetime.now(pytz.utc) - start_time).total_seconds()\n        logging.info(f\"任务耗时: {elapsed:.2f}秒\\n\")\n\n\n# 其他函数保持不变...\n\nif __name__ == \"__main__\":\n    try:\n        scheduler = BlockingScheduler(timezone=pytz.utc)\n        scheduler.add_job(\n            scheduled_task,\n            \'cron\',\n            second=\'*/1\',\n            misfire_grace_time=60\n        )\n        logging.info(\"程序启动...\")\n        scheduler.start()\n    except Exception as e:\n        logging.error(f\"致命错误: {e}\", exc_info=True)\n    finally:\n        if \'scheduler\' in locals():\n            scheduler.shutdown()\n<br></code></pre></div><p>我在pyCharm 里执行可以执行成功并打印日志，使用pyinstaller .\\report-job-v3.py</p><p>命令打包成exe后 在exe生成的目录执行好使但是exe复制到别的文件夹执行就闪退 且没有生成日志文件</p>','2025-04-08 10:38:07.976912',1,'TmeaVHSrwLTY92Sb3FVAD7',38,2);
/*!40000 ALTER TABLE `issue_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_issue2type`
--

DROP TABLE IF EXISTS `issue_issue2type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_issue2type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `iid_id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `tid_id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_issue2type_iid_id_8072c2bc_fk_issue_issue_id` (`iid_id`),
  KEY `issue_issue2type_tid_id_60a44f7e_fk_issue_issuetype_id` (`tid_id`),
  CONSTRAINT `issue_issue2type_iid_id_8072c2bc_fk_issue_issue_id` FOREIGN KEY (`iid_id`) REFERENCES `issue_issue` (`id`),
  CONSTRAINT `issue_issue2type_tid_id_60a44f7e_fk_issue_issuetype_id` FOREIGN KEY (`tid_id`) REFERENCES `issue_issuetype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_issue2type`
--

LOCK TABLES `issue_issue2type` WRITE;
/*!40000 ALTER TABLE `issue_issue2type` DISABLE KEYS */;
INSERT INTO `issue_issue2type` VALUES (2,'2j9nmq9VoDnjTNMdfY9bas','TmeaASSrwLTY92Sb3FVAD7'),(3,'6osUwe8FR44hhc7NuKjtJx','TmeaASSrwLTY92Sb3FVAD7'),(4,'6yEMR5dkGWr28L2wCScJgV','TmeaASSrwLTY92Sb3FVAD7'),(5,'anYR56sJHmWPwBHZAFXDjT','TmeaASSrwLTY92Sb3FVAD7'),(6,'E9BUQAYSJb5veGkLRhDzSi','TmeaASSrwLTY92Sb3FVAD7'),(7,'eu8E9VWQvPQJVeWvxzKdCp','TmeaASSrwLTY92Sb3FVAD7'),(9,'LUHZNmBoQ9yDntVMk2Rr2C','TmeaASSrwLTY92Sb3FVAD7'),(10,'nariVYYsGkbZBt2TyrzZ4x','TmeaASSrwLTY92Sb3FVAD7'),(11,'RVKD3eVcBPtEkkEygcNHFN','TmeaASSrwLTY92Sb3FVAD7'),(12,'SN3xSTPXf7LBFENWAzkDXe','TmeaASSrwLTY92Sb3FVAD7'),(13,'UDFuhuuNnro8rTLg8MbPcS','TmeaASSrwLTY92Sb3FVAD7'),(15,'bdLT49QHa7WqFxhVo7qqv8','TmeaASSrwLTY92Sb3FVAD7'),(17,'ZRDtwHH3Ca5RKsAk5wYPtb','TmeaASSrwLTY92Sb3FVAD7'),(18,'i6xtcNW9aWf8gCvYzDRY8h','TmeaASSrwLTY92Sb3FVAD7');
/*!40000 ALTER TABLE `issue_issue2type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_issuetype`
--

DROP TABLE IF EXISTS `issue_issuetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_issuetype` (
  `id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_issuetype`
--

LOCK TABLES `issue_issuetype` WRITE;
/*!40000 ALTER TABLE `issue_issuetype` DISABLE KEYS */;
INSERT INTO `issue_issuetype` VALUES ('3LYMPsEkFz5jLppVdTKbSw','待删除类型'),('68U44dWc443K6pchFUZ4NW','Rust'),('AmeaASSrwLTY92Sb3FVAD7','C/C++'),('CmeaASSrwLTY92Sb3FVAD7','JavaScript'),('HmeaASSrwLTY92Sb3FVAD7','FPGA'),('PEuCWq3LUzMdpvhzXrhsCe','Golang'),('TmeaASSrwLTY92Sb3FVAD1','Java'),('TmeaASSrwLTY92Sb3FVAD7','Python'),('ZmeaASSrwLTY92Sb3FVAD7','信息安全');
/*!40000 ALTER TABLE `issue_issuetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_quiz`
--

DROP TABLE IF EXISTS `issue_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_quiz` (
  `id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `quizTitle` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `quizContent` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `type_id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_quiz_type_id_c3db50a4_fk_issue_issuetype_id` (`type_id`),
  CONSTRAINT `issue_quiz_type_id_c3db50a4_fk_issue_issuetype_id` FOREIGN KEY (`type_id`) REFERENCES `issue_issuetype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_quiz`
--

LOCK TABLES `issue_quiz` WRITE;
/*!40000 ALTER TABLE `issue_quiz` DISABLE KEYS */;
INSERT INTO `issue_quiz` VALUES ('7HcZGXfunHjQAD3yagZqt3','这是一个测试题目','Javascript很美好','2026-01-05 10:35:39.518229','2026-01-05 10:35:39.518242','CmeaASSrwLTY92Sb3FVAD7'),('SZzXejR9Sw75ES8qGmpDxf','另一个测试题目','FPGA','2026-01-05 10:37:22.777123','2026-01-05 10:37:22.777133','HmeaASSrwLTY92Sb3FVAD7'),('ZmeaASSrwLLKSNWb3FVAD7','UM布局与菜单','一些自动生成的信息\n\n默认使用ant design的Layout组件，支持其全部配置【看文档配置】\n\n顶部导航/侧边栏菜单根据routes自动生成【配置式路由】\n\n支持404/403和ErrorBoundary\n\n搭配access插件轻松写右边权限\n\n搭配initial-state插件和数据流可以拥有默认用户设置全局信息','2025-04-11 11:19:05.000000','2025-04-11 11:19:08.000000','CmeaASSrwLTY92Sb3FVAD7');
/*!40000 ALTER TABLE `issue_quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user`
--

DROP TABLE IF EXISTS `user_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_user` (
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `points` int NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `permission` int NOT NULL,
  `intro` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL,
  `qq` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `wechat` varchar(60) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user`
--

LOCK TABLES `user_user` WRITE;
/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES ('pbkdf2_sha256$1200000$HUAW8p3l47YLiANGBBQILx$YICqYaIpKGZpi+YWXehumDxwuqScRFjGxMhBODM3YgU=',NULL,0,'','','',0,1,'2025-12-26 15:08:32.368482','bZeSLLFS6Udiyp4hTNsSpE','test001','c1','user_avatar/259912ccfb774fec862f3f457c20f9ab.jpg','admin',0,1,2,'','',''),('pbkdf2_sha256$1200000$tEt0IaDr2CnGkBS5fqkm6p$OwGun+iduuJwRLcNIV4UJoh7vPO9BdNrgsKaA8ET8Cg=',NULL,0,'','','',0,1,'2025-12-26 15:14:38.272079','kxM3Ziv5hsD3ZMowHN9atN','test002','c2','user_avatar/ae3d5ce806c14000a15fe91520893c30.jpg','admin',0,1,2,'','',''),('pbkdf2_sha256$1200000$CNDrD8tqGctpLPIWtgElMB$BtxXiZFZCwWCwEFqhC3Xt7FhH5G1JZt/LjRm2xc0hLM=',NULL,0,'','','1119404572@qq.com',0,1,'2026-01-04 13:23:37.211604','QNMKAZTCjmBjaqbQcm22Zy','testu002','cu2','user_avatar/185aab05fdbe41819f9e63b9cfd0be32.jpg','user',0,0,2,'111','333','222'),('pbkdf2_sha256$1200000$MfCSzIikcHAgxNX1M6DQCG$MeC2XGHuvJqqpa09OWg0PUcCqeZFk7bHEDZuDkz6O7A=',NULL,1,'chen','junyi','314298729@qq.com',1,1,'2025-03-26 13:57:33.883588','TmeaVHSrwLTY92Sb3FVAD7','superChen','陈俊亦','user_avatar/default.jpg','admin',110,1,1,'','','');
/*!40000 ALTER TABLE `user_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user_groups`
--

DROP TABLE IF EXISTS `user_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_user_groups_user_id_group_id_bb60391f_uniq` (`user_id`,`group_id`),
  KEY `user_user_groups_group_id_c57f13c0_fk_auth_group_id` (`group_id`),
  CONSTRAINT `user_user_groups_group_id_c57f13c0_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_user_groups_user_id_13f9a20d_fk_user_user_uid` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user_groups`
--

LOCK TABLES `user_user_groups` WRITE;
/*!40000 ALTER TABLE `user_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user_user_permissions`
--

DROP TABLE IF EXISTS `user_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(22) COLLATE utf8mb4_general_ci NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_user_user_permissions_user_id_permission_id_64f4d5b8_uniq` (`user_id`,`permission_id`),
  KEY `user_user_user_permi_permission_id_ce49d4de_fk_auth_perm` (`permission_id`),
  CONSTRAINT `user_user_user_permi_permission_id_ce49d4de_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_user_user_permissions_user_id_31782f58_fk_user_user_uid` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user_user_permissions`
--

LOCK TABLES `user_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `user_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-08 13:41:42
