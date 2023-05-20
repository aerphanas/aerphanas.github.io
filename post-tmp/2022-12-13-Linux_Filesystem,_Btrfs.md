---
title: Linux Filesystem, Btrfs
author: aerphanas
desc: sebuah filesystem yang menggunakan teknologi COW atau copy on write dan fokus terhadap toleransi kesalahan, perbaikan dan administrasi yang mudah.
image: linux_filesystem,_keluarga_btrfs-fig1.png
---

![Butter slices in the kitchen by Sorin Gheorghita](/images/linux_filesystem,_keluarga_btrfs-fig1.png "Butter slices in the kitchen by Sorin Gheorghita")

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Fitur](#fitur)
- [Cara Membuat Partisi](#cara-membuat-partisi)
  - [Sub Volume](#sub-volume)
  - [Snapshots](#snapshots)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

btrfs merupakan sebuah filesystem modern yang menggunakan teknologi copy on write, yang artinya bila kita melakukan perubahan pada folder atau file maka file/folder itu akan menjadi 2, pertama adalah sebelum diubah dan yang kedua adalah yang sudah terubah, maka bila terjadi kesalahan kita bisa melakukan roll-back atau kembali ke keadaan awal.

## Sejarah

---

btrfs pertama kali di desain oleh perusahaan oracle pada tahun 2007 untuk mengatasi masalah kurangnya fitur yang ada pada linux filesystem, yaitu snapshots, checksum dan volume managemen, barulah pada tahun 2013 btrfs memasuki fase stabil.

## Fitur

---

btrfs memiliki beberapa fitur utamanya adalah :

- COW atau dalam kata lain Snapshots tidak membuat duplikat secara penuh, melainkan hanyalan menympan perubahan yang terjadi.
- terdapat managemen volume yang menggunakan software dengan support untuk RAID 0, RAID 1, RAID 10 and yang lainnya.
- otomatis menmebenahi diri sendiri dengan ckecksoum dan metadata, dan otomatis mendeteksi data yang korup.

## Cara Membuat Partisi

---

saya akan memberitahukan bagai mana cara konfigurasi btrfs dengan benar sehingga kita dapat mendapatkan performa yang sempurna.

hampir sama seperti [cara saya membuat partisi ext4](https://aerphanas.github.io/posts/2022-12-08-Linux_Filesystem%2C_keluarga_extfs.html#cara-membuat-partisi), namun kita perlu beberapa penyesuaian yaitu :

daripada ```mkfs.ext4``` kita harus ```mkfs.btrfs```, namun sebelum menjalankan perintah itu kita harus menginstall software ```btrfs-progs```.

setelah membuat partisi, kita harus membuat sebuah subvolume, agar dengan mudan mengelola snapshots.
tidak ada dasar peraturan dalam membuat sub volume namun kita bisa mencontohnya pada distro OpenSUSE, seperti inilah fstabnya:

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
 UUID=3efcee78-2bc1-4311-9e0a-8105eabfea36 /home/adivin ext4   defaults              0  0
 UUID=012d1240-27ce-4a72-bc08-986536624f49 /boot        ext4   data=ordered          0  2
 UUID=0B96-B7E3                            /boot/efi    vfat   utf8                  0  2
```

setelah kita membuat sebuah partisi, kita harus memasang partisinya ke dalam sebuah folder :

```sh
 mkdir /root/disk # membuat folder disk
 mount /dev/sda1 /root/disk # pasang drive sda1 ke folder disk
```

setelah berhasil memasang partisi ke folder ```/root/disk```, kita harus membuat sebuah folder ```@``` lalu membuat sub volume disana.

```sh
 mkdir /root/disk/@
```

### Sub Volume

melihat contoh fstab OpenSUSE kita bisa simpulkan bahwa kita memerlukan beberapa sub volume yaitu :

1. /var
2. /usr/local
3. /tmp
4. /srv
5. /root
6. /opt
7. /home

sub volume bisa dibuat dengan cara :

```sh
btrfs subvolume create <volume yang mau dibuat>
```

maka kita bisa membuat sub volume seperti opensuse dengan cara :

```sh
 mkdir /root/disk/@/usr # membuat folder untuk local sub volume
btrfs subvolume create /root/disk/@/var
btrfs subvolume create /root/disk/@/usr/local
btrfs subvolume create /root/disk/@/tmp
btrfs subvolume create /root/disk/@/srv
btrfs subvolume create /root/disk/@/root
btrfs subvolume create /root/disk/@/opt
btrfs subvolume create /root/disk/@/home
```

untuk menghapus subvolume kita bisa menghapusnya dengan :

```sh
btrfs subvolume delete <volume yang mau dihapus>
```

untuk melihat list apasaja subvolume yang ada bisa dengan komand :

```sh
btrfs subvolume list /root/disk/@
```

untuk memasang subvolume kita bisa menggunakan subvolid atau menggunakan tempat dimana subvol dibuat, untuk mendapatkan subvolid kita bisa melihatnya

```sh
btrfs subvolume show /root/disk/@/var
```

bila sudah mendapatkan subvolid kita bisa memasangnya di ```/root/disk/var``` dengan perintah seperti berikut, namun bila folder ```/root/disk/var``` tidak ada, kita harus membuatnya dengan secara manual

```sh
 mount /dev/sdb1 -o subvolid=261 /root/disk/var
```

atau menggunakan tempat dimana subvol dibuat

```sh
 mount /dev/sdb1 -o subvol=/root/disk/@/var /root/disk/var
```

### Snapshots

setelah membuat sub volume kita bisa mudah mengelola snapshot, untuk membuat snapshot kita bisa menggunakan software timeshift atau snapper, namun kita juga bisa membuat snapshot secara manual, bila kita menggunakan timesift atau snapper, software itu akan otomatis membuat subvolume/folder ```.snapshots``` pada partisi.

```sh
btrfs subvolume create /root/disk/@/.snapshots # membuat subvolume untuk menampung snapshots
btrfs subvolume snapshot /root/disk /root/disk/.snapshots/yy-mm-dd-backup # membuat snapshots RW bernama yy-mm-dd-backup
btrfs subvolume snapshot -r /root/disk /root/disk/.snapshots/yy-mm-dd-backup # membuat snapshots RO bernama yy-mm-dd-backup
```

untuk menghapus snapashot kita bisa menggunakan :

```sh
btrfs subvolume delete /root/disk/.snapshots/yy-mm-dd-backup
```

setelah kita membuat snapshot, kita bisa mengembalikan keadaan folder dengan cara manual menggunakan komand ```cp``` atau ```rsync``` untuk mengembalikan keseluruhanya.

```sh
 rsync -avz /root/disk /root/disk/.snapshots/yy-mm-dd-backup /root/disk
```

untuk mengupdate snapshot sama caranya untuk mengembalikan keadaan folder/file, yaitu dengan komand ```cp``` atau ```rsync```

## Daftar Pustaka

---

- Wikipedia  
→ [Btrfs](https://en.wikipedia.org/wiki/Btrfs)  
→ [Copy On Write](https://en.wikipedia.org/wiki/Copy-on-write)  

- Btrfs Wiki  
→ [Btrfs Wiki Main Pages](https://btrfs.wiki.kernel.org/index.php/Main_Page)  

- Btrfs Read The Docs  
→ [BTRFS documentation](https://btrfs.readthedocs.io/en/latest/index.html)  

- Linux Hint  
→ [How to Create and Mount Btrfs Subvolumes](https://linuxhint.com/create-mount-btrfs-subvolumes/)  
→ [How to Use Btrfs Snapshots](https://linuxhint.com/use-btrfs-snapshots/)  

- Unsplash  
→ [Butter slices in the kitchen by Sorin Gheorghita](https://unsplash.com/photos/094mP_CBdpM?utm_source=unsplash&utm_medium=referral&utm_content=creditShareLink)  
  
