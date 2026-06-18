# Install Hermes Agent di Termux

Install Hermes Agent di HP Android dengan satu perintah.

---

## Yang Dibutuhkan

- HP Android (Android 7+)
- Termux ([install dari F-Droid](https://f-droid.org/packages/com.termux/))
- API Key (lihat bagian bawah untuk yang gratis)

> Jangan install Termux dari Play Store. Versi di Play Store sudah outdated.

---

## Persiapan

Buka Termux, jalankan ini dulu:

```
pkg update -y && pkg upgrade -y
```

Kalau muncul prompt `default=N?`, ketik **N** lalu Enter.

---

## Install

Copy-paste satu baris ini di Termux:

```
curl -fsSL https://raw.githubusercontent.com/nayeon-agent/hermes-termux-installer/main/install.sh | bash
```

Tunggu sampai selesai. Installer otomatis:

1. Install wget, curl, proot-distro, git
2. Install Ubuntu
3. Install Hermes Agent
4. Verifikasi

---

## Setup Awal

```
proot-distro login ubuntu
hermes setup
```

Ikuti langkah-langkahnya:

- Pilih **Full Setup**
- Pilih provider yang punya API Key
- Masukkan Base URL dan API Key
- Terminal backend: **Keep current (local)**
- Centang platform yang mau dipakai (tekan spasi)
- Centang tools yang mau dipakai
- Ikuti sisanya sampai selesai

---

## API Key Gratis

- **Ollama** — https://ollama.com
- **OrcaRouter** — https://www.orcarouter.ai/playground
- **Zyloo** — https://zyloo.io/dashboard/free-balance
- **Aerolink** — https://aerolink.lat/dashboard

---

## Perintah Dasar

```
proot-distro login ubuntu    Masuk ke Ubuntu
hermes                       Jalankan Hermes (CLI)
hermes gateway               Jalankan sebagai gateway (Telegram, Discord, dll)
hermes version               Cek versi
hermes doctor                Cek kesehatan sistem
```

---

## Kalau Error

**hermes: command not found**
```
source ~/.bashrc
```

**proot-distro: command not found**
```
pkg install proot-distro
```

**Ubuntu gagal install**
```
termux-setup-storage
termux-change-repo
```

---

## Referensi

- [Dokumentasi Resmi Hermes Agent](https://hermes-agent.nousresearch.com/docs)
- [Panduan Original](https://github.com/vay-sys/hermes)
