-- 1. 회원 15명 추가
-- ============================================================

-- 팀원 5명 (이니셜 기반)
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('chef_sh', 'sh@bggchef.com', 'pwd1234', '성혁셰프', '010-1111-0001', NULL, TO_DATE('1995-03-15','YYYY-MM-DD'), 0, '골드');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('chef_jm', 'jm@bggchef.com', 'pwd1234', '정묵셰프', '010-1111-0002', NULL, TO_DATE('1996-07-22','YYYY-MM-DD'), 0, '실버');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('chef_yw', 'yw@bggchef.com', 'pwd1234', '예원셰프', '010-1111-0003', NULL, TO_DATE('1997-01-08','YYYY-MM-DD'), 0, '플래티넘');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('chef_hj', 'hj@bggchef.com', 'pwd1234', '희주셰프', '010-1111-0004', NULL, TO_DATE('1994-11-30','YYYY-MM-DD'), 0, '골드');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('chef_mj', 'mj@bggchef.com', 'pwd1234', '명준셰프', '010-1111-0005', NULL, TO_DATE('1996-05-14','YYYY-MM-DD'), 0, '실버');

-- 일반 회원 (먹방/맛집 마니아)
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('foodie01', 'foodie01@test.com', 'pwd1234', '먹방대장', '010-2222-1001', NULL, TO_DATE('1998-02-10','YYYY-MM-DD'), 0, '브론즈');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('foodie02', 'foodie02@test.com', 'pwd1234', '집밥요정', '010-2222-1002', NULL, TO_DATE('1992-12-25','YYYY-MM-DD'), 0, '실버');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('foodie03', 'foodie03@test.com', 'pwd1234', '맛집탐험가', '010-2222-1003', NULL, TO_DATE('1990-08-19','YYYY-MM-DD'), 0, '골드');

-- 베이킹/요리 러버
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('cookie01', 'cookie01@test.com', 'pwd1234', '쿠킹마스터', '010-3333-2001', NULL, TO_DATE('1993-04-05','YYYY-MM-DD'), 0, '플래티넘');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('cookie02', 'cookie02@test.com', 'pwd1234', '베이킹러버', '010-3333-2002', NULL, TO_DATE('1995-09-12','YYYY-MM-DD'), 0, '브론즈');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('cookie03', 'cookie03@test.com', 'pwd1234', '디저트장인', '010-3333-2003', NULL, TO_DATE('1991-06-28','YYYY-MM-DD'), 0, '실버');

-- 초보/특수 회원
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('newbie01', 'newbie01@test.com', 'pwd1234', '요리초보', '010-4444-3001', NULL, TO_DATE('2000-01-15','YYYY-MM-DD'), 0, '브론즈');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('newbie02', 'newbie02@test.com', 'pwd1234', '냉장고털이', '010-4444-3002', NULL, TO_DATE('1999-10-20','YYYY-MM-DD'), 0, '브론즈');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('vegan01', 'vegan01@test.com', 'pwd1234', '채식왕국', '010-5555-4001', NULL, TO_DATE('1994-03-22','YYYY-MM-DD'), 0, '실버');

INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('quick01', 'quick01@test.com', 'pwd1234', '5분요리킹', '010-5555-4002', NULL, TO_DATE('1997-07-04','YYYY-MM-DD'), 0, '골드');

COMMIT;


-- ============================================================
-- 2. 재료 마스터 20개 추가
--   기존 8개(1-8) + 신규 20개 = 총 28개
--   9: 고추장   10: 된장     11: 김치     12: 두부
--   13: 계란    14: 밥       15: 식용유   16: 참기름
--   17: 깨      18: 감자     19: 당근     20: 버섯
--   21: 면      22: 치즈     23: 베이컨   24: 토마토소스
--   25: 버터    26: 밀가루   27: 우유     28: 떡
-- ============================================================

INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '고추장',     'g');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '된장',       'g');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '김치',       'g');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '두부',       '모');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '계란',       '개');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '밥',         '공기');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '식용유',     'ml');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '참기름',     'ml');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '깨',         '큰술');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '감자',       '개');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '당근',       '개');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '버섯',       'g');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '면',         'g');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '치즈',       'g');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '베이컨',     'g');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '토마토소스', 'ml');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '버터',       'g');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '밀가루',     'g');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '우유',       'ml');
INSERT INTO INGREDIENT VALUES (SEQ_INGREDIENT.NEXTVAL, '떡',         'g');

COMMIT;


-- ============================================================
-- 3. 레시피 40개
--   카테고리 ID:
--     1=찌개/국  2=구이    3=볶음     4=파스타  5=스테이크
--     6=면류    7=초밥/회  8=케이크   9=쿠키    10=떡볶이
-- ============================================================

-- ===== 한식 - 찌개/국 (category_id = 1) =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_sh', 1, '얼큰한 김치찌개', 'https://picsum.photos/seed/r1/400/400', '집에서 만드는 정통 김치찌개 레시피. 묵은지로 끓이면 더욱 깊은 맛!', 2, 30, 1, 1520, 4.8, SYSDATE-30);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_yw', 1, '구수한 된장찌개', 'https://picsum.photos/seed/r2/400/400', '엄마표 된장찌개. 두부와 애호박을 듬뿍 넣어 든든하게.', 3, 25, 1, 980, 4.6, SYSDATE-28);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'foodie02', 1, '얼큰 부대찌개', 'https://picsum.photos/seed/r3/400/400', '소시지, 스팸, 라면이 어우러진 한국식 부대찌개', 4, 35, 2, 2340, 4.9, SYSDATE-25);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_hj', 1, '시원한 미역국', 'https://picsum.photos/seed/r4/400/400', '생일에 빠질 수 없는 미역국. 소고기로 깊은 맛.', 2, 40, 1, 870, 4.5, SYSDATE-22);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'foodie01', 1, '명절 떡국', 'https://picsum.photos/seed/r5/400/400', '설날에 먹는 따뜻한 떡국. 만두 추가 가능!', 4, 30, 1, 1100, 4.7, SYSDATE-20);

-- ===== 한식 - 구이 (category_id = 2) =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_mj', 2, '바삭한 삼겹살 구이', 'https://picsum.photos/seed/r6/400/400', '집에서 즐기는 삼겹살. 쌈장과 함께!', 2, 20, 1, 3200, 4.9, SYSDATE-29);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_sh', 2, '양념 LA갈비', 'https://picsum.photos/seed/r7/400/400', '특제 양념에 재운 LA갈비. 부드럽고 달콤.', 3, 60, 2, 2500, 4.8, SYSDATE-26);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'foodie03', 2, '치즈 닭갈비', 'https://picsum.photos/seed/r8/400/400', '춘천식 닭갈비에 치즈 듬뿍. 인기 메뉴!', 3, 40, 2, 4100, 4.9, SYSDATE-15);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_jm', 2, '고등어구이', 'https://picsum.photos/seed/r9/400/400', '집에서 굽는 노릇한 고등어. 무즙과 함께.', 2, 25, 1, 750, 4.3, SYSDATE-18);

-- ===== 한식 - 볶음 (category_id = 3) =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'quick01', 3, '5분 김치볶음밥', 'https://picsum.photos/seed/r10/400/400', '냉장고 김치로 5분 만에 완성!', 1, 10, 1, 5200, 4.9, SYSDATE-10);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_hj', 3, '매콤 제육볶음', 'https://picsum.photos/seed/r11/400/400', '고추장 양념으로 만드는 정통 제육볶음', 2, 25, 1, 3800, 4.8, SYSDATE-27);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'foodie02', 3, '멸치볶음', 'https://picsum.photos/seed/r12/400/400', '도시락 단골 반찬. 달콤한 멸치볶음.', 4, 15, 1, 1200, 4.5, SYSDATE-19);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_mj', 3, '오징어볶음', 'https://picsum.photos/seed/r13/400/400', '쫄깃한 오징어와 채소를 매콤하게.', 2, 20, 1, 1850, 4.7, SYSDATE-14);

-- ===== 양식 - 파스타 (category_id = 4) =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'cookie01', 4, '진짜 까르보나라', 'https://picsum.photos/seed/r14/400/400', '이탈리아 정통식 까르보나라. 크림 없이 계란노른자로!', 2, 20, 2, 6800, 4.9, SYSDATE-12);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'foodie03', 4, '토마토 파스타', 'https://picsum.photos/seed/r15/400/400', '신선한 토마토와 바질로 만든 클래식 파스타', 2, 25, 1, 3400, 4.6, SYSDATE-21);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'quick01', 4, '5분 알리오 올리오', 'https://picsum.photos/seed/r16/400/400', '재료 4개로 완성하는 초간단 파스타', 1, 10, 1, 4200, 4.7, SYSDATE-8);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_sh', 4, '크림 새우 파스타', 'https://picsum.photos/seed/r17/400/400', '진한 크림소스에 통통한 새우 듬뿍', 2, 25, 2, 2900, 4.8, SYSDATE-16);

-- ===== 양식 - 스테이크 (category_id = 5) =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_jm', 5, '안심 스테이크', 'https://picsum.photos/seed/r18/400/400', '미디엄 레어로 굽는 부드러운 안심 스테이크', 1, 15, 2, 2100, 4.7, SYSDATE-13);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'foodie01', 5, '함박 스테이크', 'https://picsum.photos/seed/r19/400/400', '집에서 만드는 일본식 함박 스테이크', 2, 35, 2, 1750, 4.5, SYSDATE-11);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_hj', 5, '등심 스테이크', 'https://picsum.photos/seed/r20/400/400', '두툼한 등심을 미디엄으로. 마늘 소스 곁들임', 2, 20, 2, 1900, 4.6, SYSDATE-17);

-- ===== 중식 - 면류 (category_id = 6) =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'foodie02', 6, '집에서 만든 짜장면', 'https://picsum.photos/seed/r21/400/400', '춘장 볶아서 만드는 정통 짜장면', 2, 40, 2, 3100, 4.7, SYSDATE-9);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_mj', 6, '얼큰 짬뽕', 'https://picsum.photos/seed/r22/400/400', '해물 가득 매콤한 짬뽕. 집에서 끓이기', 2, 35, 2, 2700, 4.6, SYSDATE-7);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'cookie01', 6, '일본식 카레 우동', 'https://picsum.photos/seed/r23/400/400', '진한 카레 국물에 쫄깃한 우동면', 2, 25, 1, 1850, 4.5, SYSDATE-6);

-- ===== 일식 - 초밥/회 (category_id = 7) =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_yw', 7, '연어 초밥', 'https://picsum.photos/seed/r24/400/400', '집에서 만드는 신선한 연어 초밥', 2, 30, 3, 2200, 4.8, SYSDATE-5);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'foodie03', 7, '회덮밥', 'https://picsum.photos/seed/r25/400/400', '신선한 회와 야채를 듬뿍 올린 회덮밥', 1, 15, 1, 1450, 4.4, SYSDATE-4);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_sh', 7, '참치 마요 초밥', 'https://picsum.photos/seed/r26/400/400', '참치와 마요네즈의 환상 조합', 2, 20, 1, 1750, 4.6, SYSDATE-3);

-- ===== 디저트 - 케이크 (category_id = 8) =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'cookie02', 8, '뉴욕 치즈케이크', 'https://picsum.photos/seed/r27/400/400', '진한 크림치즈로 만드는 뉴욕 스타일 치즈케이크', 6, 90, 3, 5400, 4.9, SYSDATE-24);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'cookie03', 8, '초코 가나슈 케이크', 'https://picsum.photos/seed/r28/400/400', '진한 다크초콜릿 가나슈로 코팅한 케이크', 8, 120, 3, 3800, 4.8, SYSDATE-23);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_hj', 8, '당근 케이크', 'https://picsum.photos/seed/r29/400/400', '크림치즈 프로스팅 듬뿍! 촉촉한 당근 케이크', 6, 75, 2, 2100, 4.5, SYSDATE-2);

-- ===== 디저트 - 쿠키 (category_id = 9) =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'cookie02', 9, '초코칩 쿠키', 'https://picsum.photos/seed/r30/400/400', '바삭하고 쫀득한 초코칩 쿠키 20개 분량', 4, 40, 1, 4200, 4.8, SYSDATE-31);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'cookie03', 9, '마카롱 만들기', 'https://picsum.photos/seed/r31/400/400', '초보도 가능한 마카롱 레시피. 10가지 색깔!', 4, 90, 3, 6700, 4.9, SYSDATE-1);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_jm', 9, '브라우니', 'https://picsum.photos/seed/r32/400/400', '진한 초콜릿 브라우니. 호두 듬뿍.', 6, 45, 2, 3100, 4.7, SYSDATE-32);

-- ===== 분식 - 떡볶이 (category_id = 10) =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'foodie01', 10, '국물 떡볶이', 'https://picsum.photos/seed/r33/400/400', '시장표 국물 떡볶이. 어묵 듬뿍!', 2, 20, 1, 5800, 4.9, SYSDATE-35);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'newbie01', 10, '라볶이', 'https://picsum.photos/seed/r34/400/400', '라면 + 떡볶이의 환상 조합. 학생 추천!', 1, 15, 1, 3300, 4.7, SYSDATE-33);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_mj', 10, '치즈 떡볶이', 'https://picsum.photos/seed/r35/400/400', '늘어나는 치즈가 매력! 매콤달콤 치즈 떡볶이', 2, 25, 1, 4500, 4.8, SYSDATE-34);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'newbie02', 10, '간장 떡볶이', 'https://picsum.photos/seed/r36/400/400', '맵찔이도 OK! 간장 베이스 떡볶이', 2, 20, 1, 1900, 4.4, SYSDATE-36);

-- ===== 비건/추가 레시피 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'vegan01', 3, '두부 채소 볶음', 'https://picsum.photos/seed/r37/400/400', '비건 친화적 두부 볶음. 단백질 듬뿍.', 2, 15, 1, 920, 4.3, SYSDATE-37);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'vegan01', 4, '비건 토마토 파스타', 'https://picsum.photos/seed/r38/400/400', '동물성 재료 없이 만드는 비건 파스타', 2, 25, 1, 680, 4.2, SYSDATE-38);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'chef_yw', 1, '돼지 김치찜', 'https://picsum.photos/seed/r39/400/400', '돼지고기 듬뿍 들어간 푹 익은 김치찜', 3, 90, 2, 1450, 4.6, SYSDATE-39);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (SEQ_RECIPE.NEXTVAL, 'cookie01', 8, '티라미수', 'https://picsum.photos/seed/r40/400/400', '에스프레소 듬뿍 적신 정통 이탈리아 티라미수', 6, 60, 2, 2800, 4.8, SYSDATE-40);

COMMIT;


-- ============================================================
-- 4. 레시피 재료 (RECIPE_INGREDIENTS)
-- ============================================================

-- 레시피 1: 김치찌개
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 11, 1, '300g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 1,  1, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 12, 1, '1모');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 4,  1, '1대');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 5,  1, '3쪽');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  1, '1큰술');

-- 레시피 2: 된장찌개
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 10, 2, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 12, 2, '1모');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 3,  2, '1개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 2, '1개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 20, 2, '100g');

-- 레시피 3: 부대찌개
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 11, 3, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 12, 3, '1모');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  3, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 4,  3, '1대');

-- 레시피 4: 미역국
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 2,  4, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 5,  4, '3쪽');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  4, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 16, 4, '1큰술');

-- 레시피 5: 떡국
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 28, 5, '400g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 2,  5, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 13, 5, '2개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 4,  5, '1대');

-- 레시피 6: 삼겹살
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 1,  6, '400g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 8,  6, '약간');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 5,  6, '5쪽');

-- 레시피 7: LA갈비
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 2,  7, '800g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  7, '5큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  7, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 5,  7, '5쪽');

-- 레시피 8: 치즈 닭갈비
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  8, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 22, 8, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 3,  8, '1개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 28, 8, '200g');

-- 레시피 10: 김치볶음밥
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 11, 10, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 10, '2공기');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 13, 10, '2개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 15, 10, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 17, 10, '약간');

-- 레시피 11: 제육볶음
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 1,  11, '400g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  11, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 3,  11, '1개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 5,  11, '3쪽');

-- 레시피 14: 까르보나라
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 21, 14, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 23, 14, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 13, 14, '2개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 22, 14, '50g');

-- 레시피 16: 알리오 올리오
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 21, 16, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 5,  16, '5쪽');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 15, 16, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 8,  16, '약간');

-- 레시피 18: 안심 스테이크
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 2,  18, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 25, 18, '30g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 5,  18, '2쪽');

-- 레시피 24: 연어 초밥
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 24, '2공기');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  24, '1큰술');

-- 레시피 27: 치즈케이크
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 22, 27, '500g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 13, 27, '3개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  27, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 27, 27, '100ml');

-- 레시피 30: 초코칩 쿠키
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 30, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 25, 30, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  30, '80g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 13, 30, '1개');

-- 레시피 33: 떡볶이
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 28, 33, '500g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  33, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  33, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 4,  33, '1대');

COMMIT;


-- ============================================================
-- 5. 조리 순서 (RECIPE_STEP)
-- ============================================================

-- 레시피 1: 김치찌개
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 1, NULL, '돼지고기를 한 입 크기로 자르고 김치도 먹기 좋게 썰어주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 2, NULL, '냄비에 돼지고기를 볶다가 김치를 넣고 함께 볶아주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 3, NULL, '물 500ml를 붓고 끓이며 고추장 1큰술을 풀어주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 4, NULL, '두부와 대파, 마늘을 넣고 15분 더 끓여주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 5, NULL, '간을 보고 부족하면 소금이나 김치 국물로 조절. 완성!');

-- 레시피 6: 삼겹살
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 6, 1, NULL, '삼겹살을 1cm 두께로 자르거나 시판 삼겹살을 준비하세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 6, 2, NULL, '팬을 충분히 달구고 삼겹살을 올려 노릇하게 구워주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 6, 3, NULL, '한 면이 익으면 뒤집고 마늘도 함께 굽습니다.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 6, 4, NULL, '쌈장과 함께 상추쌈으로 드시면 완벽!');

-- 레시피 10: 김치볶음밥
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 10, 1, NULL, '김치를 잘게 썰어주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 10, 2, NULL, '팬에 기름을 두르고 김치를 볶아 신맛을 날립니다.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 10, 3, NULL, '밥을 넣고 김치와 잘 섞이도록 볶아주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 10, 4, NULL, '계란후라이를 위에 올리고 깨를 뿌려 완성!');

-- 레시피 14: 까르보나라
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 1, NULL, '파스타 면을 끓는 소금물에 8분간 삶아주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 2, NULL, '베이컨을 잘라 팬에 노릇하게 볶아주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 3, NULL, '볼에 계란노른자 2개와 치즈를 섞어 소스를 만들어주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 4, NULL, '삶은 면을 베이컨 팬에 넣고 불 끄고 소스를 부어 잘 섞어주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 5, NULL, '후추 듬뿍 뿌려 완성. 따뜻할 때 드세요!');

-- 레시피 18: 안심 스테이크
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 18, 1, NULL, '스테이크는 실온에 30분 두어 차가운 기운을 빼주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 18, 2, NULL, '소금과 후추로 양념하고 팬에 올리브유 두르고 달궈주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 18, 3, NULL, '한 면당 2분씩 강불에 구운 후 약불로 줄여 1분 더.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 18, 4, NULL, '버터와 마늘을 넣고 향을 입혀 5분 레스팅 후 자르기.');

-- 레시피 30: 초코칩 쿠키
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 1, NULL, '버터를 실온에 두어 부드럽게 만든 후 설탕을 넣고 크림화하세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 2, NULL, '계란을 풀어 넣고 잘 섞은 후 바닐라 추출액 1작은술 추가.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 3, NULL, '밀가루와 베이킹소다를 체쳐 넣고 가볍게 섞어주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 4, NULL, '초코칩을 듬뿍 넣고 반죽을 한입 크기로 떼어 팬에 올려주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 5, NULL, '180도 예열한 오븐에서 12분 굽기. 식힘망에 식혀 완성!');

-- 레시피 33: 떡볶이
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 33, 1, NULL, '떡을 미지근한 물에 담가 부드럽게 만들어주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 33, 2, NULL, '냄비에 물 500ml + 고추장 + 설탕 + 간장 넣고 끓여 양념장 만들기.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 33, 3, NULL, '양념장이 끓으면 떡과 어묵, 대파를 넣고 5분 더 끓여주세요.');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 33, 4, NULL, '국물이 자작해지면 완성! 깨소금 뿌려 드세요.');

COMMIT;


-- ============================================================
-- 6. 리뷰 + 대댓글 (REVIEW)
-- ============================================================

-- 레시피 1: 김치찌개
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie01', 1, 5.0, '진짜 맛있어요! 묵은지 효과 톡톡 봤습니다.', NULL, SYSDATE-29);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie02', 1, 4.8, '두부 많이 넣으니까 더 좋네요. 추천!', NULL, SYSDATE-28);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'newbie01', 1, 4.5, '처음 만들어봤는데 성공! 감사합니다.', NULL, SYSDATE-27);

-- 대댓글
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'chef_sh', 1, NULL, '도움이 되셨다니 다행이에요!', 3, SYSDATE-26);

-- 레시피 6: 삼겹살
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie03', 6, 5.0, '집에서 삼겹살 굽기 정석! 강추합니다.', NULL, SYSDATE-25);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'quick01', 6, 4.9, '간단한데 맛도 좋아요.', NULL, SYSDATE-24);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'cookie01', 6, 5.0, '두께가 정말 중요하다는 거 배웠어요!', NULL, SYSDATE-23);

-- 레시피 8: 치즈 닭갈비
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie01', 8, 5.0, '치즈 듬뿍! 외식 안 가도 되겠어요.', NULL, SYSDATE-14);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie02', 8, 4.9, '아이들이 너무 좋아해요.', NULL, SYSDATE-13);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'newbie02', 8, 4.8, '치즈 추가 사진처럼 늘어나요!', NULL, SYSDATE-12);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'cookie02', 8, 4.9, '최고. 다음에 또 만들 거예요.', NULL, SYSDATE-11);

-- 레시피 10: 김치볶음밥
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'newbie01', 10, 5.0, '5분이라더니 진짜 5분! 짱이에요.', NULL, SYSDATE-9);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'newbie02', 10, 4.8, '학교 가기 전 빠르게 먹기 좋아요.', NULL, SYSDATE-8);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie01', 10, 4.9, '계란 노른자 톡 터뜨려서 비벼 먹으면 최고!', NULL, SYSDATE-7);

-- 레시피 14: 까르보나라
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'chef_yw', 14, 5.0, '진짜 정통식! 크림 안 들어가는 게 정답이죠.', NULL, SYSDATE-11);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie03', 14, 4.9, '이탈리아에서 먹었던 그 맛이에요.', NULL, SYSDATE-10);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'cookie01', 14, 5.0, '계란노른자 타이밍이 중요하더라구요.', NULL, SYSDATE-9);

-- 레시피 27: 치즈케이크
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'cookie03', 27, 5.0, '뉴욕 치즈케이크 그대로! 진하고 부드러워요.', NULL, SYSDATE-23);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie01', 27, 4.8, '시간은 좀 걸리지만 그만한 가치!', NULL, SYSDATE-22);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie02', 27, 4.9, '딸과 함께 만들었어요. 추억!', NULL, SYSDATE-21);

-- 레시피 31: 마카롱
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'cookie01', 31, 5.0, '마카롱 처음 성공! 정말 감사해요.', NULL, SYSDATE-1);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'cookie02', 31, 4.9, '필링 추가 레시피도 알려주세요!', NULL, SYSDATE);

-- 레시피 33: 떡볶이
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'newbie01', 33, 5.0, '시장 그 맛! 어묵 듬뿍 넣었어요.', NULL, SYSDATE-34);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'newbie02', 33, 4.9, '학교 매점 떡볶이 생각나요.', NULL, SYSDATE-33);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'quick01', 33, 4.8, '간단한데 맛집 수준!', NULL, SYSDATE-32);

-- 레시피 35: 치즈 떡볶이
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie01', 35, 5.0, '치즈가 늘어나는 사진 진짜에요. 환상!', NULL, SYSDATE-33);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie03', 35, 4.9, '아이들 간식으로 최고에요.', NULL, SYSDATE-32);

-- 기타 레시피 리뷰
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie01', 3, 5.0, '부대찌개 최고! 라면 사리 듬뿍.', NULL, SYSDATE-22);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'quick01', 16, 5.0, '진짜 5분 완성! 자취생 필수.', NULL, SYSDATE-7);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie02', 21, 4.8, '집에서 짜장면 만들어서 행복했어요.', NULL, SYSDATE-8);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'cookie02', 30, 5.0, '딸이 너무 좋아해서 매주 만들어요.', NULL, SYSDATE-30);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'vegan01', 37, 4.5, '비건 입장에서 단백질 보충 좋아요.', NULL, SYSDATE-36);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'chef_hj', 11, 5.0, '제육볶음 마지막 단계 양념이 중요!', NULL, SYSDATE-26);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie02', 24, 4.8, '연어 좋아하시면 강추!', NULL, SYSDATE-4);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie01', 34, 5.0, '라면 + 떡볶이 완벽!', NULL, SYSDATE-32);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'cookie02', 28, 5.0, '진한 초콜릿이 최고에요!', NULL, SYSDATE-22);

INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'cookie02', 40, 5.0, '티라미수 카페보다 맛있어요.', NULL, SYSDATE-39);

COMMIT;


-- ============================================================
-- 7. 좋아요 (RECIPE_LIKE)
-- ============================================================

-- 레시피 1: 김치찌개
INSERT INTO RECIPE_LIKE VALUES (1, 'foodie01', SYSDATE-28);
INSERT INTO RECIPE_LIKE VALUES (1, 'foodie02', SYSDATE-27);
INSERT INTO RECIPE_LIKE VALUES (1, 'foodie03', SYSDATE-26);
INSERT INTO RECIPE_LIKE VALUES (1, 'cookie01', SYSDATE-25);
INSERT INTO RECIPE_LIKE VALUES (1, 'newbie01', SYSDATE-24);
INSERT INTO RECIPE_LIKE VALUES (1, 'newbie02', SYSDATE-23);
INSERT INTO RECIPE_LIKE VALUES (1, 'quick01',  SYSDATE-22);
INSERT INTO RECIPE_LIKE VALUES (1, 'chef_yw',  SYSDATE-21);

-- 레시피 6: 삼겹살
INSERT INTO RECIPE_LIKE VALUES (6, 'foodie01', SYSDATE-25);
INSERT INTO RECIPE_LIKE VALUES (6, 'foodie02', SYSDATE-24);
INSERT INTO RECIPE_LIKE VALUES (6, 'foodie03', SYSDATE-23);
INSERT INTO RECIPE_LIKE VALUES (6, 'chef_sh',  SYSDATE-22);
INSERT INTO RECIPE_LIKE VALUES (6, 'chef_yw',  SYSDATE-21);
INSERT INTO RECIPE_LIKE VALUES (6, 'chef_hj',  SYSDATE-20);
INSERT INTO RECIPE_LIKE VALUES (6, 'cookie01', SYSDATE-19);
INSERT INTO RECIPE_LIKE VALUES (6, 'cookie02', SYSDATE-18);
INSERT INTO RECIPE_LIKE VALUES (6, 'quick01',  SYSDATE-17);
INSERT INTO RECIPE_LIKE VALUES (6, 'newbie01', SYSDATE-16);

-- 레시피 8: 치즈 닭갈비 (최인기)
INSERT INTO RECIPE_LIKE VALUES (8, 'foodie01', SYSDATE-14);
INSERT INTO RECIPE_LIKE VALUES (8, 'foodie02', SYSDATE-13);
INSERT INTO RECIPE_LIKE VALUES (8, 'foodie03', SYSDATE-12);
INSERT INTO RECIPE_LIKE VALUES (8, 'chef_sh',  SYSDATE-11);
INSERT INTO RECIPE_LIKE VALUES (8, 'chef_jm',  SYSDATE-10);
INSERT INTO RECIPE_LIKE VALUES (8, 'chef_yw',  SYSDATE-9);
INSERT INTO RECIPE_LIKE VALUES (8, 'chef_hj',  SYSDATE-8);
INSERT INTO RECIPE_LIKE VALUES (8, 'chef_mj',  SYSDATE-7);
INSERT INTO RECIPE_LIKE VALUES (8, 'cookie01', SYSDATE-6);
INSERT INTO RECIPE_LIKE VALUES (8, 'cookie02', SYSDATE-5);
INSERT INTO RECIPE_LIKE VALUES (8, 'newbie01', SYSDATE-4);
INSERT INTO RECIPE_LIKE VALUES (8, 'quick01',  SYSDATE-3);

-- 레시피 10: 김치볶음밥
INSERT INTO RECIPE_LIKE VALUES (10, 'foodie01', SYSDATE-9);
INSERT INTO RECIPE_LIKE VALUES (10, 'foodie02', SYSDATE-8);
INSERT INTO RECIPE_LIKE VALUES (10, 'foodie03', SYSDATE-7);
INSERT INTO RECIPE_LIKE VALUES (10, 'chef_sh',  SYSDATE-6);
INSERT INTO RECIPE_LIKE VALUES (10, 'newbie01', SYSDATE-5);
INSERT INTO RECIPE_LIKE VALUES (10, 'newbie02', SYSDATE-4);
INSERT INTO RECIPE_LIKE VALUES (10, 'quick01',  SYSDATE-3);
INSERT INTO RECIPE_LIKE VALUES (10, 'cookie01', SYSDATE-2);
INSERT INTO RECIPE_LIKE VALUES (10, 'cookie02', SYSDATE-1);
INSERT INTO RECIPE_LIKE VALUES (10, 'vegan01',  SYSDATE);

-- 레시피 14: 까르보나라
INSERT INTO RECIPE_LIKE VALUES (14, 'foodie01', SYSDATE-11);
INSERT INTO RECIPE_LIKE VALUES (14, 'foodie03', SYSDATE-10);
INSERT INTO RECIPE_LIKE VALUES (14, 'chef_sh',  SYSDATE-9);
INSERT INTO RECIPE_LIKE VALUES (14, 'chef_yw',  SYSDATE-8);
INSERT INTO RECIPE_LIKE VALUES (14, 'chef_jm',  SYSDATE-7);
INSERT INTO RECIPE_LIKE VALUES (14, 'cookie01', SYSDATE-6);
INSERT INTO RECIPE_LIKE VALUES (14, 'cookie02', SYSDATE-5);
INSERT INTO RECIPE_LIKE VALUES (14, 'cookie03', SYSDATE-4);
INSERT INTO RECIPE_LIKE VALUES (14, 'quick01',  SYSDATE-3);
INSERT INTO RECIPE_LIKE VALUES (14, 'newbie02', SYSDATE-2);
INSERT INTO RECIPE_LIKE VALUES (14, 'foodie02', SYSDATE-1);

-- 레시피 27: 치즈케이크
INSERT INTO RECIPE_LIKE VALUES (27, 'foodie01', SYSDATE-22);
INSERT INTO RECIPE_LIKE VALUES (27, 'foodie02', SYSDATE-21);
INSERT INTO RECIPE_LIKE VALUES (27, 'chef_yw',  SYSDATE-20);
INSERT INTO RECIPE_LIKE VALUES (27, 'chef_hj',  SYSDATE-19);
INSERT INTO RECIPE_LIKE VALUES (27, 'cookie01', SYSDATE-18);
INSERT INTO RECIPE_LIKE VALUES (27, 'cookie03', SYSDATE-17);
INSERT INTO RECIPE_LIKE VALUES (27, 'newbie01', SYSDATE-16);
INSERT INTO RECIPE_LIKE VALUES (27, 'newbie02', SYSDATE-15);

-- 레시피 30: 초코칩 쿠키
INSERT INTO RECIPE_LIKE VALUES (30, 'foodie01', SYSDATE-30);
INSERT INTO RECIPE_LIKE VALUES (30, 'cookie01', SYSDATE-29);
INSERT INTO RECIPE_LIKE VALUES (30, 'cookie02', SYSDATE-28);
INSERT INTO RECIPE_LIKE VALUES (30, 'cookie03', SYSDATE-27);
INSERT INTO RECIPE_LIKE VALUES (30, 'newbie01', SYSDATE-26);
INSERT INTO RECIPE_LIKE VALUES (30, 'quick01',  SYSDATE-23);

-- 레시피 31: 마카롱 (최신 인기)
INSERT INTO RECIPE_LIKE VALUES (31, 'cookie01', SYSDATE-1);
INSERT INTO RECIPE_LIKE VALUES (31, 'cookie02', SYSDATE);
INSERT INTO RECIPE_LIKE VALUES (31, 'cookie03', SYSDATE);
INSERT INTO RECIPE_LIKE VALUES (31, 'foodie01', SYSDATE);
INSERT INTO RECIPE_LIKE VALUES (31, 'foodie02', SYSDATE);
INSERT INTO RECIPE_LIKE VALUES (31, 'foodie03', SYSDATE);
INSERT INTO RECIPE_LIKE VALUES (31, 'newbie01', SYSDATE);
INSERT INTO RECIPE_LIKE VALUES (31, 'chef_yw',  SYSDATE);
INSERT INTO RECIPE_LIKE VALUES (31, 'chef_hj',  SYSDATE);
INSERT INTO RECIPE_LIKE VALUES (31, 'quick01',  SYSDATE);

-- 레시피 33: 떡볶이
INSERT INTO RECIPE_LIKE VALUES (33, 'foodie01', SYSDATE-34);
INSERT INTO RECIPE_LIKE VALUES (33, 'foodie02', SYSDATE-33);
INSERT INTO RECIPE_LIKE VALUES (33, 'foodie03', SYSDATE-32);
INSERT INTO RECIPE_LIKE VALUES (33, 'newbie01', SYSDATE-31);
INSERT INTO RECIPE_LIKE VALUES (33, 'newbie02', SYSDATE-30);
INSERT INTO RECIPE_LIKE VALUES (33, 'quick01',  SYSDATE-29);
INSERT INTO RECIPE_LIKE VALUES (33, 'chef_mj',  SYSDATE-28);
INSERT INTO RECIPE_LIKE VALUES (33, 'chef_sh',  SYSDATE-27);
INSERT INTO RECIPE_LIKE VALUES (33, 'cookie01', SYSDATE-26);
INSERT INTO RECIPE_LIKE VALUES (33, 'cookie02', SYSDATE-25);

-- 기타 레시피
INSERT INTO RECIPE_LIKE VALUES (3,  'foodie01', SYSDATE-23);
INSERT INTO RECIPE_LIKE VALUES (3,  'chef_jm',  SYSDATE-22);
INSERT INTO RECIPE_LIKE VALUES (7,  'foodie02', SYSDATE-24);
INSERT INTO RECIPE_LIKE VALUES (7,  'chef_yw',  SYSDATE-23);
INSERT INTO RECIPE_LIKE VALUES (16, 'quick01',  SYSDATE-7);
INSERT INTO RECIPE_LIKE VALUES (16, 'newbie01', SYSDATE-6);
INSERT INTO RECIPE_LIKE VALUES (16, 'foodie01', SYSDATE-4);
INSERT INTO RECIPE_LIKE VALUES (24, 'foodie02', SYSDATE-4);
INSERT INTO RECIPE_LIKE VALUES (24, 'chef_yw',  SYSDATE-3);
INSERT INTO RECIPE_LIKE VALUES (28, 'cookie02', SYSDATE-22);
INSERT INTO RECIPE_LIKE VALUES (28, 'cookie03', SYSDATE-21);
INSERT INTO RECIPE_LIKE VALUES (34, 'foodie01', SYSDATE-32);
INSERT INTO RECIPE_LIKE VALUES (34, 'newbie02', SYSDATE-31);
INSERT INTO RECIPE_LIKE VALUES (35, 'foodie01', SYSDATE-33);
INSERT INTO RECIPE_LIKE VALUES (35, 'foodie03', SYSDATE-32);

COMMIT;


-- ============================================================
-- 8. 즐겨찾기 (FAVORITE)
-- ============================================================

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'foodie01', 1, SYSDATE-27);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'foodie01', 6, SYSDATE-25);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'foodie01', 8, SYSDATE-14);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'foodie01', 33, SYSDATE-32);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'foodie02', 1, SYSDATE-26);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'foodie02', 14, SYSDATE-10);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'foodie02', 27, SYSDATE-21);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'foodie03', 8, SYSDATE-13);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'foodie03', 14, SYSDATE-10);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'foodie03', 24, SYSDATE-4);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_sh', 14, SYSDATE-9);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_sh', 8, SYSDATE-11);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_sh', 18, SYSDATE-13);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_jm', 8, SYSDATE-10);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_jm', 14, SYSDATE-7);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_jm', 3, SYSDATE-22);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_yw', 1, SYSDATE-21);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_yw', 7, SYSDATE-23);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_yw', 24, SYSDATE-3);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_yw', 27, SYSDATE-20);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_hj', 27, SYSDATE-19);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_hj', 8, SYSDATE-8);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_hj', 11, SYSDATE-25);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_mj', 8, SYSDATE-7);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_mj', 33, SYSDATE-28);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'chef_mj', 35, SYSDATE-33);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie01', 14, SYSDATE-6);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie01', 27, SYSDATE-18);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie01', 30, SYSDATE-29);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie01', 31, SYSDATE-1);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie01', 40, SYSDATE-39);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie02', 27, SYSDATE-17);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie02', 30, SYSDATE-28);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie02', 31, SYSDATE);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie02', 40, SYSDATE-38);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie03', 27, SYSDATE-22);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie03', 30, SYSDATE-27);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie03', 31, SYSDATE);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'cookie03', 32, SYSDATE-30);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'newbie01', 10, SYSDATE-4);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'newbie01', 16, SYSDATE-3);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'newbie01', 33, SYSDATE-30);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'newbie01', 34, SYSDATE-31);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'newbie02', 10, SYSDATE-3);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'newbie02', 34, SYSDATE-30);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'quick01', 10, SYSDATE-2);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'quick01', 16, SYSDATE-4);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'quick01', 33, SYSDATE-28);

INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'vegan01', 37, SYSDATE-36);
INSERT INTO FAVORITE VALUES (SEQ_FAVORITE.NEXTVAL, 'vegan01', 38, SYSDATE-37);

COMMIT;


-- ============================================================
-- 9. 추천 테마 (RECOMMENDED_THEME)
-- ============================================================

INSERT INTO RECOMMENDED_THEME (theme_id, user_id, title, description, thumbnail, link_url, is_visible, view_count, created_at)
VALUES (SEQ_THEME.NEXTVAL, 'admin', '봄에 어울리는 따뜻한 한식',
        '쌀쌀한 봄날 몸을 녹여주는 한국식 찌개와 국 모음. 가족과 함께 따뜻하게!',
        'https://picsum.photos/seed/t1/600/400', NULL, 1, 1200, SYSDATE-30);

INSERT INTO RECOMMENDED_THEME (theme_id, user_id, title, description, thumbnail, link_url, is_visible, view_count, created_at)
VALUES (SEQ_THEME.NEXTVAL, 'chef_sh', '자취생 5분 컷 요리 BEST',
        '시간 없는 자취생을 위한 초간단 5분 요리 모음. 재료 4~5개로 끝!',
        'https://picsum.photos/seed/t2/600/400', NULL, 1, 2800, SYSDATE-15);

INSERT INTO RECOMMENDED_THEME (theme_id, user_id, title, description, thumbnail, link_url, is_visible, view_count, created_at)
VALUES (SEQ_THEME.NEXTVAL, 'cookie01', '홈베이킹 입문자를 위한 디저트',
        '오븐 켜는 게 두려운 분들을 위한 입문 디저트 레시피. 마카롱부터 케이크까지!',
        'https://picsum.photos/seed/t3/600/400', NULL, 1, 1800, SYSDATE-10);

INSERT INTO RECOMMENDED_THEME (theme_id, user_id, title, description, thumbnail, link_url, is_visible, view_count, created_at)
VALUES (SEQ_THEME.NEXTVAL, 'foodie03', '매콤한 음식 마니아 모여라',
        '매운맛 좋아하는 분들을 위한 매콤한 레시피 모음. 챌린지 단계별!',
        'https://picsum.photos/seed/t4/600/400', NULL, 1, 3500, SYSDATE-7);

INSERT INTO RECOMMENDED_THEME (theme_id, user_id, title, description, thumbnail, link_url, is_visible, view_count, created_at)
VALUES (SEQ_THEME.NEXTVAL, 'vegan01', '비건/채식 친화적 레시피',
        '동물성 재료 없이 만드는 맛있는 비건 요리. 채식 입문에 좋아요.',
        'https://picsum.photos/seed/t5/600/400', NULL, 1, 800, SYSDATE-5);

INSERT INTO RECOMMENDED_THEME (theme_id, user_id, title, description, thumbnail, link_url, is_visible, view_count, created_at)
VALUES (SEQ_THEME.NEXTVAL, 'quick01', '술 안주 추천 BEST',
        '치맥 말고 다른 안주 추천! 집에서 만드는 술자리 메뉴 모음.',
        'https://picsum.photos/seed/t6/600/400', NULL, 1, 1900, SYSDATE-3);

COMMIT;


-- ============================================================
-- 10. 테마-레시피 연결 (THEME_RECIPE)
-- ============================================================

-- 테마 1: 봄에 어울리는 한식
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 1, 1, 1);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 1, 2, 2);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 1, 4, 3);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 1, 5, 4);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 1, 39, 5);

-- 테마 2: 자취생 5분 컷
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 2, 10, 1);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 2, 16, 2);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 2, 25, 3);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 2, 34, 4);

-- 테마 3: 홈베이킹 디저트
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 27, 1);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 30, 2);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 31, 3);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 32, 4);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 29, 5);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 40, 6);

-- 테마 4: 매콤한 음식
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 1, 1);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 11, 2);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 13, 3);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 22, 4);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 33, 5);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 35, 6);

-- 테마 5: 비건/채식
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 5, 37, 1);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 5, 38, 2);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 5, 2,  3);

-- 테마 6: 술 안주
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 6,  1);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 8,  2);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 11, 3);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 13, 4);
INSERT INTO THEME_RECIPE VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 33, 5);

COMMIT;


-- ============================================================
-- 11. 데이터 확인
-- ============================================================

PROMPT '===== 회원 수 (총 16명: admin + 15) ====='
SELECT COUNT(*) AS user_count FROM USERS;

PROMPT '===== 레시피 수 (40개) ====='
SELECT COUNT(*) AS recipe_count FROM RECIPE;

PROMPT '===== 카테고리별 레시피 수 ====='
SELECT cm.name AS category, COUNT(r.recipe_id) AS recipe_cnt
  FROM CATEGORY_M cm
  LEFT JOIN RECIPE r ON cm.categorym_id = r.category_id AND r.is_deleted = 0
 GROUP BY cm.name, cm.categorym_id
 ORDER BY cm.categorym_id;

PROMPT '===== 인기 셰프 TOP 5 (총 조회수) ====='
SELECT u.nickname,
       COUNT(r.recipe_id) AS recipe_cnt,
       NVL(SUM(r.view_count), 0) AS total_views
  FROM USERS u
  LEFT JOIN RECIPE r ON u.user_id = r.user_id AND r.is_deleted = 0
 GROUP BY u.nickname, u.user_id
 ORDER BY total_views DESC
 FETCH FIRST 5 ROWS ONLY;

PROMPT '===== 별점 TOP 10 레시피 ====='
SELECT r.recipe_id, r.title, r.avg_rating, r.view_count, u.nickname
  FROM RECIPE r
  JOIN USERS u ON r.user_id = u.user_id
 WHERE r.is_deleted = 0
 ORDER BY r.avg_rating DESC, r.view_count DESC
 FETCH FIRST 10 ROWS ONLY;

PROMPT '===== 좋아요 많은 레시피 TOP 10 ====='
SELECT r.recipe_id, r.title, COUNT(l.user_id) AS like_cnt
  FROM RECIPE r
  LEFT JOIN RECIPE_LIKE l ON r.recipe_id = l.recipe_id
 WHERE r.is_deleted = 0
 GROUP BY r.recipe_id, r.title
 ORDER BY like_cnt DESC
 FETCH FIRST 10 ROWS ONLY;

PROMPT '===== 리뷰 수 + 대댓글 수 ====='
SELECT COUNT(*) AS total_reviews,
       SUM(CASE WHEN parent_review_id IS NULL THEN 1 ELSE 0 END) AS normal_reviews,
       SUM(CASE WHEN parent_review_id IS NOT NULL THEN 1 ELSE 0 END) AS replies
  FROM REVIEW;

PROMPT '===== 테마별 연결된 레시피 수 ====='
SELECT t.title, COUNT(tr.recipe_id) AS recipe_cnt
  FROM RECOMMENDED_THEME t
  LEFT JOIN THEME_RECIPE tr ON t.theme_id = tr.theme_id
 GROUP BY t.title, t.theme_id
 ORDER BY t.theme_id;


-- MEDAL_GRADE 컬럼 크기 늘리기
ALTER TABLE USERS MODIFY MEDAL_GRADE VARCHAR2(20);

-- chef_yw, cookie01 INSERT
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('chef_yw', 'yw@bggchef.com', 'pwd1234', '예원셰프', '010-1111-0003', NULL, TO_DATE('1997-01-08','YYYY-MM-DD'), 0, '플래티넘');
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('cookie01', 'cookie01@test.com', 'pwd1234', '쿠킹마스터', '010-3333-2001', NULL, TO_DATE('1993-04-05','YYYY-MM-DD'), 0, '플래티넘');
COMMIT;

SELECT COUNT(*) FROM USERS;

-- INGREDIENT 1~8번 추가 (데이터 파일에서 참조하는 번호)
INSERT INTO INGREDIENT VALUES (1, '돼지고기', 'g');
INSERT INTO INGREDIENT VALUES (2, '소고기', 'g');
INSERT INTO INGREDIENT VALUES (3, '애호박', '개');
INSERT INTO INGREDIENT VALUES (4, '대파', '대');
INSERT INTO INGREDIENT VALUES (5, '마늘', '쪽');
INSERT INTO INGREDIENT VALUES (6, '간장', '큰술');
INSERT INTO INGREDIENT VALUES (7, '설탕', 'g');
INSERT INTO INGREDIENT VALUES (8, '소금', '약간');

-- THEME_RECIPE INSERT (컬럼 6개에 맞게 NULL 추가)
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 1, 1, 1, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 1, 2, 2, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 1, 4, 3, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 1, 5, 4, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 2, 10, 1, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 2, 16, 2, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 2, 34, 3, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 27, 1, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 30, 2, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 31, 3, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 32, 4, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 3, 29, 5, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 1, 1, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 11, 2, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 13, 3, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 33, 4, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 35, 5, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 5, 37, 1, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 5, 38, 2, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 5, 2, 3, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 6, 1, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 8, 2, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 11, 3, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 13, 4, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 33, 5, NULL, NULL);
COMMIT;

SELECT COUNT(*) FROM THEME_RECIPE;
SELECT COUNT(*) FROM INGREDIENT;

CREATE TABLE CHEF_INTRO (
    user_id     VARCHAR2(50)    NOT NULL,
    intro       VARCHAR2(1000),
    updated_at  DATE            DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_CHEF_INTRO    PRIMARY KEY (user_id),
    CONSTRAINT FK_CHEF_INTRO_USER FOREIGN KEY (user_id)
        REFERENCES USERS(user_id)
);

SELECT * FROM CHEF_INTRO;

-- 1. [테이블 구조 변경] 필요한 컬럼 추가

ALTER TABLE RECOMMENDED_THEME ADD subtitle VARCHAR2(200);

ALTER TABLE RECIPE ADD LINK VARCHAR2(500);

ALTER TABLE THEME_RECIPE ADD user_id VARCHAR2(20);

ALTER TABLE THEME_RECIPE ADD description VARCHAR2(1000);



-- 2. [시퀀스 재생성] 중복 방지를 위한 시퀀스 초기화

DROP SEQUENCE RECOMMENDED_THEME_SEQ;

CREATE SEQUENCE RECOMMENDED_THEME_SEQ START WITH 11 INCREMENT BY 1 NOCACHE;



-- 3. [데이터 업데이트] 테마 정보 최신화

UPDATE RECOMMENDED_THEME 

SET TITLE = '술 안주 추천 BEST', 

    DESCRIPTION = '하루의 피로를 시원하게 날려줄 짜릿하고 맛있는 술안주 세계로 여러분을 초대합니다! 바삭한 삼겹살 구이와 매콤 고소한 치즈 닭갈비처럼 소주와 맥주, 그 어떤 술과도 찰떡궁합을 자랑하는 최고의 메뉴들만 쏙쏙 골라 모았습니다.' 

WHERE THEME_ID = 6;



UPDATE RECOMMENDED_THEME 

SET DESCRIPTION = '복잡한 과정 없이 계량만으로 무조건 성공하는 초보자 맞춤형 레시피를 소개합니다. 노버터 스콘부터 손반죽 없는 초코칩 쿠키까지 간단한 재료로 뚝딱 완성할 수 있습니다.' 

WHERE THEME_ID = 7;



-- 4. [매핑 데이터 초기화 및 재삽입]

DELETE FROM THEME_RECIPE;



-- 테마 4: 매콤한 음식 매핑

INSERT INTO THEME_RECIPE (theme_recipe_id, theme_id, recipe_id, user_id) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 1, 'admin');

INSERT INTO THEME_RECIPE (theme_recipe_id, theme_id, recipe_id, user_id) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 11, 'admin');

INSERT INTO THEME_RECIPE (theme_recipe_id, theme_id, recipe_id, user_id) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 4, 13, 'admin');



-- 테마 6: 술 안주 추천 매핑

INSERT INTO THEME_RECIPE (theme_recipe_id, theme_id, recipe_id, user_id) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 6, 'admin');

INSERT INTO THEME_RECIPE (theme_recipe_id, theme_id, recipe_id, user_id) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 8, 'admin');

INSERT INTO THEME_RECIPE (theme_recipe_id, theme_id, recipe_id, user_id) VALUES (SEQ_THEME_RECIPE.NEXTVAL, 6, 33, 'admin');



-- 5. [최종 정리 및 반영]

COMMIT;

SELECT RECIPE_ID, TITLE, USER_ID FROM RECIPE ORDER BY RECIPE_ID;
SELECT COUNT(*) FROM USERS;

-- 유저 추가
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('chef_yw', 'yw@bggchef.com', 'pwd1234', '예원셰프', '010-1111-0003', NULL, TO_DATE('1997-01-08','YYYY-MM-DD'), 0, '플래티넘');
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('cookie01', 'cookie01@test.com', 'pwd1234', '쿠킹마스터', '010-3333-2001', NULL, TO_DATE('1993-04-05','YYYY-MM-DD'), 0, '플래티넘');

-- 누락된 레시피 INSERT
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (1, 'chef_sh', 1, '얼큰한 김치찌개', 'https://picsum.photos/seed/r1/400/400', '집에서 만드는 정통 김치찌개', 2, 30, 1, 1520, 4.8, SYSDATE-30);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (3, 'foodie02', 1, '얼큰 부대찌개', 'https://picsum.photos/seed/r3/400/400', '소시지, 스팸, 라면이 어우러진 부대찌개', 4, 35, 2, 2340, 4.9, SYSDATE-25);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (15, 'cookie01', 4, '토마토 파스타', 'https://picsum.photos/seed/r15/400/400', '신선한 토마토와 바질로 만든 클래식 파스타', 2, 25, 1, 3400, 4.6, SYSDATE-21);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (24, 'chef_yw', 7, '연어 초밥', 'https://picsum.photos/seed/r24/400/400', '집에서 만드는 신선한 연어 초밥', 2, 30, 3, 2200, 4.8, SYSDATE-5);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (25, 'foodie03', 7, '회덮밥', 'https://picsum.photos/seed/r25/400/400', '신선한 회와 야채를 듬뿍 올린 회덮밥', 1, 15, 1, 1450, 4.4, SYSDATE-4);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (14, 'cookie01', 4, '진짜 까르보나라', 'https://picsum.photos/seed/r14/400/400', '이탈리아 정통식 까르보나라', 2, 20, 2, 6800, 4.9, SYSDATE-12);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (23, 'cookie01', 6, '일본식 카레 우동', 'https://picsum.photos/seed/r23/400/400', '진한 카레 국물에 쫄깃한 우동면', 2, 25, 1, 1850, 4.5, SYSDATE-6);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (39, 'chef_yw', 1, '돼지 김치찜', 'https://picsum.photos/seed/r39/400/400', '돼지고기 듬뿍 들어간 김치찜', 3, 90, 2, 1450, 4.6, SYSDATE-39);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (40, 'cookie01', 8, '티라미수', 'https://picsum.photos/seed/r40/400/400', '에스프레소 듬뿍 적신 정통 이탈리아 티라미수', 6, 60, 2, 2800, 4.8, SYSDATE-40);

COMMIT;
SELECT COUNT(*) FROM RECIPE;
SELECT COUNT(*) FROM USERS;

UPDATE USERS SET PROFILE_IMG = 'chef1.jpg' WHERE USER_ID = 'admin';
UPDATE USERS SET PROFILE_IMG = 'chef2.jpg' WHERE USER_ID = 'chef_hj';
UPDATE USERS SET PROFILE_IMG = 'chef3.jpg' WHERE USER_ID = 'chef_jm';
UPDATE USERS SET PROFILE_IMG = 'chef4.jpg' WHERE USER_ID = 'chef_mj';
UPDATE USERS SET PROFILE_IMG = 'chef5.jpg' WHERE USER_ID = 'chef_sh';
UPDATE USERS SET PROFILE_IMG = 'chef6.jpg' WHERE USER_ID = 'cookie02';
UPDATE USERS SET PROFILE_IMG = 'chef7.jpg' WHERE USER_ID = 'cookie03';
UPDATE USERS SET PROFILE_IMG = 'chef8.jpg' WHERE USER_ID = 'foodie01';
UPDATE USERS SET PROFILE_IMG = 'chef9.jpg' WHERE USER_ID = 'foodie02';
UPDATE USERS SET PROFILE_IMG = 'chef10.jpg' WHERE USER_ID = 'foodie03';
UPDATE USERS SET PROFILE_IMG = 'chef11.jpg' WHERE USER_ID = 'gg';
UPDATE USERS SET PROFILE_IMG = 'chef12.jpg' WHERE USER_ID = 'newbie01';
UPDATE USERS SET PROFILE_IMG = 'chef13.jpg' WHERE USER_ID = 'newbie02';
UPDATE USERS SET PROFILE_IMG = 'chef14.jpg' WHERE USER_ID = 'quick01';
UPDATE USERS SET PROFILE_IMG = 'chef15.jpg' WHERE USER_ID = 'vegan01';

COMMIT;

UPDATE RECIPE SET THUMBNAIL = 'recipe2.jpg' WHERE RECIPE_ID = 2;
UPDATE RECIPE SET THUMBNAIL = 'recipe4.jpg' WHERE RECIPE_ID = 4;
UPDATE RECIPE SET THUMBNAIL = 'recipe5.jpg' WHERE RECIPE_ID = 5;
UPDATE RECIPE SET THUMBNAIL = 'recipe6.jpg' WHERE RECIPE_ID = 6;
UPDATE RECIPE SET THUMBNAIL = 'recipe7.jpg' WHERE RECIPE_ID = 7;
UPDATE RECIPE SET THUMBNAIL = 'recipe8.jpg' WHERE RECIPE_ID = 8;
UPDATE RECIPE SET THUMBNAIL = 'recipe9.jpg' WHERE RECIPE_ID = 9;
UPDATE RECIPE SET THUMBNAIL = 'recipe10.jpg' WHERE RECIPE_ID = 10;
UPDATE RECIPE SET THUMBNAIL = 'recipe11.jpg' WHERE RECIPE_ID = 11;
UPDATE RECIPE SET THUMBNAIL = 'recipe12.jpg' WHERE RECIPE_ID = 12;
UPDATE RECIPE SET THUMBNAIL = 'recipe13.jpg' WHERE RECIPE_ID = 13;
UPDATE RECIPE SET THUMBNAIL = 'recipe14.jpg' WHERE RECIPE_ID = 14;
UPDATE RECIPE SET THUMBNAIL = 'recipe16.jpg' WHERE RECIPE_ID = 16;
UPDATE RECIPE SET THUMBNAIL = 'recipe17.jpg' WHERE RECIPE_ID = 17;
UPDATE RECIPE SET THUMBNAIL = 'recipe18.jpg' WHERE RECIPE_ID = 18;
UPDATE RECIPE SET THUMBNAIL = 'recipe19.jpg' WHERE RECIPE_ID = 19;
UPDATE RECIPE SET THUMBNAIL = 'recipe20.jpg' WHERE RECIPE_ID = 20;
UPDATE RECIPE SET THUMBNAIL = 'recipe21.jpg' WHERE RECIPE_ID = 21;
UPDATE RECIPE SET THUMBNAIL = 'recipe22.jpg' WHERE RECIPE_ID = 22;
UPDATE RECIPE SET THUMBNAIL = 'recipe23.jpg' WHERE RECIPE_ID = 23;
UPDATE RECIPE SET THUMBNAIL = 'recipe26.jpg' WHERE RECIPE_ID = 26;
UPDATE RECIPE SET THUMBNAIL = 'recipe27.jpg' WHERE RECIPE_ID = 27;
UPDATE RECIPE SET THUMBNAIL = 'recipe28.jpg' WHERE RECIPE_ID = 28;
UPDATE RECIPE SET THUMBNAIL = 'recipe29.jpg' WHERE RECIPE_ID = 29;
UPDATE RECIPE SET THUMBNAIL = 'recipe30.jpg' WHERE RECIPE_ID = 30;
UPDATE RECIPE SET THUMBNAIL = 'recipe31.jpg' WHERE RECIPE_ID = 31;
UPDATE RECIPE SET THUMBNAIL = 'recipe32.jpg' WHERE RECIPE_ID = 32;
UPDATE RECIPE SET THUMBNAIL = 'recipe33.jpg' WHERE RECIPE_ID = 33;
UPDATE RECIPE SET THUMBNAIL = 'recipe34.jpg' WHERE RECIPE_ID = 34;
UPDATE RECIPE SET THUMBNAIL = 'recipe35.jpg' WHERE RECIPE_ID = 35;
UPDATE RECIPE SET THUMBNAIL = 'recipe36.jpg' WHERE RECIPE_ID = 36;
UPDATE RECIPE SET THUMBNAIL = 'recipe37.jpg' WHERE RECIPE_ID = 37;
UPDATE RECIPE SET THUMBNAIL = 'recipe38.jpg' WHERE RECIPE_ID = 38;
UPDATE RECIPE SET THUMBNAIL = 'recipe39.jpg' WHERE RECIPE_ID = 39;

COMMIT;

ALTER TABLE THEME_RECIPE ADD recipe_image VARCHAR2(255);
ALTER TABLE THEME_RECIPE ADD thumbnail VARCHAR2(500);
ALTER TABLE REVIEW ADD theme_id NUMBER(11);
ALTER TABLE REVIEW MODIFY recipe_id NULL;
ALTER TABLE REVIEW ADD CONSTRAINT FK_REVIEW_THEME
    FOREIGN KEY (theme_id) REFERENCES RECOMMENDED_THEME(theme_id) ON DELETE CASCADE;
CREATE SEQUENCE REVIEW_SEQ START WITH 486 INCREMENT BY 1 NOCACHE NOCYCLE;
COMMIT;

-- jp 유저 3명
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('jp_user01', 'jp01@test.com', 'pwd1234', '和食マスタ?', '010-9999-0001', NULL, TO_DATE('1990-05-20','YYYY-MM-DD'), 0, '골드');
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('jp_user02', 'jp02@test.com', 'pwd1234', 'スイ?ツ女子', '010-9999-0002', NULL, TO_DATE('1995-03-11','YYYY-MM-DD'), 0, '실버');
INSERT INTO USERS (user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade)
VALUES ('jp_user03', 'jp03@test.com', 'pwd1234', 'ラ?メン道', '010-9999-0003', NULL, TO_DATE('1988-11-07','YYYY-MM-DD'), 0, '브론즈');
COMMIT;

-- 일본어 재료 (29~38번)
INSERT INTO INGREDIENT VALUES (29, '味?',     'g');
INSERT INTO INGREDIENT VALUES (30, '?油',     'ml');
INSERT INTO INGREDIENT VALUES (31, 'だし昆布', 'g');
INSERT INTO INGREDIENT VALUES (32, 'みりん',   'ml');
INSERT INTO INGREDIENT VALUES (33, '豆腐',     '丁');
INSERT INTO INGREDIENT VALUES (34, 'わかめ',   'g');
INSERT INTO INGREDIENT VALUES (35, 'サ?モン', 'g');
INSERT INTO INGREDIENT VALUES (36, '酢飯',     '合');
INSERT INTO INGREDIENT VALUES (37, '中華?',   'g');
INSERT INTO INGREDIENT VALUES (38, 'チャ?シュ?', 'g');
COMMIT;

-- 레시피 5개 (41~45번)
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (41, 'jp_user01', 7, '手?き?司', 'https://picsum.photos/seed/jp1/400/400', '新鮮なサ?モンを使った手?き?司。家族みんなで?しめます！', 4, 30, 2, 1200, 4.8, SYSDATE-10);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (42, 'jp_user03', 6, '本格豚骨ラ?メン', 'https://picsum.photos/seed/jp2/400/400', '豚骨を3時間煮?んだ本格ス?プ。チャ?シュ?も手作りです！', 2, 180, 3, 2300, 4.9, SYSDATE-8);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (43, 'jp_user01', 1, '豆腐とわかめの味?汁', 'https://picsum.photos/seed/jp3/400/400', '昆布だしで作る定番の味?汁。朝食にぴったりです。', 2, 15, 1, 890, 4.5, SYSDATE-6);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (44, 'jp_user02', 8, '抹茶ケ?キ', 'https://picsum.photos/seed/jp4/400/400', '京都産の抹茶を使った風味豊かなケ?キ。見た目も美しい！', 6, 60, 2, 3400, 4.7, SYSDATE-4);
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (45, 'jp_user01', 7, 'サ?モン?', 'https://picsum.photos/seed/jp5/400/400', '新鮮なサ?モンをたっぷりのせた海鮮?。?油との相性?群！', 1, 10, 1, 1800, 4.6, SYSDATE-2);
COMMIT;

-- 재료 연결
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 35, 41, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 36, 41, '2合');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 30, 41, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 37, 42, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 38, 42, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 30, 42, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 32, 42, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 29, 43, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 33, 43, '半丁');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 34, 43, '10g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 31, 43, '5g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 35, 45, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 36, 45, '1合');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 30, 45, '1큰술');
COMMIT;

-- 조리 순서
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 41, 1, NULL, '酢飯を作り、人肌程度に冷ましておきます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 41, 2, NULL, 'サ?モンを食べやすい大きさに切ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 41, 3, NULL, '海苔に酢飯とネタをのせて?いたら完成！');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 42, 1, NULL, '豚骨を水から3時間じっくり煮?んでス?プを作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 42, 2, NULL, '?油とみりんでス?プの味を整えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 42, 3, NULL, '?を茹でてス?プを注ぎ、チャ?シュ?をのせて完成！');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 43, 1, NULL, '昆布を水に30分浸してだし汁を作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 43, 2, NULL, 'だし汁を火にかけ、豆腐とわかめを入れます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 43, 3, NULL, '火を弱めて味?を溶かし入れたら完成！');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 45, 1, NULL, '酢飯をどんぶりに盛ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 45, 2, NULL, 'サ?モンを薄切りにして酢飯の上に?べます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 45, 3, NULL, '?油をかけて完成！お好みでわさびを添えてください。');
COMMIT;

-- 리뷰
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie01', 41, 5.0, '手作り?司、家族みんな大喜びでした！', NULL, SYSDATE-9);
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie02', 41, 4.8, 'とても美味しかったです。また作ります！', NULL, SYSDATE-8);
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'jp_user03', 42, 5.0, '本格的な豚骨ス?プに感動しました。', NULL, SYSDATE-7);
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'jp_user01', 43, 4.5, '?朝作りたくなる美味しさです！', NULL, SYSDATE-4);
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'foodie01', 44, 4.9, '抹茶の風味がたまらない！大好きです。', NULL, SYSDATE-2);
INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, created_at)
VALUES (SEQ_REVIEW.NEXTVAL, 'jp_user02', 45, 4.7, 'サ?モンが新鮮で最高でした！', NULL, SYSDATE-1);
COMMIT;

-- 추천 테마 (일본 가정요리, 和スイ?ツ)
INSERT INTO RECOMMENDED_THEME (theme_id, user_id, title, description, thumbnail, link_url, is_visible, view_count, created_at)
VALUES (SEQ_THEME.NEXTVAL, 'jp_user01', '日本の家庭料理',
        '家族みんなで?しめる日本の定番家庭料理を集めました。',
        'https://picsum.photos/seed/jpt1/600/400', NULL, 1, 950, SYSDATE-5);
INSERT INTO RECOMMENDED_THEME (theme_id, user_id, title, description, thumbnail, link_url, is_visible, view_count, created_at)
VALUES (SEQ_THEME.NEXTVAL, 'jp_user02', '和スイ?ツ特集',
        '抹茶や和素材を使ったスイ?ツレシピ。日本の甘さを?しもう！',
        'https://picsum.photos/seed/jpt2/600/400', NULL, 1, 1500, SYSDATE-3);
COMMIT;

-- 테마-레시피 연결
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION)
VALUES (SEQ_THEME_RECIPE.NEXTVAL, 8, 41, 1, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION)
VALUES (SEQ_THEME_RECIPE.NEXTVAL, 8, 42, 2, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION)
VALUES (SEQ_THEME_RECIPE.NEXTVAL, 8, 43, 3, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION)
VALUES (SEQ_THEME_RECIPE.NEXTVAL, 8, 45, 4, NULL, NULL);
INSERT INTO THEME_RECIPE (THEME_RECIPE_ID, THEME_ID, RECIPE_ID, SORT_ORDER, USER_ID, DESCRIPTION)
VALUES (SEQ_THEME_RECIPE.NEXTVAL, 9, 44, 1, NULL, NULL);
COMMIT;

SELECT COUNT(*) AS 유저 FROM USERS;
SELECT COUNT(*) AS 레시피 FROM RECIPE;
SELECT COUNT(*) AS 테마 FROM RECOMMENDED_THEME;

UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/' || THUMBNAIL 
WHERE THUMBNAIL NOT LIKE '/resources%' 
AND THUMBNAIL NOT LIKE 'http%';

UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe1.jpg'  WHERE THUMBNAIL = 'https://picsum.photos/seed/r1/400/400';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe3.jpg'  WHERE THUMBNAIL = 'https://picsum.photos/seed/r3/400/400';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe15.jpg' WHERE THUMBNAIL = 'https://picsum.photos/seed/r15/400/400';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe24.jpg' WHERE THUMBNAIL = 'https://picsum.photos/seed/r24/400/400';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe25.jpg' WHERE THUMBNAIL = 'https://picsum.photos/seed/r25/400/400';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe40.jpg' WHERE THUMBNAIL = 'https://picsum.photos/seed/r40/400/400';

COMMIT;

UPDATE USERS SET PROFILE_IMG = '/resources/upload/profile/' || PROFILE_IMG 
WHERE PROFILE_IMG NOT LIKE '/resources%' 
AND PROFILE_IMG NOT LIKE 'http%'
AND PROFILE_IMG IS NOT NULL;

COMMIT;
SELECT USER_ID, PROFILE_IMG FROM USERS WHERE PROFILE_IMG IS NOT NULL;

SELECT RECIPE_ID, TITLE, THUMBNAIL FROM RECIPE ORDER BY RECIPE_ID;

UPDATE RECIPE SET THUMBNAIL = NULL 
WHERE RECIPE_ID IN (35, 36, 37, 38, 39, 40);

COMMIT;

UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe1.jpg' WHERE RECIPE_ID = 1;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe1.jpg' WHERE RECIPE_ID = 2;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe2.jpg' WHERE RECIPE_ID = 3;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe2.jpg' WHERE RECIPE_ID = 4;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe3.jpg' WHERE RECIPE_ID = 5;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe4.jpg' WHERE RECIPE_ID = 6;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe5.jpg' WHERE RECIPE_ID = 7;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe6.jpg' WHERE RECIPE_ID = 8;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe9.jpg' WHERE RECIPE_ID = 9;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe7.jpg' WHERE RECIPE_ID = 10;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe8.jpg' WHERE RECIPE_ID = 11;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe12.jpg' WHERE RECIPE_ID = 12;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe11.jpg' WHERE RECIPE_ID = 13;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe10.jpg' WHERE RECIPE_ID = 14;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe14.jpg' WHERE RECIPE_ID = 15;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe14.jpg' WHERE RECIPE_ID = 16;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe14.jpg' WHERE RECIPE_ID = 17;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe15.jpg' WHERE RECIPE_ID = 18;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe16.jpg' WHERE RECIPE_ID = 19;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe17.jpg' WHERE RECIPE_ID = 20;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe18.jpg' WHERE RECIPE_ID = 21;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe22.jpg' WHERE RECIPE_ID = 22;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe20.jpg' WHERE RECIPE_ID = 23;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe21.jpg' WHERE RECIPE_ID = 24;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe21.jpg' WHERE RECIPE_ID = 25;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe21.jpg' WHERE RECIPE_ID = 26;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe22.jpg' WHERE RECIPE_ID = 27;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe23.jpg' WHERE RECIPE_ID = 28;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe24.jpg' WHERE RECIPE_ID = 29;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe25.jpg' WHERE RECIPE_ID = 30;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe26.jpg' WHERE RECIPE_ID = 31;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe27.jpg' WHERE RECIPE_ID = 32;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe28.jpg' WHERE RECIPE_ID = 33;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe29.jpg' WHERE RECIPE_ID = 34;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe30.jpg' WHERE RECIPE_ID = 35;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe31.jpg' WHERE RECIPE_ID = 36;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe32.jpg' WHERE RECIPE_ID = 37;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe33.jpg' WHERE RECIPE_ID = 38;
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe34.jpg' WHERE RECIPE_ID = 39;
UPDATE RECIPE SET THUMBNAIL = NULL WHERE RECIPE_ID = 40;

COMMIT;