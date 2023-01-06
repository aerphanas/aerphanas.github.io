---
title: Ada Apa Dengan Paradigma Fungsional
author: aerphanas
desc: Paradigma fungsional adalah sebuah cara lain dalam menyelesaikan masalah dengan hanya menggunakan fungsi, berbeda dengan paradigma object oriented dan imperatif.
image: ada-apa-dengan-fungsional-programming-fig1.png
---

![orang yang berasal dari gerbang ivory. oleh Lefteris Papaulakis](/images/ada-apa-dengan-fungsional-programming-fig1.png "orang yang berasal dari gerbang ivory. oleh Lefteris Papaulakis")

## Daftar Isi

- [Pendahuluan](#pendahuluan)
  - [Perbedaan dengan oop](#perbedaan-dengan-oop)
  - [Kelebihan Functional Programming](#kelebihan-functional-programming)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

Paradigma Fungsional adalah sebuah alternatif dari OOP (Object Oriented Programming), perbedaannya adalah bila oop semuanya adalah object maka di fungsional semuanya adalah fungsi.

pada dahulu bahasa komputer terbagi menjadi 2, yaitu bahasa berbasis mesin turing dan yang satunya berbasis lambda kalkulus, cara kerja turing machine adalah memodifikasi sesuatu dan menghasilkan efek samping (side effect) sedangkan program berbasis lamba kalkulus tidak melakukan mutasi terhadap variable.

tapi karna bahasa fungsional tidak dapat mengubah sesuatu maka dibuatlah sebuah solusi, diantaranya adalah menggunakan monad.

## Perbedaan Dengan OOP

---

kita bisa liat perbedan antara oop dengan fungsionalnya dengan jelas pada tabel dibawah

| OOP Pattern/Principle               | Fungsional                |
| ----------------------------------- | ------------------------- |
| Single Responsibility Principle     | Functions                 |
| Open/Closed Principle               | Functions                 |
| Dependency Inversion Principle      | Functions, also           |
| Interface Segregation Principle     | Functions                 |
| Factory Pattern                     | You will be assimilated ! |
| Strategy Pattern                    | Function again            |
| Decorator Pattern                   | Functions                 |
| Visitor Pattern                     | Resistance is futile!     |

## Kelebihan Functional Programming

---

di paradigma fungsional tidak ada yang namanya design principle atau pattern semuanya adalah fungsi, adapun kelebihan fungsional programming adalah

### first-class dan higher-order function

yang dimaksud high-order fungsi adalah bahwa fungsi dapat menjadi sebuah input untuk fungsi lain, sedangkan first-class adalah bahwa status fungsi sama dengan data yang lainya.

contoh dalam bahasa racket (lisp dialects family) seperti ini :

```scheme
#lang racket

; fungsi yang mengambil 1 input dan mengeluarkan 1 output
(define (return x)
  x)

; fungsi yang mengambil 2 input dan mengeluarkan 1 output
(define (add x y)
  (+ x y))

; fungsi yang mengambil 2 fungsi menjadi 1
(define add2 (return add))
```

### pattern matching

di fungsional programming ada sebuah fungsi yang mirip dengan ```switch case``` seperti bahasa Java atau C++

contoh dalam bahasa haskell :

```haskell
doEncAlg::Int -> Int -> Int -> Int
doEncAlg a b x
    | DC.isAlpha . DC.chr $ x = doMath + initChar
    | otherwise               = x
    where
        initChar = if DC.isUpper $ DC.chr x then 65 else 97
        numChar  = x - initChar
        doMath   = (a * numChar + b) `mod` 26
```

dalam haskell pattern matching biasanya digunakan untuk monad.

### type system

type system atau tipe sistem adalah cara untuk menentukan jenis-jenis nilai yang diizinkan dalam bahasa pemrograman dan operasi yang diizinkan untuk dilakukan pada nilai-nilai tersebut. Dalam bahasa pemrograman fungsional, sistem tipe merupakan alat yang penting untuk memastikan kebenaran dari program dan mengijinkan compiler untuk menangkap kesalahan pada saat compile, bukan membiarkan kesalahan tersebut muncul sebagai runtime error.

contohnya adalah kode haskell diatas

```haskell
doEncAlg::Int -> Int -> Int -> Int
```

yang artinya adalah bahwa fungsi ```doEncAlg``` menerima 3 variable bertipe integer dan memberikan output integer, type system seperti ini sangatlah membantu, karna error akan terjadi pada compile time (waktu kompilasi) dan bukan pada runtime time (waktu saat kode dijalankan), disini juga membuat kita bisa tau dengan mudah mengenai fungsi ini.

### data structure

dalam fungsional programming terdapat kelebihan daripada paradigma yang lain, diantaranya :

- Presisten: semua data dalam fungsional programming berupa immutable atau tidak dapat diubah, keuntungaanya adalah kita tidak perlu memikirkan tentang efek samping atau urutan operasi yang dilakukan.
- Concurrency: karna data bersifat Immutable maka kita dapat dengan aman membaginya antar thread sehingga kita dengan mudah membuat program concurrent.
- Modular: karna adanya first-class dan higher-order function kita dengan mudah dapat membagi beberapa program terpisah, dan juga dapat mengikuti filosofi UNIX

### REPL

repl merupakan singkatan dari Read Evaluate Print Loop, kelebihan ini hampir mirip dengan bahasa python, lua atau ruby, REPL sendiri pertama kali ada pada bahasa program LISP, yang pada saat itu sangatlah berguna karna programmer bahasa yang lain sibuk memperbaiki kodenya (debugging) seorang lisp programmer lebih fokus pada masalah, namun pada saat itu REPL tidak secepat saat ini.

### lazy evaluation dan Partial application

bahasa program fungsional biasanya bersifat lazy evaluation yang artinya adalah REPL tidak akan menjalankan kodenya jika tidak kita tidak memerlukan outputnya sehingga memori yang dipakai bisa optimal.

sedangkan partial application adalah kita bisa menggunakan sebuah fungsi yang mengambil 2 input tetapi kita bisa memberinya 1 setelah itu kita dapat memberinya lagi, berkat adanya lazy evaluation maka tidak akan ada error.

contoh kodenya dalam bahasa haskell :

```haskell
add :: Int -> Int -> Int
add x y = x + y

add10 :: Int -> Int
add10 = add 10
```

diatas bisa dijelaskan bahwa fungsi add mengambil 2 input dan memberikan 1 output, tetapi kita bisa memanfaatkan lazy evaluate dan partial application seperti fungsi ```add10``` yang hanya memerlukan 1 input.

## Daftar Pustaka

---

- Youtube  
↪ [Functional Design Patterns - Scott Wlaschin](https://youtu.be/srQt1NAHYC0)  

- Haskell  
↪ [Homepage](https://haskell.org)

- Racket  
↪ [Homepage](https://racket-lang.org)

- Practical Adult Insights  
↪ [What is an Ivory Tower?](https://www.practicaladultinsights.com/what-is-an-ivory-tower.htm)