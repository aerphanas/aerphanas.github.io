---
title: Foreign function Interface
author: aerphanas
desc: Foreign function interface atau disingkat FFI merupakan suatu fitur yang memungkinkan kita memanggil sebuah fungsi yang berasal dari bahasa lain dan biasanya bahasa yang dipanggil adalah bahasa C.
image: foreign_function_interface-fig1.png
---

![Fire Salamander photo by William Warby](/images/foreign_function_interface-fig1.png "Fire Salamander photo by William Warby")

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Apa itu FFI ?](#apa-itu-ffi)
- [Tujuan Menggunakan FFI](#tujuan-menggunakan-ffi)
- [Contoh penggunaan FFI](#contoh-penggunaan-ffi)
  - [Haskell](#haskell)
  - [Racket](#racket)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

kita terkadang memerlukan sebuah library / fungsi yang akan membantu kita membuat sebuah aplikasi, namun ketika melihat dokumentasi ternyata bahasa program yang sedang kita dipakai tidak mengimplementasikanya, disinilah kita bisa menggunakan FFI untuk memanggil fungsi yang kita inginkan dari bahasa lain.

## Apa itu FFI

---

Foreign function interface atau disingkat FFI adalah sebuah mekanisme yang memungkinkan kita untuk menjalankan program dari bahasa lain, FFI sangatlah berguna karna kita dapat mengimplementasikan sebuah fungsi yang tidak dapat dilakukan di bhs program yang saat ini kita pakai contohnya adalah memanggil fungsi dari library cURL atau SDL.

## Tujuan Menggunakan FFI

---

salah satu tujuanya adalah bahasa program yang kita pakai kadang tidak memiliki suatu fungsi yang sesuai maka kita bisa menggunakan / memanggilnya ke dalam program melalui FFI atau kita bisa dengan mudah melakukan atau mengimplementasikan suatu algoritma dalam bahasa lain.

tapi perlu diperhatikan beberapa FFI memiliki kekuranganya sendiri, contohnya di bahasa program Java kita bisa menggunakan FFI dengan menggunakan JNI (Java Native Interface), program yang dibuat dengan JNI tidak akan mendapat kelebihan dari bahasa yang berjalan di JVM, contoh lainya bahasa Rust, karna Rust merupakan bahasa yang sangat mementingkan keamanan memori jika kita memanggil FFI dari bahasa C maka kita tidak akan mendapatkan kelebihanya.

## Contoh penggunaan FFI

---

Biasanya FFI akan memanggil menggunakan bahasa C, meskipun kita bisa menggunakan C++ atau bahasa lain, biasanya FFI hanya akan menerima kode assembly dengan notasi dari bahasa C

### Haskell

saya akan membuatakan sebuah contoh pemanggilan fungsi dari bahasa c ke bahasa haskell, pertama-tama saya akan membuat dua buah file yang bernama ```Main.hs``` dan ```Cbits.c```.

seperti inilah isi dari file ```Cbits.c```

```c
#include <stdio.h>
#include <stdlib.h>

void print_something(){
    printf("testing FFI on Haskell\n");
}

int* testing_mem()
{
    int *p = (int*) malloc(sizeof(int));
    *p = 10;
    printf("the number is %d \n", *p);
    return p;
}

int cmain()
{
    int x;
    printf("please input some number : ");
    scanf("%d", &x);
    printf("the input number is %d \n", x);
    return 0;
}
```

dan file ```Main.hs``` akan berisi

```haskell
{-# LANGUAGE ForeignFunctionInterface #-}

import Foreign.Ptr ( Ptr )
import Foreign.Storable ( Storable(peek) )
import Foreign.Marshal.Alloc ( free )
import Foreign.C.Types ( CInt(..) )

foreign import ccall "print_something" c_print_something :: IO ()
foreign import ccall "testing_mem" c_testing_mem :: IO (Ptr CInt)
foreign import ccall "cmain" c_main :: IO CInt

test :: IO CInt
test = do c_main

main :: IO ()
main = do
    _ <- c_print_something
    ptr <- c_testing_mem
    x <- peek ptr
    free ptr
    c_main
    putStr ""
```

untuk mengkompilasinya kita bisa menggunakan perintah GHC seperti ini :

```sh
ghc -o main Main.hs Cbits.c
```

opsi ``-o`` disini agar hasil kompilasinya bernama ```main```

dalam beberapa kasus kita mungkin memanggil sebuah library yang dipakai di bahasa C, kita bisa melakukanya dengan opsi ```-l<nama library>``` contohnya jika saya ingin menggunakan library cURL saya saya hanya perlu menjalankan perintah :

```sh
ghc -o main Main.hs Cbits.c -lcurl
```

bisa dilihat dalam program C saya membuat 3 buah fungsi, fungsi untuk mencetak sebuah string ke layar, fungsi yang didalamnya terdapat pointer yang berisi address memori yang teralokasikan dan juga fungsi yang mengambil sebuah input lalu mencetaknya, semua yang saya panggil bisa berjalan dengan lancar di dalam bahasa Haskell, dari sini kita bisa membuat sebuah program yang lebih fleksibel karna memiliki kelebihan dari kedua bahasa yang berbeda.

selain menggunakan fungsi yang kita buat kita juga mampu memanggil fungsi yang berasal dari header system, contohnya saya bisa menggunakan printf dalam haskell dengan mengimport ```stdio.h``` seperti ini :

```haskell
{-# LANGUAGE CApiFFI #-}

import Foreign.C.String ( CString, withCString )

foreign import capi "stdio.h printf" c_printf :: CString -> IO ()

printf :: String -> IO ()
printf x = withCString x c_printf

main :: IO ()
main = printf "Hello world \n"
```

### Racket

dalam racket kita juga bisa langsung memanggil librari yang kita mau, sebagai contoh kita bisa memanggil ```libc``` lalu kita bisa jalankan langsung di racketnya, contohnya seperti ini :

```scheme
#lang racket

(require ffi/unsafe)

(define libc
  (ffi-lib "libc.so.6"))

(define printf
  (get-ffi-obj "printf" libc
    (_fun _string -> _void)))

(printf "Hello Worlds\n")
```

kita juga bisa memanggil dari c program yang kita buat, tetapi kita harus membuat shared object terlebih dahulu, untuk membuat shared library kita bisa menggunakan perintah gcc :

```sh
gcc -shared -fpic -o <nama-output>.so <nama-source>.c
```

cara memanggilnya sama dengan sebelumnya

## Daftar Pustaka

---

- Haskell Wiki  
↪ [Foreign Function Interface](https://wiki.haskell.org/Foreign_Function_Interface)  

- Wikipedia  
↪ [Foreign function interface](https://en.wikipedia.org/wiki/Foreign_function_interface)  

- Racket Docs  
↪ [The Racket Foreign Interface](https://docs.racket-lang.org/foreign/index.html)  

- Fire Salamander Photo  
↪ [by William Warby](https://www.flickr.com/photos/26782864@N00/7129150359)  
