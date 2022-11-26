---
title: Linux Hi-Res Audio
author: aerphanas
desc: memutar audio dengan kualitas tinggi di sistem operasi linux
---

## Daftar Isi

- [Pendahuluan](#pendahuluan)
- [ALSA](#alsa)
- [Sound Server](#sound-server)
  - [Pulseaudio](#pulseaudio)
    - [Konfigurasi](#konfigurasi-pulseaudio)
  - [Pipewire](#pipewire)
    - [Konfigurasi](#konfigurasi-pipewire)
- [Dafta Pustaka](#dafta-pustaka)

## Pendahuluan

Saya memiliki hobi yang unik yaitu mendengarkan musik, musik yang saya dengar merupakan musik yang memiliki kualitas tinggi yang biasanya memiliki bit depth dari 16 sampai 24 bit dan memiliki sample rate sama dengan diatas 44.1 kHz, agar bisa mendengarkan kualitas suara yang baik di linux memerlukan beberapa configurasi, disinilah saya akan memebagikan bagaimana cara menconfigurasi sebuah mesin linux agar bisa memutar kualitas audio yang berkualitas tinggi, linux memiliki sound API yang bernama alsa yang berada di dalam linux kernel.

## ALSA

ALSA adalah singkatan dari Advanced Linux Sound Architecture, pada awalnya ALSA merupakan proyek yang terpisah dari kernel Linux sebelum linux menggunakan ALSA, linux menggunakan OSS (Open Sound System) ALSA sendiri masuk ke Linux kernel pada versi 2.5 dan pada Linux versi 2.6 OSS di gantikan oleh ALSA, ALSA juga Kompatibel dengan OSS sehingga memudahkan aplikasi yang menggunakan OSS untuk memakai ALSA.

ALSA juga memiliki keunggulan dari OSS yaitu :

- MIDI synthesis berbasis Perangkat Keras.
- mixing Prangkat Keras untuk channels yang lebih dari satu.
- Operasi Full-duplex.
- mesupport multiprosesor.

ALSA sendiri memiliki API lebih rumit dari OSS jadi akan sulit pengembang applikasi untuk menggunakan ALSA maka dibuatlah beberapa sound servre yang gunanya memepermudah pembuatan aplikasi pada linux, ALSA sendiri memerlukan tool agar user dapat mengontrol volume dsb toolnya adalah [alsa-utils](https://pkgs.org/download/alsa-utils).

## Sound Server

Sound server adalah software yang berguna mengelola akses dan penggunaan terhadap sound card dan biasanya berjalan pada latar, saat ini keberadaan sound server di linux ada 3 dan dari ke-3 itu memiliki tujuannya masing-masing, contohnya JACK selalu mengedepankan urusan latensi sehingga cocok untuk rekaman suara.

### PulseAudio

PulseAudio adalah sebuah sound server yang ditujukan untuk Linux namun ada beberapa sistem operasi yang memportingnya ke dalam sistemnya, pada awalnya lebih tepatnya pada tahun 2004 pulseaudio memiliki nama Polypaudio namun pada tahun 2006 barulah diubah menjadi PulseAudio.

#### Konfigurasi PulseAudio

Mengkonfigurasi PulseAudio agar menmutar audio secara Hi-Res sangatlah mudah kita hanya perlu mengedit atau menambahkan beberapa line di dalam configurasinya, konfigurasi PulseAudio berada di :

```sh
/etc/pulse/daemon.conf
```

namun sebelum kita mengedit file itu kita harus login sebagai root, setelah kita login kita bisa menambahkan :

```sh
default-sample-rate = <ganti>
alternate-sample-rate = <ganti>
```

kita bisa mengganti berapa sample rate yang kita mau, rekomendasi saya ubah menjadi :

```sh
default-sample-rate = 44100
alternate-sample-rate = 48000
```

untuk PulseAudio versi 1.11 memiliki konfigurasi khusus, konfigurasi ini berguna untuk mengubah sample sate menjadi sama dengan sumber audio, konfigurasinya adalah

```sh
avoid-resampling = true
```

untuk mengubah format output menjadi 24bit kita bisa menambahkan ini :

```sh
default-sample-format = s24le
```

di PulseAudio kita juga bisa mengubah metode resample seuai keinginan kita namun sebelum itu kita harus mengetahui resample apa yang disupport oleh system kita dengan perintah :

```sh
pulseaudio --dump-resample-methods
```

saya rekomendasikan menggunakan resample soxr-vhq karna memiliki kualitas yang bagus, tambahkan konfigurasi :

```sh
resample-method = soxr-vhq
```

seperti itulah saya mendapatkan kualitas suara yang bagus menggunakan jika sedang menggunakan PulseAudio.

### Pipewire

Pipewire merupakan sebuah Sound Server yang baru, rilis pertama pada tahun 2017, dan pada tahun 2021 pipewire menjadi sound server bawaan Linux Distro bernama Fedora 34 setelah itu mulailah beberapa distro berpindah dari PulseAudio ke Pipewire, pada awalnya pipewire merupakan sebuah program untuk menghandle video di Linux Distro yang berdampingan dengan pulseaudio makadari itu sebelum bernama pipewire, pipewire memiliki nama PulseVideo.

pipewire memiliki sebuah tujuan diantaranya :

- kompatibilitas untuk aplikas yang menggunakan Flatpak
- cara aman untuk merekam dan menangkap layar di Wayland compositor
- Kompatibel dengan aplikasi yang menggunakan JACK dan PulseAudio

#### Konfigurasi Pipewire

Karna biasanya pipewire berjalan menggunakan user kita harus mengkopi configurasi dari

```sh
/usr/share/pipewire/pipewire.conf
```

ke

```sh
~/.config/pipewire/pipewire.conf

```

setelah kita mengkopi contoh konfigurasi kita bisa membukanya dan mengedit sesuai apa yang kita inginkan, jika ingin mengetahui semua konfigurasi pipiwire bisa pergi ke wikinya ada disini [Pipewire wiki](https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/home)

untuk mendapatkan kualitas audio yang maksimal saya menggunakan konfigurasi yang hampir sama dengan Pulseaudio yaitu mengubah sample rate, untuk mengubah sample rate silakan anda membuka ```pipewire.conf``` dengan text editor kesayangan anda, jika sudah silakan edit atau tambah (bila tidak ada) configurasi :

```sh
default.clock.rate          = <ganti>
default.clock.allowed-rates = [ <ganti> <ganti> ... ]
```

hampir mirip dengan PulseAudio, saya akan menggunakan 44100 sebagai standar sample rate, namun disini ada yang berbeda yaitu configurasi

```sh
default.clock.allowed-rates = [ <ganti> <ganti> ... ]
```

disini saya akan menggunakan 44100 48000 88200 96000 sebagai sample rate, kegunaanya adalah pipewire akan otomatis mengubah sample rate sesuai sumber audio tetapi menggunakan list, disinilah gunakan samplerate yang disupport oleh DAC anda, saat ini configurasi saya adalah :

```sh
default.clock.rate          = 44100
default.clock.allowed-rates = [ 44100 48000 88200 96000 ]
```

untuk bit depth pipewire akan otomatis mengkonversi ke float32, namun bila kita memiliki DAC yang mensupport int24 maka pipewire akan menyesuaikanya.

## Dafta Pustaka

- Wikipedia  
↪ [ALSA](https://en.wikipedia.org/wiki/Advanced_Linux_Sound_Architecture)  
↪ [PulseAudio](https://en.wikipedia.org/wiki/PulseAudio)  
↪ [Pipewire](https://en.wikipedia.org/wiki/PipeWire)  

- Gitlab Freedesktop  
↪ [Pipewire](https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/home)  

- Freedesktop  
↪ [Pulseaudio](https://www.freedesktop.org/wiki/Software/PulseAudio/)  

- Piperiwe  
↪ [Pipewire](https://pipewire.org/)
