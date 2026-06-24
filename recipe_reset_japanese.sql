-- ============================================================
-- 기존 레시피 관련 데이터 전체 삭제 (FK 순서 주의)
-- ============================================================

DELETE FROM THEME_RECIPE;
DELETE FROM RECIPE_LIKE;
DELETE FROM FAVORITE WHERE RECIPE_ID IS NOT NULL;
DELETE FROM REVIEW WHERE RECIPE_ID IS NOT NULL;
DELETE FROM RECIPE;
-- RECIPE_STEP, RECIPE_INGREDIENTS 는 ON DELETE CASCADE 로 자동 삭제

COMMIT;

-- ============================================================
-- 시퀀스 재설정
-- ============================================================

DROP SEQUENCE SEQ_RECIPE;
CREATE SEQUENCE SEQ_RECIPE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 35 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_RECIPE_STEP;
CREATE SEQUENCE SEQ_RECIPE_STEP MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_RECIPE_INGR;
CREATE SEQUENCE SEQ_RECIPE_INGR MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

-- ============================================================
-- 일본어 재료 추가 (ID 39~57)
-- 기존 재료도 활용: 6=간장, 7=버터, 8=밀가루, 9=참기름,
--   10=소금, 14=달걀, 18=설탕, 26=박력분
-- ============================================================

-- 재실행 대비: 이미 있으면 삭제 후 재삽입
DELETE FROM INGREDIENT WHERE INGREDIENT_ID >= 39;

INSERT INTO INGREDIENT VALUES (39, 'みそ',        'g');
INSERT INTO INGREDIENT VALUES (40, 'だし汁',       'ml');
INSERT INTO INGREDIENT VALUES (41, 'みりん',       'ml');
INSERT INTO INGREDIENT VALUES (42, '酒',           'ml');
INSERT INTO INGREDIENT VALUES (43, 'サーモン',     'g');
INSERT INTO INGREDIENT VALUES (44, 'まぐろ',       'g');
INSERT INTO INGREDIENT VALUES (45, 'えび',         'g');
INSERT INTO INGREDIENT VALUES (46, '豚肉',         'g');
INSERT INTO INGREDIENT VALUES (47, '鶏肉',         'g');
INSERT INTO INGREDIENT VALUES (49, 'ネギ',         'g');
INSERT INTO INGREDIENT VALUES (50, '海苔',         '枚');
INSERT INTO INGREDIENT VALUES (51, '酢飯',         'g');
INSERT INTO INGREDIENT VALUES (52, '生クリーム',   'ml');
INSERT INTO INGREDIENT VALUES (53, '抹茶粉',       'g');
INSERT INTO INGREDIENT VALUES (54, 'たこ',         'g');
INSERT INTO INGREDIENT VALUES (55, 'キャベツ',     'g');
INSERT INTO INGREDIENT VALUES (56, 'ソース',       'ml');
INSERT INTO INGREDIENT VALUES (57, 'イチゴ',       'g');

COMMIT;

-- ============================================================
-- 레시피 34개 (RECIPE_ID 1~34, 썸네일은 recipe{ID}.jpg 매핑)
-- 유저 배분: 18명 전원에게 1~3개씩 골고루
-- chef_sh:2  chef_jm:2  chef_yw:3  chef_hj:2  chef_mj:2
-- foodie01:2  foodie02:2  foodie03:2  quick01:1
-- newbie01:1  newbie02:1  vegan01:1
-- jp_user01:3  jp_user02:2  jp_user03:2
-- cookie01:2  cookie02:2  cookie03:2
-- ============================================================

-- ===== 국/탕 (category_id = 1) : 3개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (1, 'chef_sh', 1, '基本の味噌汁',
        '/resources/upload/recipe/recipe1.jpg',
        '毎朝飲みたい定番のお味噌汁。豆腐とわかめのシンプルな一杯です。',
        2, 15, 1, 2800, 4.7, SYSDATE-20);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (2, 'chef_jm', 1, 'けんちん汁',
        '/resources/upload/recipe/recipe2.jpg',
        '根菜たっぷりの具沢山汁物。体が温まる一品です。',
        4, 30, 2, 1500, 4.5, SYSDATE-18);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (3, 'chef_yw', 1, '豚汁',
        '/resources/upload/recipe/recipe3.jpg',
        '豚肉と野菜がたっぷり入った食べ応えある汁物。寒い季節にぴったり！',
        4, 25, 1, 3200, 4.8, SYSDATE-15);

-- ===== 반찬 (category_id = 2) : 5개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (4, 'chef_hj', 2, '鶏の唐揚げ',
        '/resources/upload/recipe/recipe4.jpg',
        'カリカリジューシーな定番唐揚げ。ニンニクと醤油で下味をつけてカラッと揚げます。',
        3, 30, 2, 5200, 4.9, SYSDATE-30);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (5, 'chef_mj', 2, '肉じゃが',
        '/resources/upload/recipe/recipe5.jpg',
        '甘辛い煮汁がしみた懐かしい家庭料理の定番。牛肉とじゃがいもで作ります。',
        4, 40, 2, 4100, 4.8, SYSDATE-25);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (6, 'foodie01', 2, '筑前煮',
        '/resources/upload/recipe/recipe6.jpg',
        '根菜と鶏肉の旨味たっぷりの煮物。おせち料理にも欠かせない一品です。',
        4, 45, 2, 2300, 4.6, SYSDATE-22);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (7, 'foodie02', 2, '天ぷら',
        '/resources/upload/recipe/recipe7.jpg',
        'サクサク衣の天ぷら。えびや野菜を揚げたてで食べると絶品！天つゆと一緒に。',
        2, 35, 3, 3800, 4.7, SYSDATE-28);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (8, 'foodie03', 2, '焼き餃子',
        '/resources/upload/recipe/recipe8.jpg',
        'パリッとした焼き餃子。ニラと豚肉たっぷりで食べ応えあり。ビールにも合う！',
        4, 40, 2, 6100, 4.9, SYSDATE-10);

-- ===== 볶음 (category_id = 3) : 5개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (9, 'quick01', 3, '焼きそば',
        '/resources/upload/recipe/recipe9.jpg',
        'ソースが絡んだ定番の焼きそば。キャベツと豚肉で簡単に作れます。',
        2, 20, 1, 4500, 4.7, SYSDATE-12);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (10, 'jp_user01', 3, '炒飯',
        '/resources/upload/recipe/recipe10.jpg',
        'パラパラ食感のチャーハン。高温で一気に炒めるのがコツです。',
        2, 15, 2, 5800, 4.8, SYSDATE-8);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (11, 'newbie01', 3, '野菜炒め',
        '/resources/upload/recipe/recipe11.jpg',
        'シャキシャキ野菜の炒め物。オイスターソースで味付けするのがポイント。',
        2, 15, 1, 2100, 4.5, SYSDATE-5);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (12, 'newbie02', 3, 'お好み焼き',
        '/resources/upload/recipe/recipe12.jpg',
        'ふわふわ食感の大阪風お好み焼き。ソースとマヨネーズで仕上げます。',
        2, 25, 2, 4200, 4.8, SYSDATE-14);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (13, 'jp_user02', 3, 'たこ焼き',
        '/resources/upload/recipe/recipe13.jpg',
        'とろっとした中身が魅力のたこ焼き。家でも本格的に作れます！',
        3, 30, 2, 5500, 4.9, SYSDATE-6);

-- ===== 파스타 (category_id = 4) : 2개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (14, 'chef_sh', 4, '和風きのこパスタ',
        '/resources/upload/recipe/recipe14.jpg',
        '醤油バターのさっぱり和風パスタ。きのこの旨味が凝縮した一皿。',
        2, 20, 1, 3400, 4.6, SYSDATE-16);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (15, 'foodie01', 4, '明太子クリームパスタ',
        '/resources/upload/recipe/recipe15.jpg',
        '濃厚クリームソースに明太子のピリ辛がマッチした人気パスタ。',
        2, 20, 1, 6800, 4.9, SYSDATE-9);

-- ===== 스테이크 (category_id = 5) : 2개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (16, 'chef_jm', 5, '和牛ステーキ',
        '/resources/upload/recipe/recipe16.jpg',
        '和牛の旨味を活かしたシンプルなステーキ。塩胡椒と醤油バターで仕上げます。',
        2, 20, 2, 2900, 4.8, SYSDATE-19);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (17, 'chef_yw', 5, '照り焼きチキン',
        '/resources/upload/recipe/recipe17.jpg',
        '甘辛タレが絡んだ照り焼きチキン。ご飯との相性抜群です。',
        2, 25, 1, 4700, 4.8, SYSDATE-23);

-- ===== 면 (category_id = 6) : 5개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (18, 'jp_user03', 6, '醤油ラーメン',
        '/resources/upload/recipe/recipe18.jpg',
        '澄んだ醤油スープが美しい定番ラーメン。自家製チャーシューも作ります。',
        2, 60, 3, 5100, 4.8, SYSDATE-27);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (19, 'chef_hj', 6, '肉うどん',
        '/resources/upload/recipe/recipe19.jpg',
        '柔らかい牛肉とコシのあるうどん。だしの効いたスープが美味しい。',
        2, 25, 1, 3300, 4.6, SYSDATE-21);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (20, 'foodie02', 6, 'ざる蕎麦',
        '/resources/upload/recipe/recipe20.jpg',
        '喉越し爽やかな冷たいお蕎麦。つゆにたっぷりつけていただきます。',
        2, 15, 1, 2800, 4.5, SYSDATE-11);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (21, 'jp_user01', 6, '冷やし中華',
        '/resources/upload/recipe/recipe21.jpg',
        '夏の定番！野菜たっぷりの冷やし中華。ごまだれで絶品です。',
        2, 20, 1, 3600, 4.7, SYSDATE-7);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (22, 'chef_mj', 6, 'つけ麺',
        '/resources/upload/recipe/recipe22.jpg',
        '濃厚なつけ汁に麺をくぐらせて食べる本格つけ麺。',
        2, 90, 3, 4200, 4.9, SYSDATE-13);

-- ===== 초밥/회 (category_id = 7) : 5개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (23, 'jp_user03', 7, '握り寿司盛り合わせ',
        '/resources/upload/recipe/recipe23.jpg',
        'まぐろ・サーモン・えびの基本握り寿司。酢飯から手作りします。',
        2, 45, 3, 5600, 4.9, SYSDATE-29);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (24, 'jp_user02', 7, '恵方巻き',
        '/resources/upload/recipe/recipe24.jpg',
        '具材たっぷりの太巻き。節分には欠かせない一品。',
        4, 40, 2, 3100, 4.6, SYSDATE-26);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (25, 'jp_user01', 7, '刺身盛り合わせ',
        '/resources/upload/recipe/recipe25.jpg',
        'まぐろとサーモンの刺身盛り。新鮮な魚を薄く引いて盛り付けます。',
        2, 15, 2, 4800, 4.8, SYSDATE-24);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (26, 'chef_yw', 7, 'ちらし寿司',
        '/resources/upload/recipe/recipe26.jpg',
        '色とりどりの具材を散らした華やかな寿司。お祝いの席にも。',
        4, 30, 2, 3900, 4.7, SYSDATE-17);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (27, 'foodie03', 7, '手巻き寿司',
        '/resources/upload/recipe/recipe27.jpg',
        'みんなで楽しく巻いて食べる手巻き寿司パーティー。',
        4, 30, 1, 3400, 4.6, SYSDATE-4);

-- ===== 케이크 (category_id = 8) : 4개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (28, 'cookie01', 8, 'ロールケーキ',
        '/resources/upload/recipe/recipe28.jpg',
        'ふわふわスポンジに生クリームを巻いた定番スイーツ。',
        6, 60, 2, 4300, 4.7, SYSDATE-32);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (29, 'cookie02', 8, 'チーズケーキ',
        '/resources/upload/recipe/recipe29.jpg',
        'なめらかな濃厚チーズケーキ。焼き上がりをよく冷やして食べます。',
        8, 90, 2, 5900, 4.9, SYSDATE-35);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (30, 'cookie03', 8, 'ショートケーキ',
        '/resources/upload/recipe/recipe30.jpg',
        'イチゴと生クリームの王道ショートケーキ。誕生日に作りたい一品！',
        6, 90, 3, 6200, 4.9, SYSDATE-31);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (31, 'cookie01', 8, '抹茶ケーキ',
        '/resources/upload/recipe/recipe31.jpg',
        '香り高い抹茶のスポンジケーキ。和洋折衷の絶品スイーツ。',
        6, 75, 3, 5100, 4.8, SYSDATE-28);

-- ===== 쿠키 (category_id = 9) : 3개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (32, 'cookie02', 9, 'バタークッキー',
        '/resources/upload/recipe/recipe32.jpg',
        'サクサクのバタークッキー。型抜きして可愛く仕上げましょう。',
        4, 50, 1, 4800, 4.7, SYSDATE-33);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (33, 'vegan01', 9, '抹茶クッキー',
        '/resources/upload/recipe/recipe33.jpg',
        '抹茶の香りと苦みがアクセント。サクサク食感が止まらないクッキー。',
        4, 45, 1, 4100, 4.8, SYSDATE-36);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (34, 'cookie03', 9, 'マカロン',
        '/resources/upload/recipe/recipe34.jpg',
        'カラフルで可愛いマカロン。コツさえつかめば家でも本格的に！',
        4, 120, 3, 7200, 4.9, SYSDATE-40);

COMMIT;

-- ============================================================
-- 재료 (RECIPE_INGREDIENTS)
-- 사용 ID:  6=간장, 7=버터, 8=밀가루, 9=참기름, 10=소금
--            14=달걀, 18=설탕, 26=박력분
--            39=みそ, 40=だし汁, 41=みりん, 42=酒
--            43=サーモン, 44=まぐろ, 45=えび, 46=豚肉, 47=鶏肉
--            49=ネギ, 50=海苔, 51=酢飯, 52=生クリーム
--            53=抹茶粉, 54=たこ, 55=キャベツ, 56=ソース, 57=イチゴ
-- ============================================================

-- 1: 味噌汁
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 39, 1, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 40, 1, '600ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 1, '1丁');

-- 2: けんちん汁
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 40, 2, '800ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  2, '大さじ1');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 10, 2, '少々');

-- 3: 豚汁
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 46, 3, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 39, 3, '大さじ3');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 40, 3, '800ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 41, 3, '大さじ1');

-- 4: 鶏の唐揚げ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 47, 4, '300g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  4, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 42, 4, '大さじ1');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 8,  4, '大さじ3');

-- 5: 肉じゃが
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  5, '大さじ4');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 5, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 41, 5, '大さじ3');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 42, 5, '大さじ2');

-- 6: 筑前煮
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 47, 6, '250g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  6, '大さじ3');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 41, 6, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 6, '大さじ1');

-- 7: 天ぷら
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 45, 7, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 8,  7, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 7, '1個');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 10, 7, '少々');

-- 8: 焼き餃子
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 46, 8, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 55, 8, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 49, 8, '50g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  8, '大さじ1');

-- 9: 焼きそば
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 46, 9, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 55, 9, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 56, 9, '大さじ3');

-- 10: 炒飯
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 10, '2個');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  10, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  10, '大さじ1');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 49, 10, '30g');

-- 11: 野菜炒め
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 55, 11, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  11, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  11, '大さじ1');

-- 12: お好み焼き
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 8,  12, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 12, '2個');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 55, 12, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 56, 12, '適量');

-- 13: たこ焼き
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 54, 13, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 8,  13, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 13, '2個');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 56, 13, '適量');

-- 14: 和風きのこパスタ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  14, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  14, '20g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 49, 14, '30g');

-- 15: 明太子クリームパスタ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 52, 15, '150ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  15, '大さじ1');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  15, '15g');

-- 16: 和牛ステーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  16, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  16, '20g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 10, 16, '少々');

-- 17: 照り焼きチキン
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 47, 17, '300g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  17, '大さじ3');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 41, 17, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 17, '大さじ1');

-- 18: 醤油ラーメン
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  18, '大さじ3');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 40, 18, '600ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 46, 18, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 49, 18, '30g');

-- 19: 肉うどん
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 40, 19, '500ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  19, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 41, 19, '大さじ1');

-- 20: ざる蕎麦
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  20, '大さじ3');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 40, 20, '400ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 41, 20, '大さじ2');

-- 21: 冷やし中華
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  21, '大さじ2');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  21, '大さじ1');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 21, '2個');

-- 22: つけ麺
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  22, '大さじ4');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 40, 22, '300ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 46, 22, '200g');

-- 23: 握り寿司盛り合わせ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 51, 23, '300g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 44, 23, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 43, 23, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 45, 23, '80g');

-- 24: 恵方巻き
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 51, 24, '400g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 50, 24, '4枚');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 43, 24, '100g');

-- 25: 刺身盛り合わせ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 44, 25, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 43, 25, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  25, '大さじ2');

-- 26: ちらし寿司
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 51, 26, '400g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 43, 26, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 45, 26, '80g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 26, '2個');

-- 27: 手巻き寿司
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 51, 27, '400g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 50, 27, '6枚');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 44, 27, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 43, 27, '100g');

-- 28: ロールケーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 28, '4個');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 28, '80g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 28, '60g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 52, 28, '200ml');

-- 29: チーズケーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 29, '3個');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 29, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 52, 29, '200ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  29, '80g');

-- 30: ショートケーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 57, 30, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 52, 30, '300ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 30, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 30, '3個');

-- 31: 抹茶ケーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 53, 31, '15g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 31, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 31, '3個');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 52, 31, '200ml');

-- 32: バタークッキー
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  32, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 32, '60g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 32, '180g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 32, '1個');

-- 33: 抹茶クッキー
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 53, 33, '10g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  33, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 33, '170g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 33, '60g');

-- 34: マカロン
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 34, '2個');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 34, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 34, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 52, 34, '100ml');

COMMIT;

-- ============================================================
-- 조리 단계 (RECIPE_STEP)
-- ============================================================

-- 1: 味噌汁
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 1, NULL, 'だし汁を鍋に入れて中火で温めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 2, NULL, '豆腐を角切りにして加え、沸騰直前まで加熱します。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 3, NULL, '火を止めてから味噌を溶き入れ、わかめを加えて完成です。');

-- 2: けんちん汁
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 2, 1, NULL, 'ごま油で根菜類（ごぼう・大根・にんじん）を炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 2, 2, NULL, 'だし汁を加えて根菜が柔らかくなるまで煮込みます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 2, 3, NULL, '醤油と塩で味を調えて完成。お好みでネギを散らします。');

-- 3: 豚汁
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 3, 1, NULL, '豚肉を食べやすい大きさに切り、野菜を一口大に切ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 3, 2, NULL, '鍋でごま油を熱し、豚肉と野菜を炒め、だし汁を加えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 3, 3, NULL, '材料が柔らかくなったら火を止め、味噌を溶き入れて完成。');

-- 4: 鶏の唐揚げ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 4, 1, NULL, '鶏もも肉を一口大に切り、醤油・酒・生姜で30分下味をつけます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 4, 2, NULL, '片栗粉と小麦粉を混ぜて鶏肉にまぶします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 4, 3, NULL, '170℃の油で4分、190℃に上げて1分二度揚げしてカリッと仕上げます。');

-- 5: 肉じゃが
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 5, 1, NULL, '鍋でサラダ油を熱し、牛肉・玉ねぎ・じゃがいもを炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 5, 2, NULL, '水・醤油・みりん・砂糖・酒を加えて蓋をして中火で煮込みます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 5, 3, NULL, 'じゃがいもが柔らかくなったら蓋を取り、煮汁を絡めて完成。');

-- 6: 筑前煮
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 6, 1, NULL, '鶏肉と根菜を食べやすい大きさに切り、ごま油で炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 6, 2, NULL, '水・醤油・みりん・砂糖を加えて落とし蓋をして煮込みます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 6, 3, NULL, '煮汁が少なくなったら火を止め、器に盛り付けて完成。');

-- 7: 天ぷら
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 7, 1, NULL, '天ぷら粉を冷水で混ぜ、サクッとした衣を作ります（混ぜすぎ注意）。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 7, 2, NULL, 'えびの背ワタを取り、野菜も食べやすく切っておきます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 7, 3, NULL, '170℃の油で衣をつけた食材を揚げ、天つゆと一緒にいただきます。');

-- 8: 焼き餃子
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 8, 1, NULL, 'キャベツと豚肉をよく混ぜて餃子のタネを作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 8, 2, NULL, '餃子の皮にタネを包み、ひだを作りながら閉じます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 8, 3, NULL, 'フライパンで焼き色をつけ、水を加えて蒸し焼きにして完成。');

-- 9: 焼きそば
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 9, 1, NULL, 'フライパンで豚肉を炒め、キャベツと野菜を加えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 9, 2, NULL, '蒸した焼きそば麺を加えてほぐしながら炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 9, 3, NULL, 'ソースを回しかけて全体に絡め、お好みで青のりをかけて完成。');

-- 10: 炒飯
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 10, 1, NULL, '卵を溶いてごはんに混ぜておきます（パラパラに仕上げるコツ）。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 10, 2, NULL, '高温のフライパンにごま油をひき、具材を炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 10, 3, NULL, 'ごはんを加えて一気に炒め、醤油を鍋肌から回しかけて完成。');

-- 11: 野菜炒め
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 11, 1, NULL, 'キャベツ・もやし・にんじんなど好みの野菜を切ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 11, 2, NULL, '強火でごま油を熱し、野菜を一気に炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 11, 3, NULL, '醤油とオイスターソースで味を調えて完成。');

-- 12: お好み焼き
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 12, 1, NULL, '小麦粉・だし・卵・千切りキャベツを混ぜて生地を作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 12, 2, NULL, 'フライパンに生地を流し入れ、豚肉をのせて中火で焼きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 12, 3, NULL, '裏返して両面に焼き色をつけ、ソース・マヨネーズ・青のりをかけて完成。');

-- 13: たこ焼き
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 13, 1, NULL, '小麦粉・だし汁・卵を混ぜてたこ焼き生地を作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 13, 2, NULL, 'たこ焼き器に油をひき、生地を入れ、たこ・紅ショウガを入れます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 13, 3, NULL, '竹串で丸く形を整えながら焼き、ソース・マヨネーズをかけて完成。');

-- 14: 和風きのこパスタ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 1, NULL, 'パスタを塩ゆでし、きのこ類（しめじ・えのき等）を炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 2, NULL, 'バターを加えて溶かし、醤油を回しかけます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 3, NULL, 'ゆでたパスタを和えて皿に盛り、大葉を散らして完成。');

-- 15: 明太子クリームパスタ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 15, 1, NULL, 'パスタを塩ゆでします。明太子は薄皮を除いておきます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 15, 2, NULL, 'フライパンにバターを溶かし、生クリームと明太子を加えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 15, 3, NULL, 'パスタを加えてソースと和え、醤油を少し垂らして完成。');

-- 16: 和牛ステーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 16, 1, NULL, '牛肉を常温に戻し、両面に塩胡椒をふります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 16, 2, NULL, '強火で熱したフライパンで両面に焼き色をつけます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 16, 3, NULL, 'バターと醤油を加えてフランベし、肉汁ごとソースを絡めて完成。');

-- 17: 照り焼きチキン
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 17, 1, NULL, '鶏もも肉は皮目をフォークで刺して下準備をします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 17, 2, NULL, 'フライパンで皮目から焼き、両面に焼き色をつけます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 17, 3, NULL, '醤油・みりん・砂糖を合わせたタレを加えて絡め、照りが出たら完成。');

-- 18: 醤油ラーメン
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 18, 1, NULL, '豚肉をタコ糸で縛り、醤油・みりん・酒で煮てチャーシューを作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 18, 2, NULL, 'だし汁に醤油ダレを加えてスープを作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 18, 3, NULL, '麺をゆでてどんぶりに盛り、スープを注いでチャーシュー・ネギをのせて完成。');

-- 19: 肉うどん
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 19, 1, NULL, 'だし汁を沸かし、醤油・みりん・塩でスープを整えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 19, 2, NULL, '牛肉を薄切りにして甘辛く煮ます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 19, 3, NULL, 'うどんをゆでてスープに入れ、牛肉をのせて完成。');

-- 20: ざる蕎麦
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 20, 1, NULL, '蕎麦を沸騰したお湯で袋の表示通りにゆでます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 20, 2, NULL, 'ゆで上がったら冷水でしっかり洗い締めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 20, 3, NULL, 'めんつゆを薄めて器に用意し、蕎麦を竹ざるに盛って完成。');

-- 21: 冷やし中華
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 21, 1, NULL, '中華麺をゆでて冷水で締め、水気をよく切ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 21, 2, NULL, 'きゅうり・ハム・錦糸卵などのトッピングを準備します。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 21, 3, NULL, '麺を皿に盛り、具材を並べ、ごまだれをかけて完成。');

-- 22: つけ麺
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 22, 1, NULL, '豚骨と鶏ガラで濃厚なスープをとり、醤油ダレを合わせます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 22, 2, NULL, '太麺をゆでて冷水で締め、盛り付けます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 22, 3, NULL, '熱々のつけ汁に麺をくぐらせて食べます。チャーシューをスープに加えても美味。');

-- 23: 握り寿司盛り合わせ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 23, 1, NULL, '温かいご飯に寿司酢を合わせて酢飯を作り、うちわで冷まします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 23, 2, NULL, 'まぐろ・サーモン・えびを薄く切り、形を整えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 23, 3, NULL, '酢飯を握り、ネタをのせて醤油とわさびでいただきます。');

-- 24: 恵方巻き
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 24, 1, NULL, '酢飯を作り、具材（きゅうり・えび・玉子焼きなど）を準備します。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 24, 2, NULL, '海苔の上に酢飯を薄く広げ、手前に具材を並べます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 24, 3, NULL, '具材が中心になるよう手前からしっかり巻いて完成。');

-- 25: 刺身盛り合わせ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 25, 1, NULL, '新鮮なまぐろとサーモンを刺身包丁で薄く引きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 25, 2, NULL, '切り身を扇状に並べ、大根のつまを添えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 25, 3, NULL, 'わさびと醤油でいただきます。');

-- 26: ちらし寿司
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 26, 1, NULL, '酢飯を作り、桶に広げます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 26, 2, NULL, '錦糸卵・サーモン・えびなどの具材を色よく準備します。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 26, 3, NULL, '酢飯の上に具材を散らして完成。花びらのように美しく盛り付けます。');

-- 27: 手巻き寿司
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 27, 1, NULL, '酢飯を作り、具材（刺身・きゅうり・アボカドなど）を切り分けます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 27, 2, NULL, '海苔を正方形に切り、酢飯をのせて具材を斜めに置きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 27, 3, NULL, 'コーン型に巻いて完成。好みの具材で楽しみましょう！');

-- 28: ロールケーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 28, 1, NULL, '卵を泡立て、砂糖・薄力粉を加えてスポンジ生地を作り、薄く焼きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 28, 2, NULL, '生クリームを8分立てに泡立てて冷やしておきます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 28, 3, NULL, 'スポンジの内側に生クリームを塗り、端からしっかり巻いて冷蔵庫で形を固めます。');

-- 29: チーズケーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 29, 1, NULL, 'クリームチーズ・砂糖・卵・生クリームを混ぜてなめらかな生地を作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 29, 2, NULL, 'クッキーを砕いてバターで固めた台に生地を流し入れます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 29, 3, NULL, '160℃で50分焼き、粗熱を取ったら冷蔵庫で一晩冷やして完成。');

-- 30: ショートケーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 1, NULL, '薄力粉・卵・砂糖でスポンジ生地を焼いて冷まします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 2, NULL, '生クリームを7分立てに泡立て、スポンジに塗ってイチゴを並べます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 3, NULL, 'もう一枚スポンジをのせ、全体に生クリームを塗りデコレーションして完成。');

-- 31: 抹茶ケーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 31, 1, NULL, '薄力粉と抹茶粉を合わせ、卵・砂糖と混ぜてスポンジ生地を作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 31, 2, NULL, '170℃で35分焼き、完全に冷ましてから切り分けます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 31, 3, NULL, '抹茶入り生クリームを間に塗り、仕上げに抹茶粉を振って完成。');

-- 32: バタークッキー
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 32, 1, NULL, 'バターを常温に戻して砂糖と混ぜ、薄力粉を加えてサラサラな生地にします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 32, 2, NULL, '生地を冷蔵庫で30分休ませ、型で抜きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 32, 3, NULL, '170℃で12分焼いて完成。冷ますとサクサクになります。');

-- 33: 抹茶クッキー
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 33, 1, NULL, 'バター・砂糖・薄力粉・抹茶粉を混ぜ合わせて生地を作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 33, 2, NULL, '棒状に成形してラップで包み、冷蔵庫で1時間休ませます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 33, 3, NULL, '5mm厚に切って160℃で15分焼いて完成。抹茶の色がきれいです。');

-- 34: マカロン
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 34, 1, NULL, 'アーモンドプードルと粉砂糖を合わせ、細かく篩います。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 34, 2, NULL, '卵白と砂糖でメレンゲを作り、粉類と混ぜてマカロナージュします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 34, 3, NULL, '絞り袋で円形に絞り出し、乾燥後150℃で13分焼いてクリームを挟んで完成。');

COMMIT;

-- ============================================================
-- 확인 쿼리
-- ============================================================

SELECT COUNT(*) AS recipe_count FROM RECIPE;
SELECT RECIPE_ID, TITLE, THUMBNAIL FROM RECIPE ORDER BY RECIPE_ID;
