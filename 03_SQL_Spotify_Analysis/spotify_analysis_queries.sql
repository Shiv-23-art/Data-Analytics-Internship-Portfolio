-- Task 3: SQL for Data Analysis
-- Author: Shivani
-- Description: A collection of SQL queries for analyzing the spotofy_music_data table.
-- Date: 24 April 2025

CREATE DATABASE spotify_music_project;
USE spotify_music_project;

CREATE TABLE spotify_music_data (
    Artist VARCHAR(255),
    Track VARCHAR(255),
    Album VARCHAR(255),
    Album_type VARCHAR(50),
    Danceability FLOAT,
    Energy FLOAT,
    Loudness FLOAT,
    Speechiness FLOAT,
    Acousticness FLOAT,
    Instrumentalness FLOAT,
    Liveness FLOAT,
    Valence FLOAT,
    Tempo FLOAT,
    Duration_min FLOAT,
    Title VARCHAR(255),
    Channels VARCHAR(255),
    Views BIGINT,
    Likes BIGINT,
    Comments BIGINT,
    Licensed BOOLEAN,
    official_video BOOLEAN,
    Streaming BIGINT,
    EnergyLiveness FLOAT,
    most_playedon VARCHAR(50)
);

-- Query 1 : Display first 10 rows
SELECT * FROM spotify_music_data LIMIT 10;

-- Query 2 : Display filtered data
SELECT * FROM spotify_music_data
WHERE ENERGY > 0.8;

-- Query 3 : Aggregated Data
SELECT SUM(Streaming) AS Total_Streams FROM spotify_music_data;

-- Query 4 : Grouped Data
SELECT Album_type, AVG(Energy) AS avg_energy
FROM spotify_music_data
GROUP BY Album_type;

-- Query 5 : Create a view
CREATE VIEW vibrant_playlist AS
SELECT Title, Artist, Energy, Danceability
FROM spotify_music_data
WHERE Energy > 0.8 AND Danceability > 0.7;

-- QUERY 6 : Subqueries
SELECT Artist
FROM spotify_music_data
WHERE Streaming = (
    SELECT MAX(Streaming)
    FROM spotify_music_data
);

SELECT Title, Energy
FROM spotify_music_data
WHERE Energy > (
    SELECT AVG(Energy)
    FROM spotify_music_data
);

-- Query 7 : Optimize Queries with Indexes
CREATE INDEX idx_artist ON spotify_music_data(Artist);

SELECT Title, Artist
FROM spotify_music_data
WHERE Artist = 'Khalid';

-- Query 8 - Create second table with existing table
CREATE TABLE unique_artists AS
SELECT DISTINCT Artist
FROM spotify_music_data;

-- Query 9 - USED JOINS
SELECT spotify_music_data.Title, unique_artists.Artist, spotify_music_data.Energy
FROM spotify_music_data AS spotify_music_data
INNER JOIN unique_artists AS unique_artists
ON spotify_music_data.Artist = unique_artists.Artist;

-- Query 10 - Group BY
SELECT Artist, COUNT(*) AS song_count
FROM spotify_music_data
GROUP BY Artist
HAVING COUNT(*) > (
    SELECT AVG(song_count)
    FROM (
        SELECT Artist, COUNT(*) AS song_count
        FROM spotify_music_data
        GROUP BY Artist
    ) AS subquery_table
);