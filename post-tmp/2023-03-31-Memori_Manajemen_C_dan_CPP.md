---
title: Memori Manajemen C dan C++
author: aerphanas
desc: dalam sebuah bahasa program yang tidak memiliki Garbage Colector, biasanya penguna bahasa tersebut diharuskan untuk menggelola memori mereka sendiri
image: memori-managemen-c-dan-cpp-fig1.png
---

![Image by destex on Wallhaven dengan perubahan](/images/memori-managemen-c-dan-cpp-fig1.png "Image by destex on Wallhaven dengan perubahan")

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Manual Memory C Program](#manual-memory-c-program)
  - [malloc](#malloc)
  - [calloc](#calloc)
  - [realloc](#realloc)
- [Mengelola Memory C++](#mengelola-memory-c)
- [Strategi Memori C++](#strategi-memori-c)
  - [RAII](#raii)
  - [Smart Pointer](#smart-pointer)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

bahasa c dan c++ memiliki caranya sendiri dalam mengelola memori, perbedaannya adalah jika bahasa C mengelola memori secara manual tetapi di bahasa c++ kita dapat mengggunakan metode RAII.

## Manual Memory C Program

---

dalam bahasa C kita dapat mengelola memori heap dengan beberapa cara, diantaranya adalah menggunakan fungsi `malloc`, `calloc`, `realloc` dan `free` yang berasal dari `stdlib.h`.

fungsi `free` digunakan untuk membebaskan memori yang di alokasikan

### malloc

malloc digunakan untuk mengalokasikan memori pada memori heap, malloc memerlukan input `size_t` dan mengembalikan `void*` yang artinya fungsi malloc mengembalikan sebuah alamat memori dan fungsi malloc memerlukan input untuk berapa besar memori yang akan dialokasikan.

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int size = sizeof(int);
    int *n = (int*) malloc(size*1);
    *n = 10;

    printf("value : %d\n", *n);
    printf("addr  : %p\n", n);

    free(n);
    return 0;
}
```

pada program diatas kita harus memgkonversi tipe `void*` ke `int*` agar kita dapat menaruh isi di dalamnya kita juga secara manual harus menggunakan fungsi `free` untuk membersihkan memori yang kita pakai.

### calloc

calloc memiliki fungsi yang hampir sama dengan malloc yang membedakan di sini adalah calloc memberikan value awal pada memori yang di alokasikan, jika kita menggunakan `malloc` memori yang kita alokasikan akan berisi sebuah angka/huruf random.

calloc juga mengembalikan sebuah tipe yang sama dengan malloc yaitu `void*`, namun calloc memerlukan 2 buat input yaitu berapa element yang dialokasikan dan ukuran dari data yang di alokasikan.

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int size = sizeof(int);
    int *n = (int*) calloc(size, size*1);
    *n = 10;

    printf("value : %d\n", *n);
    printf("addr  : %p\n", n);

    free(n);
    return 0;
}
```

dari kode diatas fungsi calloc membunyai input ukuran tipe data yang ingin di alokasikan dan berapa jumlahnya.

### realloc

realloc digunakan untuk mengubah ukuran memori yang di alokasikan oleh `alloc` dan `calloc`, realloc mengambil 2 buah input yaitu alamat memori dan ukuran baru yang akan di alokasikan.

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int size = sizeof(int);
    int *n = (int*) calloc(size, size*1);
    *n = 10;

    printf("value : %d\n", *n);
    printf("addr  : %p\n", (void *)n);
    printf("size  : %lu\n", sizeof(int));

    n = realloc(n, size*2);
    printf("size  : %lu\n", sizeof(int)*2);

    free(n);
    return 0;
}
```

jika kode di atas di jalankan maka ukuran memori pada variable n akan berubah yang sebelumnya 4 menjadi 8, karena ukuran dari tipe data int disini adalah 4.

## Mengelola Memory C++

---

C++ memiliki 2 buah fungsi yang digunakan untuk mengalokasikan memori yaitu `new` dan `delede`, kita tidak perlu memberikan berapa memori yang kita perlukan, C++ akan otomatis mengalokasikannya untuk kita.

```c++
#include <iostream>

int main(){
    int* holder = new int(42);
    std::cout << *holder
              << std::endl;
    delete holder;
    return 0;
}
```

## Strategi Memori C++

---

terdapat masalah pada kode-kode diatas yang biasanya terjadi pada bahasa program yang mulakukan pengolahan memori secara manual, diantaranya adalah Dangling pointer dan Double Free

Dangling Pointer adalah sebuah pointer yang tidak menunjuk sebuah memori.

```c++
#include <iostream>
#include <cstdio>

int main() {
   int *dp = NULL;
   {
       int c = 10;
       dp = &c;
       printf("%p\n", dp);
   }
   printf("%p\n", dp);
   printf("%d\n", *dp);
   return 0;
}
```

kode diatas kita mencoba mengaksesk alamat memori sebuah variable yang berada diluar scope, bayangkan apa yang terjadi jika alamat memori yang kita gunakan digunakan oleh program lain ?.

salah satu masalah lain adalah double free yaitu dimana kita melakukan pembersihan memori yang sudah dibersihkan.

```c++
#include <iostream>

int main() {
    int* ptr = new int;
    *ptr = 10;
    delete ptr;
    delete ptr;
    return 0;
}
```

kode diatas melakukan pembersihan pada variable ptr 2 kali, apa yang terjadi jika proggram lain sedang berjalan menggunakan alamat memori ptr, maka program itu akan terjadi error dan akan sulit mencari bug.

### RAII

di dalam bahasa C++ terdapat sebuah tehnik yang dinamakan RAII atau (Resource acquisition is initialization) dimana kita bisa melakukan pembersihan memori pada Destructor.

destructor adalah sebuah fungsi digunakan untuk membersihkan sumber daya yang telah dialokasikan pada saat objek dibuat.

```c++
#include <iostream>

class IntHolder {
private:
    int* m_value;
public:
    IntHolder(int value) {
        m_value = new int(value);  
    } 
    ~IntHolder() {
        delete m_value;
    }
    int getValue() const {
        return *m_value;
    }
};

int main() {
    IntHolder holder = IntHolder(42);
    std::cout << holder.getValue()
              << std::endl;
    return 0;
}
```

### Smart Pointer

C++ memiliki sebuah fitur yang membuat mengelola memori menjadi lebih mudah, diantaranya adalah `std::unique_ptr` dan `std::shared_ptr`, perlu diingat bahwa `std::unique_ptr` dan `std::shared_ptr` merupakan sebuah fitur c++ dengan standar C++11 dan juga kita perlu mengimport memory header.

`std::unique_ptr` adalah sebuah konsep yang mirip dengan Rust Borrow system yaitu sebuah object hanya memiliki 1 sebuah resource, contoh menggunakan `std::unique_ptr`

```c++
#include <iostream>
#include <memory>

int main() {
    std::unique_ptr<int> ptr(new int);

    *ptr = 10;

    std::cout << "Nilai pointer: "
              << *ptr
              << std::endl;

    return 0;
}
```

`std::shared_ptr` hampir sama dengan konsep Rust Reference Counting (Rc) yaitu pointer yang dapat digunakan oleh beberapa objek untuk membagikan kepemilikan pada suatu resource. Ketika tidak ada lagi objek yang memiliki kepemilikan pada resource, maka resource akan dihapus, contoh `std::shared_ptr`

```c++
#include <iostream>
#include <memory>

class MyClass {
public:
    void doSomething() {
        std::cout << "Melakukan sesuatu!"
                  << std::endl;
    }
};

int main() {
    std::shared_ptr<MyClass> ptr1(new MyClass);

    std::shared_ptr<MyClass> ptr2 = ptr1;

    ptr1->doSomething();
    ptr2->doSomething();

    std::cout << "Jumlah pointer yang mengacu ke objek: "
              << ptr1.use_count()
              << std::endl;

   return 0;
}
```

## Daftar Pustaka

---

- CPP Reference  
→ [stdlib](https://en.cppreference.com/w/c/program)  
→ [memory](https://en.cppreference.com/w/cpp/header/memory)

- Wikipedia  
→ [Dangling Pointer](https://en.wikipedia.org/wiki/Dangling_pointer)

- Common Weakness Enumeration (CWE)  
→ [CWE-415: Double Free](https://cwe.mitre.org/data/definitions/415.html)  
→ [CWE-825: Expired Pointer Dereference](https://cwe.mitre.org/data/definitions/825.html)  
→ [CWE-416: Use After Free](https://cwe.mitre.org/data/definitions/416.html)

- Common Vulnerabilities and Exposures (CVE)  
→ [CVE-2014-1776](https://web.archive.org/web/20170430095220/http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-1776)

- Wallhaven  
→ [blue eyes, blonde, anime, c++, programming, New Game!](https://whvn.cc/83q7ek)
