---
title: Linux Container
author: aerphanas
desc: Mengupas lebih dalam teknologi container, yang digunakan oleh Developer untuk mendistribusikan aplikasi mereka
---

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Interface](#interface)
  - [Docker](#docker)
  - [Nerdctl](#nerdctl)
  - [Podman](#podman)
  - [LXD](#lxd)
- [Proses](#proses)
  - [Runc](#runc)
  - [Crun](#crun)
  <!--- [continerd]() -->
  - [LXC](#lxc)
  - [Railcar](#railcar)
- [Proses Dengan Virtualisasi]()
  - [Kata Container](#kata-container)
  - [Gvysor](#gvysor)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

Container merupakan sebuah teknologi yang memungkinkan kita untuk menjalankan sebuah aplikasi atau sebuah peroses tanpa mempedulikan library apa yang ada di mesin kita, dan container ini ditujukan untuk programmer dan urusan server, container juga merupakan bagian dari OS-level virtualization atau virtualisasi level os meskipun memiliki paradigma virtualisasi namun tidak satupun menggunakan virtual hardware tetapi ada beberapa runtime yang memungkinkan kita untuk membuat virtualisasi hardware yang akan dibahas pada pos ini, namun beberapa runtime menggunakan kernel untuk meperbolehkan sebuah proses untuk berjalan didalam isolasi.

## Interface

Interface merupakan sebuah program yang berfungsi untuk mengontrol runtime,builder, etc untuk mempermudah membuat sebuah container, saat ini terdapat banyak interface diantaranya docker, nerdctl, podman, LXD, dan mungkin di luar sana terdapat lebih banyak lagi yang belum saya ketahui.

### Docker

Docker merupakan sebuah interface yang secara bawaan menggunakan runc,docker juga merupakan sebuah nama perusahaan yang bernama Docker Inc. yang dibuat oleh Kamel Founadi, Solomon Hykes, dan Sebastien Pahl, Docker pertama kali terbit ke public di Santa Clara apada PyCon tahun 2013.dan di rilis sebagai open-source pada March 2013. pada saat itu, docker menggunakan LXC sebagai runtime. namun satu tauh setelahnya tepatnya saat rilis versi 0.9, Docker menggantikan LXC dengan runtime buatanya sendiri yang bernama libcontainer yang ditulis menggunakan bahasa program GO.

### Nerdctl

Nerdctl merupakan sebuah interface yang dibuat untuk containered yang merupakan sebuah sistem service yang melakukan komunikasi dengan proses runc, namun nerdctl tidak hanya berkomunikasi dengan containerd tetapi nerdctl juga memerlukan buildkit, buildkit yang yang bertujuan untuk membuat sebuah container image.

Nerdctl juga memiliki baris perintah yang hampir sama dengan docker namun ada beberapa baris perintah yang tidak tersedia, nerdctl memiliki tujuan sebagai interface termutakhir untuk berkomunikasi dengan containerd.

Nerdctl pertamakali dibuat di github oleh Akihiro Suda pada 4 Desember 2020, dengan lisensi bertipe Apache.

### Podman

Podman dibuat oleh Redhat sebagai alternatif untuk docker, karna pada saat itu docker tidak dapat berjalan tanpa docker service yang memiliki akses root, karna memiliki akses root maka memiliki celah keamanan, maka dari itu redhat membuat podman yang dapat berjalan tanpa root alias rootless, podman pertama kali muncul di github pada 1 November 2017 oleh Daniel J Walsh, namun pada 15 November 2019 docker mendatap fitur rootles yang di kontribusi oleh Akihiro Suda.

Podman memiliki baris perintah yang sama dengan docker sampai-sampai di dokumentasinya podman dapat menjadi alias docker.

### LXD

## Proses

### Runc

### Crun

### LXC

### Kata Container

### Gvysor

### Railcar

## Daftar Pustaka

- Redhat  
↪ [A Practical Introduction to Container Terminology](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction#container_runtime)  

- Docker  
↪ [What is a Container?](https://www.docker.com/resources/what-container/)  

- Podman  
↪ [What is Podman?](https://docs.podman.io/en/latest/)  

- Github  
↪ [Docker Rootles pull request](https://github.com/docker/docs/pull/9729)  
↪ [Podman initial commit](https://github.com/containers/podman/commit/a031b83a09a8628435317a03f199cdc18b78262f)  
↪ [Nerdctl initial commit](https://github.com/containerd/nerdctl/commit/f0d302cac40fbdbfcfe74a3ba5cbefdf2f5b3741)