-- =====================================================================
-- DakLak AI Guide: tạo bảng cho database PostgreSQL (Supabase)
-- Cách dùng: Supabase Dashboard → SQL Editor → New query → dán toàn bộ → Run
-- Chạy lại nhiều lần vẫn an toàn (IF NOT EXISTS / ON CONFLICT).
-- =====================================================================

-- ---------- Danh mục ----------
CREATE TABLE IF NOT EXISTS placecategories (
    categoryid   SERIAL PRIMARY KEY,
    categoryname VARCHAR(200) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS ocopcategories (
    categoryid   SERIAL PRIMARY KEY,
    categoryname VARCHAR(200) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS culturalcategories (
    categoryid   SERIAL PRIMARY KEY,
    categoryname VARCHAR(200) NOT NULL UNIQUE
);

-- ---------- Địa điểm du lịch ----------
CREATE TABLE IF NOT EXISTS touristplaces (
    placeid     SERIAL PRIMARY KEY,
    name        VARCHAR(300) NOT NULL,
    description TEXT,
    categoryid  INT REFERENCES placecategories(categoryid) ON DELETE SET NULL,
    address     VARCHAR(500),
    latitude    NUMERIC(10, 7),
    longitude   NUMERIC(10, 7),
    ticketprice NUMERIC(12, 0),
    opentime    VARCHAR(20),
    closetime   VARCHAR(20),
    imageurl    TEXT,
    website     TEXT,
    isfeatured  BOOLEAN NOT NULL DEFAULT FALSE,
    createdat   TIMESTAMPTZ DEFAULT NOW()
);

-- ---------- Sản phẩm OCOP ----------
CREATE TABLE IF NOT EXISTS ocopproducts (
    productid   SERIAL PRIMARY KEY,
    name        VARCHAR(300) NOT NULL,
    description TEXT,
    categoryid  INT REFERENCES ocopcategories(categoryid) ON DELETE SET NULL,
    producer    VARCHAR(300),
    ocoplevel   INT CHECK (ocoplevel BETWEEN 1 AND 5),
    price       NUMERIC(12, 0),
    address     VARCHAR(500),
    latitude    NUMERIC(10, 7),
    longitude   NUMERIC(10, 7),
    website     TEXT,
    imageurl    TEXT,
    createdat   TIMESTAMPTZ DEFAULT NOW()
);

-- ---------- Bài viết văn hóa ----------
CREATE TABLE IF NOT EXISTS culturalarticles (
    articleid  SERIAL PRIMARY KEY,
    title      VARCHAR(300) NOT NULL,
    content    TEXT,
    categoryid INT REFERENCES culturalcategories(categoryid) ON DELETE SET NULL,
    imageurl   TEXT,
    createdat  TIMESTAMPTZ DEFAULT NOW()
);

-- ---------- Lễ hội & sự kiện ----------
CREATE TABLE IF NOT EXISTS events (
    eventid     SERIAL PRIMARY KEY,
    name        VARCHAR(300) NOT NULL,
    description TEXT,
    startdate   DATE,
    enddate     DATE,
    timenote    VARCHAR(200),
    location    VARCHAR(500),
    latitude    NUMERIC(10, 7),
    longitude   NUMERIC(10, 7),
    imageurl    TEXT,
    website     TEXT,
    isfeatured  BOOLEAN NOT NULL DEFAULT FALSE,
    createdat   TIMESTAMPTZ DEFAULT NOW(),
    CHECK (enddate IS NULL OR startdate IS NULL OR enddate >= startdate)
);

-- ---------- Ẩm thực ----------
CREATE TABLE IF NOT EXISTS foods (
    foodid      SERIAL PRIMARY KEY,
    name        VARCHAR(300) NOT NULL,
    description TEXT,
    foodtype    VARCHAR(100),
    pricerange  VARCHAR(100),
    wheretoeat  TEXT,
    address     VARCHAR(500),
    latitude    NUMERIC(10, 7),
    longitude   NUMERIC(10, 7),
    imageurl    TEXT,
    isfeatured  BOOLEAN NOT NULL DEFAULT FALSE,
    createdat   TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_events_startdate        ON events(startdate);
CREATE INDEX IF NOT EXISTS ix_touristplaces_categoryid    ON touristplaces(categoryid);
CREATE INDEX IF NOT EXISTS ix_ocopproducts_categoryid     ON ocopproducts(categoryid);
CREATE INDEX IF NOT EXISTS ix_culturalarticles_categoryid ON culturalarticles(categoryid);

-- Chặn truy cập trực tiếp qua API công khai của Supabase (anon key).
-- Backend .NET kết nối bằng user postgres nên không bị ảnh hưởng.
ALTER TABLE placecategories    ENABLE ROW LEVEL SECURITY;
ALTER TABLE ocopcategories     ENABLE ROW LEVEL SECURITY;
ALTER TABLE culturalcategories ENABLE ROW LEVEL SECURITY;
ALTER TABLE touristplaces      ENABLE ROW LEVEL SECURITY;
ALTER TABLE ocopproducts       ENABLE ROW LEVEL SECURITY;
ALTER TABLE culturalarticles   ENABLE ROW LEVEL SECURITY;
ALTER TABLE events             ENABLE ROW LEVEL SECURITY;
ALTER TABLE foods              ENABLE ROW LEVEL SECURITY;

-- =====================================================================
-- DỮ LIỆU MẪU (có thể xóa phần này nếu muốn nhập tay từ trang /admin)
-- Tọa độ chỉ là gần đúng; giá vé và giờ mở cửa để trống, bạn tự bổ sung.
-- =====================================================================

INSERT INTO placecategories (categoryname) VALUES
    ('Thác nước'), ('Hồ'), ('Buôn làng'), ('Bảo tàng'), ('Sinh thái'), ('Di tích')
ON CONFLICT (categoryname) DO NOTHING;

INSERT INTO ocopcategories (categoryname) VALUES
    ('Cà phê'), ('Ca cao - Sô cô la'), ('Mật ong'), ('Hồ tiêu'), ('Hạt điều - Mắc ca'),
    ('Trái cây - Sầu riêng'), ('Đồ uống'), ('Thủ công mỹ nghệ')
ON CONFLICT (categoryname) DO NOTHING;

INSERT INTO culturalcategories (categoryname) VALUES
    ('Lễ hội'), ('Âm nhạc - Cồng chiêng'), ('Kiến trúc'), ('Ẩm thực'), ('Phong tục')
ON CONFLICT (categoryname) DO NOTHING;

INSERT INTO touristplaces (name, description, categoryid, address, latitude, longitude, isfeatured)
SELECT v.name, v.description, c.categoryid, v.address, v.lat, v.lng, v.featured
FROM (VALUES
    ('Thác Dray Nur',
     'Một trong những thác nước hùng vĩ nhất trên dòng sông Sêrêpôk, gắn với truyền thuyết tình yêu của người Ê Đê.',
     'Thác nước', 'Xã Dray Sáp, huyện Krông Ana, Đắk Lắk', 12.5390, 107.8860, TRUE),
    ('Hồ Lắk',
     'Hồ nước ngọt tự nhiên lớn của Tây Nguyên, nổi tiếng với cảnh núi rừng, đi thuyền độc mộc và buôn Jun của người M''nông.',
     'Hồ', 'Thị trấn Liên Sơn, huyện Lắk, Đắk Lắk', 12.4180, 108.1800, TRUE),
    ('Khu du lịch Buôn Đôn',
     'Vùng đất gắn với nghề săn bắt và thuần dưỡng voi, có cầu treo, nhà sàn cổ và rừng khộp ven sông Sêrêpôk.',
     'Buôn làng', 'Xã Krông Na, huyện Buôn Đôn, Đắk Lắk', 12.8870, 107.7860, TRUE),
    ('Bảo tàng Thế giới Cà phê',
     'Bảo tàng với kiến trúc lấy cảm hứng từ nhà dài Ê Đê, trưng bày lịch sử và văn hóa cà phê thế giới.',
     'Bảo tàng', 'Đường Lê Thánh Tông, TP. Buôn Ma Thuột, Đắk Lắk', 12.6890, 108.0500, TRUE),
    ('Buôn Akô Dhông',
     'Buôn làng của người Ê Đê ngay trong lòng thành phố, còn giữ nhiều nhà dài truyền thống.',
     'Buôn làng', 'Phường Tân Lợi, TP. Buôn Ma Thuột, Đắk Lắk', 12.6940, 108.0470, FALSE)
) AS v(name, description, catname, address, lat, lng, featured)
JOIN placecategories c ON c.categoryname = v.catname
WHERE NOT EXISTS (SELECT 1 FROM touristplaces t WHERE t.name = v.name);

INSERT INTO culturalarticles (title, content, categoryid)
SELECT v.title, v.content, c.categoryid
FROM (VALUES
    ('Không gian văn hóa Cồng chiêng Tây Nguyên',
     'Không gian văn hóa Cồng chiêng Tây Nguyên được UNESCO công nhận là di sản văn hóa phi vật thể của nhân loại. Cồng chiêng gắn liền với các nghi lễ vòng đời và lễ hội nông nghiệp của đồng bào các dân tộc Tây Nguyên, trong đó có Đắk Lắk.',
     'Âm nhạc - Cồng chiêng'),
    ('Nhà dài của người Ê Đê',
     'Nhà dài là kiểu nhà sàn truyền thống của người Ê Đê, nơi nhiều thế hệ trong một gia đình theo chế độ mẫu hệ cùng sinh sống. Nhà càng dài thể hiện gia đình càng đông người.',
     'Kiến trúc'),
    ('Lễ hội Cà phê Buôn Ma Thuột',
     'Lễ hội tôn vinh cây cà phê và người trồng cà phê, thường có các hoạt động diễu hành, trình diễn cồng chiêng, hội chợ và giới thiệu các sản phẩm cà phê của Đắk Lắk.',
     'Lễ hội')
) AS v(title, content, catname)
JOIN culturalcategories c ON c.categoryname = v.catname
WHERE NOT EXISTS (SELECT 1 FROM culturalarticles a WHERE a.title = v.title);

-- Sự kiện: ngày cụ thể để trống (mỗi năm khác nhau), bạn cập nhật ngày thật trong trang /admin
INSERT INTO events (name, description, timenote, location, isfeatured)
SELECT v.name, v.description, v.timenote, v.location, v.featured
FROM (VALUES
    ('Lễ hội Cà phê Buôn Ma Thuột',
     'Lễ hội lớn nhất của Đắk Lắk, tôn vinh cây cà phê và người trồng cà phê với diễu hành đường phố, trình diễn cồng chiêng, hội chợ, triển lãm và thưởng thức cà phê.',
     'Thường vào tháng 3, hai năm tổ chức một lần', 'TP. Buôn Ma Thuột', TRUE),
    ('Hội đua voi Buôn Đôn',
     'Những chú voi cùng các nài voi tranh tài trên đường đua, thường được tổ chức cùng dịp lễ hội lớn của tỉnh. Có thêm các hoạt động voi bơi qua sông, voi đá bóng.',
     'Thường vào tháng 3', 'Huyện Buôn Đôn', TRUE),
    ('Lễ mừng lúa mới của người Ê Đê',
     'Nghi lễ tạ ơn thần linh sau mùa thu hoạch, có cúng rượu cần, đánh cồng chiêng và múa xoang cùng cộng đồng buôn làng.',
     'Sau mùa thu hoạch, khoảng cuối năm', 'Các buôn làng Ê Đê', FALSE)
) AS v(name, description, timenote, location, featured)
WHERE NOT EXISTS (SELECT 1 FROM events e WHERE e.name = v.name);

-- Ẩm thực: chưa ghi quán cụ thể và giá, bạn bổ sung trong trang /admin
INSERT INTO foods (name, description, foodtype, isfeatured)
SELECT v.name, v.description, v.foodtype, v.featured
FROM (VALUES
    ('Cơm lam',
     'Gạo nếp được cho vào ống tre non rồi nướng trên lửa than, khi chín có mùi thơm của tre và vị dẻo ngọt. Thường ăn cùng muối vừng hoặc gà nướng.',
     'Món chính', TRUE),
    ('Gà nướng',
     'Gà thả vườn tẩm ướp gia vị núi rừng như sả, ớt, mắc khén rồi nướng trên than hồng, da giòn, thịt săn chắc. Món ăn quen thuộc đi cùng cơm lam.',
     'Món chính', TRUE),
    ('Bún đỏ Buôn Ma Thuột',
     'Sợi bún to màu đỏ, ăn cùng chả cua, trứng cút, rau sống và nước dùng đậm vị. Món ăn sáng và ăn vặt quen thuộc của người Buôn Ma Thuột.',
     'Món chính', TRUE),
    ('Bánh ướt cuốn thịt nướng',
     'Bánh ướt mỏng cuốn thịt nướng hoặc nem nướng cùng rau rừng, chấm nước chấm pha từ nước thịt rất riêng của Buôn Ma Thuột.',
     'Món chính', FALSE),
    ('Canh cà đắng',
     'Món canh dân dã của người Ê Đê nấu từ cà đắng, thường kết hợp với cá khô, da trâu hoặc lá bép, có vị đắng nhẹ, cay của ớt và thơm của lá rừng.',
     'Món dân tộc', FALSE),
    ('Rượu cần',
     'Rượu ủ từ gạo, ngô hoặc sắn với men lá rừng, đựng trong ché và uống bằng cần trúc. Rượu cần gắn liền với lễ hội và sự hiếu khách của đồng bào Tây Nguyên.',
     'Đồ uống', TRUE),
    ('Cà phê Buôn Ma Thuột',
     'Đắk Lắk là thủ phủ cà phê Robusta của Việt Nam. Ghé Buôn Ma Thuột nên thử một ly cà phê phin đậm đà hoặc mua cà phê bột, cà phê hạt về làm quà.',
     'Đồ uống', TRUE)
) AS v(name, description, foodtype, featured)
WHERE NOT EXISTS (SELECT 1 FROM foods f WHERE f.name = v.name);
