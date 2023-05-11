---
title: Membuat GUI GTK dengan gtk-rs
author: aerphanas
desc: perkenalan bagaimana cara membuat gtk gui menggunakan bahasa Rust dengan gtk-rs yang merupakan sebuah binding untuk GNOME stack
image: membuat-gui-gtk-dengan-gtk-rs-fig1.png
---

![logo gtk-rs sebagai holy grail (karna lebih mudah membuat gtk dengan gtk-rs)](/images/membuat-gui-gtk-dengan-gtk-rs-fig1.png "logo gtk-rs sebagai holy grail (karna lebih mudah membuat gtk dengan gtk-rs)")

## Daftar isi

- [Pendahuluan](#pendahuluan)
- [Membuat Proyek](#membuat-proyek)
- [Membuat gui app](#membuat-gui-app)
- [Daftar Pustaka](#daftar-pustaka)

## Pendahuluan

---

sebelum saya melanjutkan post ini saya ingin menjelaskan bahwa Materi dalam blog atau artikel ini belum ditinjau, didukung, atau disetujui oleh Rust Foundation. Untuk informasi lebih lanjut silakan klik link yang ada di Daftar Pustaka.

gtk-rs merupakan sebuah binding safe untuk GNOME stack untuk bahasa program Rust, yang dimaksud dengan GNOME stack adalah, gtk-rs memberikan dukungan untuk GLib, Cairo, GTK3 dan GTK4, dan di post kali ini saya ingin memperkenalkan cara membuat gtk app sederhana, karna untuk membuat gtk app kita bisa menggunakan 2 cara yaitu composite template dan menulis secara langsungg, karna composite template lebih rumit daripada mengetik kode langsung, kita akan menggunakan cara kedua, yaitu menggetik langsung.

jika pembaca ingin mendalami cara membuat gtk4 atau mungkin membuat GNOME app, saya rekomendasikan membaca "The introductory book" yang ada di web gtk-rs

## Membuat Proyek

---

sebelum kita mengetik sebuah kode kita akan membuat proyek dengan cargo, dalam post ini saya asumsikan pembaca sudah menginstall Rust toolchain melalui rustup dan mengerti dasar-dasar programming dalam bahasa Rust,

```sh
cargo new gtk-test
```

setelah itu kita menambahkan dependensi pada proyek kita

```sh
cargo add gtk4 --rename gtk --features v4_8
```

opsi `--rename` disini, kita akan mengubah nama dependensi menjadi nama `gtk` lalu kita menggunakan opsi `--features` agar kita bisa menggunakan API GTK versi 4.8

## Membuat gui app

---

untuk memulai membuat gtk app kita membuka file `app.rs`, urutan untuk membuat sebuah applikasi gui gtk adalah membuat app lalu membuat window, untuk membuat app kita akan menambahkan kode ini ke dalam fungsi main, namun sebelum itu dalam gtk app atau gnome app kita memerlukan app id, kita bisa menseting APP id sedagai constan

```rust
const APP_ID: &str = "io.github.aerphanas";
```

lalu kita bisa menambah kode dibawah

```rust
fn main() -> glib::ExitCode {
    let app = Application::builder().application_id(APP_ID).build();
    app.connect_activate(build_ui);
    app.run()
}
```

dari kode diatas kita menggunakan sebuah design pattern OOP builder untuk membuat aplikasi lalu kita menambahkan sebuah APP_ID untuk memberitahukan bahwa applikasi kita id "io.github.aerphanas", setelah itu kita akan menambahkan sebuah fungsi yang akan di jalankan saat membuat applikasi, dalam hal ini kita akan memberikan sebuah fungsi yangg akan menghasilkan sebuah window, seperti inilah fungsi yang kita berikan

```rust
fn build_ui(app: &Application) {
    let button_res: Button = Button::builder().label("Hello").build();

    let window: ApplicationWindow = ApplicationWindow::builder()
        .application(app)
        .title("Hello")
        .child(&button_res)
        .build();

    window.present();
}
```

di fungsi ini kita membuat sebuah tombol yang memiliki sebuah label `Hello` kemudian kita membuat sebuah window denggan title `Hello` yang memiliki anak button, yang di maksud anak disini adalah bahwa variable `button_res` akan berada didalam window, setelah itu kita menampilkan window dengan method `present()` setelah itu kita bisa menjalankan dengan perintah

```rust
cargo run
```

setelah dijalankan, sebuah jendela akan muncul namun ketika mengklik tombol `Hello` tidak terjadi apa-apa, karna kita tidak mengimplementasikan apa yang terjadi saat kita mengklik tombol, sebelum mengimplementasikanya kita bisa melihat dokumentasi `gtk-rs`, bila kita lihat dokumentasi `gtk4::button`, `gtk4::button` mengimplementasikan trait `ButtonExt` dimana terdapat fungsi `connect_clicked` yang dalam dokumentasi artinya `Emitted when the button has been activated (pressed and released).` atau `lakukan sesuatu jika tombol ditekan dan dilepaskan`, fungsi ini memiliki signature

```rust
fn connect_clicked<F: Fn(&Self) + 'static>(&self, f: F) -> SignalHandlerId
```

dalam signature tersebut fungsi `connect_clicked` mengambil sebuah fungsi lalu mengembalikan sebuah signalhandlerid, dalam hal ini kita bisa membuat sebuah fungsi atau sebuah closure atau fungsi lambda, sebagai contoh disini kita bisa mencoba membuat jika tombol ditekan akan menampilkan sebuah pesan di terminal, deklarasi fungsi ini harus dilakukan sebelum membuat variable window

```rust
button_res.connect_clicked(|_| println!("hello world"));
```

setelah itu kita bisa jalankan program kita, dan jika kita mengklik tombol berlabel `Hello` kita akan melihat `hello world` dalam terminal, kita bisa melihat semua fungsi yang diberikan `gtk-rs` di dokumentasi, janganlah khawatir dokumentasi `gtk-rs` sangatlah rapih, jika kalian mengerti bahasa Rust maka akan dengan mudah membuat gtk app dengan `gtk-rs`.

> jika ingin mendalami cara membuat gtk app atau mungkin gnome app saya sarankan untuk membaca tutorial berjudul "GUI development with Rust and GTK 4" yang ditulis oleh Julian Hofer, tutorial tersebut bisa kalian temukan di website gtk-rs

## Daftar Pustaka

---

- Rust Foundation  
→ [Rust Foundation](https://foundation.rust-lang.org/)

- gtk-rs  
→ [Home Page](https://gtk-rs.org/)

- rustup  
→ [Home Page](https://rustup.rs/)

- cargo  
→ [gtk4](https://crates.io/crates/gtk4)

-  GUI development with Rust and GTK 4, by Julian Hofer  
→ [introduction](https://gtk-rs.org/gtk4-rs/stable/latest/book/)
