-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2024 at 09:06 AM
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
-- Database: `simpas`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `email`, `password`) VALUES
(1, 'adminsimpas@gmail.com', '$2y$10$Qfg2iff5sT6omni/YCAbKu.hOC.nX2.ThjpzxVGyCSoLye91TJxnK');

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image_filename` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `title`, `content`, `image_filename`, `created_at`) VALUES
(1, 'Kurangi Produksi Sampah Plastik!', 'Surat ini saya kirimkan atas keresahan melihat sebuah siklus tiada henti. Lingkungan yang kita bersihkan, setiap saat kembali dikotori oleh tumpukan sampah plastik. Dalam waktu dua bulan, lima bulan hingga satu tahun ke depan selalu bertemu kemasan plastik yang sama.\r\n\r\nSaya ingin ( Coca-cola, Unilever, Danone, Nestle, Indofood, Wings, Mayora ) bersama dengan perusahaan-perusahaan lain yang produknya saya beli secara berkala, bersedia bertanggung jawab dengan mengirim rencana pengurangan sampah sesuai dengan Permen LHK Nomor 75 Tahun 2019, untuk menghentikan pencemaran sampah plastik yang terjadi.\r\n\r\nDengan kondisi lingkungan yang telah mencapai titik krisis akibat pencemaran plastik, baru 23 produsen* yang telah melaporkan rencana pengurangan sampahnya kepada KLHK. Berarti masih banyak produsen yang belum melaporkannya.', 'artikel1.jpg', '2024-11-10 16:19:38'),
(2, 'SAMPAH PLASTIK CEMARI SUNGAI ', 'Indonesia adalah negara dengan penduduk terpadat ke empat didunia. Setiap penduduk dalam menjalankan kehidupannya akan mengeluarkan sampah sebagai zat sisa pembuangan. Sampah sangat mudah dilihat dan temukan disekitar kita. Setiap orang akan menghasilkan sampah. Sampah dibagi menjadin tiga bentuk yaitu sampah organik, anorganik, dan sampah hasil sisa zat kimia. Semenjak kecil kita telah diajarkan untuk hidup bersih dengan cara membuang sampah pada tempat sampah, namun banyak sekali orang yang lalai untuk menjalankan hal tersebut. Sampah hingga kini masih menjadi polemik permasalahn yang ada di Indonesia, permasalahan tersebut sulit ditangani hingga kini. Contoh permasalahn tersebut yaitu banyaknya limbah plastik disungai, hasil limbah pabrik, dan banyaknya kasus sampah plastik yang dibuang kelaut, kemudian membuat kehidupan perairan menjadi kotor.\r\n\r\nMenurut penelitian Riset Kesehatan Kemenkes tahu 2013 menunjukkan bahwa terdapat 10 kg sampah yang akan dibuang oleh satu orang penduduk di Indonesia. Meneurut Badan Pusat Statistika pada tahun 2020 Indonesia memiliki 273,5 juta jiwa. Hal ini bisa dikalikan dengan 10 kg maka jumlah sampah yang dapat dihasilkan oleh Indonesia sebanyak 2 milyar lebih untuk satu bulannya. Hal tersebutlah yang membuat sungai-sungai mudah tersumbat oleh sampah, kemudian meluap dan menimbulkan banjir. Belum lagi permasalahan yang mengancam biota laut akibat terganggunnya makhluk laut dengan adanya sampah di ekosistem mereka. Menurut penelitian Jenna Jeanback pada tahun 2015 mengatakan bahwa Indonesia adalah negara dengan pemasok sampah plastik terbesar ke 2 didunia setelah China yaitu sebesar 187,2 Ton sampah yang dibuang ke laut. Hal tersebut membuat miris, karena banyak biota laut yang akan mati akibat ekosistem mereka terganggu. bahaya yang terjadi akibat membuang sampah dilaut adalah musnahnya biota laut, kemudian racun dari sampah yang termakan biota laut dapat meracuni manusia sendiri karena manusia juga memakan hasil laut. Hal inilah yang harus kita ubah untuk menjaga ekosistem sekitar kita terhindar dari sampah.\r\n\r\nPengolahan sampah dapat dilakukan dengan 3R yaitu Reduce, Reuce, Recyle hal itu dilakukan untuk mengurangi sampah plastik yang ada di sekitar kita. Reduce dapat dilakukan dengan mengurangi sampah plastik, dengan membawa tas belanja sendiri yang dpaat digunakan berkali-kali, sehingga kita dapat mengurangi sampah kresek, kemudian Reuce dapat kita lakukan dengan menggunaka barang dengan hemat, dan recycle adlaah dengan mendaur ulang sampah plastik yang telah kita gunakan supaya dapat kita gunakan kembali contoh dengan membuat tas darii sampah bungkus sachet kopi atau yang lainnya. Kebiasaan kebiasaan ini harus kita mulai sejak dini, dan dimulai dengan lingkungan sekitar kita. Kita harus mampu menjaga lingkungan supaya terhindar dari bencana. Kebiasaan membuang sampah pada tempatnya, membedakan sampah organik untuk dijadikan pupuk kompos, dan membuat 2R merupakan langkah dini untuk mengurangi banyaknya sampah yang ada di lingkungan. Sehingga dapat disimpulkan bahwa kita harus melakukan kebiasaan baik sejak dini untuk menjaga lingkungan demi generasi selanjutnya.', 'artikel2.jpg', '2024-11-10 16:20:32'),
(3, 'Dampak Buang Sampah Sembarangan', 'Dampak membuang sampah sembarangan akan merusak pemandangan, mendatangkan bau yang tidak sedap, mendatangkan banjir level rendah sampai yang tinggi, mendatangkan berbagai penyakit dan dapat mencemari lingkungan.\r\n\r\nMaka dari itu, mulai sekarang marilah kita membiasakan diri untuk tidak membuang sampah. Apa sih susahnya membuang sampah pada tempatnya? Hanya mengantongi sampah saja, membawa ke tong sampah, itu mudah banget dan memberikan pengaruh efek kebaikan yang besar.\r\n\r\nPengendalian sampah yang paling sederhana dan efektif adalah dengan menumbuhkan kesadaran dari dalam diri sendiri untuk tidak merusak lingkungan dengan sampah. Mulailah tanamkan niat, bahwa, ‘’Aku harus membuang sampah pada tempatnya. Selain itu diperlukan juga kontrol sosial budaya masyarakat untuk lebih menghargai lingkungan. Peran Pemerintah dalam hal ini juga sangat diperlukan, dengan peraturan-peraturan dan sangsi-sangsi yang ada, diharapkan bisa meminimalkan perusakan lingkungan oleh pihak-pihak yang tidak bertanggung jawab', 'artikel3.jpg', '2024-11-10 16:21:14'),
(4, 'Mari Kelola Sampah Dengan Bijak', 'Meski demikian, di beberapa daerah di Indonesia sudah banyak yang pengelolaan sampahnya tersusun dengan baik. Sehingga tidak menimbulkan dampak yang merugikan. Sampah mempunyai dampak buruk jika tidak dikelola dengan baik, seperti banjir, sumber penyakit, lingkungan menjadi tidak sehat, dan lain sebagainya.\r\n\r\nTapi sebelumnya, masyarakat harus mengetahui terlebih dahulu jenis-jenis sampah yaitu organin dan anorganik, maka langkah selanjutnya kita hanya tinggal mengelolanya saja.\r\n\r\nMengutip dari kejarmimpi.id, berikut ini adalah tips mengelola sampah secara bijak;\r\n\r\n1) membuat tempat sampah sesuai jenisnya, sampah organic dan anorganik,\r\n2) mengganti alas plastik sampah menjadi koran atau kardus untuk mengurangi konsumsi sampah plastik,\r\n3) manfaatkan sampah organic menjadi pupuk kompos,\r\n4) manfaatkan sampah anorganik yang sekiranya masih layak didaur ulang,\r\n5) membuang sampah ke TPS atau TPA setiap seminggu 2 kali,\r\n6) mulailah mengelola sampah berbahaya seperti sampah elektronik, baterai, dan lain sebagainya,\r\n7) berilah rewards untuk diri sendiri setiap minggunya jika masalah sampah di rumah tinggal anda sudah selesai,\r\n8) bijak-bijaklah menjadi seorang konsumen.\r\n\r\nMengelola sampah seperti di atas memanglah bukan hal sulit untuk dilakukan, tetapi jika tidak dilakukan secara konsisten maka akan muncul lagi masalah sampah di sekitar anda. (FT)', 'artikel4.jpg', '2024-11-10 16:22:05'),
(5, 'Selamatkan Bumi dari Gunungan Sampah!', 'Masalah sampah ini menjadi masalah yang tiada habisnya, selalu menjadi masalah serius dari dahulu hingga saat ini. Setiap individu rata-rata mengetahui akan dampak dari sampah tersebut. Hanya saja, yang disayangkan kurangnya kesadaran akan hal yang bisa dikatakan sepele ini.\r\n\r\nMasalah sampah selalu dianggap hal yang sepele yang pada dasarnya masalah ini merupakan masalah serius yang tidak ada ujungnya.\r\n\r\nSepertinya, mata dan telinga sudah bosan membaca dan mendengar slogan yang berbunyi \"Buanglah Sampah pada Tempatnya\".\r\n\r\nNamun, masih banyak di antara kita yang acuh akan imbauan ini.\r\n\r\nJika bukan dari kita yang memulai bertindak, mau menunggu siapa?\r\n\r\nSampai kapan acuh terhadap sampah ini?\r\n\r\nMungkin saat ini masih dianggap sepele, tapi kedepannya?\r\n\r\nDilansir dari Sistem Informasi Pengelolaan Sampah Nasional (SIPSN), data hasil penginputan jumlah sampah yang dilakukan oleh 132 Kabupaten/Kota se-Indonesia pada tahun 2023 dengan besar timbulan sampah 15,464,683.44 (ton/tahun).\r\n\r\nSementara itu, data dari Asosiasi Industri Plastik Indonesia (INAPLAS) serta Badan Pusat Statistik (BPS) menyebutkan bahwa sampah plastik di Indonesia jumlahnya mencapai 64 juta ton/tahun dengan 3,2 juta ton dari sampah tersebut adalah sampah yang dibuang ke laut.\r\n\r\nDalam hal pencemaran di laut, Indonesia menjadi penghasil sampah plastik laut kedua terbesar di dunia setelah Tiongkok.\r\n\r\nDari hasil penelitian UC Davis dan Universitas Hasanuddin di Pasar Paotere Makassar memperlihatkan 23% kandungan plastik yang terdapat dalam perut ikan yang menjadi sampel penelitian.\r\n\r\nBagaimana masih mau acuh dan diam saja? Jika tidak bisa membantu mengurangi sampah setidaknya kita tidak menambah sampah dengan melakukan beberapa cara yang bisa diterapkan.\r\n\r\nPertama, hindari penggunaan botol air minum atau kantong plastik sekali pakai dan beralih ke botol atau kantong yang dapat digunakan kembali.\r\n\r\nKedua, membawa tas belanja sendiri dari pada menerima kantong plastik saat berbelanja. Bukannya ini terdengar keren ya?\r\n\r\nKetiga, kurangi penggunaan sedotan plastik dengan sedotan kertas atau sedotan stainless steel sebagai alternatif lain yang dapat digunakan ulang.\r\n\r\nKeempat, hindari penggunaan makanan dan minuman yang dikemas dalam kemasan plastik, seperti minuman ringan dan makanan cepat saji.\r\n\r\nPastikan untuk membuang sampah pada tempat yang telah disediakan oleh pihak berwenang. Beratkan tangan ini untuk membuang sampah sembarangan.\r\n\r\nBerani beda dengan menjaga kebersihan itu keren banget.\r\n\r\nUntuk kita, generasi muda, sangat diperlukan kesadaran dan partisipasi dalam menjaga kebersihan, minimal lingkungan di sekitar kita. Berani memulai, setidaknya dari sepuluh orang akan ada satu orang yang akan mengikuti perilaku menjaga kebersihan ini.\r\n\r\nAda yang mengetahui sekelompok pemuda yang menamai dirinya dengan Pandawara Group?\r\n\r\nMereka dengan pengikut akun Instagram 2,5 juta dan pengikut akun TikTok sebanyak 8,4 juta yang beranggotakan lima orang pemuda dengan membuat konten tentang pentingnya menjaga kebersihan.\r\n\r\nBegitu banyak komentar positif dan tidak sedikit juga komentar negatif. Zaman semakin canggih dan media sosial sekarang sudah menjadi kebutuhan kita dengan melihat tontonan dan konten bermanfaat yang dibuat Pandawara, tentu memberikan kesadaran akan pentingnya menjaga kebersihan.\r\n\r\nSekarang tidak hanya Pandawara Group yang bergerak. Sudah banyak kelompok lain yang mencontohkan konten dengan bergerak membersihkan lingkungan sekitar.\r\n\r\nYang berawalkan lima orang, sekarang sudah bisa merangkul warga setempat untuk ikut berpartisipasi dalam membersihkan sampah di tempat tersebut. Luar biasa bukan?\r\n\r\nMari jadi bagian yang peduli pada sampah!\r\n\r\n', 'artikel6.jpg', '2024-11-10 16:38:00'),
(6, '7,2 JT Ton Sampah di Indonesia Belum Terkelola ', ' Data Sistem Informasi Pengelolaan Sampah Nasional (SIPSN) Kementerian Lingkungan Hidup dan Kehutanan (KLHK) tahun 2022 hasil input dari 202 kab/kota se Indonesia menyebut jumlah timbunan sampah nasional mencapai angka 21.1 juta ton. Dari total produksi sampah nasional tersebut, 65.71% (13.9 juta ton) dapat terkelola, sedangkan sisanya 34,29% (7,2 juta ton) belum terkelola dengan baik.\r\n\r\nDemikian disampaikan Sekretaris Deputi Bidang Revolusi Mental, Pemajuan Kebudayaan, dan Prestasi Olahraga Gatot Hendrarto saat membuka Leaders Academy Online Indonesia 2023 yang merupakan bagian kegiatan tahunan World Cleanup Day (WCD) Indonesia. Peserta Leaders Academy ini akan menjadi ujung tombak menjaring relawan di seluruh Indonesia untuk kegiatan WCD September 2023 nanti.\r\n\r\nDitekankan Gatot, pemerintah baik pusat dan daerah akan terus mengupayakan dan melaksanakan kebijakan dan program kolaboratif dan persuasif antar pemangku kepentingan untuk pengelolaan sampah yang tepat dengan mengedepankan prinsip sirkular ekonomi dimana ada peningkatan manfaat ekonomi dari sampah. \r\n\r\nKesadaran kolektif dan keterlibatan masyarakat dalam pengelolaan sampah merupakan salah satu bentuk modal sosial untuk menciptakan budaya bersih sebagai bagian dari identitas dan karakter masyarakat Indonesia. Gerakan Indonesia Bersih, sebagai salah satu pilar dari 5 Gerakan Nasional Revolusi Mental (GNRM) diharapkan menjadi gerakan sosial kolaboratif yang  turut berkontribusi membina mental masyarakat untuk sadar dan paham akan permasalahan sampah dan bergerak untuk mengambil bagian dalam pengelolaan sampah.\r\n\r\n“Pola tradisional pengelolaan sampah : kumpul - buang - angkut harus ditinggalkan dan mulai mengubah perilaku dimulai dengan upaya pilah pilih sampah di rumah hingga gaya hidup 3R (reduce, reuse, recycle),” jelas Gatot  yang hadir secara daring, Jumat (4/08/2023).\r\n\r\nDi Indonesia, WCD Indonesia telah mendapat respon baik dari masyarakat terbukti dengan semakin meningkatnya jumlah relawan setiap tahun. Para local heroes seperti relawan WCD di seluruh Indonesia harus terus diapresiasi, dikuatkan, dan dibantu untuk diperluas jaringannya. Selain aksi bersih-bersih, upaya membudayakan dan menggerakkan program-program di tingkat masyarakat seperti program Bank Sampah juga patut terus disebarkan untuk penyadaran dan peningkatan kemampuan pemilahan sampah yang dihasilkan dari tingkat rumah tangga.\r\n\r\n', 'artikel5.jpg', '2024-11-11 08:00:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
