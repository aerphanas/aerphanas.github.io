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
  - [Jack](#jack)
  - [Pipewire](#pipewire)
- [Pemutar Audio](#pemutar-audio)
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

ALSA sendiri memiliki API lebih rumit dari OSS jadi akan sulit pengembang applikasi untuk menggunakan ALSA maka dibuatlah beberapa sound servre yang gunanya memepermudah pembuatan aplikasi pada linux, ALSA sendiri memerlukan tool agar user dapat mengontrol volume dsb toolnya adalah [alsa-utils](https://pkgs.org/download/alsa-utils)

## Sound Server

Sound server adalah software yang berguna mengelola akses dan penggunaan terhadap sound card dan biasanya berjalan pada latar, saat ini keberadaan sound server di linux ada 3 dan dari ke-3 itu memiliki tujuannya masing-masing, contohnya JACK selalu mengedepankan urusan latensi sehingga cocok untuk rekaman suara 

### Pulseaudio

PulseAudio adalah sebuah sound server yang ditujukan untuk Linux namun ada beberapa sistem operasi yang memportingnya ke dalam sistemnya, pada awalnya lebih tepatnya pada tahun 2004 pulseaudio memiliki nama Polypaudio namun pada tahun 2006 barulah diubah menjadi PulseAudio

### Jack

### Pipewire



## Pemutar Audio



## Dafta Pustaka

- [Wikipedia:ALSA](https://en.wikipedia.org/wiki/Advanced_Linux_Sound_Architecture)
- [Wikipedia:PulseAudio](https://en.wikipedia.org/wiki/PulseAudio)
- [Wikipedia:JACK](https://en.wikipedia.org/wiki/JACK_Audio_Connection_Kit)
- [Pulseaudio](https://www.freedesktop.org/wiki/Software/PulseAudio/)
- [JACK](https://jackaudio.org/)
- [Pipewire](https://pipewire.org/)