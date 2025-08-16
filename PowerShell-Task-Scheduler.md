---
tags:
  - DEV/PowerShell
  - PKM/obsidian
  - TaskSchedule
---

Mục đích tự động commit Obsidian code

# Cách chạy script PowerShell tự động mỗi 1 phút bằng Task Scheduler

1. **Viết script PowerShell như bạn đã có**, ví dụ lưu file `git_auto_push.ps1`.
2. **Mở Task Scheduler**:
   - Nhấn `Win + S`, gõ "Task Scheduler", rồi Enter để mở.
3. **Tạo tác vụ mới**:
   - Bên phải, chọn **Create Task...** (không phải Create Basic Task để có nhiều tuỳ chọn hơn).
4. **Trong tab General**:
   - Đặt tên cho Task (ví dụ: `RunGitAutoPushEvery1Min`).
   - Chọn **Run whether user is logged on or not** để chạy nền.
   - Chọn quyền cao nhất nếu cần (Run with highest privileges).
5. **Tab Triggers**:
   - Nhấn **New...**
   - Ở mục **Begin the task:** chọn **On a schedule**
   - Chọn **Daily**
   - Ở phần **Advanced settings**, tích vào **Repeat task every:** chọn **2 minutes**
   - Mục **for a duration of:** chọn **Indefinitely**
   - Nhấn OK
6. **Tab Actions**:
   - Nhấn **New...**
   - Ở phần **Action:** chọn **Start a program**
   - **Program/script:** nhập `powershell.exe`
   - **Add arguments (optional):** nhập:

```
-NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File "D:\Dropbox\PKM\git_auto_push.ps1" -location "D:\Dropbox\PKM"
```

(Thay đường dẫn script và thư mục git của bạn cho đúng) 7. **Tab Conditions \& Settings**: Cấu hình thêm tuỳ chọn nếu cần (ví dụ không tắt task khi pin yếu). 8. Nhấn **OK**, nhập mật khẩu tài khoản Windows nếu được yêu cầu.

## Cách Test xem chạy thành công hay không

Chỉnh lại xem chiều từ iphone có ổn không
Thêm chiều từ máy tính lên này

### Kiểm tra

- Task sẽ tự chạy script PowerShell mỗi 1 phút theo lịch bạn thiết lập.
- Bạn có thể xem trạng thái Task trong Task Scheduler > Library.
- Kiểm tra kết quả hoặc log output nếu script của bạn có ghi file hoặc in ra.

Nếu bạn muốn chạy tự động trên macOS thì cần dùng `launchd` như đã hướng dẫn trước đây, còn với Windows thì Task Scheduler là giải pháp chuẩn và dễ nhất để chạy task định kỳ, kể cả script PowerShell.

relate:: [[Setup chạy schedule bằng launchd trên macos]]
