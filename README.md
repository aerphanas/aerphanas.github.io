# aerphanas.github.io

Static site menggunakan Hakyll sebagai generator

[![Author](https://img.shields.io/badge/author-aerphanas-red.svg)](https://github.com/aerphanas)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-important)](https://github.com/aerphanas/aerphanas.github.io/blob/master/LICENSE)
[![pages-build-deployment](https://github.com/aerphanas/aerphanas.github.io/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/aerphanas/aerphanas.github.io/actions/workflows/pages/pages-build-deployment)
![Haskell Language](https://img.shields.io/badge/Haskell-Haskell2010-informational)


## Daftar isi
- [Tujuan](#tujuan)
- [Persiapan](#persiapan)
  - [cara menggunakan](#cara-meggunakan-site)
- [Kontribusi](#kontribusi)

## Tujuan
Tujuan di buat blog ini adalah untuk mempromosikan Opensource dan mengajarkan beberapa trik dan tips tentang opensource secara mendalam, mulai dari sejarah, jenis, konfigurasi, dan sebagainya, blog ini dibangun juga agar dapat memberikan pengertian terhadap sesuatu alat yang biasanya di rilis menggunakan bahasa inggris dan dengan dokumentasi atau manual yang sulit dipahami agar dapat mudah dipahami

## Persiapan
syarat tools yang harus diinstal sebelum melakukan pengembangan :

- cabal  >= 1.10
- GHC base == 4.*
- hakyll == 4.15.*

untuk menginstall GHC dan cabal dianjurkan menggunakan [GHCup](https://www.haskell.org/ghcup/) agar lebih mudah, setelah menginstall tools yang diperlukan kita hanya perlu clone github reponya, dengan cara :

```sh
git clone https://github.com/aerphanas/aerphanas.github.io.git
```

lalu setelah itu pergilah ke directori ```aerphanas.github.io``` dan lakukan

```sh
cabal new-install
```

setelah itu akan dibuat sebuah perintah yang bernama ```site```.

#### cara meggunakan site
> note : site harus dijalankan di folder ```aerphanas.github.io```

```sh
site build # membangun site dan ditujukan di ./doc folder 
```

```sh
site clean # membersihkan tujuan (disini tujuanya adalah folder ./doc)
```

```sh
site watch # menjalankan website secara interaktif
           # interaktif disini adalah web akan otomatis berubah bila ada file yang berubah
```

```sh
site watch site watch --host 10.11.53.122 --port 8080
           # sama seperti diatas tetapi daripada menggunakan ip 127.0.0.1 dan port 8000
           # kita menggunakan ip 10.11.53.122 dan port 8080
```

## Kontribusi

1. fork proyek github saya ke akun github kamu
2. buatlah branch baru pada poyek yang di fork dengan nama yang informatif
3. buatlah pull request
