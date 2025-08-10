#!/bin/bash
# Script tự động cài đặt Termux và tải file Scode85.py

# Định nghĩa màu sắc
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RED='\033[1;31m'
BOLD='\033[1m'
NC='\033[0m' # No Color

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

# Hàm hiển thị trạng thái
show_status() {
    local message=$1
    echo -e "${CYAN}[⏳] ${message}...${NC}"
    sleep 0.5
}

# Hàm hiển thị lỗi
show_error() {
    local message=$1
    echo -e "${RED}[❌] Lỗi: ${message}${NC}"
}

# Hàm kiểm tra và hiển thị trạng thái thành công
check_status() {
    local message=$1
    local exit_code=$2
    if [ $exit_code -eq 0 ]; then
        echo -e "${GREEN}[✅] ${message} hoàn tất!${NC}"
    else
        show_error "${message} thất bại!"
        exit 1
    fi
}

# Xóa màn hình trước khi hiển thị
clear

# Hiển thị tiêu đề
echo -e "${BLUE}╒════════════════════════════════════════════╕${NC}"
echo -e "${CYAN}│ ${BOLD}✨ TERMUX AUTO SETUP      ✨${BOLD}               │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Developed by Đặng Gia  ✨${BOLD}               │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Version 1.4 (Beta)     ✨${BOLD}               │${NC}"
echo -e "${BLUE}╘════════════════════════════════════════════╛${NC}"
echo ""

# Kiểm tra kết nối mạng
show_loading "Kiểm tra kết nối mạng"
show_status "Kiểm tra kết nối mạng"
ping -c 1 google.com > /dev/null 2>&1
check_status "Kiểm tra kết nối mạng" $?
echo ""

# Cập nhật và nâng cấp Termux
show_loading "Khởi động cập nhật Termux"
show_status "Cập nhật Termux"
yes | pkg update > /dev/null 2>&1 && yes | pkg upgrade -y > /dev/null 2>&1
check_status "Cập nhật Termux" $?
echo ""

# Cấp quyền truy cập bộ nhớ
show_loading "Khởi động cấp quyền lưu trữ"
show_status "Cấp quyền lưu trữ"
echo "y" | termux-setup-storage > /dev/null 2>&1
check_status "Cấp quyền lưu trữ" $?
echo ""

# Cài đặt các gói cần thiết
show_loading "Khởi động cài đặt gói"
show_status "Cài đặt gói"
yes | pkg install python tsu libexpat openssl android-tools -y > /dev/null 2>&1
check_status "Cài đặt gói" $?
echo ""

# Cài đặt các thư viện Python
show_loading "Khởi động cài đặt thư viện Python"
show_status "Cài đặt thư viện Python"
pip install requests Flask colorama aiohttp crypto pycryptodome prettytable loguru rich pytz tqdm pyjwt pystyle cloudscraper > /dev/null 2>&1
check_status "Cài đặt thư viện Python" $?
echo ""

# Tải file về /sdcard/Download
show_loading "Khởi động tải Scode85.py"
show_status "Tải Scode85.py"
curl -o /sdcard/Download/Scode85.py https://raw.githubusercontent.com/scode85/taitool/refs/heads/main/Scode85.py > /dev/null 2>&1
check_status "Tải Scode85.py" $?
echo ""

# Kiểm tra xem file có tồn tại không
if [ -f "/sdcard/Download/Scode85.py" ]; then
    echo -e "${GREEN}[✅] Đã tải Scode85.py thành công!${NC}"
else
    show_error "File Scode85.py không tồn tại sau khi tải!"
    exit 1
fi
echo ""

# Màn hình hoàn thành
clear
echo -e "${BLUE}╒════════════════════════════════════════════╕${NC}"
echo -e "${CYAN}│ ${BOLD}✨ TERMUX AUTO SETUP      ✨${BOLD}               │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Developed by Đặng Gia  ✨${BOLD}               │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Version 1.4 (Beta)     ✨${BOLD}               │${NC}"
echo -e "${BLUE}╘════════════════════════════════════════════╛${NC}"
echo -e "${CYAN} ╒════════════════════════════════════════════╕${NC}"
echo -e "${GREEN} │ ${BOLD}Setup Hoàn Tất Có Thể Sử Dụng Ngay${BOLD}          │${NC}"
echo -e "${CYAN} ╘════════════════════════════════════════════╛${NC}"
echo -e "${BLUE}📦 Khởi động tool với lệnh sau:${NC}"
echo -e "${YELLOW}   ➜ cd /sdcard/Download && python Scode85.py${NC}"
