SELECT * FROM EMPLOYEES;

SELECT * FROM PLAYER;
SELECT * FROM STADIUM;
SELECT * FROM SCHEDULE;
SELECT * FROM TEAM;


-- PLAYER 테이블에서 WEIGHT 가 70이상이고 80이하인 선수 검색 
	SELECT WEIGHT 무게
	FROM PLAYER
	WHERE WEIGHT BETWEEN 70 AND 80
	ORDER BY WEIGHT ASC;
-- PLAYER 테이블에서 TEAM_ID가 K03이고 HEIGHT가 180미만인 선수 검색 
	SELECT TEAM_ID 팀아이디, 
		HEIGHT 키
	FROM PLAYER
	WHERE TEAM_ID = 'K03' AND HEIGHT < 180
	ORDER BY HEIGHT ASC;
-- PLAYER 테이블에서 TEAM_ID가 K06이고 NICKNAME이 제리인 선수 검색 
	SELECT TEAM_ID 팀아이디, 
	NICKNAME 별명
	FROM PLAYER
	WHERE TEAM_ID = 'K06' AND NICKNAME = '제리';
-- PLAYER 테이블에서 HEIGH가 170 이상이고 WEIGHT 80이상인 선수 이름 검색 
	SELECT HEIGHT 키, 
	WEIGHT 무게 
	FROM PLAYER
	WHERE HEIGHT >= 170 AND WEIGHT >=80;
-- PLAYER 테이블에서 TEAM_ID가 K02이거나 K07 이고 포지션은 MF인 선수 검색
	
-- STADIUM 테이블에서 SEAT_COUNT가 30000 초과이고 41000 이하 인 경기장 검색


--=======================================================================

-- 강사님께서 적으신 풀이

/*
-- PLAYER 테이블에서 WEIGHT가 70이상이고 80이하인 선수 검색
SELECT * FROM PLAYER
WHERE WEIGHT BETWEEN 70 AND 80;

-- PLAYER 테이블에서 TEAM_ID가 K03 이고 HEIGHT가 180미만인 선수 검색
SELECT * FROM PLAYER
WHERE TEAM_ID = 'K03' AND HEIGHT < 180;

-- PLAYER 테이블에서 TEAM_ID가 K06 이고 NICKNAME이 제리인 선수 검색
SELECT * FROM PLAYER
WHERE TEAM_ID = 'K06' AND NICKNAME = '제리';

-- PLAYER 테이블에서 HEIGHT가 170이상이고 WEIGHT가 80이상인 선수 이름 검색
SELECT * FROM PLAYER
WHERE HEIGHT >= 170 AND WEIGHT >= 80;

-- PLAYER 테이블에서 TEAM_ID가 K02 이거나 K07 이고 POSITION은 MF인 선수 검색
SELECT * FROM PLAYER
WHERE (TEAM_ID = 'K02' OR TEAM_ID = 'K07') AND "POSITION" = 'MF';

SELECT * FROM PLAYER
WHERE TEAM_ID IN('K02', 'K07') AND "POSITION" = 'MF';

-- STADIUM 테이블에서 SEAT_COUNT가 30000 초과 이고 41000 이하 인 경기장 검색
SELECT * FROM STADIUM
WHERE SEAT_COUNT > 30000 AND SEAT_COUNT <= 41000;

-- PLAYER 테이블에서 NICKNAME이 NULL인 선수를 '없음'으로 변경하여 조회하기
SELECT PLAYER_NAME, NVL(NICKNAME, '없음')
FROM PLAYER;

-- PLAYER 테이블에서 POSITION이 NULL인 선수를 '미정'으로 변경 후 검색
SELECT PLAYER_NAME, NVL("POSITION" , '미정')
FROM PLAYER;

-- PLAYER 테이블에서 NATION이 등록되어 있으면 '등록', 아니면 '미등록'으로 검색
SELECT PLAYER_NAME, NVL2(NATION, '등록', '미등록'), NATION 
FROM PLAYER; 
*/




















