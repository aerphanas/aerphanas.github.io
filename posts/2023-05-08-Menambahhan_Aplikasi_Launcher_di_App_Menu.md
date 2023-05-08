---
title: Menambahkan Aplikasi Launcher di App Menu
author: aerphanas
desc: membuat app launcher untuk menjalankan aplikasi yang tidak memiliki desktop launcher yang tampil di app menu
image: menambahhan-aplikasi-launcher-di-app-menu-fig1.png
---

![dua soyjaks menunjuk desktop icon](/images/menambahhan-aplikasi-launcher-di-app-menu-fig1.png "dua soyjaks menunjuk desktop icon")

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Desktop Entry](#desktop-entry)
  - [Membuat Entry](#membuat-entry)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

saat saya mendownload sebuah software secara langsung yang berasal dari web asli terkadang saya mendapatkan sebuah file kompresi `tar`, setelah saya mengekstrak file ini biasanya terdapat folder bin, lib, dll, cara saya menjalankanya yaitu melalui terminal, namun kaliini saya ingin menjalankannya melalui App menu dan tidak perlu membuka terminal untuk menjalankannya.

## Desktop Entry

---

untuk menampilkan sebuah app launcher di app menu kita akan membuat sebuah file spesifikasi yang nanti bisa dibaca oleh app menu untuk menampilkan app launcher kita, untuk standar spesifikasi saya menggunakan standar yang berasal dari freedesktop jadi apa yang saya lakukan di post ini hanya berlaku untuk app menu yang menggunakan spesifikasinya

### Membuat Entry

saya akan membuat entry dalam folder `.local/share/applications/` yang berada pada `/home/user/` user disini di sesuaikan dengan nama user kalian, sebagai contoh saya akan memebuat desktop entry `Pharo`, pharo adalah sebuah bahasa program sekaligus IDE yang mengimplementasikan SmallTalk.

buatlah sebuah entry

```sh
touch ~/.local/share/applications/pharo.desktop
```

lalu bukalah file `.desktop` dengan text editor favorit kalian, lalu dalam text tambahkan `[Desktop Entry]` di atas sebelum menulis key.

di web freedesktop terdapat sebuah table list key, desktop entry juga mensupport link web namun di post kali ini saya ingin membuat app launcher, jadi kunci inilah yang saya anggap benar untuk menyelesaikan masalah saya

| Kunci       | keterangan                                        |
|:-----------:|:-------------------------------------------------:|
| Type        | tipe entry yang ingin dibuat                      |
| Version     | versi spec                                        |
| Name        | nama aplikasi yang nanti ditampilkan di app menu |
| GenericName | nama generik                                      |
| Comment     | ditampilkan sebagai diskripsi                     |
| Exec        | letak file binari atau nama binari                |
| Icon        | nama icon atau file gambar untuk dijadikan icon   |
| Terminal    | menjalankan terminal saat mengklik app            |

- **Type**, disini saya ingin membuat sebuah app launcher maka saya akan mengisi `Application`
- **Version**, disini saya akan menggunakan versi 1.0, meskipun bisa versi 1.5 tetapi pada umumnya aplikasi di linux menggunakan versi 1.0
- **Name**, saya memasukan nama `Pharo`
- **GenericName**, saya memasukan `Pure Object-Oriented Programming Language`
- **Comment**, saya mengisi `Pharo is a mininal, elegant, pure, reflective object language (and fully open-source).`
- **Exec**, karna saya menginstall menggunakan OpenSUSE Build Service, saya menginsatl melalui pacman, jadi saya akan mengisi `/usr/bin/pharo`
- **Icon**, disini lah saya menggunakan custom icon karna icon pack yang saya pakai tidak memiliki ikon pharo, saya mengambil ikon official dari github lalu menyimpanya ke folder `/home/adivin/icons/pharo.png`
- **Terminal**, karna saya tidak ingin menjalankanya melalui terminal, maka saya mengisi `false`

seperti inilah file yang sudah dibuat

```txt
[Desktop Entry]

Type=Application
Version=1.0
Name=Pharo
GenericName=Pure Object-Oriented Programming Language
Comment=Pharo is a mininal, elegant, pure, reflective object language (and fully open-source).
Exec=/usr/bin/pharo
Icon=/home/adivin/icons/pharo.png
Terminal=false
```

jika sudah dibuat saya rekomendasikan untuk logout agar app list termuat kembali, setelah itu login kembali dan jika kita membuka app menu maka app kita akan muncul dengan nama dan icon yang kita pilih, file desktop entry saya sangatlah minimal jika ingin membaca lebih lanjut saya berikan sebah link untuk menambahkan kunci lain yang berada di daftar pustaka.

## Daftar Pustaka

---

- freedesktop  
→ [Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#recognized-keys)  
→ [Registered Categories](https://specifications.freedesktop.org/menu-spec/latest/apa.html)

- pharo  
→ [home page](https://pharo.org/)

- swi-prolog  
→ [home page](https://www.swi-prolog.org/)
