param(
  [string]$location = "D:\Dropbox\PKM",
  [string]$msg = ""
)

# Lấy tên máy tính hiện tại
$computerName = $env:COMPUTERNAME

# Nếu $msg rỗng thì gán mặc định với thời gian và tên máy tính
if ([string]::IsNullOrEmpty($msg)) {
  $msg = "Update code on $computerName at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
}

# Di chuyển đến thư mục làm việc
Set-Location $location

# Thêm tất cả thay đổi
git add .

# Commit với message đã chuẩn bị
git commit -m $msg

# Pull code với rebase
git pull --rebase

# Kiểm tra conflict
#if ($LASTEXITCODE -ne 0) {
#  Write-Host "Có conflict khi pull code. Vui lòng xử lý rồi commit lại!"
#  exit 1
#}

# Push code lên remote
git push

Write-Host "Đã add, commit, pull và push thành công!"
exit 1
