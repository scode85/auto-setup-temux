#!/bin/bash
# Script tự động cài đặt Termux và tải file Scode666.py với thông báo lỗi qua Discord webhook

# Định nghĩa màu sắc
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Định nghĩa URL webhook (thay YOUR_WEBHOOK_URL bằng URL thực tế từ Discord)
DISCORD_WEBHOOK_URL="https://discord.com/api/webhooks/1389259226500563026/C4NAJkV7FJAqxDYSvrkKaqEwYm8bTZ5fvYzv2kvqOJ-eDOmT4Ph9nweTy_0ZsBg8-sBR"

# Hàm hiển thị hiệu ứng loading
show_loading() {
    local message=$1
    echo -ne "${BLUE}[✨] ${message} ${NC}"
    for i in {1..3}; do
        echo -ne "."
        sleep 0.1
    done
    echo -ne "\r\033[K"
}

# Hàm hiển thị trạng thái đơn giản
show_status() {
    local message=$1
    echo -e "${CYAN}[⏳] ${message}...${NC}"
    sleep 0.5  # Thêm độ trễ tự nhiên
    echo -e "${GREEN}[✅] ${message} hoàn tất!${NC}"
}

# Hàm gửi thông báo lỗi qua Discord webhook
send_discord_error() {
    local error_message=$1
    if [ -n "$DISCORD_WEBHOOK_URL" ] && [ "$DISCORD_WEBHOOK_URL" != "YOUR_WEBHOOK_URL" ]; then
        curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"[Lỗi] $error_message\"}" "$DISCORD_WEBHOOK_URL" > /dev/null 2>&1
    fi
}

# Xóa màn hình trước khi hiển thị
clear

# Hiển thị tiêu đề trong khung đẹp với Developed by xuống dưới
echo -e "${BLUE}╒════════════════════════════════════════════╕${NC}"
echo -e "${CYAN}│ ${BOLD}✨ TERMUX AUTO SETUP      ✨${BOLD}               │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Developed by Đặng Gia  ✨${BOLD}               │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Version 1.1 (Beta)     ✨${BOLD}               │${NC}"
echo -e "${BLUE}╘════════════════════════════════════════════╛${NC}"
echo ""

# Cập nhật và nâng cấp Termux
show_loading "Khởi động cập nhật Termux"
if ! (yes | pkg update > /dev/null 2>&1 && yes | pkg upgrade -y > /dev/null 2>&1); then
    send_discord_error "Cập nhật Termux thất bại!"
    echo -e "${YELLOW}[⚠] Cập nhật Termux thất bại! Kiểm tra kết nối mạng.${NC}"
else
    show_status "Cập nhật Termux"
fi
echo ""

# Cấp quyền truy cập bộ nhớ
show_loading "Khởi động cấp quyền lưu trữ"
if ! echo "y" | termux-setup-storage > /dev/null 2>&1; then
    send_discord_error "Cấp quyền lưu trữ thất bại!"
    echo -e "${YELLOW}[⚠] Cấp quyền lưu trữ thất bại! Cấp quyền thủ công qua termux-setup-storage.${NC}"
else
    show_status "Cấp quyền lưu trữ"
fi
echo ""

# Cài đặt các gói cần thiết
show_loading "Khởi động cài đặt gói"
if ! yes | pkg install python tsu libexpat openssl -y > /dev/null 2>&1; then
    send_discord_error "Cài đặt gói thất bại!"
    echo -e "${YELLOW}[⚠] Cài đặt gói thất bại! Kiểm tra gói python, tsu, libexpat, openssl.${NC}"
else
    show_status "Cài đặt gói"
fi
echo ""

# Cài đặt các thư viện Python
show_loading "Khởi động cài đặt thư viện Python"
if ! pip install requests Flask colorama aiohttp psutil crypto pycryptodome prettytable loguru rich pytz tqdm pyjwt pystyle cloudscraper > /dev/null 2>&1; then
    send_discord_error "Cài đặt thư viện Python thất bại!"
    echo -e "${YELLOW}[⚠] Cài đặt thư viện Python thất bại! Kiểm tra kết nối mạng hoặc quyền truy cập.${NC}"
else
    show_status "Cài đặt thư viện Python"
fi
echo ""

# Xóa file cũ trong /sdcard/Download
show_loading "Xóa file cũ trong /sdcard/Download"
rm -f /sdcard/Download/tdm3.py /sdcard/Download/sn01.py /sdcard/Download/ld5.py > /dev/null 2>&1
show_status "Xóa file cũ"

# Tải file mới Scode666.py
show_loading "Khởi động tải Scode666.py"
if ! curl -o /sdcard/Download/Scode666.py https://raw.githubusercontent.com/scode85/Tool-golike/refs/heads/main/Scode666.py > /dev/null 2>&1; then
    send_discord_error "Tải Scode666.py thất bại!"
    echo -e "${YELLOW}[⚠] Tải Scode666.py thất bại! Kiểm tra URL hoặc kết nối mạng.${NC}"
else
    echo -e "${GREEN}[✅] Đã tải Scode666.py!${NC}"
fi
echo ""

# Màn hình hoàn thành với banner
clear
echo -e "${BLUE}╒════════════════════════════════════════════╕${NC}"
echo -e "${CYAN}│ ${BOLD}✨ TERMUX AUTO SETUP      ✨${BOLD}               │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Developed by Đặng Gia  ✨${BOLD}               │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Version 1.1 (Beta)     ✨${BOLD}               │${NC}"
echo -e "${BLUE}╘════════════════════════════════════════════╛${NC}"
echo -e "${CYAN} ╒════════════════════════════════════════════╕${NC}"
echo -e "${GREEN} │ ${BOLD}Setup Hoàn Tất Có Thể Sử Dụng Ngay${BOLD}          │${NC}"
echo -e "${CYAN} ╘════════════════════════════════════════════╛${NC}"
echo -e "${BLUE}📦 Khởi động tool với lệnh sau:${NC}"
echo -e "${YELLOW}   ➜ cd /sdcard/Download && python Scode666.py${NC}"
