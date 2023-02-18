---
title: Install Software dari AUR
author: aerphanas
desc: AUR atau Arch User Repository adalah sebuah git server yang diperuntukan untuk pengguna Arch linux untuk membagikan/mendistribusikan software mereka ke sesama pengguna.
image: install_software_dari_aur-fig1.png
---

![archlinux-wallpaper conference](/images/install_software_dari_aur-fig1.png "archlinux-wallpaper conference")

## Daftar isi

- [Pendahuluan](#pendahuluan)
  - [Mendapatkan build file](#mendapatkan-build-file)
  - [Menyiapkan package](#menyiapkan-package)
  - [Menginstall package](#menginstall-package)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

Arch User Repository atau disingkat AUR adalah sebuah tempat untuk developer atau pihak ke 3 mendistribusikan software/packagenya ke arch linux dengan mudah.

sebelum menginstal software dari AUR kita harus mimiliki ```git``` dan ```base-devel```, kita bisa menginstallnya dengan pacman :

```sh
pacman -S git base-devel
```

setiap kali kita menginstall software kita harus berada pada user yang memiliki permission admin, kita bisa menggunakan utilitas sudo atau doas.

```sh
sudo pacman -S git base-devel
```

## Mendapatkan build file

---

isi dari sebuah aur biasanya hanyalah sebuah file yang bernama PKGBUILD, file inilah berisi link source code, pach dan configurasi yang akan otomatis menyesuaikan dengan Arch distro oleh si distributor.

untuk mendapatkan build file kita harus pergi ke AUR website, mengklik software yang akan kita install, lalu klik salah satu link yang ada di "Git Clone URL", di contoh ini saya akan mencoba menginstall software rar, clone git di folder Project/aur.

```sh
cd /Project/aur
git clone https://aur.archlinux.org/rar.git
```

## Menyiapkan package

---

di tahap inilah package yang akan kita instal di siapkan, jika berupa software akan di compile dan bila berupa hal lain seperti font atau theme, akan terdownload dari source yang di tetapkan di file PKGBUILD.

```sh
makepkg -sr
```

sebelum menjalankan perintah diatas kita harus berada pada folder berisi PKGBUILD, untuk opsi ```-s``` atau ```--syncdeps``` bertujuan untuk menginstall dependencies dengan pacman dan biasanya kita akan ditanyakan tentang password akun kita, dan opsi ```-r``` atau ```--rmdeps``` bertujuan untuk menghapus dependencies yang terinstall oleh opsi ```-s```.

## Menginstall package

---

setelah package disiapkan akan ada sebuah file yang terkompresi dengan zst dan memiliki ekstensi ```.pkg.tar.zst```, untuk menginstallnya kita hanya perlu menggunakan pacman dengan opsi ```-U```, opsi ini digunakan untuk upgrade atau untuk menambahkan package, tentu saja kita harus menggunakan sudo atau dalam akun root untuk mengintallnya.

```sh
sudo pacman -U rar-6.20.0-1-x86_64.pkg.tar.zst
```

pacman akan otomatis menginstall dependencies yang diperlukan agar program berjalan dengan semestinya

## Daftar Pustaka

---

- Arch repository  
↪ [base-devel](https://archlinux.org/packages/core/any/base-devel/)  
↪ [git](https://archlinux.org/packages/extra/x86_64/git/)  
↪ [archlinuux-wallpaper](https://archlinux.org/packages/community/any/archlinux-wallpaper/)  

- Arch AUR  
↪ [Home Page](https://aur.archlinux.org/)  
