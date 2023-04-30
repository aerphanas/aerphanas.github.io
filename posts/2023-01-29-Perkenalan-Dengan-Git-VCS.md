---
title: Perkenalan Dengan Git VCS
author: aerphanas
desc: git merupakan sebuah version control software yang saat ini paling populer dan yang paling sering digunakan untuk melacak perubahan pada sebuah file/folder.
image: perkenalan-dengan-git-vcs-fig1.png
---

![ilustrasi percabangan branch by git-scm contributor](/images/perkenalan-dengan-git-vcs-fig1.png "ilustrasi percabangan branch by git-scm contributor")

## Daftar Isi

- [Pendahuluan](#pendahuluan)
- [Mendapatkan Git](#mendapatkan-git)
- [Menggunakan Git](#menggunakan-git)
  - [Melacak File](#melacak-file)
  - [Percabangan Branch](#percabangan-branch)
- [Alternatif](#alternatif)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

git merupakan sebuah alat yang digunakan untuk mencatat perubahan pada sebuah file, git pada awalnya digunakan oleh Linus Torvalds untuk mencatat perubahan pada proyek Kernel Linux namun karna Linus Torvalds membuat git dengan lisensi yang sama dengan Kernel Linux yaitu GPL v2, maka git dapat digunakan oleh siapa saja, selama mematuhi lisensi.

## Mendapatkan Git

---

untuk mendapatkan git kita hanya perlu menginstalnya melalui command line tergantung Distro apa yang anda pakai, untuk debian dan turunanya bisa memakai ```apt``` dan untuk fedora bisa memakai ```dnf```.

untuk pengguna windows silakan pergi ke web site resminya yaitu ```git-scm.com```

## Menggunakan GIt

---

untuk membuat suatu folder agar dapat dilacak oleh git kita harus menjalankan perintah ini di dalam folder yang ingin di lacak

```sh
git init
```

### Melacak File

setelah itu akan terbuat sebuah folder tersembunyi yang bernama ```.git```, jika terdapat folder ini berarti kita sudah berhasil membuat folder ini agar dicatat oleh git, semua pencatatan akan berada pada folder ```.git```.

jika folder yang kita gunakan memiliki isi kita harus melacak file apa jasa yang ada di sini, caranya adalah dengan menggunakan perintah

```sh
git add <namafile>
```

bila kita ingin menambahkan semua sekaligus bisa juga dengan menambah ```-A``` setelah ```git add```, namun saya sarankan tambahlah file secara manual atau satu-persatu karna kita bisa memberikanya sebuah komentar pada sebuah file yang ditambahkan untuk mempermudah mengenali sebuah file, untuk menambahkan komentar pada file yang tercatat kita bisa menggunakan perintah

```sh
git commit -m "<komentar>"
```

komentar diatas akan diperlukan bila kita mau mencatat perubahan pada file agar kita dapat mengenali apa saja yang diubah.

setiap perubahan yang sudah selesai kita ubah kita harus menambahkanya dengan kommand ```git add``` dan jangan lupa sebuah komentar.

bila kita ingin mengedit file yang tercatat atau mengubah komentar kita bisa menjalankan perintah :

```sh
git commit --amend
```

untuk menghapus file dari file tercatat kita bisa menggunakan perintah :

```sh
git rm <namafile>
```

### Percabangan Branch

bagai mana bila kita ingin mengubah suatu file tetapi ingin menympan file yang sebelum diubah ?, git memiliki sebuah fungsi branch dimana kita bisa melakukanya.

untuk membuat branch baru pada git bisa menggunakan :

```sh
git branch <namabranch>
```

untuk menghapus branch kita bisa menambahkan opsi ```-d```, contohnya jika kita ingin menghapus branch ```devel``` kita bisa menggunakan :

```sh
git branch -d devel
```

dan bila kita menghapus branch yang memiliki file yang belum tercatat

```sh
git branch -D devel
```

bila kita menggati branch maka file kita akan otomatis berganti sesuai branchnya, maka kita tidak bisa menghapus branch bila ada file yang belum tercatat.

untuk berganti antara branch kita menggunakan perintah :

```sh
git checkout <namabranch>
```

> saya hanya memberikan perkenalan git, jika kamu tertarik mendalaminya kamu bisa membaca bukunya dengan geratis yang ada di git-scm.com

## Alternatif

---

git memiliki alternatif yang dapat kita gunakan secara gratis, diantaranya

- Apache Subversion (SVN)
- GNU Bazaar
- Darcs
- Mercurial

## Daftar Pustaka

---

- Git  
→ [git-scm](https://git-scm.com/)  
