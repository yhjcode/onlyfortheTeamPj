-- ============================================================
-- RECOMMENDED_THEME 썸네일 업데이트
-- 파일 위치: resources/upload/theme/
-- ============================================================
-- 테마 ID 확인용 (먼저 실행해서 ID 확인)
-- SELECT THEME_ID, USER_ID, TITLE, THUMBNAIL FROM RECOMMENDED_THEME ORDER BY THEME_ID;

-- Theme 1 (admin): 매콤한 한식 계열
UPDATE RECOMMENDED_THEME
SET THUMBNAIL = '/resources/upload/theme/spicy.png'
WHERE THEME_ID = 1;

-- Theme 2 (chef_sh): 5분 간단 요리 BEST
UPDATE RECOMMENDED_THEME
SET THUMBNAIL = '/resources/upload/theme/simple.png'
WHERE THEME_ID = 2;

-- Theme 3 (cookie01): 홈베이킹 디저트
UPDATE RECOMMENDED_THEME
SET THUMBNAIL = '/resources/upload/theme/bakery.png'
WHERE THEME_ID = 3;

-- Theme 4 (foodie03): 밥도둑 / 봄 레시피
UPDATE RECOMMENDED_THEME
SET THUMBNAIL = '/resources/upload/theme/spring.png'
WHERE THEME_ID = 4;

-- Theme 5 (vegan01): 채식/채소 친화적 레시피
UPDATE RECOMMENDED_THEME
SET THUMBNAIL = '/resources/upload/theme/vegetarian.png'
WHERE THEME_ID = 5;

-- Theme 6 (quick01): 술안주 추천 BEST
UPDATE RECOMMENDED_THEME
SET THUMBNAIL = '/resources/upload/theme/Drink snacks.png'
WHERE THEME_ID = 6;

COMMIT;
