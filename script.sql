DROP DATABASE IF EXISTS inkkarma;
CREATE DATABASE inkkarma;

\c inkkarma;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE artists (
    artistId UUID DEFAULT uuid_generate_v4(),
    email VARCHAR(100) UNIQUE NOT NULL,
    artistusername VARCHAR(100) UNIQUE NOT NULL,
    PRIMARY KEY (artistId)
);

CREATE TABLE canvases (
    canvasId UUID DEFAULT uuid_generate_v4(),
    email VARCHAR(100) UNIQUE NOT NULL,
    canvasusername VARCHAR(100) UNIQUE NOT NULL,
    PRIMARY KEY (canvasId)
);

CREATE TABLE queries (
    queryId UUID DEFAULT uuid_generate_v4(),
    canvasId UUID REFERENCES canvases(canvasId) NOT NULL,
    querydescription TEXT NOT NULL,
    style VARCHAR(100) NOT NULL,
    placement VARCHAR(100) NOT NULL,
    color VARCHAR(100) NOT NULL,
    querytype VARCHAR(100) NOT NULL,
    size VARCHAR(100) NOT NULL,
    experience VARCHAR(100) NOT NULL,
    zip NUMERIC(5) NOT NULL,
    radius INTEGER NOT NULL,
    timing VARCHAR(100) NOT NULL,
    numberOfSubmissions INTEGER NOT NULL,
    daysLeft INTEGER NOT NULL,
    images TEXT [] NOT NULL,
    createddate TIMESTAMPTZ,
    PRIMARY KEY (queryId)
);

CREATE TABLE submissions (
    submissionId UUID DEFAULT uuid_generate_v4(),
    caption TEXT NOT NULL,
    queryId UUID REFERENCES queries(queryId) NOT NULL,
    artistId UUID REFERENCES artists(artistId) NOT NULL,
    upload TEXT NOT NULL,
    createddate TIMESTAMPTZ,
    PRIMARY KEY (submissionId)
);

INSERT INTO artists (email, artistusername)
    VALUES 
    ('kissmyself@hot.com', 'TheKid'),
    ('cellblock4@bighouse.gov', 'ClinkInk'),
    ('3stacks@cool.com', 'IceCold'),
    ('George@vandelay.com', 'Costanza');

INSERT INTO canvases (email, canvasusername)
    VALUES 
        ('tsmith@yahoo.com', 'TSmith1'),
        ('johnnybravo@carton.com', 'HotDude'),
        ('skeletor@heman.com', 'BlueBones'),
        ('Early@redneck.net', 'Squidbilly');

INSERT INTO queries (querydescription, style, placement, color, querytype, size, experience, zip, radius, timing, numberOfSubmissions, daysLeft, images, canvasId)
    VALUES
        ('goldfish', 'Hyper-realistic', 'Upper Arm', 'Color', 'Free', 'Medium', 'Old hat', '30307', '5', 'dunno', '13', '2', ARRAY [
            'http://1.bp.blogspot.com/-tDHqfK4oZgI/UOwbeYpFLYI/AAAAAAAAE4s/FB36NyaLd1k/s1600/Godlfish-Wallpapers-09.jpg', 
            'https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Fdigitalfire.ucd.ie%2Fwp-content%2Fuploads%2F2012%2F10%2Fshutterstock_70361200.jpg&f=1' ], 'e394eb0f-c15c-42c7-83f2-1d3e018dc1e5'),
        ('eyeball like MC Escher', '3D', 'Chest', 'Color', 'Free', 'Small', 'First-timer', '30324', '10', 'leggo!', '7', '5', ARRAY [
            'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.3aPvCIZdOTXLiCWnv75BAAHaFj%26pid%3D15.1&f=1'], '7a6832c1-f430-47c5-99fd-dd8b04b63d40'),
        ('A victorian, shapeshifting raven', 'Victorian', 'Chest', 'Black', 'Specific', 'Large', 'Old hat', '10472', '10', 'dunno', '6', '4', ARRAY [
            'https://creatureofthewheel.files.wordpress.com/2013/02/bauchelain-korbal.jpg', 
            'https://i.ytimg.com/vi/DDv_PlrBg14/maxresdefault.jpg' ], '44a713c1-5355-4093-8ec2-b160fe2427c5'),
        ('A geo turtle with an island on his back', 'Geometric', 'Back', 'Color', 'Specific', 'Large', 'Old hat', '20833', '25', 'dunno', '19', '1', ARRAY [
            'https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2F1.bp.blogspot.com%2F-g1DR8c9QL6c%2FUXVvfPYoa-I%2FAAAAAAAAA-A%2Fc26XfELhFog%2Fs640%2FTurtle%2BIsland.jpg&f=1' ], 'd292871b-038b-4162-a752-bbc565970274');

INSERT INTO submissions (caption, upload, queryId, artistId)
    VALUES
        ('standing turtle with island', 'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fhypnomariachi.files.wordpress.com%2F2014%2F12%2Fturtle_by_milicaclk-d7hyc3h.jpg&f=1', '521e644f-2b9f-4fa1-ba1a-dc2fd9ec2ef9', 'd638a833-55da-49e1-a3e6-51f077a7796a'),
        ('ravens morphing into dude', 'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fpm1.narvii.com%2F6306%2Fa52da484c66c46abe5f98e9556136db472e9932a_hq.jpg&f=1', 'e6e5dfd3-3c75-4586-be9b-42451337073b', 'cb651d2e-bbad-43f1-ba33-2b43dfdab4cb'),
        ('eyeball', 'https://proxy.duckduckgo.com/iur/?f=1&image_host=http%3A%2F%2Frattatattoo.com%2Fwp-content%2Fuploads%2F2013%2F02%2FNiki-Norberg-combines-greyscale-and-color-areas-to-add-appeal-to-this-realistic-eye-tattoo.jpg&u=https://rattatattoo.com/wp-content/uploads/2013/02/Niki-Norberg-combines-greyscale-and-color-areas-to-add-appeal-to-this-realistic-eye-tattoo.jpg', '6a669819-ef80-4ce7-b41f-b999a9f63cc2', '83ae2135-5dee-421d-a9a4-f52546af1332'),
        ('goldfish', 'https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2F3.bp.blogspot.com%2F-LSF96prYGtw%2FUw7hR-UMsFI%2FAAAAAAAAD1Y%2FIWRQKsKHcvs%2Fs1600%2FIMG_5165-2cropwm.jpg&f=1', 'f65140be-c09e-4284-aded-c1f68f5ebdb1', '9a376563-c4e4-45c3-b552-5512503a42f9');

