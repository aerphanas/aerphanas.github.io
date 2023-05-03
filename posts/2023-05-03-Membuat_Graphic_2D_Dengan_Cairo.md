---
title: Membuat Graphic 2D Dengan Cairo
author: aerphanas
desc: membuat gambar 2D menggunakan librari cairo dengan bahasa program yang memiliki bindingnya seperti bahasa Rust, Haskell dan Common Lisp
image: membuat-graphic-2d-dengan-cairo-fig1.png
---

![Pyramid photo from jooinn](/images/membuat-graphic-2d-dengan-cairo-fig1.png "Pyramid photo from jooinn")

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Rust](#rust)
- [Haskell](#haskell)
- [Common Lisp](#common-lisp)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

cairo merupakan sebuah open source graphic library yang menyediakan graphic vector atau sebuah cara membuat gambar menggunakan bentuk-bentuk geometri seperti poin, garis, lengkukan dan polygon, cairo di buat menggunakan bahasa c tetapi kita dapat menggunakanya pada bahasa lain dengan bantuan FFI, namun kita tidak langsung menggunakan FFI melainkan mengggunakan binding yang sudah disediakan, dan dalam post ini saya akan memperkenalkan cara menggunakan cairo dalam bahasa program Rust, Haskell dan Common Lisp

## Rust

---

sebelum saya melanjutkan post ini saya ingin menjelaskan bahwa Materi dalam blog atau artikel ini belum ditinjau, didukung, atau
disetujui oleh Rust Foundation. Untuk informasi lebih lanjut silakan klik link yang ada di Daftar Pustaka.

disini saya akan mengasumsikan bahwa pembaca post ini sudah menginstall Rust menggunakan rustup, langsung saja kita akan membuat project baru menggunakan cargo

```sh
cargo new cairo_test
```

disini saya membuat project bernama cairo_test, setelah itu kita akan menambah dependensi cairo menggunakan command cargo

```sh
cargo add cairo-rs
```

agar kita bisa mengimport hasil gambar kita ke file `png` kita harus menambahkan fitur png ke cairo-rs

```sh
cargo add cairo-rs --features png
```

lalu  kita bisa mengimportnya di dalam file main.rs kita

```rust
use cairo::{FontSlant, FontWeight, Format, ImageSurface};
```

untuk membuat sebuah graphic menggunakan cairo, pertama-tama kita membuat sebuah ImageSurface dan sebuah Contex

```rust
let surface = ImageSurface::create(Format::Rgb24, 512, 512).unwrap();
let cr = cairo::Context::new(&surface).unwrap();
```

setelah itu kita bisa bebas menggambar sesuai keinginan kita.
kita bisa mengubah background dengan menambahkan

```rust
cr.set_source_rgb(1.0, 1.0, 1.0);
cr.paint().unwrap();
```
dalam cairo nilai warna menggunakan desimal dari 0.0 sampai 1.0, maka jika kita ingin mengubah warna kita harus melakukan konversi terlebih dahulu yaitu dibagi dengan 255.

kita juga bisa mencetak sebuah text di Contex dan menseting fontnya

```sh
cr.set_source_rgb(0.0, 0.0, 0.0);
cr.select_font_face("Fira Code", FontSlant::Normal, FontWeight::Normal);
cr.set_font_size(100.0);
cr.move_to(50.0, 225.0);
cr.show_text(".Hello").unwrap();
```
kode diatas akan mencetak text Hello yang memiliki font 100, kordinat awal 50 dan 225 dengan font `Fira Code`

setelah itu kita bisa menginmportnya ke dalam png dengan kode

```sh
let mut file = File::create("example.png").unwrap();
surface.write_to_png(&mut file).unwrap();
```
lalu kita bisa menjalankanya, jika tidak ada error file `example.png` akan terbuat

```sh
cargo run
```
cargo-rs merupakan sebuah project anak dari gtk-rs karna itulah kita bisa menggunakanya dengan mudah di dalam sebuah project gtk, kita hanya perlu menggunakan Drawing Area, seperti ini contohnya

```sh
let drawing = DrawingArea::builder().build();

drawing.set_draw_func(|_, cr, _, _| {
  cr.set_source_rgb(1.0, 1.0, 1.0);cr.paint().unwrap();

  cr.set_source_rgb(0.0, 0.0, 0.0);
  cr.select_font_face("Fira Code", FontSlant::Normal, FontWeight::Normal);
  cr.set_font_size(100.0);
  cr.move_to(50.0, 225.0);
  cr.show_text(".Hello").unwrap();

  cr.set_source_rgb(100.0, 0.0, 100.0);
  cr.select_font_face("Fira Code", FontSlant::Normal, FontWeight::Normal);
  cr.set_font_size(100.0);
  cr.move_to(100.0, 250.0);
  cr.show_text(".Void").unwrap();
});
```

## Haskell

---

haskell juga memiliki cairo binding yang dapat kita gunakan seperti cairo-rs, disini saya asumsikan bahwa pembaca sudah menginstall haskell dan cabal melalui ghcup, maka langsung saja kita bisa membuat project terlebih dahulu menggunakan cabal

```sh
mkdir cairosh; cd cairosh; cabal init
```

lalu kita bisa langsung menambahkan dependensi dengan mengedit file cabal karna nama project kita `cairosh` maka nama file cabal kita adalah `cairosh.cabal`, perlu diingat sebelum menambahkan dependensi kita harus melihat package yang ingin kita tambah dengan pergi ke hackage lalu melihat versi base berapa yang di support, saat postingan ini dibuat cairo versi terbaru adalah 0.13.8.2 dengan base versi base (>=4.8 && <5) yang artinya kita bisa memakai di base 4.8.x.x sampai 4.9.9 (dibawah versi 5)

```sh
executable cairosh
     main-is:          Main.hs
     build-depends:    base ^>=4.16.4.0,
                       cairo == 0.13.*

     hs-source-dirs:   app
     default-language: Haskell2010
```

setelah itu kita bisa mengimportnya kedalam `Main.hs`

```haskell
import qualified Graphic.Rendering.Cairo as CR
```

dalam program haskell yang pertama kali kita buat adalah sebuah fungsi, disini kita akan membuat gambar dan mengeksportnya ke dalam sebuah pdf, sebelum itu ayo kita lihat type signature fungsi `withPDfSurface`

```haskell
withPDFSurface :: FilePath -> Double -> Double -> (Surface -> IO a) -> IO a
```
bisa dilihat bahwa fungsi ini memerlukan sebuah filepath (nama file output) sebuah panjang, lebar dan sebuah fungsi yang mengambil Surface yang menghasilkan side effect

sebelum mengisi fungsi ini kita akan membuat fungsi yang memiliki type signature `(Surface -> IO a)`

```haskell
surfaceDo :: CR.Surface -> IO ()
surfaceDo surface = CR.renderWith surface $ do
  CR.setSourceRGB 0 0 0
  CR.setLineWidth 2
  CR.arc x y radius 0 (2 * pi)
  CR.stroke
  where radius = 100
        x = 150
        y = x
```

disini kita menggunakan sebuah notasi `do` agar terlihat lebih rapih, setelah kita membuat fungsi ini kita hanya perlu mengisi fungsi `withPDfsurface`, disini saya akan membuat fungsi baru agar dapat dipanggil ke dalam fungsi main

```haskell
createPdf :: IO ()
createPdf = CR.withPDFSurface filePath width height surfaceDo
  where filePath = "lingkaran.pdf"
        width = 300
        height = 300
```

lalu kita dapat memamggilnya ke dalam fungsi main, yang nanti akan dijalankan ketika program kita berjalan

```haskell
main :: IO ()
main = createPdf
```

setelah itu kita bisa menjalankanya dengan `cabal run`, dan akan terbuat sebuah file pdf bernama `lingkaran.pdf` kita bisa membukanya dengan pdf reader biasa

## Common Lisp

---

salah satu bahasa program favorit saya tentu saja juga memiliki binding cairo, di common lisp binding cairo bernama `cl-cairo2` kita bisa menginstallnya menggunakan quicklisp, silakan pergi ke halaman quicklisp jika belum terinstall, kita juga memerlukan `roswell` yang ditujukan untuk mempermudah kita, silakan pergi ke situsnya jika belum terinstall.

kita akan membuat sebuah project menggunakan roswell dengan `lispsy` sebagai nama project

```sh
ros init lispsy
```

setelah itu akan akan ada file baru bernama `lispsy.ros` yang kita bisa jalankan seperti script-script bash lain `./lispsy.ros`, langsung saja pada bagian awal kita harus menambahkan package yang ingin kita gunakan

```lisp
(progn ;;init forms
  (ros:ensure-asdf)
  #+quicklisp(ql:quickload '(cl-cairo2) :silent t))
```

karna kita akan menggunakan `cl-cairo` kita bisa menambahkan kode seperti ini

```lisp
(defpackage :ros.script.calro.3890699335
  (:use :cl :cl-cairo2))
(in-package :ros.script.calro.3890699335)
```

setiap `ros` membuat project baru maka akan otomatis membuat nama package, jadi sesuaikanlah sesuai nama kode kalian, masih ingatkah bahwa cairo menggunakan warna dari 0.0 samapai 1.0 karna itu kita harus mengkonversi nilai warna, namun kita bisa dengan mudah membuat macro untuk mengatasinya

```lisp
(defmacro hex-to-rgb (hex)
  `(let ((r (/ (parse-integer (subseq ,hex 1 3) :radix 16) 255.0))
         (g (/ (parse-integer (subseq ,hex 3 5) :radix 16) 255.0))
         (b (/ (parse-integer (subseq ,hex 5 7) :radix 16) 255.0)))
     (set-source-rgb r g b)))
```

dengan macro diatas kita hanya perlu memasukan kode warna seperti `#3b4252` maka akan otomatis mengubahnya ke dalam format yang didukung cairo.

dalam binding `cl-cairo2` kita tidak perlu membuat Surface atau Contex, kita bisa langsung memmakai fungsi `with-png-file`

```lisp
(with-png-file ("output.png" :rgb24 wh wh)
  (hex-to-rgb "#051d34")
  (paint)

  (hex-to-rgb "#f9b119")
  (let ((center (- (/ wh 2) 150)))
    (let ((hw (+ center 200)))
  (rectangle center center hw hw)))
  (fill-path)

  (move-to (/ wh 2) (/ wh 2))
  (hex-to-rgb "#000000")
  (select-font-face "Fira Code" :normal :bold)
  (set-font-size 20)
  (show-text "Hello World"))
```

> semua kode dalam blog ini bisa kalian liat di Github saya

## Daftar Pustaka

---

- Rust Foundation  
→ [Rust Foundation](https://foundation.rust-lang.org/)

- Wikipedia  
→ [Cairo (Graphic)](https://en.wikipedia.org/wiki/Cairo_%28graphics%29)

- Aerphanas  
→ [Foreign function interface](https://aerphanas.github.io/posts/2023-02-24-Foreign_Function_Interface.htmlxs)

- Github  
→ [gtk-cairo-rs](https://github.com/aerphanas/gtk-cairo-rs)  
→ [cairo-animate](https://github.com/aerphanas/cairo-animate)  
→ [cl-cairo-example](https://github.com/aerphanas/cl-cairo-example)  
→ [cl-cairo](https://github.com/rpav/cl-cairo2)  

- gtk-rs  
→ [home pake](https://gtk-rs.org/)  
→ [gtk-rs-core](https://gtk-rs.org/gtk-rs-core/)

- hackage  
→ [cairo](https://hackage.haskell.org/package/cairo)  

- Quicklisp  
→ [quicklisp beta](https://www.quicklisp.org/beta/)  

- Roswell  
→ [home page](https://roswell.github.io/)  

- Jooinn  
→ [Pyramids](https://jooinn.com/pyramids-3.html) 
