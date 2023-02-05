---
title: Alternatif Docker - Podman Pod
author: aerphanas
desc: Podman memiliki fungsi yang hampir mirip dengan docker compose tetapi lebih baik menurut saya, kita juga bisa import konfigurasi dari kubernetes.
image: alternatif-docker-podman-pod-fig1.png
---

![Container ship](/images/alternatif-docker-podman-pod-fig1.png "Container ship")

## Daftar isi

- [Pendahuluan](#pendahuluan)
  - [Membuat Pod](#membuat-pod)
  - [Menambahkan Container ke Pod](#menambahkan-container-ke-pod)
  - [Export ke Kubernetes](#export-ke-kubernetes)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

Podman merupakan sebuah tehnologi yang dubuat oleh Redhat untuk menggantikan Docker, karna menurutnya docker memiliki masalah terhadap keamanan seperti docker engine yang berjalan diatas root, namun saat ini docker bisa berjalan tanpa akses root seperti podman.

## Membuat Pod

---

Podman memiliki sebuah kelebihan dari docker yaitu podman pod yang berguna untuk mengelompokan beberapa container menjadi satu, untuk membuat sebuah pod kita dapat menggunakan perintah :

```sh
podman pod create -n db_postgresql \
                  -h postgresql \
                  -p 8080:80 \
                  -p 5432:5432 \
                  -v dbpsql:/var/lib/postgresql/data
```

dari perintah diatas, opsi ```-n``` digunakan untuk memberikan nama pada pod disini saya menamainya db_postgresql, opsi ```-h``` untuk menseting hostname untuk container kita, opsi ```-p``` merupakan singkatan dari opsi ```--publish``` opsi ini digunakan agar port yang ada di container maju menjadi port host, sehingga kita bisa mengakses localhost:8080  bila kita menggunakan ```-p 8080:8080```, opsi ```-v``` digunakan untuk agar data kita yang berada pada container bisa tetap ada meskipun container sudah dihapus.

bila kita mejalankan :

```sh
podman pod list
```

kita akan mendapatkan list pod yang kita buat.

## Menambahkan Container ke Pod

---

Untuk menambahkan Container ke dalam pod sangatlah mudah kita hanya perlu menambahkan opsi ```--pod```, contohnya seperti ini :

```sh
podman run -d --name postgresql \
              --restart always \
              --pod db_postgresql \
              -e POSTGRES_PASSWORD=postgres \
              -e POSTGRES_USER=postgres \
              -e PGDATA=/var/lib/postgresql/data \
              docker.io/library/postgres:13
```

penjabaran untuk perintah diatas adalah, opsi ```-d``` untuk memberitahu bahwa container ini akan berjalan di latar belakang, opsi ```--restart``` opsi ini digunakan bila terjadi masalah pada container maka dia akan otomatis restart, opsi ```-pod``` untuk memberitahukan bahwa container ini akan berjalan pada pod db_postgresql dan opsi ```-e``` merupakan environtment variable untuk container.

untuk memanagemen postgresql kita biasanya memerukan pgadmin maka sekalian saja kita membuatnya :

```sh
podman run -d --name pgadmin \
              --restart always \
              --pod db_postgresql \
              -e PGADMIN_DEFAULT_EMAIL=user@domain.com \
              -e PGADMIN_DEFAULT_PASSWORD=SuperSecret \
              dpage/pgadmin4
```

inilah kenapa saat membuat pod saya melakukan port forward untuk port 80 dan 5432, karna urusan network sudah terurus oleh pod atau lebih tepatnya oleh intra maka kita tidak perlu melakukan port maping pada saat membuat container.

>bila memerlukan referensi tambahan silakan cek daftar pustaka.

## Export ke Kubernetes

---

podman pod dapat dengan mudah melakukan eksport ke kubernetes dengna menjalankan perintah :

```sh
podman generate kube db_postgresql >> db_postgresql.yaml
```

disini saya mengimport podman pod dengan nama ```db_postgresql``` kedalam sebuah file configurasi yang nantinya dapat di import ke kubernetes atau kita bisa sebaliknya, kita dapat mengimport configurasi kubernetes ke podman pod dengan cara :

```sh
podman play kube db_postgresql.yaml
```

## Daftar Pustaka

---

- RedHat  
↪ [Moving from docker-compose to Podman pods](https://www.redhat.com/sysadmin/compose-podman-pods)  

- Podman  
↪ [Podman api reference](https://docs.podman.io/en/latest/_static/api.html)  

- photo by  
↪ [container wallpaper](https://wallpapercave.com/container-wallpapers)  