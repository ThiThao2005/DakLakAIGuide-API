-- =====================================================================
-- DakLak AI Guide: THÊM ẢNH CHO CÁC MỤC CHƯA CÓ ẢNH
-- Ảnh lấy từ Wikimedia Commons (giấy phép tự do: CC BY / CC BY-SA / CC0 / Public domain).
-- Mỗi dòng ghi kèm tên file, giấy phép và trang gốc để ghi nguồn khi cần.
-- Chỉ cập nhật mục ĐANG TRỐNG ẢNH, không ghi đè ảnh bạn đã tự thêm.
-- Cách dùng: Supabase → SQL Editor → New query → dán → Run.
-- =====================================================================

-- ----- Địa điểm -----
-- Dray Nur Waterfall (49483462012).jpg | CC BY 2.0 | https://commons.wikimedia.org/wiki/File:Dray_Nur_Waterfall_(49483462012).jpg
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/52/Dray_Nur_Waterfall_%2849483462012%29.jpg/1280px-Dray_Nur_Waterfall_%2849483462012%29.jpg' WHERE placeid = 4 AND (imageurl IS NULL OR imageurl = '');
-- Yokdon7.JPG | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Yokdon7.JPG
UPDATE touristplaces SET imageurl = 'https://upload.wikimedia.org/wikipedia/commons/8/8b/Yokdon7.JPG' WHERE placeid = 12 AND (imageurl IS NULL OR imageurl = '');
-- Bãi Xép 1.jpg | CC BY-SA 4.0 | https://commons.wikimedia.org/wiki/File:B%C3%A3i_X%C3%A9p_1.jpg
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/23/B%C3%A3i_X%C3%A9p_1.jpg/1280px-B%C3%A3i_X%C3%A9p_1.jpg' WHERE placeid = 8 AND (imageurl IS NULL OR imageurl = '');
-- Bao tang Dak Lak 8.JPG | Public domain | https://commons.wikimedia.org/wiki/File:Bao_tang_Dak_Lak_8.JPG
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/47/Bao_tang_Dak_Lak_8.JPG/1280px-Bao_tang_Dak_Lak_8.JPG' WHERE placeid = 16 AND (imageurl IS NULL OR imageurl = '');
-- Biệt Điện Bảo Đại.jpg | CC BY-SA 4.0 | https://commons.wikimedia.org/wiki/File:Bi%E1%BB%87t_%C4%90i%E1%BB%87n_B%E1%BA%A3o_%C4%90%E1%BA%A1i.jpg
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/1e/Bi%E1%BB%87t_%C4%90i%E1%BB%87n_B%E1%BA%A3o_%C4%90%E1%BA%A1i.jpg/1280px-Bi%E1%BB%87t_%C4%90i%E1%BB%87n_B%E1%BA%A3o_%C4%90%E1%BA%A1i.jpg' WHERE placeid = 17 AND (imageurl IS NULL OR imageurl = '');
-- Buon ako dhong.JPG | CC BY-SA 4.0 | https://commons.wikimedia.org/wiki/File:Buon_ako_dhong.JPG
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/12/Buon_ako_dhong.JPG/1280px-Buon_ako_dhong.JPG' WHERE placeid = 1 AND (imageurl IS NULL OR imageurl = '');
-- Khai doan pagoda.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Khai_doan_pagoda.jpg
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9c/Khai_doan_pagoda.jpg/1280px-Khai_doan_pagoda.jpg' WHERE placeid = 6 AND (imageurl IS NULL OR imageurl = '');
-- Đầm Ô Loan, An Hiệp, Tuy An, Phú Yên.jpeg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:%C4%90%E1%BA%A7m_%C3%94_Loan,_An_Hi%E1%BB%87p,_Tuy_An,_Ph%C3%BA_Y%C3%AAn.jpeg
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/70/%C4%90%E1%BA%A7m_%C3%94_Loan%2C_An_Hi%E1%BB%87p%2C_Tuy_An%2C_Ph%C3%BA_Y%C3%AAn.jpeg/1280px-%C4%90%E1%BA%A7m_%C3%94_Loan%2C_An_Hi%E1%BB%87p%2C_Tuy_An%2C_Ph%C3%BA_Y%C3%AAn.jpeg' WHERE placeid = 13 AND (imageurl IS NULL OR imageurl = '');
-- Buôn Ma Thuột - buildings at Exile House former prison Apr 2024 01.jpg | CC BY-SA 4.0 | https://commons.wikimedia.org/wiki/File:Bu%C3%B4n_Ma_Thu%E1%BB%99t_-_buildings_at_Exile_House_former_prison_Apr_2024_01.jpg
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f2/Bu%C3%B4n_Ma_Thu%E1%BB%99t_-_buildings_at_Exile_House_former_prison_Apr_2024_01.jpg/1280px-Bu%C3%B4n_Ma_Thu%E1%BB%99t_-_buildings_at_Exile_House_former_prison_Apr_2024_01.jpg' WHERE placeid = 11 AND (imageurl IS NULL OR imageurl = '');
-- Gia long waterfall.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Gia_long_waterfall.jpg
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/57/Gia_long_waterfall.jpg/1280px-Gia_long_waterfall.jpg' WHERE placeid = 10 AND (imageurl IS NULL OR imageurl = '');
-- Krongkma03.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Krongkma03.jpg
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/ec/Krongkma03.jpg/1280px-Krongkma03.jpg' WHERE placeid = 18 AND (imageurl IS NULL OR imageurl = '');
-- Tháp Nhạn, Tuy Hòa, Phú Yên.JPG | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Th%C3%A1p_Nh%E1%BA%A1n,_Tuy_H%C3%B2a,_Ph%C3%BA_Y%C3%AAn.JPG
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/14/Th%C3%A1p_Nh%E1%BA%A1n%2C_Tuy_H%C3%B2a%2C_Ph%C3%BA_Y%C3%AAn.JPG/1280px-Th%C3%A1p_Nh%E1%BA%A1n%2C_Tuy_H%C3%B2a%2C_Ph%C3%BA_Y%C3%AAn.JPG' WHERE placeid = 15 AND (imageurl IS NULL OR imageurl = '');
-- Đỉnh Chư Yang Sin.jpg | CC BY-SA 4.0 | https://commons.wikimedia.org/wiki/File:%C4%90%E1%BB%89nh_Ch%C6%B0_Yang_Sin.jpg
UPDATE touristplaces SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e7/%C4%90%E1%BB%89nh_Ch%C6%B0_Yang_Sin.jpg/1280px-%C4%90%E1%BB%89nh_Ch%C6%B0_Yang_Sin.jpg' WHERE placeid = 20 AND (imageurl IS NULL OR imageurl = '');
-- ----- Ẩm thực -----
-- Avocado Hass - single and halved.jpg | CC BY-SA 4.0 | https://commons.wikimedia.org/wiki/File:Avocado_Hass_-_single_and_halved.jpg
UPDATE foods SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c9/Avocado_Hass_-_single_and_halved.jpg/1280px-Avocado_Hass_-_single_and_halved.jpg' WHERE foodid = 14 AND (imageurl IS NULL OR imageurl = '');
-- Vietnamese coffee brewing with metal filter.jpg | CC BY 2.0 | https://commons.wikimedia.org/wiki/File:Vietnamese_coffee_brewing_with_metal_filter.jpg
UPDATE foods SET imageurl = 'https://upload.wikimedia.org/wikipedia/commons/d/dd/Vietnamese_coffee_brewing_with_metal_filter.jpg' WHERE foodid = 2 AND (imageurl IS NULL OR imageurl = '');
-- Grilled chicken covered in chilli's.jpg | CC BY-SA 4.0 | https://commons.wikimedia.org/wiki/File:Grilled_chicken_covered_in_chilli%27s.jpg
UPDATE foods SET imageurl = 'https://upload.wikimedia.org/wikipedia/commons/3/39/Grilled_chicken_covered_in_chilli%27s.jpg' WHERE foodid = 6 AND (imageurl IS NULL OR imageurl = '');
-- Ruou can jars in E De long house.png | Public domain | https://commons.wikimedia.org/wiki/File:Ruou_can_jars_in_E_De_long_house.png
UPDATE foods SET imageurl = 'https://upload.wikimedia.org/wikipedia/commons/7/71/Ruou_can_jars_in_E_De_long_house.png' WHERE foodid = 1 AND (imageurl IS NULL OR imageurl = '');
-- Banh hoi.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Banh_hoi.jpg
UPDATE foods SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/08/Banh_hoi.jpg/1280px-Banh_hoi.jpg' WHERE foodid = 13 AND (imageurl IS NULL OR imageurl = '');
-- Một số tổ ong tại Cát Bà.jpg | Public domain | https://commons.wikimedia.org/wiki/File:M%E1%BB%99t_s%E1%BB%91_t%E1%BB%95_ong_t%E1%BA%A1i_C%C3%A1t_B%C3%A0.jpg
UPDATE foods SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c2/M%E1%BB%99t_s%E1%BB%91_t%E1%BB%95_ong_t%E1%BA%A1i_C%C3%A1t_B%C3%A0.jpg/1280px-M%E1%BB%99t_s%E1%BB%91_t%E1%BB%95_ong_t%E1%BA%A1i_C%C3%A1t_B%C3%A0.jpg' WHERE foodid = 11 AND (imageurl IS NULL OR imageurl = '');
-- Durian in Vietnam (49372869308).jpg | CC BY 2.0 | https://commons.wikimedia.org/wiki/File:Durian_in_Vietnam_(49372869308).jpg
UPDATE foods SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/05/Durian_in_Vietnam_%2849372869308%29.jpg/1280px-Durian_in_Vietnam_%2849372869308%29.jpg' WHERE foodid = 15 AND (imageurl IS NULL OR imageurl = '');
-- Kkomak (Tegillarca granosa).jpg | CC BY-SA 2.0 kr | https://commons.wikimedia.org/wiki/File:Kkomak_(Tegillarca_granosa).jpg
UPDATE foods SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/34/Kkomak_%28Tegillarca_granosa%29.jpg/1280px-Kkomak_%28Tegillarca_granosa%29.jpg' WHERE foodid = 9 AND (imageurl IS NULL OR imageurl = '');
-- ----- Sự kiện -----
-- Voi ở Bản Đôn.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Voi_%E1%BB%9F_B%E1%BA%A3n_%C4%90%C3%B4n.jpg
UPDATE events SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/dc/Voi_%E1%BB%9F_B%E1%BA%A3n_%C4%90%C3%B4n.jpg/1280px-Voi_%E1%BB%9F_B%E1%BA%A3n_%C4%90%C3%B4n.jpg' WHERE eventid = 1 AND (imageurl IS NULL OR imageurl = '');
-- Nhà mồ Tây Nguyên.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Nh%C3%A0_m%E1%BB%93_T%C3%A2y_Nguy%C3%AAn.jpg
UPDATE events SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/80/Nh%C3%A0_m%E1%BB%93_T%C3%A2y_Nguy%C3%AAn.jpg/1280px-Nh%C3%A0_m%E1%BB%93_T%C3%A2y_Nguy%C3%AAn.jpg' WHERE eventid = 6 AND (imageurl IS NULL OR imageurl = '');
-- Bộ cồng chiêng.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:B%E1%BB%99_c%E1%BB%93ng_chi%C3%AAng.jpg
UPDATE events SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/29/B%E1%BB%99_c%E1%BB%93ng_chi%C3%AAng.jpg/1280px-B%E1%BB%99_c%E1%BB%93ng_chi%C3%AAng.jpg' WHERE eventid = 3 AND (imageurl IS NULL OR imageurl = '');
-- Buôn Ma Thuột city square.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Bu%C3%B4n_Ma_Thu%E1%BB%99t_city_square.jpg
UPDATE events SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/2e/Bu%C3%B4n_Ma_Thu%E1%BB%99t_city_square.jpg/1280px-Bu%C3%B4n_Ma_Thu%E1%BB%99t_city_square.jpg' WHERE eventid = 2 AND (imageurl IS NULL OR imageurl = '');
-- Lak Lake.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Lak_Lake.jpg
UPDATE events SET imageurl = 'https://upload.wikimedia.org/wikipedia/commons/9/9a/Lak_Lake.jpg' WHERE eventid = 5 AND (imageurl IS NULL OR imageurl = '');
-- ----- Văn hóa -----
-- Ruou can for sale.jpg | Public domain | https://commons.wikimedia.org/wiki/File:Ruou_can_for_sale.jpg
UPDATE culturalarticles SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/90/Ruou_can_for_sale.jpg/1280px-Ruou_can_for_sale.jpg' WHERE articleid = 11 AND (imageurl IS NULL OR imageurl = '');
-- Ede longhouse, Museum of Ethnology, Hanoi (37608576475).jpg | CC BY 2.0 | https://commons.wikimedia.org/wiki/File:Ede_longhouse,_Museum_of_Ethnology,_Hanoi_(37608576475).jpg
UPDATE culturalarticles SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/04/Ede_longhouse%2C_Museum_of_Ethnology%2C_Hanoi_%2837608576475%29.jpg/1280px-Ede_longhouse%2C_Museum_of_Ethnology%2C_Hanoi_%2837608576475%29.jpg' WHERE articleid = 12 AND (imageurl IS NULL OR imageurl = '');
-- Buon ako nha san.JPG | CC BY-SA 4.0 | https://commons.wikimedia.org/wiki/File:Buon_ako_nha_san.JPG
UPDATE culturalarticles SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/12/Buon_ako_nha_san.JPG/1280px-Buon_ako_nha_san.JPG' WHERE articleid = 4 AND (imageurl IS NULL OR imageurl = '');
-- House column, Ede - Vietnam Museum of Ethnology - Hanoi, Vietnam - DSC02760.JPG | CC0 | https://commons.wikimedia.org/wiki/File:House_column,_Ede_-_Vietnam_Museum_of_Ethnology_-_Hanoi,_Vietnam_-_DSC02760.JPG
UPDATE culturalarticles SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/11/House_column%2C_Ede_-_Vietnam_Museum_of_Ethnology_-_Hanoi%2C_Vietnam_-_DSC02760.JPG/1280px-House_column%2C_Ede_-_Vietnam_Museum_of_Ethnology_-_Hanoi%2C_Vietnam_-_DSC02760.JPG' WHERE articleid = 5 AND (imageurl IS NULL OR imageurl = '');
-- Dan toc hoc 19.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Dan_toc_hoc_19.jpg
UPDATE culturalarticles SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/1f/Dan_toc_hoc_19.jpg/1280px-Dan_toc_hoc_19.jpg' WHERE articleid = 6 AND (imageurl IS NULL OR imageurl = '');
-- Bài chòi Hội An 3.JPG | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:B%C3%A0i_ch%C3%B2i_H%E1%BB%99i_An_3.JPG
UPDATE culturalarticles SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/fc/B%C3%A0i_ch%C3%B2i_H%E1%BB%99i_An_3.JPG/1280px-B%C3%A0i_ch%C3%B2i_H%E1%BB%99i_An_3.JPG' WHERE articleid = 7 AND (imageurl IS NULL OR imageurl = '');
-- Mnong mahout.jpg | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Mnong_mahout.jpg
UPDATE culturalarticles SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/24/Mnong_mahout.jpg/1280px-Mnong_mahout.jpg' WHERE articleid = 9 AND (imageurl IS NULL OR imageurl = '');
-- The house on stilts of Ede people in a central highland.JPG | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:The_house_on_stilts_of_Ede_people_in_a_central_highland.JPG
UPDATE culturalarticles SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ab/The_house_on_stilts_of_Ede_people_in_a_central_highland.JPG/1280px-The_house_on_stilts_of_Ede_people_in_a_central_highland.JPG' WHERE articleid = 2 AND (imageurl IS NULL OR imageurl = '');
-- Vietnam - coffee plantation.jpg | CC BY 4.0 | https://commons.wikimedia.org/wiki/File:Vietnam_-_coffee_plantation.jpg
UPDATE culturalarticles SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/12/Vietnam_-_coffee_plantation.jpg/1280px-Vietnam_-_coffee_plantation.jpg' WHERE articleid = 3 AND (imageurl IS NULL OR imageurl = '');
-- Tay Nguyen gongs.JPG | CC BY-SA 3.0 | https://commons.wikimedia.org/wiki/File:Tay_Nguyen_gongs.JPG
UPDATE culturalarticles SET imageurl = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/18/Tay_Nguyen_gongs.JPG/1280px-Tay_Nguyen_gongs.JPG' WHERE articleid = 1 AND (imageurl IS NULL OR imageurl = '');

-- Kiểm tra: số mục còn thiếu ảnh
SELECT 'Địa điểm' AS bang, COUNT(*) FILTER (WHERE imageurl IS NULL OR imageurl = '') AS thieu_anh FROM touristplaces
UNION ALL SELECT 'Ẩm thực', COUNT(*) FILTER (WHERE imageurl IS NULL OR imageurl = '') FROM foods
UNION ALL SELECT 'Sự kiện', COUNT(*) FILTER (WHERE imageurl IS NULL OR imageurl = '') FROM events
UNION ALL SELECT 'Văn hóa', COUNT(*) FILTER (WHERE imageurl IS NULL OR imageurl = '') FROM culturalarticles;
