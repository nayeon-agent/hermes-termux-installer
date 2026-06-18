1|# 🔥 Hermes Agent — One-Line Installer for Termux
2|
3|Install **Hermes Agent** di HP Android kamu hanya dengan **1 perintah**!
4|
5|---
6|
7|## Apa itu Hermes Agent?
8|
9|Hermes Agent adalah AI assistant yang bisa kamu jalankan langsung dari terminal. Bisa chatting, otomasi tugas, bahkan terhubung ke Telegram, Discord, dan platform lainnya.
10|
11|---
12|
13|## Yang Dibutuhkan
14|
15|Sebelum mulai, pastikan kamu punya:
16|
17|| Kebutuhan | Keterangan |
18||-----------|------------|
19|| 📱 **HP Android** | Minimum Android 7+ |
20|| ⬇️ **Termux** | Install dari F-Droid (bukan Play Store!) |
21|| 🔑 **API Key** | Bisa gratis dari provider di bawah |
22|
23|### Cara Install Termux
24|
25|1. Buka **F-Droid** (bukan Play Store!)
26|2. Cari **"Termux"**
27|3. Install dan buka
28|
29|> ⚠️ **PENTING:** Jangan install Termux dari Play Store karena versinya sudah tidak update dan banyak bug.
30|
31|---
32|
33|## 🚀 Cara Install (One-Line)
34|
35|Buka Termux, lalu **copy-paste** perintah ini:
36|
37|```bash
38|curl -fsSL https://raw.githubusercontent.com/nayeon-agent/hermes-termux-installer/main/install.sh | bash
39|```
40|
41|Tunggu sampai selesai. Proses ini akan:
42|
43|1. ✅ Update Termux
44|2. ✅ Install package yang dibutuhkan (wget, curl, proot-distro, git)
45|3. ✅ Install Ubuntu
46|4. ✅ Install Hermes Agent
47|
48|---
49|
50|## ⚙️ Setup Hermes (Setelah Install)
51|
52|Setelah install selesai, jalankan perintah berikut:
53|
54|```bash
55|proot-distro login ubuntu
56|hermes setup
57|```
58|
59|Saat setup, kamu akan diminta:
60|
61|1. **Pilih mode setup** → Pilih **Full Setup**
62|2. **Pilih provider** → Pilih yang punya API Key
63|3. **Masukkan Base URL** → Sesuai provider
64|4. **Masukkan API Key** → Dari provider yang dipilih
65|5. **Terminal backend** → Keep current (local)
66|6. **Platforms** → Pilih yang mau diaktifkan (tekan Spasi untuk centang)
67|7. **Tools** → Pilih yang mau diaktifkan
68|8. **Selesai!**
69|
70|---
71|
72|## 🆓 API Key Gratis
73|
74|Belum punya API Key? Dapatkan yang **gratis** dari sini:
75|
76|| Provider | Link | Keterangan |
77||----------|------|------------|
78|| **Ollama** | [ollama.com](https://ollama.com/) | Model open-source lokal |
79|| **OrcaRouter** | [orcarouter.ai](https://www.orcarouter.ai/playground) | Multi-model |
80|| **Zyloo** | [zyloo.io](https://zyloo.io/dashboard/free-balance) | Ada free balance |
81|| **Aerolink** | [aerolink.lat](https://aerolink.lat/dashboard) | Free tier tersedia |
82|
83|---
84|
85|## 🏃 Cara Menjalankan
86|
87|### Masuk ke Ubuntu
88|```bash
89|proot-distro login ubuntu
90|```
91|
92|### Jalankan Hermes (CLI)
93|```bash
94|hermes
95|```
96|
97|### Jalankan sebagai Gateway (multi-platform)
98|```bash
99|hermes gateway
100|```
101|
102|### Cek Versi
103|```bash
104|hermes version
105|hermes doctor
106|```
107|
108|---
109|
110|## 🛠️ Troubleshooting
111|
112|### "Command not found: hermes"
113|```bash
114|source ~/.bashrc
115|```
116|
117|### "proot-distro: command not found"
118|```bash
119|pkg install proot-distro
120|```
121|
122|### Ubuntu tidak bisa diinstall
123|Pastikan storage sudah di-setup:
124|```bash
125|termux-setup-storage
126|```
127|
128|---
129|
130|## 📁 File Structure
131|
132|```
133|hermes-termux-installer/
134|├── install.sh          # Script installer utama
135|└── README.md           # Dokumentasi ini
136|```
137|
138|---
139|
140|## 📝 Referensi
141|
142|- [Hermes Agent Official Docs](https://hermes-agent.nousresearch.com/docs/getting-started/installation)
143|- [Original Guide](https://github.com/vay-sys/hermes)
144|
145|---
146|
147|Made with 💕 by Nayeon Agent
148|