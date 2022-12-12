---
title: Linux Filesystem, Btrfs
author: aerphanas
desc: sebuah filesystem yang menggunakan teknologi COW atau copy on write dan fokus ke toleransi kesalahan, perbaikan dan administrasi yang mudah.
image:
---

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Fitur](#fitur)
- [Cara Membuat Partisi](#cara-membuat-partisi)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

btrfs merupakan sebuah filesystem moderen yang menggunakan teknologi copy on write, yang artinya bila kita melakukan perubahan pada folder atau file maka file/folder itu akan menjadi 2, yang pertama adalah sebelum diubah dan yang kedua adalah yang sudah terubah, maka bila terjadi kesalahan kita bisa melakukan roll-back atau kembali ke keadaan awal.

## Sejarah

---

btrfs pertama kali di desain oleh perusahaan oracle untuk mengatasi masalah kurangnya fitur yang ada pada linux filesystem, yaitu snapshots, checksum dan volume managemen pada tahun 2007, barulah pada tahun 2013 btrfs memasuki fase stabil.

## Fitur

---

btrfs memiliki beberapa fitur utamanya adalah :

- COW atau dalam kata lain Snapshots tidak membuat duplikat secara penuh, melainkan hanyalan menympan perubahan yang terjadi.
- terdapat managemen volume yang menggunakan software dengan support untuk RAID 0, RAID 1, RAID 10 and yang lainnya.
- otomatis menmebenahi diri sendiri dengan ckecksoum dan metadata, dan otomatis mendeteksi data yang korup.

## Cara Membuat Partisi

---

saya akan memberitahukan bagai mana cara konfigurasi btrfs dengan benar sehingga kita dapat mendapatkan performa yang sempurna.

hampir sama seperti [cara saya membuat partisi ext4](https://aerphanas.github.io/posts/2022-12-08-Linux_Filesystem%2C_keluarga_extfs.html#cara-membuat-partisi), kita perlu beberapa penyesuaian yaitu :

daripada ```mkfs.ext4``` kita harus ```mkfs.btrfs```, sebelum menjalankan perintah itu kita harus menginstall ```btrfs-progs```.

setelah membuat partisi kita harus membuat sebuah subvolume, agar dengan mudan mengelola snapshots, tidak ada dasar peraturan dalam membuat sub volume namun kita bisa mencontohnya pada distro OpenSUSE, seperti inilah fstabnya:

```sh
/dev/mapper/cr_system-opensuse             /            btrfs  defaults,ssd          0  0
/dev/mapper/cr_system-opensuse             /var         btrfs  subvol=/@/var         0  0
/dev/mapper/cr_system-opensuse             /usr/local   btrfs  subvol=/@/usr/local   0  0
/dev/mapper/cr_system-opensuse             /tmp         btrfs  subvol=/@/tmp         0  0
/dev/mapper/cr_system-opensuse             /srv         btrfs  subvol=/@/srv         0  0
/dev/mapper/cr_system-opensuse             /root        btrfs  subvol=/@/root        0  0
/dev/mapper/cr_system-opensuse             /opt         btrfs  subvol=/@/opt         0  0
/dev/mapper/cr_system-opensuse             /home        btrfs  subvol=/@/home        0  0
/dev/mapper/cr_system-opensuse             /.snapshots  btrfs  subvol=/@/.snapshots  0  0
/dev/system/swap                           swap         swap   defaults              0  0
UUID=3efcee78-2bc1-4311-9e0a-8105eabfea36  /home/adivin ext4   defaults              0  0
UUID=012d1240-27ce-4a72-bc08-986536624f49  /boot        ext4   data=ordered          0  2
UUID=0B96-B7E3                             /boot/efi    vfat   utf8                  0  2
```

## Daftar Pustaka

---

- Wikipedia  
↪ [Btrfs](https://en.wikipedia.org/wiki/Btrfs)  
↪ [Copy On Write](https://en.wikipedia.org/wiki/Copy-on-write)

- Btrfs Wiki  
↪ [Btrfs Wiki Main Pages](https://btrfs.wiki.kernel.org/index.php/Main_Page)

- Btrfs Read The Docs  
↪ [BTRFS documentation](https://btrfs.readthedocs.io/en/latest/index.html)