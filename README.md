1|# 🔥 Install Hermes Agent di Termux
2|
3|Satu perintah untuk install AI assistant di HP Android kamu.
4|
5|---
6|
7|## 📱 Apa yang Dibutuhkan
8|
9|- HP Android (minimal Android 7)
10|- **Termux** — install dari [F-Droid](https://f-droid.org/packages/com.termux/)
11|- **API Key** — bisa gratis, lihat bagian bawah
12|
13|> ⚠️ Jangan install Termux dari Play Store. Sudah usang dan banyak bug.
14|
15|---
16|
17|## 🚀 Install (Satu Baris)
18|
19|### Persiapan
20|
21|Sebelum install, update package Termux dulu secara manual:
22|
23|```
24|pkg update -y && pkg upgrade -y
25|```
26|
27|Tunggu sampai selesai. Jika muncul prompt seperti `default=N?`, ketik **N** lalu Enter.
28|
29|### Mulai Install
30|
31|Buka Termux, copy-paste ini:
32|
33|```
34|curl -fsSL https://raw.githubusercontent.com/nayeon-agent/hermes-termux-installer/main/install.sh | bash
35|```
36|
37|Installer akan otomatis:
38|
39|1. Install wget, curl, proot-distro, git
40|2. Install Ubuntu
41|3. Install Hermes Agent
42|4. Verifikasi instalasi
43|
44|---
45|
46|## ⚙️ Setup Awal
47|
48|Setelah instalasi selesai:
49|
50|```
51|proot-distro login ubuntu
52|hermes setup
53|```
54|
55|Ikuti langkah-langkahnya:
56|
57|- Pilih **Full Setup**
58|- Pilih provider yang kamu punya API Key-nya
59|- Masukkan Base URL dan API Key
60|- Terminal backend: **Keep current (local)**
61|- Platforms: centang yang ingin dipakai (spasi = centang)
62|- Tools: biarkan default atau sesuaikan
63|- Ikuti sisanya sampai selesai
64|
65|---
66|
67|## 🆓 API Key Gratis
68|
69|| Nama | Link |
70||------|------|
71|| Ollama | https://ollama.com |
72|| OrcaRouter | https://www.orcarouter.ai/playground |
73|| Zyloo | https://zyloo.io/dashboard/free-balance |
74|| Aerolink | https://aerolink.lat/dashboard |
75|
76|---
77|
78|## 🏃 Perintah Sehari-hari
79|
80|```
81|proot-distro login ubuntu   # Masuk ke Ubuntu
82|hermes                       # Mulai Hermes (CLI)
83|hermes gateway               # Mode multi-platform (Telegram, Discord, dll)
84|hermes version               # Cek versi
85|hermes doctor                # Cek kesehatan
86|hermes doctor --fix          # Perbaiki otomatis
87|```
88|
89|---
90|
91|## 🛠️ Masalah Umum
92|
93|**"command not found: hermes"**
94|```
95|source ~/.bashrc
96|```
97|
98|**"proot-distro: command not found"**
99|```
100|pkg install proot-distro
101|```
102|
103|**Ubuntu gagal install**
104|```
105|termux-setup-storage
106|```
107|
108|---
109|
110|## 📖 Referensi
111|
112|- [Dokumentasi Hermes Agent](https://hermes-agent.nousresearch.com/docs)
113|- [Panduan Original](https://github.com/vay-sys/hermes)