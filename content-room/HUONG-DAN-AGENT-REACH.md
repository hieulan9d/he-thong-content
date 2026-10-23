# Hướng dẫn cài & dùng Agent Reach trên Windows

Mã nguồn đã nằm sẵn ở: `E:\antigravyti\hệ thống content\content-room\Agent-Reach`

## 1. Cài (PowerShell, chạy 1 lần)

```powershell
# Cần Python 3.10+  (kiểm tra: py -3 --version)
py -3 -m venv $env:USERPROFILE\.agent-reach-venv
& $env:USERPROFILE\.agent-reach-venv\Scripts\Activate.ps1
python -m pip install "E:\antigravyti\hệ thống content\content-room\Agent-Reach"

agent-reach install --env=auto            # chỉ kiểm tra, không sửa máy
agent-reach install --env=auto --dry-run  # xem trước nó sẽ cài gì
agent-reach install --env=auto --system   # cài thật các công cụ nền (yt-dlp, gh, mcporter...)
agent-reach skill --install               # gắn SKILL.md cho Claude Code / agent
agent-reach doctor                        # xem kênh nào ✅
```

> Nếu PowerShell chặn Activate.ps1: chạy `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` một lần.
> Mỗi lần mở terminal mới cần Activate lại (dòng thứ 2).

## 2. Mở thêm kênh mạng xã hội (tuỳ chọn)

```powershell
agent-reach install --env=auto --system --channels=facebook,instagram   # Meta
agent-reach install --env=auto --system --channels=opencli,xiaohongshu  # Tiểu Hồng Thư
agent-reach install --env=auto --system --channels=all                  # tất cả
```

Facebook / Instagram / Xiaohongshu / Reddit chạy qua **OpenCLI**, dùng lại phiên đăng nhập Chrome:
1. Cài extension OpenCLI: https://chromewebstore.google.com/detail/opencli/ildkmabpimmkaediidaifkhjpohdnifk
2. Đăng nhập facebook.com / instagram.com trong Chrome — **nên dùng nick phụ** (tránh checkpoint/khoá nick).
3. `opencli doctor` → thấy `Extension: connected` là xong.

## 3. Lệnh dùng hằng ngày (cho content)

| Việc | Lệnh |
|---|---|
| Đọc 1 trang web thành văn bản | `curl -s "https://r.jina.ai/https://link-bai-viet"` |
| Lấy phụ đề YouTube (làm tư liệu kịch bản) | `yt-dlp --write-sub --write-auto-sub --skip-download -o "%(id)s" "LINK_YOUTUBE"` |
| Tìm bài/trang trên Facebook | `opencli facebook search "máy lọc không khí" -f yaml` |
| Xem nhóm Facebook đang tham gia | `opencli facebook groups -f yaml` |
| Tìm tài khoản Instagram | `opencli instagram search "spa nha trang" -f yaml` |
| Bài gần đây của 1 tài khoản IG | `opencli instagram user TEN_TAI_KHOAN -f yaml` |
| Tìm trên Xiaohongshu (ý tưởng video) | `opencli xiaohongshu search "智能家居" -f yaml` |
| Tìm kiếm web toàn cầu (Exa) | sau khi cài mcporter: agent tự gọi |
| Kiểm tra sức khoẻ / cập nhật | `agent-reach doctor`  ·  `agent-reach check-update` |

## 4. Cách dùng thông minh nhất: để agent tự làm

Sau khi `agent-reach skill --install`, chỉ cần nói với Claude Code / Antigravity bằng tiếng Việt, ví dụ:

- "Dùng Agent Reach lấy phụ đề 5 video YouTube top về robot hút bụi, tóm tắt hook 3 giây đầu."
- "Tìm trên Xiaohongshu 20 bài về 私密护理, liệt kê góc tiếp cận nội dung đang hot."
- "Đọc fanpage đối thủ X trên Facebook, thống kê dạng bài và tần suất đăng."

Agent sẽ tự chọn công cụ, tự đổi đường nếu một công cụ bị chặn.

## 5. Gỡ cài đặt
`agent-reach uninstall` (xoá cấu hình, token, skill) rồi xoá thư mục `%USERPROFILE%\.agent-reach-venv`.
