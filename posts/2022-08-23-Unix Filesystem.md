---
title: Unix Filesytem
author: aerphanas
---

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Unix FileSystem](#unix-file-system)
  - [I-List](#i-list)
  - [Tabel Partisi](#tabel-partisi)
  - [Hirarki FileSystem](#hirarki-filesystem)
- [Linux FileSystem](#linux-filesystem)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

Di Blog ini saya ingin membagikan informasi mengenai linux file system, sebelum saya menjelaskan linux filesystem saya akan menjelaskan terlebih dahulu soal unix filesystem, karna linux terinspirasi dari Minix yang di buat oleh [Andrew S. Tanenbaum](https://www.cs.vu.nl/~ast/) yang bertujuan untuk pelajaran, Minix sendiri terinspirasi dari UNIX

## Unix File System

File sistem merupakan komponen utama dalam sebuah sistem operasi, maka dari itu sebelum dibuatnya sistem operasi yang pertama kali di pikirkan adalah file system, unix file system sendiri didesain oleh Kent Thompson untuk unix sistem operasi versi eksperimen pada 1969, di unix sendiri tipe file terbage menjadi 4 tipe, yaitu file, folder, file spesial dan tautan, tautan sendiri bisa berupa file atau folder

### I-List

Sebuah sistem operasi Unix pasti terkoneksi dengan beberapa file system dan setiap file sistem itu mempunyai i-list, i-list sendiri adalah representasi dari area yang berada pada memori fisik, salah satu i-list menunjuk pada root file system, root file system sendiri berisi sistem operasi yang harus ada setiap waktu, sehingga menunjukan bahwa tujuan dari adanya i-list adalah untuk mapping atau pemetaan dari memori fisik ke sistem operasi yang berbentuk file dan folder, pemetaan ini bisa diubah ukuranya bisa dibesarkan atau dikecilkan tergantung jenis file system yang kita pakai, untuk UNIX sendiri memakai file system dengan nama FS.

setiap awal dari i-list dinamakan i-node, fungsi i-node adalah untuk mencatat perubahan pada file sistem dan i-node juga berisi informasi dari memori fisik, didalam i-node terdiri dari 10 pointer langsung, pointer ini menunjuk langsung ke memori blok pada penyimpanan, satu i-node dapat merepresentasikan sebuah file yang besar

### Tabel Partisi

sebuah sistem operasi memiliki sebuah tabel partisi yang berguna untuk mengatur file system, tabel partisi ini berada di ``` /etc/fstab``` , di dalam fstab berisi informasi nama memori fisik, folder mount untuk dimana memori akan di mount atau pasang dan jenis mountnya bisa hanya baca (Read-Only) atau baca tulis (Read-Write).

### Hirarki Filesystem

| Mount Point   | Deskripsi                                                         |
|---------------|-------------------------------------------------------------------|
| /hp-ux        | berisi program kernel                                             |
| /dev/         | memori/perangkat yang direprsentasikan sebagai file spesial       |
| /bin/         | berisi program untuk mengatur sistem contohnya cp, rm, mkdir, dll |
| /etc/         | configurasi sistem                                                |
| /lib/         | tempat untuk library dalam programming                            |
| /tmp/         | untuk menaruh tempat sementara dan akan terhapus saat booting     |
| /lost+found/  | tempat file yang terhapus tapi masih terbuka pada perogram lain   |
| /usr/bin/     | program yang dapat dijalankan oleh pengguna                       |
| /usr/include/ | tempat untuk menyimpan header untuk programming c atau c++        |
| /usr/lib/     | tempat lain untuk library dalam programming                       |
| /usr/local/   | Typically a place where local utilities go                        |
| /usr/man      | kumpulan manual file saat kita memanggil man                      |

## Daftar Pustaka

- [A Basic UNIX Tutorial](https://fsl.fmrib.ox.ac.uk/fslcourse/unix_intro/index.html)
- [Unix File System](https://www.geeksforgeeks.org/unix-file-system/)
- [UNIX Past](https://unix.org/what_is_unix/history_timeline.html)
- [The Evolution of the Unix Time-sharing System](https://www.bell-labs.com/usr/dmr/www/hist.html)
