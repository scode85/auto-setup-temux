#!/bin/bash
# Script tự động cài đặt Termux - Scode Auto Setup

# Định nghĩa màu sắc nâng cao
WHITE='\033[1;37m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_YELLOW='\033[1;33m'
LIGHT_PURPLE='\033[1;35m'
LIGHT_RED='\033[1;31m'
BG_LIGHT_BLUE='\033[48;5;45m'
BG_LIGHT_GREEN='\033[48;5;46m'
BG_LIGHT_RED='\033[48;5;196m'
NC='\033[0m' # No Color

# Hàm hiển thị banner Scode với gradient màu
show_start_banner() {
    clear
    echo -e "${LIGHT_CYAN}╔══════════════════════════════════════════════════════════╗"
    echo -e "║${LIGHT_PURPLE} ███████╗${LIGHT_CYAN} ██████╗${LIGHT_GREEN} ██████╗${LIGHT_YELLOW} ██████╗${WHITE} ███████╗ ${LIGHT_CYAN}║"
    echo -e "║${LIGHT_PURPLE} ██╔════╝${LIGHT_CYAN}██╔════╝${LIGHT_GREEN}██╔═══██╗${LIGHT_YELLOW}██╔══██╗${WHITE}██╔════╝ ${LIGHT_CYAN}║"
    echo -e "║${LIGHT_PURPLE} ███████╗${LIGHT_CYAN}██║     ${LIGHT_GREEN}██║   ██║${LIGHT_YELLOW}██║  ██║${WHITE}█████╗   ${LIGHT_CYAN}║"
    echo -e "║${LIGHT_PURPLE} ╚════██║${LIGHT_CYAN}██║     ${LIGHT_GREEN}██║   ██║${LIGHT_YELLOW}██║  ██║${WHITE}██╔══╝   ${LIGHT_CYAN}║"
    echo -e "║${LIGHT_PURPLE} ███████║${LIGHT_CYAN}╚██████╗${LIGHT_GREEN}╚██████╔╝${LIGHT_YELLOW}██████╔╝${WHITE}███████╗ ${LIGHT_CYAN}║"
    echo -e "║${LIGHT_PURPLE} ╚══════╝${LIGHT_CYAN} ╚═════╝ ${LIGHT_GREEN}╚═════╝ ${LIGHT_YELLOW}╚═════╝ ${WHITE}╚══════╝ ${LIGHT_CYAN}║"
    echo -e "╠══════════════════════════════════════════════════════════╣"
    echo -e "║ ${WHITE}🚀 Scode Auto Setup ${LIGHT_CYAN}                                ║"
    echo -e "║ ${LIGHT_YELLOW}🔧 Developed by Đặng Gia ${LIGHT_CYAN}                     ║"
    echo -e "║ ${LIGHT_GREEN}📌 Version 2.0 ${LIGHT_CYAN}                               ║"
    echo -e "╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Hàm hiển thị banner hoàn thành
show_success_banner() {
    clear
    echo -e "${LIGHT_GREEN}╔══════════════════════════════════════════════════════════╗"
    echo -e "║${LIGHT_PURPLE} ███████╗${LIGHT_CYAN} ██████╗${LIGHT_GREEN} ██████╗${LIGHT_YELLOW} ██████╗${WHITE} ███████╗ ${LIGHT_GREEN}║"
    echo -e "║${LIGHT_PURPLE} ██╔════╝${LIGHT_CYAN}██╔════╝${LIGHT_GREEN}██╔═══██╗${LIGHT_YELLOW}██╔══██╗${WHITE}██╔════╝ ${LIGHT_GREEN}║"
    echo -e "║${LIGHT_PURPLE} ███████╗${LIGHT_CYAN}██║     ${LIGHT_GREEN}██║   ██║${LIGHT_YELLOW}██║  ██║${WHITE}█████╗   ${LIGHT_GREEN}║"
    echo -e "║${LIGHT_PURPLE} ╚════██║${LIGHT_CYAN}██║     ${LIGHT_GREEN}██║   ██║${LIGHT_YELLOW}██║  ██║${WHITE}██╔══╝   ${LIGHT_GREEN}║"
    echo -e "║${LIGHT_PURPLE} ███████║${LIGHT_CYAN}╚██████╗${LIGHT_GREEN}╚██████╔╝${LIGHT_YELLOW}██████╔╝${WHITE}███████╗ ${LIGHT_GREEN}║"
    echo -e "║${LIGHT_PURPLE} ╚══════╝${LIGHT_CYAN} ╚═════╝ ${LIGHT_GREEN}╚═════╝ ${LIGHT_YELLOW}╚═════╝ ${WHITE}╚══════╝ ${LIGHT_GREEN}║"
    echo -e "╠══════════════════════════════════════════════════════════╣"
    echo -e "║ ${BG_LIGHT_GREEN}${WHITE}   🎉 CÀI ĐẶT THÀNH CÔNG - SẴN SÀNG SỬ DỤNG! 🚀   ${NC}${LIGHT_GREEN}   ║"
    echo -e "╠══════════════════════════════════════════════════════════╣"
    echo -e "║ ${WHITE}🚀 Scode Auto Setup ${LIGHT_GREEN}                                ║"
    echo -e "║ ${LIGHT_YELLOW}🔧 Developed by Đặng Gia ${LIGHT_GREEN}                     ║"
    echo -e "║ ${LIGHT_CYAN}📌 Version 2.0 ${LIGHT_GREEN}                               ║"
    echo -e "╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Hàm hiển thị thanh tiến trình với gradient
show_progress() {
    local duration=$1
    local message=$2
    local icon=$3
    
    echo -ne "${LIGHT_CYAN}[${icon}] ${WHITE}${message} ${NC}["
    for i in {1..30}; do
        if [ $i -le 10 ]; then
            color="${CYAN}"
        elif [ $i -le 20 ]; then
            color="${LIGHT_CYAN}"
        else
            color="${LIGHT_GREEN}"
        fi
        
        echo -ne "${color}▓${NC}"
        sleep $duration
    done
    echo -e "]"
}

# Hàm hiển thị trạng thái với màu sắc khác nhau
show_status() {
    local message=$1
    local icon=$2
    local color=$3
    
    echo -e "${color}[${icon}] ${WHITE}${message}...${NC}"
    sleep 0.2
}

# Hàm xử lý lỗi
handle_error() {
    local message=$1
    echo -e "${LIGHT_RED}╔══════════════════════════════════════════════════════════╗"
    echo -e "║ ${WHITE}${BG_LIGHT_RED}                    LỖI CÀI ĐẶT!                     ${NC}${LIGHT_RED}║"
    echo -e "╠══════════════════════════════════════════════════════════╣"
    echo -e "║ ${LIGHT_YELLOW}✖ ${message} ${LIGHT_RED}                               ║"
    echo -e "║ ${WHITE}Nguyên nhân có thể do:${LIGHT_RED}                                 ║"
    echo -e "║ ${LIGHT_YELLOW}• Mất kết nối Internet${LIGHT_RED}                                 ║"
    echo -e "║ ${LIGHT_YELLOW}• Hết dung lượng lưu trữ${LIGHT_RED}                               ║"
    echo -e "║ ${LIGHT_YELLOW}• Xung đột gói cài đặt${LIGHT_RED}                                 ║"
    echo -e "║ ${WHITE}Vui lòng kiểm tra và thử lại!${LIGHT_RED}                           ║"
    echo -e "╚══════════════════════════════════════════════════════════╝${NC}"
    exit 1
}

# Hàm kiểm tra lỗi sau mỗi lệnh
check_error() {
    if [ $? -ne 0 ]; then
        handle_error "$1"
    fi
}

# Hiển thị banner đầu
show_start_banner

# Cập nhật và nâng cấp Termux
show_progress 0.03 "Khởi động cập nhật hệ thống" "🔄"
show_status "Cập nhật gói hệ thống" "⏳" "${LIGHT_CYAN}"
pkg update -y > /dev/null 2>&1
check_error "Không thể cập nhật danh sách gói"
pkg upgrade -y > /dev/null 2>&1
check_error "Không thể nâng cấp hệ thống"
echo -e "${LIGHT_GREEN}[✓] Cập nhật hệ thống hoàn tất!${NC}"
echo ""

# Cấp quyền truy cập bộ nhớ
show_progress 0.02 "Yêu cầu quyền lưu trữ" "🔑"
show_status "Cấp quyền lưu trữ" "💾" "${LIGHT_PURPLE}"
termux-setup-storage <<< "y" > /dev/null 2>&1
check_error "Không thể cấp quyền truy cập bộ nhớ"
echo -e "${LIGHT_GREEN}[✓] Cấp quyền lưu trữ hoàn tất!${NC}"
echo ""

# Cài đặt các gói cần thiết
show_progress 0.02 "Chuẩn bị cài đặt gói" "📦"
show_status "Cài đặt gói hệ thống" "⚙️" "${LIGHT_YELLOW}"
pkg install -y python tsu libexpat openssl > /dev/null 2>&1
check_error "Cài đặt gói hệ thống thất bại"
echo -e "${LIGHT_GREEN}[✓] Cài đặt gói hệ thống hoàn tất!${NC}"
echo ""

# Cài đặt các thư viện Python
show_progress 0.01 "Thiết lập môi trường Python" "🐍"
show_status "Cài đặt thư viện Python" "📚" "${LIGHT_CYAN}"
pip install requests Flask colorama aiohttp psutil crypto pycryptodome prettytable loguru rich pytz tqdm pyjwt pystyle cloudscraper > /dev/null 2>&1
check_error "Cài đặt thư viện Python thất bại"
echo -e "${LIGHT_GREEN}[✓] Cài đặt thư viện Python hoàn tất!${NC}"
echo ""

# Tải file về /sdcard/Download
show_progress 0.01 "Kết nối kho lưu trữ" "📡"
show_status "Tải Scode666.py" "⬇️" "${LIGHT_PURPLE}"
curl -o /sdcard/Download/Scode666.py https://raw.githubusercontent.com/scode85/Tool-golike/refs/heads/main/Scode666.py > /dev/null 2>&1
check_error "Tải Scode666.py thất bại"
echo -e "${LIGHT_GREEN}[✓] Tải Scode666.py hoàn tất!${NC}"
echo ""

# Hiển thị banner hoàn thành
show_success_banner

# Hiển thị hướng dẫn sử dụng
echo -e "${LIGHT_CYAN}╔══════════════════════════════════════════════════════════╗"
echo -e "║ ${BG_LIGHT_BLUE}${WHITE}                    🚀 LỆNH KHỞI CHẠY                    ${NC}${LIGHT_CYAN}║"
echo -e "╠══════════════════════════════════════════════════════════╣"
echo -e "║ ${LIGHT_YELLOW}1. ${LIGHT_PURPLE}cd /sdcard/Download ${LIGHT_CYAN}                               ║"
echo -e "║ ${LIGHT_YELLOW}2. ${LIGHT_GREEN}python Scode666.py ${LIGHT_CYAN}                               ║"
echo -e "╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${LIGHT_PURPLE}💡 Mẹo: ${WHITE}Bạn có thể chạy trực tiếp bằng cách nhập lệnh đầy đủ:"
echo -e "${LIGHT_YELLOW}   python /sdcard/Download && python Scode666.py"
echo ""
echo -e "${LIGHT_GREEN}✅ Mọi quá trình đã hoàn tất thành công!"
echo -e "${LIGHT_CYAN}💖 Cảm ơn bạn đã sử dụng Scode Auto Setup!${NC}"
