# 🔥 Install Hermes Agent di Termux

Satu perintah untuk install AI assistant di HP Android kamu.

---

## 📱 Apa yang Dibutuhkan

- HP Android (minimal Android 7)
- **Termux** — install dari [F-Droid](https://f-droid.org/packages/com.termux/)
- **API Key** — bisa gratis, lihat bagian bawah

> ⚠️ Jangan install Termux dari Play Store. Sudah usang dan banyak bug.

---

## 🚀 Install (Satu Baris)

Buka Termux, copy-paste ini:

```
curl -fsSL https://raw.githubusercontent.com/nayeon-agent/hermes-termux-installer/main/install.sh | bash
```

Tunggu sampai selesai (~5-15 menit). Installer akan otomatis:

1. Update Termux
2. Install wget, curl, proot-distro, git
3. Install Ubuntu
4. Install Hermes Agent
5. Verifikasi instalasi

---

## ⚙️ Setup Awal

Setelah instalasi selesai:

```
proot-distro login ubuntu
hermes setup
```

Ikuti langkah-langkahnya:

- Pilih **Full Setup**
- Pilih provider yang kamu punya API Key-nya
- Masukkan Base URL dan API Key
- Terminal backend: **Keep current (local)**
- Platforms: centang yang ingin dipakai (spasi = centang)
- Tools: biarkan default atau sesuaikan
- Ikuti sisanya sampai selesai

---

## 🆓 API Key Gratis

| Nama | Link |
|------|------|
| Ollama | https://ollama.com |
| OrcaRouter | https://www.orcarouter.ai/playground |
| Zyloo | https://zyloo.io/dashboard/free-balance |
| Aerolink | https://aerolink.lat/dashboard |

---

## 🏃 Perintah Sehari-hari

```
proot-distro login ubuntu   # Masuk ke Ubuntu
hermes                       # Mulai Hermes (CLI)
hermes gateway               # Mode multi-platform (Telegram, Discord, dll)
hermes version               # Cek versi
hermes doctor                # Cek kesehatan
hermes doctor --fix          # Perbaiki otomatis
```

---

## 🛠️ Masalah Umum

**"command not found: hermes"**
```
source ~/.bashrc
```

**"proot-distro: command not found"**
```
pkg install proot-distro
```

**Ubuntu gagal install**
```
termux-setup-storage
```

---

## 📖 Referensi

- [Dokumentasi Hermes Agent](https://hermes-agent.nousresearch.com/docs)
- [Panduan Original](https://github.com/vay-sys/hermes)