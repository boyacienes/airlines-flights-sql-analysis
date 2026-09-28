-- =============================================
-- Airlines Flights Data - SQL Pratik Sorguları
-- =============================================

-- 1) Hangi şehirden kaç defa uçulmuş?
SELECT source_city, COUNT(*) AS tekrar_sayisi
FROM airlines_flights_data
GROUP BY source_city
ORDER BY tekrar_sayisi DESC;


-- 2) Hangi şehre ne kadar uçulmuş?
SELECT destination_city, COUNT(*) AS tekrar_sayisi
FROM airlines_flights_data
GROUP BY destination_city
ORDER BY tekrar_sayisi DESC;


-- 3) Delhi'den Mumbai'ye aktarmasız uçuşlarda 
--    kalkış saatine göre ortalama uçuş süresi
SELECT departure_time, 
    AVG(duration) AS ort_sure,
    COUNT(*) AS ucus_sayisi
FROM airlines_flights_data
WHERE source_city = 'Delhi'
  AND destination_city = 'Mumbai'
  AND stops = 'zero'
GROUP BY departure_time
ORDER BY ort_sure;
-- Yorum: Gece uçuşları daha kısa sürüyor.


-- 4) En fazla uçuş yapan havayolu şirketi
SELECT airline, COUNT(*) AS ucus_sayisi
FROM airlines_flights_data
GROUP BY airline
ORDER BY ucus_sayisi DESC;


-- 5) Ortalama bilet fiyatına göre havayolları
SELECT airline, AVG(price) AS ort_fiyat
FROM airlines_flights_data
GROUP BY airline
ORDER BY ort_fiyat DESC;
-- Yorum: En fazla uçan ve ortalama fiyatı en yüksek şirket Vistara.


-- 6) Ortalama fiyata göre havayolu kategorileri
SELECT airline, AVG(price) AS ortalama_bilet_fiyati,
    CASE 
        WHEN AVG(price) < 6000 THEN 'Economy'
        WHEN AVG(price) BETWEEN 6000 AND 12000 THEN 'Mid-Range'
        ELSE 'Lux-Premium'
    END AS segment
FROM airlines_flights_data
GROUP BY airline
ORDER BY ortalama_bilet_fiyati DESC;


-- 7) Ortalama fiyattan daha pahalı biletler
SELECT airline, source_city, destination_city, price
FROM airlines_flights_data
WHERE price > (SELECT AVG(price) FROM airlines_flights_data);


-- 8) Ortalama fiyatı genel ortalamanın üzerinde olan havayolları
SELECT airline, AVG(price) AS ortalama_fiyat
FROM airlines_flights_data
GROUP BY airline
HAVING AVG(price) > (SELECT AVG(price) FROM airlines_flights_data)
ORDER BY ortalama_fiyat DESC;
-- Yorum: Ortalama üzerinde fiyatı olan 2 havayolu var.


-- 9) En pahalı 5 rota (ortalama fiyata göre)
SELECT TOP 5 source_city, destination_city, 
AVG(price) AS ortalama_fiyat
FROM airlines_flights_data
GROUP BY source_city, destination_city
ORDER BY ortalama_fiyat DESC;