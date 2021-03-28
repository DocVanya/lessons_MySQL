   
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT * FROM profiles;
SELECT * FROM gender;
SELECT * FROM likes;

SELECT
	g.gender_info,
	count(l.like_type) AS total  
FROM likes l
JOIN profiles p ON p.user_id = l.user_id
JOIN gender g ON g.id = p.gender_id
GROUP BY g.gender_info
ORDER BY total;


-- Подсчитать количество лайков которые получили 10 самых молодых пользователей.

SELECT * FROM target_types;

SELECT sum(l.like_type) AS total 
FROM profiles p
JOIN likes l ON l.target_id = p.user_id AND target_type_id = 2
ORDER BY p.birthday DESC LIMIT 10
;

SELECT count(l.like_type) AS total
FROM profiles p
JOIN likes l ON l.target_id = p.user_id
WHERE l.target_type_id = 2
ORDER BY p.birthday DESC LIMIT 10;


-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
   
SELECT CONCAT(p.first_name, ' ', p.last_name) AS user,
(count(l.like_type) + count(m.id) + COUNT(m2.from_user_id)) AS total
FROM profiles p
JOIN likes l ON l.user_id = p.user_id
JOIN media m ON m.user_id = p.user_id
JOIN messages m2 ON m2.from_user_id = p.user_id
GROUP BY user
ORDER BY total
LIMIT 10;   
   
-- Список медиафайлов пользователя с количеством реакций(лайков и дизлайков)
SELECT
  m.filename,
  CONCAT(p.first_name, ' ', p.last_name) AS owner,
  l.like_type AS likes,
  l.like_type  AS dislike
FROM media m
JOIN users u ON u.id = m.user_id
JOIN profiles p ON p.user_id = u.id
LEFT JOIN likes l ON l.target_id = m.id AND l.target_type_id = 3
WHERE u.id = 5;

SELECT * FROM likes;   