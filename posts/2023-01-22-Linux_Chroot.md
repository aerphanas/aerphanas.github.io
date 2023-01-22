---
title: Linux Chroot
author: aerphanas
desc: Chroot merupakan sebuah "utilitas" dalam sistem UNIX-Like yang digunakan untuk mengubah direktori menjadi direktori root.
image: linux-chroot-fig1.png
---

![tool chroot terdapat pada GNU coreutils](/images/linux-chroot-fig1.png "tool chroot terdapat pada GNU coreutils")

## Daftar Isi

- [Pendahuluan](#pendahuluan)
  - [Persiapan](#persiapan)
  - [Chroot](#chroot)
  - [Perlakuan Khusus](#perlakuan-khusus)
    - [OpenZFS](#openzfs)
    - [GuixSD](#guixsd)
    - [NixOS](#nixos)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

Chroot merupakan sebuah utilitas atau alat command line yang digunakan untuk memindahkan root, chroot juga merupakan versi awal dari sebuah teknologi yang saat ini kita sebut container.

chroot sangatlah berguna untuk siapapun mulai dari programmer sampai sysadmin, berikut kegunaan chroot :

- Pemulihan, chroot sering digunakan oleh sysadmin untuk memperbaiki system yang bermasalah pada configurasi yang menyebabkan sistem tidak bisa menyala atau booting.
- Pengembangan software, fungsi chroot ini digunakan para developer untuk mengecek sebuah dependensi dari software yang mereka kembangkan, karna setiap distro menyediakan versi dependensi yang berbeda.

> perlu diingat bahwa chroot memiliki sebuah limitasi dan beberapa lubang keamanan, maka sebaikya gunakanlah teknologi container yang lebih aman dari chroot, bila ingin menggunakannya secara serius.

## Persiapan

---

Sebelum menggunakan chroot kita harus menyiapkan beberapa block device yang harus terpasang terlebih dahulu ke sebuah folder yang digunakan untuk chroot.

block device yang harus disiapkan adalah :

- /dev
- /proc
- /sys
- /tmp
- /run
- efivarfs (khusus EFI Boot) atau perbaikan boot

saya asumsikan target folder yang digunakan adalah ```mydisk```, maka cara menyiapkannya adalah :

```sh
mount --rbind /dev  ./mydisk/dev
mount --rbind /sys  ./mydisk/sys
mount --rbind /tmp  ./mydisk/tmp
mount --bind  /run  ./mydisk/run 
mount --make-rslave ./mydisk/dev
mount --make-rslave ./mydisk/sys
mount -t proc /proc ./mydisk/proc
```

khusus Efi dan tujuan untuk perbaikan EFI

```sh
mount --rbind /sys/firmware/efi/efivars ./mydisk/sys/firmware/efi/efivars/
```

untuk menggunakan koneksi internet pada chroot

```sh
cp /etc/resolv.conf mydisk/etc
```

> memasang efivarfs digunakan hanya jika kita ingin melakukan perbaikan pada entri efi

## Chroot

---

untuk melakukan chroot sangatlah mudah kita hanya perlu menggunakan perintahnya dengan tambahan folder dan command yang dijalankan, contohnya seperti ini :

```sh
chroot ./mydisk /bin/bash
```

setelah itu kita bisa memuat konfigurasi Shell yang ada pada chroot dengan :

```sh
source /etc/profile
source ~/.bashrc
```

agar tidak membingunkan kita membedakan mana terminal yang berisi chroot dan mana yang tidak, kita bisa mengedit variable PS1 pada Shell contohnya seperti ini :

```sh
export PS1="(chroot) $PS1"
```

bila sudah selesai kita bisa keluar dari chroot dengan perintah ```exit``` dan mencopot block device dengan perintah :

```sh
umount --recursive ./mydisk
```

## Perlakuan Khusus

---

beberapa filesystem khusus memiliki caranya sendiri dalam melakukan chroot, tidak hanya filesystem saja, ini juga termasuk pada linux distro yang tidak menggunakan standar HFS (Hirarki filesystem).

### OpenZFS

OpenZfs adalah sebuah filesystem yang memadukan logical volume managemen degan filesystem biasa, mungkin saya akan membahasnya pada post khusus.

saya menggunakan ```mnt``` sebagai target folder, sepertiinilah persiapan sebelum chroot :

```sh
zpool export -a
zpool import -N -R /mnt rpool
zpool import -N -R /mnt bpool
zfs load-key -a
zfs mount rpool/ROOT/ubuntu
zfs mount bpool/BOOT/ubuntu
zfs mount -a
```

chroot kedalam folder target :

```sh
for i in proc sys dev run tmp; do mount -o bind /$i /mnt/$i; done
chroot /mnt /bin/bash --login
mount -a

```

untuk keluar dari chroot gunakan perintah berikut :

```sh
exit
mount | grep -v zfs | tac | awk '/\/mnt/ {print $3}' | xargs -i{} umount -lf {}
zpool export -a
```

> ZFS sangatlah berbeda dengan filesystem yang lain namun zfs sangat sangat bagus untuk server karna fitur yang ditawarkanya.

### GuixSD

GuixSD merupakan sebuah sistem operasi atau distribusi GNU/Linux yang menggunakan Guix Package manager untuk menginstal semua software sistem ke folder khusus bernama guix store lalu melakukan link ke dalam HFS yang ditentukan oleh Guix package manager.

persiapan untuk melakukan chroot sangatlah mirip pada cara yang biasa, yang membedakan adalah kita harus menggunakan live iso khusus, live iso yang digunakan haruslah GuixSD karna kita memerlukan proses guix dan guix profile.

disini saya menggunakan folder ```mnt``` sebagai target :

```sh
mount /dev/sda2 /mnt
# mount Block Device
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /dev /mnt/dev
```

setelah itu kita bisa memasuki chroot dengan :

```sh
chroot /mnt /bin/sh
```

kita juga harus mempersiapkan beberapa profile, disini nama user saya adalah adivin :

```sh
source /var/guix/profiles/system/profile/etc/profile
source /home/adivin/.guix-profile/etc/profile
source /home/adivin/.config/guix/current/etc/profile
```

setelah itu saya menjalankan proses guix :

```sh
guix-daemon --build-users-group=guixbuild --disable-chroot &
```

### NixOS

NixOS memberikan sebuah tool untuk memudahkan chroot seperti arch linux (```arch-chroot```), kita hanya perlu memasang system pada folder ```/mnt``` lalu menjalankan perintah ```nixos-enter```, perintah ini otomatis menyiapkan Block Device dan mensetting profile yang tepat, namun tentu saja kita harus menggunakan live iso dari NixOS.

> semua proses diatas dijalankan pada root

## Daftar Pustaka

---

- Gentoo Wiki  
↪ [Chroot](https://wiki.gentoo.org/wiki/Chroot)  

- Arch Wiki  
↪ [Chroot](https://wiki.archlinux.org/title/chroot)  

- Wikipedia  
↪ [Chroot](https://en.wikipedia.org/wiki/Chroot)  

- Tom's Development Blog  
↪ [Chroot into an Ubuntu on zfs system](https://tpmullan.com/2021/10/27/chroot-into-an-ubuntu-on-zfs-system/)  

- Guix Manual  
↪ [Chrooting into an existing system](https://guix.gnu.org/en/manual/devel/en/guix.html#Chrooting-into-an-existing-system)  

- NixOS Wiki  
↪ [Change root](https://nixos.wiki/wiki/Change_root)  

- MaiZure's Projects  
↪ [Decoded: GNU coreutils](https://www.maizure.org/projects/decoded-gnu-coreutils/)  
