# Test Teko

    1. Trang admin quản lý
    • Famework: sử dụng Gin để code web API, dùng Gorm để giao tiếp với db
    • DB: Postgresql
    a. Register, Login, Logout:
    • Register: 
        ◦ Lấy thông tin nhập vào của người dùng lưu vào table user
        ◦ Thông tin của người dùng sẽ được chuẩn hoá về 1 chuẩn nhất định
        ◦ Lưu user_name và pass đã được hash vào table account
        ◦ Xet type của account là “admin”
    • Login:
        ◦ Nhập thông tin user_name, password
        ◦ Query từ table account thông qua user_name
        ◦ Pass sẽ được hash và so sánh với field haspwd trong table account
        ◦ Sinh ra AdminToken lúc login để sử dụng
        ◦ Nếu đúng thì sẽ thông báo là đăng nhập thành công và sai sẽ báo lỗi
    • Logout:
        ◦ Nhận request logout
        ◦ Xoá token login và trả về trang đăng nhập 
    b. Các suất chiếu:
    • Create: Tạo các khung giờ chiếu và lưu vào table time_show, field created_at đc cập nhật
    • Update: Update khung giờ chiếu và lưu vào table time_show, field updated_at được cập nhật
    • Delete: cập nhật field deleted_at trong table time_show
    • Get:
        ◦ Kiểm tra account có type là “admin”  hay không nếu không thì trả về lỗi
        ◦ Query từ table time_show ta sẽ được các suất chiếu
        ◦ Trả về kết quả cho admin
    c. Các bộ phim đang chiếu/ sắp chiếu:
    • Create: Tạo các film lưu table film, và tạo dữ liệu cho table time_show, field created_at của 2 table được cập nhật
    • Update: Update khung giờ trong table time_show, field updated_at được cật nhật
    • Delete: cập nhật field deleted_at trong table time_show
    • Get:
        ◦ Kiểm tra account có type là “admin”  hay không nếu không thì trả về lỗi
        ◦ query db từ bảng film với deleted_at != nil sẽ ra các film đang chiếu và sắp chiếu
        ◦ Trả về kết quả cho admin
    d. Giao dịch mua vé xem phim:
    • Create: Tạo giao dịch và lưu vào table transaction_ticket, field created_at được cập nhật
    • Update: // hành động này không nên có
    • Delete: cập nhật field deleted_at trong table transaction_ticket
    • Get: 
        ◦ Kiểm tra account có type là “admin”  hay không nếu không thì trả về lỗi
        ◦ Query từ table transaction_ticket để xem giao dịch
        ◦ Trả về kết quả cho admin
    e. Phương án tối ưu DB Structure: 
    • Thêm các trigger để ràng buộc dữ liệu chặt chẽ hơn
    • Lúc giao dịch mua vé xảy ra có thể thêm trigger để kiểm tra mảng ticket_id có id nào 
    không tồn tại trong table ticket không
    • Có thể phân quyền phần account để phát triển thêm cho ứng dụng
    • Có thể kết thêm các loại vé (vip, hạng 1, hạng 2)
    2. 5 ResfulAPI cho app frontend: sử dụng công nghệ như trang admin 
    • ListFilmShowing (Xem các film đang chiếu/sắp chiếu): Query từ table film với deleted_at != nil sẽ cho ra các film đang chiếu và sắp chiếu 
    • ListLocationgFree (Xem ghế còn trống trong rạp): Query từ table cinema_location với rạp được chọn và field free == true 
    • ListCinemaOpen (Xem các rạp còn ghế để mua): Query từ table cinema_location với  field free == true 
    • TicketTransaction (giao dịch mua vé xem phim):
        ◦ Query từ table ticket_cinema để xem số vé còn trống
        ◦ Update bảng ticket field updated_at để thể hiện vé đã được mua với các ID từ lúc chọn vé trống để mua ở bước trên
        ◦ Create vào table transaction_ticket field mới với field ticket_id là mảng các ID được chọn từ bước trên, price là tổng giá vé bán được, user_id là id của người bán để tiện quản lí
        ◦ Tất cả các bước trên được đặt trong 1 transaction để thực hiện tuần từ và bảo đảm rằng database được nhất quán và nếu có lỗi ở bước nào trước đó thì mọi hành động update database không được thực hiện

    • Register (đăng ký): 
        ◦ Lấy thông tin nhập vào của người dùng lưu vào table user
        ◦ Thông tin của người dùng sẽ được chuẩn hoá về 1 chuẩn nhất định
        ◦ Lưu user_name và pass đã được hash vào table account
    • Login (đăng nhập):
        ◦ Nhập thông tin user_name, password
        ◦ Query từ table account thông qua user_name
        ◦ Pass sẽ được hash và so sánh với field haspwd trong table account
        ◦ Sinh ra AuthToken lúc login để sử dụng
        ◦ Nếu đúng thì sẽ thông báo là đăng nhập thành công và sai sẽ báo lỗi
    3. 5 ResfulAPI để đối tác ví điện tử tích hợp vào:
         ◦ CompleteTransactionTicket (hoàn tất giao dịch mua vé):
         ◦ BuyTicket (mua vé):
                o Kiểm tra account đăng có quyền là “3 rd ”
                o Tạo ra 1 TransactionTicket như mục 2 với user_id là id user của account 3 rd
         ◦ CancelTicket(Huỷ vé):
                o Kiểm tra account đăng có quyền là “3 rd ”4.
                o Update field deleted_at trong table transaction_ticket
         ◦ BookTicket( Đặt vé):
                o Kiểm tra account đăng có quyền là “3 rd ”
                o Tạo dữ liệu cho table book_ticket
    4. Trang Report: 
    • Top 5 film ăn khách nhất: 
        ◦ Query từ bảng time_show được film chiếu 3 ngày gần đây
        ◦ Từ film được chiếu query ra được cinema_film_id từ table cinema_fim
        ◦ Từ id query được ở trên ta query từ table cinema_film_ticket được ticket_id và đếm số lần xuất hiện của mỗi ticket_id và trả về 5 ticket có số lần xuất hiện nhiều nhất
    5. Setup docker compose: file docker-compose.yml trong source
    6. CI/CD: dùng gitlabCI để setup