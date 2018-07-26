# Làm việc với git:
## Dành cho developer:
- Tự tạo branch của mình từ branch `develop`.
- Trước khi bắt đầu làm việc luôn pull và merge code mới nhất từ branch `develop` về.
- Chia nhỏ các commit (theo chức năng, theo bug...), commit và push nhiều lần trong ngày.
- Cuối mỗi ngày pull và merge code mới nhất từ `develop` về trước khi push lần cuối và tạo `merge request` vào `develop`.
- Update file CHANGELOG.md nếu có thêm chức năng mới.

## Team leader:
- Merge code của thành viên vào branch `develop` cuối mỗi ngày.
- Mỗi khi release một bản test cần:
 + Build release từ branch `develop`.
 + Kiểm tra và update lại file CHANGELOG.md đề đảm bảo có đầy đủ thông tin phiên bản và các thay đổi có trong phiên bản đó.
 + Tạo tag tại thời điểm release, đặt tên theo version (v1.0, v2.1.1...).

# Làm việc với `Issues`:
- Các issue được post bắt buộc phải gắn với 1 phiên bản cụ thể.
- Chỉ xử lý các issue được gán cho mình.
- Sau khi xử lý xong thì gán label phù hợp và assign lại cho người có trách nhiệm tiếp theo.
- Có các label để phân loại issue cơ bản là `bug`, `feature`.
- Các label trạng thái của issue là `feedback`, `solved`, `critical`.

# Quản lý version:
- Trong quá trình phát triển, app sẽ luôn được đánh version bắt đầu bằng 0, ví dụ: 0.1, 0.1.3...
- Sau mỗi lần build để test, version sẽ được tăng lên.
- Đổi với thay đổi lớn như thêm chức năng mới, thay đổi flow lớn..., version tăng như sau: 0.1 -> 0.2, 0.13 -> 0.14...
- Đổi với chỉnh sửa nhỏ và fix bug..., vesion tăng như sau: 0.1 -> 0.1.1, 0.13.1 -> 0.13.2...
