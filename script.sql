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
    tattoerid UUID REFERENCES tattooers(id) NOT NULL,
    active BOOLEAN NOT NULL,
    caption TEXT NOT NULL,
    style VARCHAR(100) [] NOT NULL,
    color VARCHAR(100) [] NOT NULL,
    size VARCHAR(100) [] NOT NULL,
    zip NUMERIC(5) NOT NULL,
    image TEXT NOT NULL,
    createddate TIMESTAMPTZ,
    PRIMARY KEY (id)
);

CREATE TABLE portfolio (
    id UUID DEFAULT uuid_generate_v4(),
    tattoerid UUID REFERENCES tattooers(id) NOT NULL,
    images TEXT [] NOT NULL,
    createddate TIMESTAMPTZ,
    PRIMARY KEY (id)
);

-- INSERT INTO pieces (caption, style, color, size, zip, images, tattooerid, active)
--     VALUES
--         ('goldfish',  {'Hyper-realistic', '3D', 'Dotwork'}, {'Color'}, {'Medium', 'Large'}, '30307', {'http://1.bp.blogspot.com/-tDHqfK4oZgI/UOwbeYpFLYI/AAAAAAAAE4s/FB36NyaLd1k/s1600/Godlfish-Wallpapers-09.jpg', 'https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Fdigitalfire.ucd.ie%2Fwp-content%2Fuploads%2F2012%2F10%2Fshutterstock_70361200.jpg&f=1'}, 'e394eb0f-c15c-42c7-83f2-1d3e018dc1e5'),
--         ('eyeball like MC Escher', {'3D', 'Biomechanical'}, {'Black', 'Color'}, {'Small'}, '30324', {'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.3aPvCIZdOTXLiCWnv75BAAHaFj%26pid%3D15.1&f=1'}, '7a6832c1-f430-47c5-99fd-dd8b04b63d40'),
--         ('A victorian, shapeshifting raven', {'New School'}, {'Black'}, {'Large'}, '10472', {'https://creatureofthewheel.files.wordpress.com/2013/02/bauchelain-korbal.jpg', 'https://i.ytimg.com/vi/DDv_PlrBg14/maxresdefault.jpg'}, '44a713c1-5355-4093-8ec2-b160fe2427c5'),
--         ('A geo turtle with an island on his back', {'Geometric'}, {'Color'}, {'Large'}, '20833', {'https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2F1.bp.blogspot.com%2F-g1DR8c9QL6c%2FUXVvfPYoa-I%2FAAAAAAAAA-A%2Fc26XfELhFog%2Fs640%2FTurtle%2BIsland.jpg&f=1'}, 'd292871b-038b-4162-a752-bbc565970274');

-- INSERT INTO portfolio (upload, tattooerid)
--     VALUES
--         ('https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fhypnomariachi.files.wordpress.com%2F2014%2F12%2Fturtle_by_milicaclk-d7hyc3h.jpg&f=1', 'd638a833-55da-49e1-a3e6-51f077a7796a'),
--         ('https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fpm1.narvii.com%2F6306%2Fa52da484c66c46abe5f98e9556136db472e9932a_hq.jpg&f=1', 'cb651d2e-bbad-43f1-ba33-2b43dfdab4cb'),
--         ('https://proxy.duckduckgo.com/iur/?f=1&image_host=http%3A%2F%2Frattatattoo.com%2Fwp-content%2Fuploads%2F2013%2F02%2FNiki-Norberg-combines-greyscale-and-color-areas-to-add-appeal-to-this-realistic-eye-tattoo.jpg&u=https://rattatattoo.com/wp-content/uploads/2013/02/Niki-Norberg-combines-greyscale-and-color-areas-to-add-appeal-to-this-realistic-eye-tattoo.jpg', '83ae2135-5dee-421d-a9a4-f52546af1332'),
--         ('https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2F3.bp.blogspot.com%2F-LSF96prYGtw%2FUw7hR-UMsFI%2FAAAAAAAAD1Y%2FIWRQKsKHcvs%2Fs1600%2FIMG_5165-2cropwm.jpg&f=1', '9a376563-c4e4-45c3-b552-5512503a42f9');

