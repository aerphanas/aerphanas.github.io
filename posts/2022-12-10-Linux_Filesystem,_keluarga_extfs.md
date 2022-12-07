---
title: Linux Filesystem, keluarga extfs
author: aerphanas
desc: ext merupakan singkatan dari extended file system yang dibuat khusus untuk linux kernel,yang sebelumnya linux menggunakan filesystem milik minix
image: linux_filesystem,_keluarga_extfs-fig1.png
---

![Ext4 Manual](/images/linux_filesystem,_keluarga_extfs-fig1.png "Ext4 Manual")

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Versi](#versi)
  - [ext](#ext)
  - [ext2](#ext2)
  - [ext3](#ext3)
  - [ext4](#ext4)
- [Cara Membuat Partisi](#cara-membuat-partisi)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

Ext merupakan sebuah filesystem yang dibuat khusus untuk linux kernel, sebelum menggunakan ext linux kernel menggunakan filesystem minix, ext pertama kali di terbitkan ke publik pada april 1992, pada awalnya ext merupakan sebuah ekstensi dari minix filesystem karena minix filesystem memiliki limitasi diantaranya :

- blok tersimpan pada bilangan 16bit
- maksimal penyimpanan hanya 64MB
- maksimal nama file adalah 14 kata.

## Versi

---

sebelum dapat menjadi filesystem utama untuk linux, linux memerlukan sebuah filesystem virtual, virtual filesystem adalah sebuah lapisan untuk memanggil fungsi filesystem untuk melakukan input output (I/O), karnaa virtual filesystem inilah linux dapat menjalankan beberapa filesystem seperti dos, minix, ext dan ext2.

### ext

ext di desain oleh Rémy Card, dan bertujuan untuk membuat filesystem yang lebih unggul dari minix filesystem, pada tahun 1993 dibuatlah beberapa pengganti ext diantaranya ext2 dan xiafs, namun karna ext2 memberikan sebuah perbaikan pada ext filesystem diantaranya fargmentasi dan software yang lebih matang maka xiafs kalah dan selanjutnya linux memakai ext2.

### ext2

seperti yang dikatakan diatas ext2 merupakan ekstensi dari ext yang memiliki kelebihan diantaranya :

- maksimal penyimpanan dari 2GB di ext menjai 4TB di ext2.
- mensupport ukuran blok berupa variable.

diluar dari ekstensi untuk ext filesystem ext2 juga membawa fitur baru diantaranya :

- Untuk BSD atau System V 4 semantics dapat dipilih pada waktu pemasangan.
- singkronis update seperti BSD dapat dilakukan.
- sistem administrator dapat memilih ukuran alokasi logical block pada saat membuat partisi ext2.
- implementasi fast symbolic links.
- melacak keadaan filesystem.
- check filesystem secara paksa.

### ext3

sama seperti ext dan ext2, ext3 merupakan exstensi dari ext2 exstensi yang dimaksud adalah adanya tambahan jurnal.
fungsi jurnal disini adalah untuk mempercepat pemulihan pada filesystem yang mengalami kegagalan atau sistem padam secara mendadak, semua data yang berpotensi tidak konsisten pada disk harus dicatat juga dalam jurnal karena hal itulah kecepatan pemulihan pada filesystem ext3 lebih cepat dari ext2.

cara kerja fitur pemulihan dengan jurnal adalah memindai semua jurnal dan menkopinya ke filesystem, pemulihan jurnal cepat karna ukuran jurnal lebih kecil dari filesystemnya.

selain exstensi jurnal ext3 juga memiliki kelebihan diantaranya :

- menambahkan/growth filesystem secara online (sedang terpasang).
- ukuran penyimpanan dan file lebih besar dari ext2 tapi terpengaruh oleh ukuran block.

### ext4

pada awalnya ext3 akan mendapat improfisasi seperti menambah limitasi penyimpanan dan menambah performa namun beberapa pengembang ext3 tidak setuju karna alasan stabilitas, setelah itu dibuatlah sebuah fork atau sebuah percabangan agar tidak mengganggu pengguna ext3 maka lahirlah ext4, dan sampai saat inilah ext4 masih digunakan.

ext4 memiliki kompatibilitas untuk versi lamanya yang artinya kita bisa memasang ext2 atau ext3 sebagai ext4, ekstensi ext4 diantaranya :

- penyimpanan filesystem dan file lebih besar, masing-masing sampai 1 Exabyte dan 16 Terabyte
- improfisasi terhadap file besar dan fragmentasi
- kompatibilitas untuk ext2 dan ext3
- Pra-alokasi yang persisten
- jumlah subdirektori yang tak terhingga
- jurnal yang menggunakan checksum

## Cara Membuat Partisi

---

untuk membuat partisi ext4 kita harus memiliki software e2fsprogs di linux, setelah terinstall maka kita bisa mengetik :

NOTE : untuk mengubah partisi kita harus mengeksekusinya dalam user root

```sh
mkfs.ext4 # untuk ext4
mkfs.ext3 # untuk ext3
mkfs.ext2 # untuk ext2
```

command diatas merupakan singkatan dari :

```sh
mk2fs -t ext4 # untuk ext4
mk2fs -t ext3 # untuk ext3
mk2fs -t ext2 # untuk ext2
```

karna dilinuk semua hardware dianggap sebagai folder atau file, maka kita harus mencari dimanakah keberadaan hardware kita, dalam linux ```/dev/``` merupakan sebuah folder tempat penyimpanan, untuk mengetahuinya kita bisa menggunakan software ```lsblk```, setiap distro memiliki software ini namun bila tidak ada kalian bisa menginstall ```util-linux``` untuk mendapatkanya.

setelah mendapatkannya kita bisa mengecek 2x untuk memastikanya, untuk memastikanya apakah pinyimpanan yang dituju benar kita memerlukan software fdisk.

disini saya akan menggunakan /dev/sda sebagai contoh

```sh
fdisk -l /dev/sda
```

perintah diatas akan memberikan kita sebuah info tipe disk, id, ukuran, dsb

untuk dapat memformat kita harus mempunyai partisi karna ```/dev/sda``` merupakan disk/perangkat keras, kita bisa menggunakan fdisk untuk membuat partisi, untuk membuatnya kita bisa :

```sh
fdisk /dev/sda
```

setelah itu kita mindapat kan sebiah prom interaktif, silakan ketik ```m``` untuk melihat semua perintah yang diperlukan, setalah kita mendadpatkan partisi kita hanya perlu menjalankan perintah diawal ```mkfs``` atau ```mk2fs -t```

Note : Berhati-hatilah saat menjalankan perintah diatas, karna bila ada kesalahan maka semua data yang berada di partisi itu akan terhapus, maka bila perlu buatlah sebuah backup, pindahkanlah data penting ke penyimpanan lain.

## Daftar Pustaka

---

- Linux Source code  
↪ [Linux v0.96c](https://www.tuhs.org/cgi-bin/utree.pl?file=Linux0.96c/include/linux/ext_fs.h)

- ext2fsprogs  
↪ [Design and Implementation of the Second Extended Filesystem](https://e2fsprogs.sourceforge.net/ext2intro.html)  
↪ [Journaling the Linux ext2fs Filesystem](https://e2fsprogs.sourceforge.net/journal-design.pdf)  
↪ [Ext2fs Home Page](https://e2fsprogs.sourceforge.net/ext2.html)  

- Ext4 (and Ext2/Ext3) Wiki  
↪ [Ext4](https://ext4.wiki.kernel.org/index.php/Main_Page)  

- Manual  
↪ [Ext4](https://man7.org/linux/man-pages/man5/ext4.5.html)  
↪ [filesystems(5)](https://linux.die.net/man/5/filesystems)  

- Wikipedia  
↪ [ext4](https://en.wikipedia.org/wiki/Ext4)  
↪ [ext3](https://en.wikipedia.org/wiki/Ext3)  
