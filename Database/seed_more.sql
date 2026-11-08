-- =====================================================================
-- DakLak AI Guide: DỮ LIỆU MẪU BỔ SUNG
-- Chạy SAU schema.sql. Cách dùng: Supabase → SQL Editor → New query → dán → Run.
-- Chạy lại nhiều lần vẫn an toàn (không tạo trùng theo tên).
--
-- Lưu ý:
-- * Từ 01/7/2025, tỉnh Phú Yên sáp nhập vào tỉnh Đắk Lắk (trung tâm hành chính
--   vẫn là Buôn Ma Thuột) và cấp huyện không còn. Vì vậy dữ liệu có thêm vùng biển
--   Phú Yên cũ, địa chỉ ghi theo khu vực (kèm chữ "cũ") thay cho huyện.
-- * Tọa độ là GẦN ĐÚNG để hiện trên bản đồ; giá vé, giờ mở cửa, ngày lễ hội cụ thể
--   để trống vì thay đổi theo năm. Bạn bổ sung/kiểm tra lại trong trang /admin.
-- =====================================================================

-- ---------- Danh mục bổ sung ----------
INSERT INTO placecategories (categoryname) VALUES ('Biển - Đảo')
ON CONFLICT (categoryname) DO NOTHING;

INSERT INTO culturalcategories (categoryname) VALUES
    ('Văn học dân gian'), ('Nghề truyền thống'), ('Tín ngưỡng'), ('Nghệ thuật trình diễn')
ON CONFLICT (categoryname) DO NOTHING;

-- =====================================================================
-- ĐỊA ĐIỂM DU LỊCH
-- =====================================================================
INSERT INTO touristplaces (name, description, categoryid, address, latitude, longitude, isfeatured)
SELECT v.name, v.description, c.categoryid, v.address, v.lat, v.lng, v.featured
FROM (VALUES
    -- ----- Vùng Buôn Ma Thuột và lân cận -----
    ('Thác Gia Long',
     'Thác nằm trên dòng Sêrêpôk, gần cụm thác Dray Nur. Dòng nước đổ qua những vách đá bazan, xung quanh là rừng cây và bãi đá rộng, thích hợp dã ngoại và chụp ảnh.',
     'Thác nước', 'Khu vực Krông Ana (cũ), Đắk Lắk', 12.5560::numeric, 107.8850::numeric, FALSE),
    ('Thác Krông Kmar',
     'Thác nằm ở chân dãy Chư Yang Sin, nước trong và mát quanh năm. Đường đến thác đi qua vùng núi rừng còn hoang sơ.',
     'Thác nước', 'Khu vực Krông Bông (cũ), Đắk Lắk', NULL::numeric, NULL::numeric, FALSE),
    ('Vườn quốc gia Yok Đôn',
     'Vườn quốc gia lớn nhất Việt Nam, nổi bật với hệ sinh thái rừng khộp đặc trưng Tây Nguyên. Du khách có thể đi bộ xuyên rừng, ngắm chim, cắm trại và tìm hiểu chương trình bảo tồn voi.',
     'Sinh thái', 'Khu vực Buôn Đôn (cũ), Đắk Lắk', 12.8800, 107.7300, TRUE),
    ('Vườn quốc gia Chư Yang Sin',
     'Nơi có đỉnh Chư Yang Sin, một trong những đỉnh núi cao nhất Tây Nguyên. Rừng nguyên sinh với nhiều loài động thực vật quý hiếm, hợp với những ai thích leo núi, trekking.',
     'Sinh thái', 'Khu vực Krông Bông – Lắk (cũ), Đắk Lắk', NULL::numeric, NULL::numeric, FALSE),
    ('Hồ Ea Kao',
     'Hồ nước rộng gần trung tâm Buôn Ma Thuột, xung quanh là đồi cà phê và vườn cây. Nơi được người dân thành phố chọn để cắm trại, ngắm hoàng hôn cuối tuần.',
     'Hồ', 'Khu vực Ea Kao, TP. Buôn Ma Thuột, Đắk Lắk', NULL::numeric, NULL::numeric, FALSE),
    ('Bảo tàng Đắk Lắk',
     'Bảo tàng giới thiệu thiên nhiên, lịch sử và văn hóa các dân tộc Tây Nguyên: cồng chiêng, nhà dài, trang phục, công cụ săn bắt và thuần dưỡng voi.',
     'Bảo tàng', 'Trung tâm TP. Buôn Ma Thuột, Đắk Lắk', NULL::numeric, NULL::numeric, FALSE),
    ('Chùa Sắc tứ Khải Đoan',
     'Ngôi chùa cổ của Buôn Ma Thuột, kiến trúc kết hợp phong cách chùa Việt với nét nhà rông, nhà dài Tây Nguyên. Không gian yên tĩnh giữa lòng thành phố.',
     'Di tích', 'Trung tâm TP. Buôn Ma Thuột, Đắk Lắk', NULL::numeric, NULL::numeric, FALSE),
    ('Di tích Nhà đày Buôn Ma Thuột',
     'Nhà tù do thực dân Pháp xây dựng để giam giữ tù chính trị, nay là di tích lịch sử quốc gia. Nơi tìm hiểu về lịch sử đấu tranh cách mạng ở Tây Nguyên.',
     'Di tích', 'TP. Buôn Ma Thuột, Đắk Lắk', NULL::numeric, NULL::numeric, FALSE),
    ('Biệt điện Bảo Đại',
     'Dinh thự nghỉ dưỡng của vua Bảo Đại khi lên Buôn Ma Thuột săn bắn, mang kiến trúc Pháp pha nét nhà sàn. Bên trong trưng bày hiện vật về đời sống, văn hóa Tây Nguyên.',
     'Di tích', 'TP. Buôn Ma Thuột, Đắk Lắk', NULL::numeric, NULL::numeric, FALSE),
    ('Làng gốm Yang Tao',
     'Làng của người M''nông còn giữ nghề làm gốm thủ công: nặn tay không dùng bàn xoay và nung lộ thiên bằng rơm, củi. Du khách có thể xem nghệ nhân làm gốm và mua sản phẩm làm quà.',
     'Buôn làng', 'Khu vực Lắk (cũ), Đắk Lắk', NULL::numeric, NULL::numeric, FALSE),

    -- ----- Vùng biển Phú Yên cũ -----
    ('Gành Đá Đĩa',
     'Bãi đá bazan xếp thành từng cột hình lục giác như những chiếc đĩa chồng lên nhau, được hình thành từ dung nham núi lửa nguội đi gặp nước biển. Danh thắng nổi tiếng nhất vùng biển.',
     'Biển - Đảo', 'Khu vực An Ninh Đông, Tuy An (cũ), Đắk Lắk', 13.3590, 109.2950, TRUE),
    ('Mũi Điện (Mũi Đại Lãnh)',
     'Điểm cực Đông trên đất liền Việt Nam, nơi đón ánh bình minh sớm nhất. Trên đỉnh có ngọn hải đăng cổ do người Pháp xây dựng, bên dưới là Bãi Môn nước trong xanh.',
     'Biển - Đảo', 'Khu vực Hòa Tâm, Đông Hòa (cũ), Đắk Lắk', 12.8950, 109.4580, TRUE),
    ('Đầm Ô Loan',
     'Đầm nước lợ rộng lớn, cảnh sắc thơ mộng với những vó lưới, nhà chồ. Nổi tiếng với món sò huyết và hoàng hôn trên đầm.',
     'Hồ', 'Khu vực Tuy An (cũ), Đắk Lắk', 13.2600, 109.2700, FALSE),
    ('Tháp Nhạn',
     'Ngôi tháp Chăm cổ trên núi Nhạn, bên bờ sông Đà Rằng, là biểu tượng của thành phố Tuy Hòa. Từ chân tháp có thể ngắm toàn cảnh thành phố và cửa biển.',
     'Di tích', 'Khu vực TP. Tuy Hòa (cũ), Đắk Lắk', 13.0940, 109.3070, FALSE),
    ('Bãi Xép',
     'Bãi biển nhỏ yên bình với bãi cỏ xanh, gành đá và làng chài, từng là bối cảnh của bộ phim "Tôi thấy hoa vàng trên cỏ xanh".',
     'Biển - Đảo', 'Khu vực An Phú, Tuy Hòa (cũ), Đắk Lắk', NULL::numeric, NULL::numeric, FALSE)
) AS v(name, description, catname, address, lat, lng, featured)
JOIN placecategories c ON c.categoryname = v.catname
WHERE NOT EXISTS (SELECT 1 FROM touristplaces t WHERE t.name = v.name);

-- =====================================================================
-- ẨM THỰC
-- =====================================================================
INSERT INTO foods (name, description, foodtype, isfeatured)
SELECT v.name, v.description, v.foodtype, v.featured
FROM (VALUES
    ('Lẩu cá lăng',
     'Cá lăng đánh bắt từ sông Sêrêpôk, thịt chắc, ngọt và ít xương, nấu lẩu chua cay cùng măng chua, cà chua và rau rừng. Món nên thử khi đến vùng Buôn Đôn, Dray Nur.',
     'Món chính', TRUE),
    ('Măng le',
     'Măng rừng hái vào mùa mưa, có vị ngọt và giòn. Người Tây Nguyên dùng măng le để luộc chấm muối é, xào thịt hoặc nấu canh.',
     'Món dân tộc', FALSE),
    ('Muối é (muối kiến vàng)',
     'Muối giã cùng ớt và lá é rừng, có nơi trộn thêm kiến vàng, vị cay thơm đặc trưng. Dùng chấm gà nướng, măng luộc, trái cây.',
     'Món dân tộc', FALSE),
    ('Bơ Đắk Lắk',
     'Đắk Lắk là vùng trồng bơ lớn, nổi tiếng với bơ sáp dẻo, béo ngậy. Mùa bơ rộ khoảng giữa năm, có thể ăn trực tiếp, làm sinh tố hoặc kem bơ.',
     'Đặc sản làm quà', TRUE),
    ('Sầu riêng Đắk Lắk',
     'Sầu riêng trồng trên đất đỏ bazan cơm vàng, dày, thơm và béo. Mùa thu hoạch chính thường vào khoảng giữa đến cuối năm.',
     'Đặc sản làm quà', FALSE),
    ('Mật ong hoa cà phê',
     'Mật ong do ong lấy từ hoa cà phê nở vào mùa khô, vị ngọt thanh và thơm nhẹ mùi hoa. Món quà đặc trưng của vùng đất cà phê.',
     'Đặc sản làm quà', FALSE),
    ('Mắt cá ngừ đại dương',
     'Đặc sản vùng biển Phú Yên cũ. Mắt cá ngừ được hầm thuốc bắc hoặc nướng, béo ngậy và bổ dưỡng.',
     'Món chính', TRUE),
    ('Sò huyết đầm Ô Loan',
     'Sò huyết nuôi tự nhiên ở đầm Ô Loan, thịt đỏ, ngọt, có thể nướng mỡ hành, xào me hoặc luộc chấm muối tiêu chanh.',
     'Món chính', FALSE),
    ('Bánh hỏi lòng heo',
     'Món ăn sáng quen thuộc của người Phú Yên: bánh hỏi mỏng dai ăn cùng lòng heo, cháo lòng và nước chấm đậm vị.',
     'Món ăn vặt', FALSE),
    ('Bánh tráng Hòa Đa',
     'Bánh tráng làng nghề Hòa Đa (vùng Phú Yên cũ) có rắc mè, nướng giòn thơm. Ăn kèm các món cuốn hoặc làm quà.',
     'Đặc sản làm quà', FALSE)
) AS v(name, description, foodtype, featured)
WHERE NOT EXISTS (SELECT 1 FROM foods f WHERE f.name = v.name);

-- =====================================================================
-- LỄ HỘI & SỰ KIỆN
-- =====================================================================
INSERT INTO events (name, description, timenote, location, isfeatured)
SELECT v.name, v.description, v.timenote, v.location, v.featured
FROM (VALUES
    ('Lễ cúng bến nước của người Ê Đê',
     'Bến nước là nơi lấy nguồn sống cho cả buôn. Sau mùa rẫy, dân làng làm lễ cúng thần nước để cầu mong nguồn nước trong lành, mùa màng bội thu, kèm đánh cồng chiêng và uống rượu cần.',
     'Thường vào mùa khô, sau thu hoạch', 'Các buôn làng Ê Đê', FALSE),
    ('Lễ bỏ mả',
     'Nghi lễ tiễn biệt người đã khuất lần cuối của nhiều dân tộc Tây Nguyên. Lễ kéo dài nhiều ngày với cồng chiêng, múa xoang, dựng nhà mồ và tượng gỗ.',
     'Mùa khô, tùy từng buôn làng', 'Các buôn làng Tây Nguyên', FALSE),
    ('Hội đua thuyền độc mộc',
     'Những chiếc thuyền độc mộc đẽo từ một thân cây lớn tranh tài trên mặt hồ, thường được tổ chức trong các dịp lễ hội lớn của tỉnh.',
     'Theo dịp lễ hội của tỉnh', 'Hồ Lắk', FALSE),
    ('Hội đua ngựa Gò Thì Thùng',
     'Hội đua ngựa truyền thống lâu đời của vùng Phú Yên cũ, tổ chức vào dịp đầu xuân. Các nài ngựa tranh tài trên một gò đất rộng, thu hút đông đảo người dân và du khách.',
     'Dịp Tết Nguyên đán (khoảng mùng 9 tháng Giêng)', 'Khu vực Đồng Xuân (cũ), Đắk Lắk', TRUE),
    ('Lễ hội cầu ngư',
     'Lễ hội của ngư dân vùng biển, cầu mong trời yên biển lặng, ra khơi bình an và đánh bắt được nhiều cá. Có rước, tế lễ, hát bả trạo và hội đua thuyền.',
     'Đầu năm, tùy từng làng biển', 'Các làng biển vùng Phú Yên cũ', FALSE)
) AS v(name, description, timenote, location, featured)
WHERE NOT EXISTS (SELECT 1 FROM events e WHERE e.name = v.name);

-- =====================================================================
-- VĂN HÓA TRUYỀN THỐNG
-- =====================================================================
INSERT INTO culturalarticles (title, content, categoryid)
SELECT v.title, v.content, c.categoryid
FROM (VALUES
    ('Sử thi Đam San',
     'Đam San là bộ sử thi (khan) nổi tiếng của người Ê Đê, kể về người anh hùng Đam San dũng cảm chinh phục Nữ thần Mặt Trời và chiến đấu bảo vệ buôn làng. Sử thi thường được nghệ nhân kể bên bếp lửa nhà dài suốt nhiều đêm liền.',
     'Văn học dân gian'),
    ('Chế độ mẫu hệ của người Ê Đê',
     'Người Ê Đê theo chế độ mẫu hệ: con cái mang họ mẹ, người phụ nữ giữ vai trò chủ nhà và quản lý tài sản. Khi cưới, nhà gái đi hỏi chồng và chàng trai về ở nhà vợ.',
     'Phong tục'),
    ('Luật tục Ê Đê',
     'Luật tục là hệ thống quy định truyền miệng điều chỉnh mọi mặt đời sống buôn làng, từ quan hệ gia đình, sở hữu đất đai đến bảo vệ rừng và nguồn nước. Luật tục được đọc theo lối văn vần, dễ nhớ, dễ truyền.',
     'Phong tục'),
    ('Nghề dệt thổ cẩm',
     'Phụ nữ Ê Đê, M''nông dệt thổ cẩm bằng khung dệt thủ công, dùng sợi bông nhuộm màu từ cây rừng. Hoa văn chủ yếu là hình thoi, răng cưa, đường kẻ với các màu đen, đỏ, vàng, trắng, thể hiện quan niệm về thiên nhiên và cuộc sống.',
     'Nghề truyền thống'),
    ('Ghế Kpan trong nhà dài',
     'Kpan là chiếc ghế dài được đẽo từ một thân cây lớn, đặt trong gian khách của nhà dài Ê Đê. Ghế dành cho các nghệ nhân ngồi đánh cồng chiêng trong lễ hội, và là biểu tượng cho sự giàu có, uy tín của gia đình.',
     'Kiến trúc'),
    ('Văn hóa rượu cần và ché',
     'Ché là vật quý của gia đình Tây Nguyên, được dùng ủ rượu cần và cũng là thước đo tài sản. Uống rượu cần có nghi thức riêng: chủ nhà mời khách theo thứ tự, mọi người uống chung quanh ché bằng cần trúc.',
     'Phong tục'),
    ('Nghề săn bắt và thuần dưỡng voi ở Buôn Đôn',
     'Buôn Đôn từng nổi tiếng là vùng đất săn bắt và thuần dưỡng voi rừng của người M''nông, Lào và Ê Đê. Ngày nay việc săn voi đã dừng, voi nhà được chăm sóc theo hướng bảo tồn và du lịch thân thiện với voi.',
     'Nghề truyền thống'),
    ('Nghề làm gốm của người M''nông',
     'Gốm Yang Tao được nặn hoàn toàn bằng tay, không dùng bàn xoay, rồi nung lộ thiên bằng rơm và củi. Sản phẩm có màu đất mộc mạc, phục vụ sinh hoạt hằng ngày như nồi, chum, bình nước.',
     'Nghề truyền thống'),
    ('Tín ngưỡng Yang của người Tây Nguyên',
     'Đồng bào Tây Nguyên tin rằng mọi vật đều có thần linh (Yang): thần lúa, thần núi, thần nước, thần rừng. Các lễ cúng trong năm như mừng lúa mới, cúng bến nước đều để tạ ơn và cầu xin các vị thần.',
     'Tín ngưỡng'),
    ('Nghệ thuật Bài Chòi',
     'Bài Chòi là loại hình vừa chơi vừa hát dân gian của miền Trung, trong đó có vùng Phú Yên cũ, được UNESCO ghi danh là Di sản văn hóa phi vật thể đại diện của nhân loại. Người chơi ngồi trong các chòi tre, nghe "anh hiệu" hát câu thai để đoán con bài.',
     'Nghệ thuật trình diễn')
) AS v(title, content, catname)
JOIN culturalcategories c ON c.categoryname = v.catname
WHERE NOT EXISTS (SELECT 1 FROM culturalarticles a WHERE a.title = v.title);

-- Kiểm tra nhanh số lượng sau khi chạy
SELECT 'Địa điểm' AS bang, COUNT(*) FROM touristplaces
UNION ALL SELECT 'Ẩm thực', COUNT(*) FROM foods
UNION ALL SELECT 'Sự kiện', COUNT(*) FROM events
UNION ALL SELECT 'Văn hóa', COUNT(*) FROM culturalarticles;
