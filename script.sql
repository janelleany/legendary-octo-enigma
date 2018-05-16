DROP DATABASE IF EXISTS inkkarma;
CREATE DATABASE inkkarma;

\c inkkarma;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE tattooers (
    id UUID DEFAULT uuid_generate_v4(),
    email VARCHAR(100) UNIQUE NOT NULL,
    alias VARCHAR(100) UNIQUE NOT NULL,
    hash VARCHAR(200) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE collectors (
    id UUID DEFAULT uuid_generate_v4(),
    email VARCHAR(100) UNIQUE NOT NULL,
    alias VARCHAR(100) UNIQUE NOT NULL,
    hash VARCHAR(200) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE pieces (
    id UUID DEFAULT uuid_generate_v4(),
    tattooerid UUID REFERENCES tattooers(id) NOT NULL,
    active BOOLEAN NOT NULL,
    caption TEXT NOT NULL,
    style VARCHAR(100) [] NOT NULL,
    color VARCHAR(100) [] NOT NULL,
    size VARCHAR(100) [] NOT NULL,
    price NUMERIC(3) NOT NULL,
    deposit NUMERIC(2) NOT NULL,
    zip NUMERIC(5) NOT NULL,
    img TEXT NOT NULL,
    createddate TIMESTAMPTZ,
    PRIMARY KEY (id)
);

CREATE TABLE portfolio (
    id UUID DEFAULT uuid_generate_v4(),
    tattooerid UUID REFERENCES tattooers(id) NOT NULL,
    images TEXT [] NOT NULL,
    createddate TIMESTAMPTZ,
    PRIMARY KEY (id)
);

-- INSERT INTO pieces (caption, style, color, size, zip, img, tattooerid, active)
--     VALUES
--         ('goldfish',  ARRAY ['Hyper-realistic', '3D', 'Dotwork'], ARRAY ['Color'], ARRAY ['Medium', 'Large'], '30307', 'http://1.bp.blogspot.com/-tDHqfK4oZgI/UOwbeYpFLYI/AAAAAAAAE4s/FB36NyaLd1k/s1600/Godlfish-Wallpapers-09.jpg', '174c3a4a-4808-4bb3-8e05-d5ce20b3558b', 'true'),
--         ('eyeball like MC Escher', ARRAY ['3D', 'Biomechanical'], ARRAY ['Black', 'Color'], ARRAY ['Small'], '30324', 'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.3aPvCIZdOTXLiCWnv75BAAHaFj%26pid%3D15.1&f=1', '174c3a4a-4808-4bb3-8e05-d5ce20b3558b', 'true'),
--         ('A victorian, shapeshifting raven', ARRAY ['New School'], ARRAY ['Black'], ARRAY ['Large'], '10472', 'https://creatureofthewheel.files.wordpress.com/2013/02/bauchelain-korbal.jpg', '174c3a4a-4808-4bb3-8e05-d5ce20b3558b', 'true'),
--         ('A geo turtle with an island on his back', ARRAY ['Geometric'], ARRAY ['Color'], ARRAY ['Large'], '20833', 'https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2F1.bp.blogspot.com%2F-g1DR8c9QL6c%2FUXVvfPYoa-I%2FAAAAAAAAA-A%2Fc26XfELhFog%2Fs640%2FTurtle%2BIsland.jpg&f=1', '174c3a4a-4808-4bb3-8e05-d5ce20b3558b', 'true');

-- INSERT INTO portfolio (upload, tattooerid)
--     VALUES
--         ('https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fhypnomariachi.files.wordpress.com%2F2014%2F12%2Fturtle_by_milicaclk-d7hyc3h.jpg&f=1', 'd638a833-55da-49e1-a3e6-51f077a7796a'),
--         ('https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fpm1.narvii.com%2F6306%2Fa52da484c66c46abe5f98e9556136db472e9932a_hq.jpg&f=1', 'cb651d2e-bbad-43f1-ba33-2b43dfdab4cb'),
--         ('https://proxy.duckduckgo.com/iur/?f=1&image_host=http%3A%2F%2Frattatattoo.com%2Fwp-content%2Fuploads%2F2013%2F02%2FNiki-Norberg-combines-greyscale-and-color-areas-to-add-appeal-to-this-realistic-eye-tattoo.jpg&u=https://rattatattoo.com/wp-content/uploads/2013/02/Niki-Norberg-combines-greyscale-and-color-areas-to-add-appeal-to-this-realistic-eye-tattoo.jpg', '83ae2135-5dee-421d-a9a4-f52546af1332'),
--         ('https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2F3.bp.blogspot.com%2F-LSF96prYGtw%2FUw7hR-UMsFI%2FAAAAAAAAD1Y%2FIWRQKsKHcvs%2Fs1600%2FIMG_5165-2cropwm.jpg&f=1', '9a376563-c4e4-45c3-b552-5512503a42f9');

