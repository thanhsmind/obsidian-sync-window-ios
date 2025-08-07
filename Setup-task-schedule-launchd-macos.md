---
tags:
  - MacOS
  - TaskSchedule
---

# Làm sao để thay thế cron bằng launchd

Để thay thế cron bằng launchd trên macOS để tự động chạy một script (ví dụ chạy mỗi 2 phút), bạn cần tạo một file cấu hình kiểu plist (Property List) cho launchd và đăng ký job đó với launchctl. Đây là cách cơ bản để làm điều này:

### Các bước thay thế cron bằng launchd

1. **Tạo file cấu hình plist cho launchd**

File plist xác định các thông tin như: - Tên job (Label) - Script hoặc chương trình sẽ chạy (ProgramArguments) - Thời gian chạy định kỳ (StartInterval hoặc StartCalendarInterval) - Log đầu ra, lỗi (tuỳ chọn)

Ví dụ file `com.tennguoidung.PKM.plist` để chạy script mỗi 1 phút:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.tennguoidung.PKM</string>

    <key>ProgramArguments</key>
    <array>
      <string>/bin/bash</string>
      <string>/Users/tennguoidung/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/PKM/gitcommit</string>
    </array>

    <key>StartInterval</key>
    <integer>60</integer>   <!-- 60 giây = 1 phút -->

    <key>StandardOutPath</key>
    <string>/tmp/myscript.out</string>

    <key>StandardErrorPath</key>
    <string>/tmp/myscript.err</string>
  </dict>
</plist>
```

    - Thay `/Users/tennguoidung/tenfile.sh` bằng đường dẫn script của bạn.
    - `StartInterval` là khoảng thời gian giữa các lần chạy tính bằng giây (mỗi 120 giây tức 2 phút).
    - Thuộc tính log giúp bạn kiểm tra kết quả chạy.

2. **Đặt file plist vào đúng thư mục**
   - Nếu muốn chạy theo user, đặt vào:

```
~/Library/LaunchAgents/
```

    - Nếu muốn chạy cho toàn hệ thống (yêu cầu quyền admin), đặt vào:

```
/Library/LaunchAgents/
```

hoặc `/Library/LaunchDaemons/` tùy mục đích. 3. **Đăng ký và khởi động job với launchctl**

Mở Terminal và chạy lệnh:

```
launchctl load ~/Library/LaunchAgents/com.tennguoidung.PKM.plist
```

Nếu muốn tắt job:

```
launchctl unload ~/Library/LaunchAgents/com.tennguoidung.PKM.plist
```

4. **Kiểm tra hoạt động**
   - Kiểm tra file `/tmp/myscript.out` và `/tmp/myscript.err` xem script có chạy đúng không.
   - Bạn có thể xem status các job bằng lệnh:

```
launchctl list | grep com.thanhnguyen
```

### Ưu điểm của launchd so với cron

- launchd được macOS ưu tiên sử dụng, hỗ trợ nhiều tính năng hơn.
- Có thể chạy job khi máy thức dậy sau ngủ (cron không hỗ trợ tốt).
- Cấu hình tập trung theo chuẩn plist dễ quản lý đồng bộ.
- Hỗ trợ nhiều triggers phức tạp hơn ngoài chạy theo thời gian.

### Tổng kết

- Viết cấu hình `.plist` cho launchd với `StartInterval` để thay cron chạy mỗi 2 phút.
- Đặt file vào đúng thư mục `~/Library/LaunchAgents/` và đăng ký với lệnh `launchctl load`.
- Kiểm tra log và trạng thái để đảm bảo script chạy như mong muốn.

relate:: [[Cách chạy script PowerShell tự động mỗi 2 phút bằng Task Scheduler]]
