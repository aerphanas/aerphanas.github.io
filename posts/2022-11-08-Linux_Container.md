---
title: Linux Container
author: aerphanas
desc: Mengupas lebih dalam teknologi container yang digunakan oleh Developer untuk mendistribusikan aplikasi mereka
image: linux-container-fig1.png
---

![Linux Container](/images/linux-container-fig1.png "Linux Container")

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Interface](#interface)
  - [Docker](#docker)
  - [Nerdctl](#nerdctl)
  - [Podman](#podman)
  - [LXD](#lxd)
  - [machinectl](#machinectl)
- [Prosesor](#prosesor)
  - [Runc](#runc)
  - [Crun](#crun)
  <!--- [continerd]() -->
  - [Youki](#youki)
  - [LXC](#lxc)
  - [Railcar](#railcar)
  - [Systemd-nspawn](#systemd-nspawn)
- [Prosesor Dengan Teknologi yang unik](#prosesor-dengan-teknologi-yang-unik)
  - [Kata Container](#kata-container)
  - [gVisor](#gvisor)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

Container merupakan sebuah teknologi yang memungkinkan kita untuk menjalankan sebuah aplikasi atau sebuah peroses tanpa mempedulikan library apa yang ada di mesin kita, dan container ini ditujukan untuk programmer dan urusan server, container juga merupakan bagian dari OS-level virtualization atau virtualisasi level os meskipun memiliki paradigma virtualisasi namun tidak satupun menggunakan virtual hardware tetapi ada beberapa runtime dan interface yang memungkinkan kita untuk membuat virtualisasi hardware yang akan dibahas pada pos ini, namun beberapa runtime menggunakan kernel untuk meperbolehkan sebuah prosesor untuk berjalan didalam isolasi.

## Interface

---

Interface merupakan sebuah program yang berfungsi untuk mengontrol runtime,builder, etc untuk mempermudah membuat sebuah container, saat ini terdapat banyak interface diantaranya docker, nerdctl, podman, LXD, dan mungkin di luar sana terdapat lebih banyak lagi yang belum saya ketahui.

### Docker

Docker merupakan sebuah interface yang secara bawaan menggunakan runc,docker juga merupakan sebuah nama perusahaan yang bernama Docker Inc. yang dibuat oleh Kamel Founadi, Solomon Hykes, dan Sebastien Pahl, Docker pertama kali terbit ke public di Santa Clara apada PyCon tahun 2013.dan di rilis sebagai open-source pada March 2013. pada saat itu, docker menggunakan LXC sebagai runtime. namun satu tauh setelahnya tepatnya saat rilis versi 0.9, Docker menggantikan LXC dengan runtime buatanya sendiri yang bernama libcontainer yang ditulis menggunakan bahasa program GO.

docker cli pertama kali muncul di github yang di buat oleh Avatar Thatcher dan Tibor Vass pada 2 Juni 2017.

### Nerdctl

Nerdctl merupakan sebuah interface yang dibuat untuk containered yang merupakan sebuah sistem service yang melakukan komunikasi dengan prosesor runc, namun nerdctl tidak hanya berkomunikasi dengan containerd tetapi nerdctl juga memerlukan buildkit, buildkit yang yang bertujuan untuk membuat sebuah container image.

Nerdctl juga memiliki baris perintah yang hampir sama dengan docker namun ada beberapa baris perintah yang tidak tersedia, nerdctl memiliki tujuan sebagai interface termutakhir untuk berkomunikasi dengan containerd.

Nerdctl pertamakali dibuat di github oleh Akihiro Suda pada 4 Desember 2020, dengan lisensi bertipe Apache.

### Podman

Podman dibuat oleh Redhat sebagai alternatif untuk docker, karna pada saat itu docker tidak dapat berjalan tanpa docker service yang memiliki akses root, karna memiliki akses root maka memiliki celah keamanan, maka dari itu redhat membuat podman yang dapat berjalan tanpa root alias rootless, podman pertama kali muncul di github pada 1 November 2017 oleh Daniel J Walsh, namun pada 15 November 2019 docker mendatap fitur rootles yang di kontribusi oleh Akihiro Suda.

Podman memiliki baris perintah yang sama dengan docker sampai-sampai di dokumentasinya podman dapat menjadi alias docker.

### LXD

LXD dibuat oleh Canonical sebagai  interface dari lxc yang lebih bersahabat, lxd berkomunikasi dengan lxc melalui librari liblxc, tidak hanya menjadi interface alternatif dari lxc tetapi lxd menambahkan beberapa fungsi baru agar mudah di gunakan dan lxd juga dapat berkomunikasi dengan libvirt sehingga dapat membuat mesin virtual dengan lxd pada versi 4.0 lts keatas.

LXD dibuat menggunakan bahasa program GO.

LXD berbeda dengan kebanyakan container, jika container yang lain bertujuan untuk aplikasi container tetapi LXD adalah system container dimana system container memberikan kebebasan  kepada pengguna untuk mengupdate, menambah user, mengedit user dan mengupdate aplikasi namun tetap terisolasi dari sistem berbeda dengan aplikasi container dimana kita hanya dapat membuat image dan bila ingin mengupdate satu komponen kita harus membuat ulang imagenya, sehingga system container sangat cocok untuk para developer untuk menjadikanya sebagai tempat Test.

### machinectl

sesuai dengan deskripsinya machinectl digunakan untuk berinteraksi dengan systemd, tidak hanya dapat mengontrol container tapi machinectl dapat mengontrol mesin virtual yang dibuat menggunakan systemd-machined.

machinectl mensupport :

- sebuah folder yang berisi full sistem operasi, termasuk folder /usr, /etc, dan sebagainya.
- partisi btrfs subvolume yang berisi file sistem operasi.
- image "raw" yang berisi tabel partisi MBR ataupun GPT dan berisi file system os.
- File sistem os itu sendiri.

## Prosesor

---

Prosesor adalah sebuah software yang mengatur urusan level rendah yang diantaranya yaitu mengatur cgroups, SELinux Policy, App Armor rules, berkomunikasi dengan kernel untuk memulai container, membuat mount point, dan metadata lainya yang disediakan oleh interface, terdapat banyak prosesor yang dibuat maka dibuatlah sebuah standar (OCI), prosesor yang mengikuti standar adalah runc. This is the most widely used container runtime, but there are others OCI compliant runtimes, such as crun, railcar, dan katacontainers.

### Runc

Runc pertamakali dibuat di github oleh 2 maintainer yaitu ichael Crosby dan Guillaume Charmes pada 22 Februari 2014, dengan lisensi bertipe Apache dan diberi nama libcontainer, meskipun runc dirancang untuk menjadi prosesor tetapi runc memberikan sebuah beberapa baris perintah yang dapat digunakan untuk berinteraksi dengan runc, tetapi pada githubnya dianjurkan untuk meggunakan interface yang ada separti docker.

### Crun

Hampir semua prosesor container menggunakan bahasa programm GO yang akan memanggil modul yang di buat dengan bahasa C, maka dari itu beberapa programmer yang percaya bahwa bahasa C lebih baik untuk berkomunikasi untuk urusan level yang rendah, dibuat crun sebuah Prosesor yang berstandar OCI dan dibuat dengan bahasa program C.

karna dibuat menggunakan bahasa C, crun lebih cepat dari prosesor yang lainya.

crun pertama kali muncul di github pada 30 agustus 2017 oleh Giuseppe Scrivano dan sebelum memiliki nama Crun namanya adalah libocispec

### Youki

Sebuah tren belakangan ini adalah menulis kembali sebuah program dalam bahasa rust, tren itu sampai pada teknologi container yang diberi nama Youki yang dalam bahasa jepang berarti container, para pembuat youki berpikir bahwa rust lebih aman karna bahasa rust memiliki managemen memori yang bagus yang diberinama memory safety.

saat ini youki memiliki kecepatan lebih cepat dari runc namun tidak lebih cepat dari crun, dalam githubnya dikatakan bahwa youki masih belum sempurna untuk menjadi alternatif dari runc atau yang lain

youki pernama kali muncul di github pada 27 Maret 2021 oleh Toru Komatsu, dimana proyek ini sangatlah muda jika anda ingin membantunya anda tinggal pergi ke github si youki

### LXC

LXC merupakan sebuah runtime dibangun sejak 2008, lxc dibangun sangatlah aman karna lxc berjalan pada user namespace pada kernel, maka dari itu lxc hanya bisa dijalankan pada kernel versi 2.6.32, fungsi isolasi user namespace memerlukan kita untuk menset UID (User Id) dan GID (Group ID) tertentu yang nanti akan digunakan untuk kernel, sehingga UID Dan GID ini akan muncul di dalam.

## Prosesor dengan teknologi yang unik

---

### Kata Container

Kata container merupakan sebuah prosesor yang unik dimana dia memadukan virtualisasi dan container, tujuanya adalah agar lebih aman, karna biasanya interface container akan berjalan pada root dan bila ada sebuah image yang berbahaya maka akan berakibat fatal karna memiliki akses root pada sistem.

Kata container memiliki 2 versi, dimana versi 1 sudah tidak lagi berkembang dan semua pengembangan berpindah ke versi 2.

### gVisor

gVisor merupakan projek yang tertutup namun akhirnya di buat opensource oleh google pada 2 Mai 2018, proses container ini merupakan salah satu yang unik, karna meggunakan teknologi sandbox, sehingga memiliki keamanan yang exstra dari pada proses yang lain dan lebih ringan dari mesin virtual, perbedaan dari proses biasa adalah gVisor menyediakan kernel sendiri yang berjalan pada proses normal, kernel ini pun dibuat dengan bahasa program GO

bila igin menjalankan gVisor dengan docker bira mengganti docker runtime mencadi runsc, runsc merupakan kepanjangan dari run Sandboxed Container.

### Railcar

sebelum proyek proses youki ada, oracle membuat sebuah runtime yang menggunakan bahasa program rust, proyek railcar pretama muncul di github pada tahun 2017 namun sebelum memiliki nama railcar proyek ini memiliki nama smith.

disanyangkan saat ini proyek railcar tidak bisa berkembang karena github reponya sudah di arsipkan dan hanya bisa dibaca.

### Systemd-nspawn

systemd tidah hanya menghadirkan beberapa tool yang berguna di dalamnya tetapi memberikan juga sebuah kemudahan untuk membuat container, namun systemd-nspawn sebenarnya menggunakan teknologi chroot namun dengan tambahannya yaitu membuat virtualisasi penuh dengan linux FSH dan juga process tree, IPC Subsystem, nama host dan nama domain.

systemd-nspawn dibuat pada 14 Maret 2011, dan awal tujuanya adalah untuk memudahkan user untuk melakukan chroot.

## Daftar Pustaka

---

- Redhat  
↪ [A Practical Introduction to Container Terminology](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction#container_runtime)  

- Docker  
↪ [What is a Container?](https://www.docker.com/resources/what-container/)  

- Podman  
↪ [What is Podman?](https://docs.podman.io/en/latest/)  

- Linuxcontainers  
↪ [LXD Introduction](https://linuxcontainers.org/lxd/introduction/)  

- Canonical  
↪ [LXD virtual machines: an overview](https://canonical.com/blog/lxd-virtual-machines-an-overview)  

- the Open Container Initiative  
↪ [About the Open Container Initiative](https://opencontainers.org/about/overview/)  

- Youki  
↪ [Youki User and Developer Documentation](https://containers.github.io/youki/)  

- Kata Container  
↪ [An overview of the Kata Containers project](https://katacontainers.io/learn/)  

- Google Cloud  
↪ [Open-sourcing gVisor, a sandboxed container runtime](https://cloud.google.com/blog/products/identity-security/open-sourcing-gvisor-a-sandboxed-container-runtime)  

- freedesktop.org  
↪ [Systemd-nspawn](https://www.freedesktop.org/software/systemd/man/systemd-nspawn.html)  
↪ [machinectl](https://www.freedesktop.org/software/systemd/man/machinectl.html)  

- Arch Wiki  
↪ [systemd-nspawn](https://wiki.archlinux.org/title/systemd-nspawn#Management)  

- Github  commit  
↪ [Docker Rootles pull request](https://github.com/docker/docs/pull/9729)  
↪ [Podman initial commit](https://github.com/containers/podman/commit/a031b83a09a8628435317a03f199cdc18b78262f)  
↪ [Nerdctl initial commit](https://github.com/containerd/nerdctl/commit/f0d302cac40fbdbfcfe74a3ba5cbefdf2f5b3741)  
↪ [Runc initial commit](https://github.com/opencontainers/runc/commit/6415e8becc2c47845cf565b87229b5dbd2fa40ad)  
↪ [Crun initial commit](https://github.com/containers/crun/commit/b8be7fd24c8f15a4abeaa06ad6c5e5d00cdd58d4)  
↪ [Railcar commit](https://github.com/oracle/railcar/commit/f2666751efb3310d843442d60bf9b8df40e009d8)  
↪ [Systemd-nspawn initial commit](https://github.com/systemd/systemd/commit/88213476187cafc86bea2276199891873000588d)

- Github Repository  
↪ [Runc](https://github.com/opencontainers/runc)  
↪ [Crun](https://github.com/containers/crun)  
↪ [LXC](https://github.com/lxc/lxc)  
↪ [Podman](https://github.com/containers/podman)  
↪ [Youki](https://github.com/containers/youki)  
↪ [Kata Container](https://github.com/kata-containers/kata-containers)  
↪ [gVisor](https://github.com/google/gvisor)  
↪ [Machinectl](https://github.com/systemd/systemd/blob/main/src/machine/machinectl.c)  
↪ [Systemd-nspawn](https://github.com/systemd/systemd/blob/main/src/nspawn/nspawn.c)
