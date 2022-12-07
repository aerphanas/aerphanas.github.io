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

- maksimal penyimpanan dari 2GB di ext menjai 4TB di ext2
- mensupport ukuran blok berupa variable

diluar dari ekstensi untuk ext filesystem ext2 juga membawa fitur baru diantaranya :

- Untuk BSD atau System V 4 semantics dapat dipilih pada waktu pemasangan.
- singkronis update seperti BSD dapat dilakukan.
- sistem administrator dapat memilih ukuran alokasi logical block pada saat membuat partisi ext2.
- ext2 mengimplementasikan fast symbolic links
- ext2 melacak keadaan filesystem
- check filesystem secara paksa

### ext3



### ext4

## Cara Membuat Partisi

---

## Daftar Pustaka

---

- Linux Source code  
↪ [Linux v0.96c](https://www.tuhs.org/cgi-bin/utree.pl?file=Linux0.96c/include/linux/ext_fs.h)

- ext2fsprogs  
↪ [Design and Implementation of the Second Extended Filesystem](https://e2fsprogs.sourceforge.net/ext2intro.html)  
↪ [Journaling the Linux ext2fs Filesystem](https://e2fsprogs.sourceforge.net/journal-design.pdf)  

- Wayback Machine  
↪ [Design and Implementation of the Second Extended Filesystem](https://web.archive.org/web/20120204044824/http://e2fsprogs.sourceforge.net/ext2intro.html)

- Manual  
↪ [Ext4](https://man7.org/linux/man-pages/man5/ext4.5.html)  
↪ [filesystems(5)](https://linux.die.net/man/5/filesystems)