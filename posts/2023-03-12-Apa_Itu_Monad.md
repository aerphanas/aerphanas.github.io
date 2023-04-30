---
title: Apa itu Monad
author: aerphanas
desc: monad adalah monoid dalam kategori endofunctors, sebuah kata-kata yang membingungkan, tetapi dalam post ini akan di jelaskan arti sebenarnya apa itu monad
image: apa-itu-monad-fig1.png
---

![Haskell Red Noise](/images/apa-itu-monad-fig1.png "haskell red noise")

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Monad](#monad)
  - [Monoid](#monoid)
  - [Category](#category)
  - [Functor](#functor)
  - [EndoFunctor](#endofunctor)
  - [Apa itu Monad](#apa-itu-monad)
- [Contoh dalam Bahasa Program](#contoh-dalam-bahasa-program)
  - [Haskell](#haskell)
  - [Java](#java)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

Monad pertama kali saya dengar ada pada bahasa program yang memiliki paradigma fungsional bersih, yang artinya bahasa yang semuanya adalah imutable atau tidak dapat diubah, disinilah monad sangat berguna dimana kita membuat sebuah state baru dan kita memindakhan state sekarang ke state yang baru tanpa mengubah sebuah state, inilah di bahasa fungsional yang bersih dapat mencetak sebuah huruf/angka di terminal.

## Monad

---

> monad adalah monoid dalam kategori endofunctor, apa masalahnya ?

sebuah kata kata yang diucapkan oleh Philip Wadler saat ditanya apa itu monad dan dalam sebuah buku yang berjudul "Categories for the working mathematician" yang ditulis oleh Saunders Mac Lane di halaman 138 menjelaskan monad,

> "Monad in X is just a monoid in the category of endofunctors of X, with product x replaced by composition of endofunctors and unit set by the identity endofunctor"

atau dalam bahasa indonesia

> "Secara keseluruhan, Monad di X hanyalah Monid dalam Kategori EndoFunctors X, dengan produk x diganti dengan komposisi endofunctors dan unit yang ditetapkan oleh identitas EndoFunctor"

dari pernyataan itu kita harus mebedah satu-satu apa itu monoid, category theory dan endofunctor

### Monoid

monoid adalah Himpunan seperti n = [1, 2, 3..], operasi biner [+, -, *, /] atau himpunan elemen himpunan dan identitas n + 0 = n atau 0 + n = n

contoh lain seperti 1+2+3+4 , ini juga merupakan monoid karna jika kita mengaplikasikan seperti (1+(2+(3+4))) atau (((1+2)+3)+4) maka hasil yang diberikan tetaplah sama.

### Category

category, secara singkat kategori adalah kumpulan dari himpunan, seperti kelas pada Pemrograman Berorientasi Objek, seperti inilah contohnya :

```java
class People {
  private String name;
  private Integer age;

  public void doubleAge() {
    this.age * 2;
  }

  public void minusAge() {
    this.age -= 2;
  }
}
```

### Functor

functor adalah fungsi yang mengambil sebuah kategori ke kategori lainnya

### EndoFunctor

Endo memiliki arti didalam, maka bila digabungkan dengan Functor maka EndoFunctor adalah sebuah fungsi atau category yang mengaplikasikan ke dirinya sendiri

### Apa itu Monad

dari pengertian diatas maka Monad adalah sekumpulan fungsi yang mengubah sekumpulan data. Secara khusus data memiliki struktur yang terdefinisi dengan baik, dan Monad adalah kumpulan fungsi yang memetakan data tersebut ke dalam variasi struktur aslinya melalui komposisi fungsi.

## Contoh dalam Bahasa Program

---

beberapa orang akan mudah memahami dalam bentuk contoh, maka dari itu saya akan memberikan contoh monad dalam bahasa program

### Haskell

di haskell, monad adalah cara untuk mengubah keadaan internal dari beberapa konteks tanpa mengubah konteks itu sendiri

seperti kira-kira inilah kode monad dalam dalam haskell

```haskell
data Context A = ...
return :: A -> COntext A
(>>=) :: Context A -> (A -> Context B) -> Context b
```

bila saya perhatikan dalam logo haskell terdapat sebuah monad yaitu ```>>=```

dalam sebuah ```maybe``` atau ```options``` dalam bahasa lain juga merupakan monad, di haskell seperti inilah bentuk kode dari ```maybe``` :

```haskell
Data Maybe a = Nothing | Just a deriving (Eq, Ord)
instance Monad Maybe where
  Nothing >>= F() = Nothing
  Just val >>= F () = F val
```

seperti yang sudah saya jelaskan sebelumnya haskell dapat mencetak data ke layar dengan bantuan monad, caranya adalah IO membungkus seluruh status program ke dalam konteks tunggal dalam Konteks ini kita tidak memiliki apa pun yang dicetak di layar, lalu kami mendefinisikan fungsi yang membawa konteks kita ke dalam konteks baru atau sesuatu yang dicetak ke layar

seperti ini contohnya cara mencetak sesuatu dilayar :

```haskell
main :: IO ()
main = getLine >>=
    \filename -> readFile filename >>=
    \contents -> putStrLn cintents
```

haskell juga memiliki sebuah syntactic sugar agar kita tidak harus mengetik ```>>=``` dengan menggunakan  ```do``` block, kode diatas dapat ditulis seperti ini :

```haskell
main :: IO ()
main = do
    filename <- getLine
    contets <- readFile filename
    putStrLn contets
```

### Java

semenjak kira-kira versi java 8 keatas java mulai mensupport paradigma fungsional, seperti inilah contohnya :

```java
Array.asList(1,2,3)
    .stream()
    .map(n -> new int[] {n+1, n*2})
    .collect(Collectors.tolist())
```

## Daftar Pustaka

---

- Blogspot  
→ [A Brief, Incomplete, and Mostly Wrong History of Programming Languages](https://james-iry.blogspot.com/2009/05/brief-incomplete-and-mostly-wrong.html)

- Youtube  
→ [Okay but WTF is a MONAD?????? #SoME2](https://www.youtube.com/watch?v=-fKAh4PVKbU)  
→ [A Sensible Introduction to Category Theory](https://www.youtube.com/watch?v=yAi3XWCBkDo&t=922s)  
→ [Functors](https://www.youtube.com/watch?v=Q0WB73fzUXg)  

- Community LYAH  
→ [Community Learn You a Haskell](https://learnyouahaskell.github.io/a-fistful-of-monads.html)  

- Oracle Docs  
→ [Java stream API](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html)  

- Xmobar  
→ [Xmobar tutorial](https://xmonad.org/TUTORIAL.html)  
