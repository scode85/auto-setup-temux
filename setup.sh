#!/bin/bash
# Script tự động cài đặt Termux và tải file Scode666.py với thông báo qua bot Telegram

# Định nghĩa màu sắc
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Định nghĩa thông tin Telegram
TELEGRAM_BOT_TOKEN="7440498179:AAEcs0-JfAsF_PpoNihGptEjr55PqO3vY8k"  # Bot Token của bạn
TELEGRAM_CHAT_ID="-4961965566"                                      # Chat ID của bạn
TELEGRAM_API_URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

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

# Hàm lấy IP thiết bị
get_device_ip() {
    if command -v ifconfig >/dev/null 2>&1; then
        ifconfig | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | grep -v "255" | head -n 1
    elif command -v ip >/dev/null 2>&1; then
        ip addr show | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | grep -v "255" | head -n 1
    else
        echo "Không xác định"
    fi
}

# Hàm gửi thông báo lỗi qua Telegram
send_telegram_error() {
    local error_message=$1
    local device_ip=$(get_device_ip)
    local device_name=$(hostname || echo "Không xác định")
    local current_time=$(TZ=Asia/Ho_Chi_Minh date +"%H:%M, %d/%m/%Y")
    local message="❌ *Lỗi trong Termux Auto Setup*\n*Thông báo:* $error_message\n*IP Thiết bị:* $device_ip\n*Tên Thiết bị:* $device_name\n*Thời gian (VN):* $current_time"
    curl -s -X POST "$TELEGRAM_API_URL" -d chat_id="$TELEGRAM_CHAT_ID" -d text="$message" -d parse_mode="Markdown" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${YELLOW}[⚠] Gửi thông báo lỗi Telegram thất bại! Kiểm tra kết nối hoặc thông tin bot.${NC}"
    fi
}

# Hàm gửi thông báo thành công qua Telegram
send_telegram_success() {
    local device_ip=$(get_device_ip)
    local device_name=$(hostname || echo "Không xác định")
    local current_time=$(TZ=Asia/Ho_Chi_Minh date +"%H:%M, %d/%m/%Y")
    local message="✅ *Setup Termux Hoàn Tất*\n*Thông báo:* Quá trình cài đặt và tải file Scode666.py đã thành công!\n*IP Thiết bị:* $device_ip\n*Tên Thiết bị:* $device_name\n*Thời gian (VN):* $current_time"
    curl -s -X POST "$TELEGRAM_API_URL" -d chat_id="$TELEGRAM_CHAT_ID" -d text="$message" -d parse_mode="Markdown" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${YELLOW}[⚠] Gửi thông báo thành công Telegram thất bại! Kiểm tra kết nối hoặc thông tin bot.${NC}"
    fi
}

# Xóa màn hình trước khi hiển thị
clear

# Hiển thị tiêu đề trong khung đẹp với Developed by xuống dưới
echo -e "${BLUE}╒════════════════════════════════════════════╕${NC}"
echo -e "${CYAN}│ ${BOLD}✨ TERMUX AUTO SETUP     ✨${BOLD}                │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Developed by Đặng Gia ✨${BOLD}                │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Version 1.4           ✨${BOLD}                │${NC}"
echo -e "${BLUE}╘════════════════════════════════════════════╛${NC}"
echo ""

# Cập nhật và nâng cấp Termux
show_loading "Khởi động cập nhật Termux"
if ! (yes | pkg update > /dev/null 2>&1 && yes | pkg upgrade -y > /dev/null 2>&1); then
    send_telegram_error "Cập nhật Termux thất bại!"
    echo -e "${YELLOW}[⚠] Cập nhật Termux thất bại! Kiểm tra kết nối mạng.${NC}"
    exit 1
else
    show_status "Cập nhật Termux"
fi
echo ""

# Cấp quyền truy cập bộ nhớ
show_loading "Khởi động cấp quyền lưu trữ"
if ! echo "y" | termux-setup-storage > /dev/null 2>&1; then
    send_telegram_error "Cấp quyền lưu trữ thất bại!"
    echo -e "${YELLOW}[⚠] Cấp quyền lưu trữ thất bại! Cấp quyền thủ công qua termux-setup-storage.${NC}"
    exit 1
else
    show_status "Cấp quyền lưu trữ"
fi
echo ""

# Cài đặt các gói cần thiết
show_loading "Khởi động cài đặt gói"
if ! yes | pkg install python tsu libexpat openssl -y > /dev/null 2>&1; then
    send_telegram_error "Cài đặt gói thất bại!"
    echo -e "${YELLOW}[⚠] Cài đặt gói thất bại! Kiểm tra gói python, tsu, libexpat, openssl.${NC}"
    exit 1
else
    show_status "Cài đặt gói"
fi
echo ""

# Cài đặt các thư viện Python
show_loading "Khởi động cài đặt thư viện Python"
if ! pip install requests Flask colorama aiohttp psutil crypto pycryptodome prettytable loguru rich pytz tqdm pyjwt pystyle cloudscraper > /dev/null 2>&1; then
    send_telegram_error "Cài đặt thư viện Python thất bại!"
    echo -e "${YELLOW}[⚠] Cài đặt thư viện Python thất bại! Kiểm tra kết nối mạng hoặc quyền truy cập.${NC}"
    exit 1
else
    show_status "Cài đặt thư viện Python"
fi
echo ""

# Tải file mới Scode666.py từ GitHub
SCODE666_URL="https://raw.githubusercontent.com/[username]/[repo]/main/Scode666.py"  # Thay bằng URL của bạn
show_loading "Khởi động tải Scode666.py"
if ! curl -s -o /sdcard/Download/Scode666.py "$SCODE666_URL" > /dev/null 2>&1; then
    send_telegram_error "Tải Scode666.py thất bại!"
    echo -e "${YELLOW}[⚠] Tải Scode666.py thất bại! Kiểm tra URL hoặc kết nối mạng.${NC}"
    exit 1
else
    echo -e "${GREEN}[✅] Đã tải Scode666.py!${NC}"
fi
echo ""

# Kiểm tra và gửi thông báo thành công nếu không có lỗi
if [ $? -eq 0 ]; then
    send_telegram_success
fi

# Màn hình hoàn thành với banner
clear
echo -e "${BLUE}╒════════════════════════════════════════════╕${NC}"
echo -e "${CYAN}│ ${BOLD}✨ TERMUX AUTO SETUP     ✨${BOLD}                │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Developed by Đặng Gia ✨${BOLD}                │${NC}"
echo -e "${CYAN}│ ${BOLD}✨ Version 1.4           ✨${BOLD}                │${NC}"
echo -e "${BLUE}╘════════════════════════════════════════════╛${NC}"
echo -e "${CYAN} ╒════════════════════════════════════════════╕${NC}"
echo -e "${GREEN} │ ${BOLD}Setup Hoàn Tất Có Thể Sử Dụng Ngay${BOLD}         │${NC}"
echo -e "${CYAN} ╘════════════════════════════════════════════╛${NC}"
echo -e "${BLUE}📦 Khởi động tool với lệnh sau:${NC}"
echo -e "${YELLOW}   ➜ cd /sdcard/Download && python Scode666.py${NC}"
