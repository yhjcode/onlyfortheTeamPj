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
-- 한국 재료 추가 (ID 58~78)
-- 기존 재료 활용: 6=간장, 7=버터, 8=밀가루, 9=참기름,
--   10=소금, 14=달걀, 18=설탕, 26=박력분, 52=생크림
-- ============================================================

DELETE FROM INGREDIENT WHERE INGREDIENT_ID >= 58;

INSERT INTO INGREDIENT VALUES (58, '김치',         'g');
INSERT INTO INGREDIENT VALUES (59, '돼지고기',      'g');
INSERT INTO INGREDIENT VALUES (60, '소고기',        'g');
INSERT INTO INGREDIENT VALUES (61, '닭고기',        'g');
INSERT INTO INGREDIENT VALUES (62, '오징어',        '마리');
INSERT INTO INGREDIENT VALUES (63, '고등어',        '마리');
INSERT INTO INGREDIENT VALUES (64, '떡',            'g');
INSERT INTO INGREDIENT VALUES (65, '멸치',          'g');
INSERT INTO INGREDIENT VALUES (66, '미역',          'g');
INSERT INTO INGREDIENT VALUES (67, '고추장',        '큰술');
INSERT INTO INGREDIENT VALUES (68, '마늘',          '쪽');
INSERT INTO INGREDIENT VALUES (69, '양파',          '개');
INSERT INTO INGREDIENT VALUES (70, '두부',          '모');
INSERT INTO INGREDIENT VALUES (71, '파스타면',      'g');
INSERT INTO INGREDIENT VALUES (72, '토마토',        '개');
INSERT INTO INGREDIENT VALUES (73, '새우',          'g');
INSERT INTO INGREDIENT VALUES (74, '모짜렐라치즈',  'g');
INSERT INTO INGREDIENT VALUES (75, '초콜릿',        'g');
INSERT INTO INGREDIENT VALUES (76, '크림치즈',      'g');
INSERT INTO INGREDIENT VALUES (77, '당근',          '개');
INSERT INTO INGREDIENT VALUES (78, '호두',          'g');

COMMIT;

-- ============================================================
-- 레시피 34개 (RECIPE_ID 1~34)
-- 카테고리: 1=국/탕, 2=반찬, 3=볶음, 4=파스타, 5=스테이크
--           6=면, 7=초밥/회, 8=케이크, 9=쿠키
-- ============================================================

-- ===== 국/탕 (category_id = 1) : 4개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (1, 'chef_sh', 1, '辛いキムチチゲ',
        '/resources/upload/recipe/recipe1.jpg',
        '白菜キムチと豆腐、豚肉を煮込んだ韓国の定番鍋料理。ご飯のお供に最高です。',
        2, 30, 2, 3100, 4.8, SYSDATE-20);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (2, 'chef_jm', 1, '辛いプデチゲ',
        '/resources/upload/recipe/recipe2.jpg',
        'ソーセージ・ハム・ラーメンとキムチを一緒に煮込んだボリューム満点の鍋料理。',
        4, 30, 1, 2700, 4.7, SYSDATE-18);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (3, 'chef_yw', 1, '爽やかわかめスープ',
        '/resources/upload/recipe/recipe3.jpg',
        'わかめのやさしい旨味が広がるあっさりスープ。韓国では誕生日に食べる習慣があります。',
        2, 20, 1, 2200, 4.6, SYSDATE-15);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (4, 'chef_hj', 1, 'お正月のトックク',
        '/resources/upload/recipe/recipe4.jpg',
        '薄切りのお餅を牛骨スープで煮込んだ韓国の正月料理。食べると一歳年を取ると言われます。',
        4, 25, 1, 1900, 4.6, SYSDATE-10);

-- ===== 반찬 (category_id = 2) : 3개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (5, 'chef_mj', 2, 'カリカリサムギョプサル',
        '/resources/upload/recipe/recipe5.jpg',
        '厚切り豚バラ肉を直火でカリカリに焼くシンプルな焼肉。レタスに包んで召し上がれ。',
        4, 20, 1, 4800, 4.9, SYSDATE-30);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (6, 'foodie01', 2, 'ヤンニョムLAカルビ',
        '/resources/upload/recipe/recipe6.jpg',
        '甘辛の薬念ダレに漬け込んだLAカルビ。焼き上がりの香ばしさがたまりません。',
        4, 40, 2, 3500, 4.8, SYSDATE-25);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (8, 'foodie03', 2, 'サバの塩焼き',
        '/resources/upload/recipe/recipe8.jpg',
        '新鮮なサバに塩をふってじっくり焼いた定番の一品。ふっくらとした身がおいしい。',
        2, 20, 1, 2400, 4.5, SYSDATE-22);

-- ===== 볶음 (category_id = 3) : 9개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (7, 'foodie02', 3, 'チーズタッカルビ',
        '/resources/upload/recipe/recipe7.jpg',
        '辛いヤンニョムソースで炒めた鶏肉にとろけるチーズをかけた大人気メニュー。',
        3, 30, 2, 5200, 4.9, SYSDATE-28);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (9, 'quick01', 3, '5分キムチチャーハン',
        '/resources/upload/recipe/recipe9.jpg',
        '5分で完成！冷蔵庫のキムチと卵だけで作れるピリ辛チャーハン。',
        2, 5, 1, 6100, 4.8, SYSDATE-12);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (10, 'jp_user01', 3, '辛いチェユクポックム',
        '/resources/upload/recipe/recipe10.jpg',
        '豚バラ肉をコチュジャンベースのタレで炒めた韓国定番の炒め物。ご飯と相性抜群。',
        3, 25, 2, 4600, 4.7, SYSDATE-8);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (11, 'newbie01', 2, 'いりこ炒め',
        '/resources/upload/recipe/recipe11.jpg',
        '小さなちりめんじゃこを甘辛く炒めた韓国の定番副菜。作り置きにも便利です。',
        4, 15, 1, 2100, 4.5, SYSDATE-5);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (12, 'newbie02', 3, 'イカ炒め',
        '/resources/upload/recipe/recipe12.jpg',
        'コチュジャンで炒めたピリ辛のイカ炒め。野菜と一緒に炒めるとさらにおいしい。',
        3, 25, 2, 3800, 4.7, SYSDATE-14);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (29, 'foodie02', 3, '国民的トッポッキ',
        '/resources/upload/recipe/recipe29.jpg',
        '韓国の定番屋台グルメ！コチュジャンソースで煮たピリ辛のお餅料理。',
        3, 20, 1, 7200, 4.9, SYSDATE-9);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (30, 'foodie03', 3, 'ラーポッキ',
        '/resources/upload/recipe/recipe30.jpg',
        'ラーメンとトッポッキを合わせた韓国の人気フュージョン料理。辛くて甘くてやみつき！',
        3, 25, 1, 5400, 4.8, SYSDATE-7);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (31, 'quick01', 3, 'チーズトッポッキ',
        '/resources/upload/recipe/recipe31.jpg',
        '辛いトッポッキの上にとろけるチーズをたっぷりかけた濃厚アレンジ。',
        3, 25, 1, 4300, 4.8, SYSDATE-6);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (32, 'jp_user03', 3, '醤油トッポッキ',
        '/resources/upload/recipe/recipe32.jpg',
        '辛くない醤油ベースのあっさりトッポッキ。辛いのが苦手な方にもおすすめ。',
        3, 20, 1, 3100, 4.6, SYSDATE-13);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (33, 'vegan01', 3, '豆腐野菜炒め',
        '/resources/upload/recipe/recipe33.jpg',
        '豆腐と季節の野菜をシンプルに炒めたヘルシーな一品。ビーガン対応です。',
        3, 15, 1, 2000, 4.4, SYSDATE-4);

-- ===== 파스타 (category_id = 4) : 3개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (13, 'chef_sh', 4, 'トマトパスタ',
        '/resources/upload/recipe/recipe13.jpg',
        'フレッシュトマトとニンニクで作るシンプルなトマトソースパスタ。誰でも簡単に作れます。',
        2, 25, 1, 3400, 4.6, SYSDATE-16);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (14, 'chef_jm', 4, '5分アーリオオーリオ',
        '/resources/upload/recipe/recipe14.jpg',
        'オリーブオイルとニンニク、唐辛子だけで作るシンプルなパスタ。5分で完成！',
        2, 15, 1, 4100, 4.7, SYSDATE-19);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (15, 'foodie01', 4, 'クリームエビパスタ',
        '/resources/upload/recipe/recipe15.jpg',
        'ぷりぷりエビと濃厚クリームソースの贅沢なパスタ。記念日にもぴったり。',
        2, 25, 2, 5600, 4.9, SYSDATE-23);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (34, 'vegan01', 4, 'ビーガントマトパスタ',
        '/resources/upload/recipe/recipe34.jpg',
        '動物性食品を一切使わないヴィーガン対応のトマトパスタ。野菜の旨味がたっぷり。',
        2, 25, 1, 1800, 4.5, SYSDATE-3);

-- ===== 스테이크 (category_id = 5) : 3개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (16, 'chef_yw', 5, 'ヒレステーキ',
        '/resources/upload/recipe/recipe16.jpg',
        'やわらかいヒレ肉をミディアムレアに仕上げたシンプルなステーキ。肉の旨味を存分に味わえます。',
        2, 20, 2, 4000, 4.8, SYSDATE-32);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (17, 'chef_hj', 5, 'ハンバーグステーキ',
        '/resources/upload/recipe/recipe17.jpg',
        '肉汁たっぷりのやわらかいハンバーグ。デミグラスソースとの相性が抜群です。',
        4, 35, 2, 5100, 4.8, SYSDATE-27);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (18, 'chef_mj', 5, 'サーロインステーキ',
        '/resources/upload/recipe/recipe18.jpg',
        'サーロイン肉を鉄板でシンプルに焼いたプレミアムステーキ。塩胡椒だけで十分おいしい。',
        2, 20, 2, 3700, 4.8, SYSDATE-24);

-- ===== 면 (category_id = 6) : 2개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (19, 'jp_user02', 6, '手作りジャージャー麺',
        '/resources/upload/recipe/recipe19.jpg',
        '甘い黒豆ソースと野菜を合わせた韓国風ジャージャー麺。チュンジャンソースで本格的に。',
        4, 40, 2, 4200, 4.7, SYSDATE-21);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (20, 'jp_user03', 6, '辛いチャンポン',
        '/resources/upload/recipe/recipe20.jpg',
        '海鮮たっぷりの辛いスープに中華麺を入れた韓国の定番麺料理。海の旨味が凝縮！',
        4, 35, 2, 3600, 4.7, SYSDATE-17);

-- ===== 초밥/회 (category_id = 7) : 2개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (21, 'jp_user01', 7, '海鮮丼',
        '/resources/upload/recipe/recipe21.jpg',
        '新鮮な刺身をたっぷりのせた韓国風ビビンパ風の海鮮丼。コチュジャンダレで混ぜて食べます。',
        2, 20, 2, 4500, 4.8, SYSDATE-11);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (22, 'jp_user02', 7, 'ツナマヨ寿司',
        '/resources/upload/recipe/recipe22.jpg',
        'ツナとマヨネーズを合わせた人気の手まり寿司。子供から大人まで喜ばれる定番メニュー。',
        4, 25, 1, 3200, 4.6, SYSDATE-26);

-- ===== 케이크 (category_id = 8) : 3개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (23, 'cookie01', 8, 'ニューヨークチーズケーキ',
        '/resources/upload/recipe/recipe23.jpg',
        '濃厚でクリーミーなニューヨークスタイルのチーズケーキ。しっかりとした甘さが魅力です。',
        8, 90, 3, 5800, 4.9, SYSDATE-35);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (24, 'cookie02', 8, 'チョコガナッシュケーキ',
        '/resources/upload/recipe/recipe24.jpg',
        'ガナッシュクリームをたっぷり使った大人のチョコレートケーキ。濃厚な味わいがたまりません。',
        8, 90, 3, 4700, 4.8, SYSDATE-31);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (25, 'cookie03', 8, 'キャロットケーキ',
        '/resources/upload/recipe/recipe25.jpg',
        'にんじんたっぷりのしっとりスパイスケーキ。クリームチーズフロスティングと一緒に。',
        8, 75, 2, 3900, 4.7, SYSDATE-29);

-- ===== 쿠키 (category_id = 9) : 3개 =====
INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (26, 'cookie01', 9, 'チョコチップクッキー',
        '/resources/upload/recipe/recipe26.jpg',
        'バターの香りとチョコチップが絶妙なサクサクのクッキー。家で簡単に作れます！',
        4, 35, 1, 4800, 4.7, SYSDATE-33);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (27, 'cookie02', 9, 'マカロン作り',
        '/resources/upload/recipe/recipe27.jpg',
        'アーモンドプードルとメレンゲで作るカラフルなマカロン。コツさえつかめば家でも本格的に！',
        4, 120, 3, 6800, 4.9, SYSDATE-40);

INSERT INTO RECIPE (recipe_id, user_id, category_id, title, thumbnail, description, servings, cook_time, difficulty, view_count, avg_rating, created_at)
VALUES (28, 'cookie03', 9, 'ブラウニー',
        '/resources/upload/recipe/recipe28.jpg',
        '濃厚チョコレートのしっとりとしたブラウニー。外はサクッと中はしっとりが理想です。',
        6, 45, 1, 4200, 4.7, SYSDATE-36);

COMMIT;

-- ============================================================
-- 재료 (RECIPE_INGREDIENTS)
-- 사용 ID: 6=간장, 7=버터, 8=밀가루, 9=참기름, 10=소금
--          14=달걀, 18=설탕, 26=박력분, 52=生クリーム
--          58=김치, 59=돼지고기, 60=소고기, 61=닭고기
--          62=오징어, 63=고등어, 64=떡, 65=멸치, 66=미역
--          67=고추장, 68=마늘, 69=양파, 70=두부
--          71=파스타면, 72=토마토, 73=새우, 74=모짜렐라치즈
--          75=초콜릿, 76=크림치즈, 77=당근, 78=호두
-- ============================================================

-- 1: 辛いキムチチゲ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 58, 1, '300g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 59, 1, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 70, 1, '반모');

-- 2: 辛いプデチゲ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 58, 2, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 67, 2, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 69, 2, '1개');

-- 3: 爽やかわかめスープ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 66, 3, '30g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 60, 3, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  3, '1큰술');

-- 4: お正月のトックク
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 64, 4, '400g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 60, 4, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 4, '2개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  4, '2큰술');

-- 5: カリカリサムギョプサル
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 59, 5, '500g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 10, 5, '적당량');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 68, 5, '5쪽');

-- 6: ヤンニョムLAカルビ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 60, 6, '600g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  6, '4큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 6, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 68, 6, '6쪽');

-- 7: チーズタッカルビ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 61, 7, '400g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 67, 7, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 74, 7, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 69, 7, '1개');

-- 8: サバの塩焼き
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 63, 8, '1마리');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 10, 8, '적당량');

-- 9: 5分キムチチャーハン
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 58, 9, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 9, '2개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  9, '1큰술');

-- 10: 辛いチェユクポックム
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 59, 10, '300g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 67, 10, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 69, 10, '1개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 68, 10, '4쪽');

-- 11: いりこ炒め
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 65, 11, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  11, '1큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 11, '1큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  11, '1작은술');

-- 12: イカ炒め
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 62, 12, '1마리');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 67, 12, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 69, 12, '1개');

-- 13: トマトパスタ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 71, 13, '180g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 72, 13, '4개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 68, 13, '4쪽');

-- 14: 5分アーリオオーリオ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 71, 14, '160g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 68, 14, '6쪽');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 10, 14, '적당량');

-- 15: クリームエビパスタ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 71, 15, '180g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 73, 15, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 52, 15, '200ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  15, '20g');

-- 16: ヒレステーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 60, 16, '300g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 10, 16, '적당량');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  16, '20g');

-- 17: ハンバーグステーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 60, 17, '400g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 17, '1개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 8,  17, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 69, 17, '반개');

-- 18: サーロインステーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 60, 18, '350g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 10, 18, '적당량');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  18, '15g');

-- 19: 手作りジャージャー麺
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 59, 19, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 69, 19, '2개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  19, '2큰술');

-- 20: 辛いチャンポン
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 67, 20, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 73, 20, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 62, 20, '반마리');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 69, 20, '1개');

-- 21: 海鮮丼
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 67, 21, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  21, '1큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  21, '1큰술');

-- 22: ツナマヨ寿司
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  22, '1큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 22, '2큰술');

-- 23: ニューヨークチーズケーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 76, 23, '400g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 23, '3개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 23, '120g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 52, 23, '200ml');

-- 24: チョコガナッシュケーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 75, 24, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 52, 24, '150ml');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 24, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 24, '3개');

-- 25: キャロットケーキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 77, 25, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 25, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 25, '3개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 76, 25, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 78, 25, '80g');

-- 26: チョコチップクッキー
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  26, '120g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 26, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 26, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 75, 26, '100g');

-- 27: マカロン作り
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 27, '2개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 27, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 27, '100g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 52, 27, '100ml');

-- 28: ブラウニー
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 75, 28, '150g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 7,  28, '80g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 28, '120g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 14, 28, '2개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 26, 28, '60g');

-- 29: 国民的トッポッキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 64, 29, '300g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 67, 29, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 29, '1큰술');

-- 30: ラーポッキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 64, 30, '200g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 67, 30, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 30, '1큰술');

-- 31: チーズトッポッキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 64, 31, '300g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 67, 31, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 74, 31, '150g');

-- 32: 醤油トッポッキ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 64, 32, '300g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  32, '3큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 18, 32, '1큰술');

-- 33: 豆腐野菜炒め
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 70, 33, '1모');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 6,  33, '2큰술');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 9,  33, '1큰술');

-- 34: ビーガントマトパスタ
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 71, 34, '160g');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 72, 34, '5개');
INSERT INTO RECIPE_INGREDIENTS VALUES (SEQ_RECIPE_INGR.NEXTVAL, 68, 34, '4쪽');

COMMIT;

-- ============================================================
-- 조리 단계 (RECIPE_STEP)
-- ============================================================

-- 1: 辛いキムチチゲ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 1, NULL, '豚肉を食べやすい大きさに切り、キムチは2〜3cm幅に切ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 2, NULL, '鍋にごま油を熱し、豚肉とキムチを炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 1, 3, NULL, '水と豆腐を加え、コチュジャンと塩で味を調えて10分煮込んで完成。');

-- 2: 辛いプデチゲ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 2, 1, NULL, 'ソーセージとハムを輪切りにし、キムチ・豆腐・野菜を準備します。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 2, 2, NULL, 'だし汁にコチュジャンを溶かし、具材を全て入れて火にかけます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 2, 3, NULL, '煮立ったらラーメンを加えてさっと煮て完成。辛さはコチュジャンで調節してください。');

-- 3: 爽やかわかめスープ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 3, 1, NULL, 'わかめを水で戻し、牛肉は細切りにします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 3, 2, NULL, 'ごま油で牛肉を炒め、わかめを加えてさらに炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 3, 3, NULL, '水を注いで煮込み、醤油と塩で味を調えて完成。');

-- 4: お正月のトックク
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 4, 1, NULL, '牛肉を水から煮てスープをとり、肉は細く裂いておきます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 4, 2, NULL, 'お餅を水に浸してから煮立てたスープに加えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 4, 3, NULL, '錦糸卵と海苔をのせ、醤油で味を調えて完成。');

-- 5: カリカリサムギョプサル
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 5, 1, NULL, '豚バラ肉を食べやすい大きさに切ります。塩胡椒は不要です。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 5, 2, NULL, '鉄板またはフライパンを強火で熱し、豚バラをカリカリになるまで焼きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 5, 3, NULL, 'レタスに肉・キムチ・ニンニクを包み、包んで食べます。');

-- 6: ヤンニョムLAカルビ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 6, 1, NULL, '醤油・砂糖・ニンニク・梨すりおろしを混ぜてヤンニョムダレを作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 6, 2, NULL, 'LAカルビをダレに一晩漬け込みます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 6, 3, NULL, '強火のグリルまたはフライパンで香ばしく焼いて完成。');

-- 7: チーズタッカルビ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 7, 1, NULL, '鶏肉をコチュジャン・醤油・砂糖・ニンニクのタレに30分漬け込みます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 7, 2, NULL, 'フライパンにキャベツや野菜と鶏肉を入れて炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 7, 3, NULL, 'モッツァレラチーズをたっぷりのせて蓋をし、チーズが溶けたら完成。');

-- 8: サバの塩焼き
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 8, 1, NULL, 'サバを三枚おろしにし、両面に塩を振って15分置きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 8, 2, NULL, 'キッチンペーパーで水気を拭き取り、グリルまたはフライパンで焼きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 8, 3, NULL, '皮がパリッと焼けたら完成。大根おろしと一緒に召し上がれ。');

-- 9: 5分キムチチャーハン
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 9, 1, NULL, 'キムチを粗みじんに切ります。冷やご飯を用意します。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 9, 2, NULL, 'ごま油でキムチを炒め、ご飯を加えてよく炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 9, 3, NULL, '端に卵を割り入れてスクランブルにし、全体を混ぜて完成。');

-- 10: 辛いチェユクポックム
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 10, 1, NULL, '豚バラ肉を食べやすい大きさに切り、コチュジャン・醤油・ニンニクで下味をつけます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 10, 2, NULL, 'フライパンに油を熱し、玉ねぎと肉を強火で炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 10, 3, NULL, 'ネギを加えてさっと炒め、ごま油を垂らして完成。');

-- 11: いりこ炒め
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 11, 1, NULL, 'フライパンでちりめんじゃこを空炒りして水分を飛ばします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 11, 2, NULL, '醤油・砂糖・ごま油を合わせたタレを加えてからめます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 11, 3, NULL, '白ごまを振って完成。冷蔵庫で3〜4日保存可能です。');

-- 12: イカ炒め
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 12, 1, NULL, 'イカを食べやすい大きさに切り、コチュジャン・ニンニクのタレを作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 12, 2, NULL, 'フライパンに油を熱し、玉ねぎとイカを炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 12, 3, NULL, 'タレを加えてよく絡め、ネギとごま油で仕上げて完成。');

-- 13: トマトパスタ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 13, 1, NULL, 'トマトをざく切りにし、ニンニクをみじん切りにします。パスタを塩ゆでします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 13, 2, NULL, 'オリーブオイルでニンニクを炒め、トマトを加えてソースを作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 13, 3, NULL, 'ゆでたパスタとソースを和え、バジルを散らして完成。');

-- 14: 5分アーリオオーリオ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 1, NULL, 'パスタを塩ゆでします。ニンニクを薄切りにします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 2, NULL, 'オリーブオイルでニンニクを弱火でじっくり炒め、唐辛子を加えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 14, 3, NULL, 'パスタのゆで汁を少し加えてソースを作り、パスタと和えて完成。');

-- 15: クリームエビパスタ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 15, 1, NULL, 'パスタを塩ゆでします。エビは背ワタを取り、バターでソテーします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 15, 2, NULL, '生クリームを加えて中火で煮詰め、塩胡椒で味を調えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 15, 3, NULL, 'パスタとエビをソースで和えて皿に盛り、パセリを散らして完成。');

-- 16: ヒレステーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 16, 1, NULL, 'ヒレ肉を常温に戻し、両面に塩胡椒をしっかりふります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 16, 2, NULL, 'フライパンを強火で熱し、バターを溶かし、両面をしっかり焼きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 16, 3, NULL, '5分休ませてから切り分け、付け合わせと一緒に盛り付けて完成。');

-- 17: ハンバーグステーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 17, 1, NULL, 'ひき肉・玉ねぎ・卵・パン粉を合わせてよくこね、楕円形に成形します。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 17, 2, NULL, 'フライパンで両面に焼き色をつけ、蓋をして中火で蒸し焼きにします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 17, 3, NULL, 'デミグラスソースをかけて完成。付け合わせにはマッシュポテトが合います。');

-- 18: サーロインステーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 18, 1, NULL, 'サーロインを常温に戻し、焼く30分前に塩胡椒をふります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 18, 2, NULL, '鉄フライパンを煙が出るまで熱し、強火で両面をさっと焼きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 18, 3, NULL, 'バターをのせてアルミホイルで包み3分休ませて完成。');

-- 19: 手作りジャージャー麺
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 19, 1, NULL, '豚肉と玉ねぎをみじん切りにし、中華鍋で炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 19, 2, NULL, 'チュンジャン（黒豆ソース）を加えて炒め、水と片栗粉でとろみをつけます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 19, 3, NULL, 'ゆでた中華麺に肉ソースをかけ、きゅうりの細切りをのせて完成。');

-- 20: 辛いチャンポン
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 20, 1, NULL, 'エビ・イカなど海鮮を下処理します。野菜も食べやすく切ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 20, 2, NULL, 'ごま油でコチュジャンを炒め、野菜と海鮮を加えてさらに炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 20, 3, NULL, 'だし汁を加えて煮立て、麺を入れて完成。辛さはコチュジャンで調節してください。');

-- 21: 海鮮丼
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 21, 1, NULL, '新鮮な刺身（サーモン・まぐろ・タコなど）を薄切りにします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 21, 2, NULL, 'どんぶりにご飯を盛り、コチュジャンダレ（コチュジャン・ごま油・醤油・酢）を作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 21, 3, NULL, '刺身をきれいに盛り付け、ダレをかけてよく混ぜて食べます。');

-- 22: ツナマヨ寿司
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 22, 1, NULL, 'ご飯に酢・砂糖・塩を混ぜて酢飯を作り、うちわで冷まします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 22, 2, NULL, 'ツナ缶の油を切り、マヨネーズと混ぜます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 22, 3, NULL, '酢飯を丸く握り、海苔を巻いてツナマヨをのせて完成。');

-- 23: ニューヨークチーズケーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 23, 1, NULL, 'クリームチーズを常温に戻し、砂糖・卵・生クリームとなめらかに混ぜます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 23, 2, NULL, 'クッキーをバターで固めた台に生地を流し入れます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 23, 3, NULL, '160℃で1時間焼き、冷蔵庫で一晩冷やして完成。');

-- 24: チョコガナッシュケーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 24, 1, NULL, '薄力粉・ベーキングパウダー・卵・砂糖・バターでチョコスポンジを焼きます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 24, 2, NULL, 'チョコレートと生クリームを合わせてガナッシュを作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 24, 3, NULL, 'スポンジにガナッシュを塗り重ね、全体をコーティングして完成。');

-- 25: キャロットケーキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 25, 1, NULL, 'にんじんをすりおろし、薄力粉・シナモン・砂糖・卵・サラダ油と混ぜます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 25, 2, NULL, '170℃で40分焼き、完全に冷まします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 25, 3, NULL, 'クリームチーズとバターで作ったフロスティングをたっぷり塗って完成。');

-- 26: チョコチップクッキー
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 26, 1, NULL, 'バターと砂糖をクリーム状に混ぜ、卵を加えてさらに混ぜます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 26, 2, NULL, '薄力粉を加えてさっと混ぜ、チョコチップを折り込みます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 26, 3, NULL, 'スプーンで丸めてオーブンシートにおき、180℃で12分焼いて完成。');

-- 27: マカロン作り
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 27, 1, NULL, 'アーモンドプードルと粉砂糖を合わせて細かく篩います。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 27, 2, NULL, '卵白と砂糖でメレンゲを作り、粉類と混ぜてマカロナージュします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 27, 3, NULL, '絞り袋で円形に絞り出し、乾燥後150℃で13分焼いてバタークリームを挟んで完成。');

-- 28: ブラウニー
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 28, 1, NULL, 'チョコレートとバターを湯せんで溶かし、砂糖と卵を加えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 28, 2, NULL, '薄力粉を加えてさっくり混ぜ、型に流し入れます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 28, 3, NULL, '170℃で25分焼き、冷めてから切り分けて完成。中心がしっとりするのが理想。');

-- 29: 国民的トッポッキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 29, 1, NULL, 'お餅を水に浸してほぐし、だし汁を沸かします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 29, 2, NULL, 'コチュジャン・砂糖・醤油を合わせてソースを作り、だし汁に入れます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 29, 3, NULL, 'お餅を加えて弱火で10分煮込み、とろみが出たら完成。');

-- 30: ラーポッキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 1, NULL, 'お餅とラーメンを用意し、だし汁を沸かします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 2, NULL, 'コチュジャンソースで味を調え、お餅とラーメンを加えます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 30, 3, NULL, '麺が柔らかくなったら完成。お好みでチーズやゆで卵を追加しても。');

-- 31: チーズトッポッキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 31, 1, NULL, '基本のトッポッキと同じようにコチュジャンソースでお餅を煮ます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 31, 2, NULL, '火を弱め、モッツァレラチーズを全体にたっぷりのせます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 31, 3, NULL, '蓋をしてチーズが溶けたら完成。引き伸ばして食べるのが醍醐味！');

-- 32: 醤油トッポッキ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 32, 1, NULL, 'お餅を水に浸してほぐし、だし汁を沸かします。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 32, 2, NULL, '醤油・砂糖・ニンニクを合わせたタレを加えてお餅を煮ます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 32, 3, NULL, 'ごま油を垂らしてネギを散らして完成。辛くないので子供にも人気！');

-- 33: 豆腐野菜炒め
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 33, 1, NULL, '豆腐を食べやすい大きさに切り、キッチンペーパーで水気を取ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 33, 2, NULL, 'フライパンに油を熱し、豆腐に焼き色をつけます。野菜を加えて炒めます。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 33, 3, NULL, '醤油・ごま油で味を調えて完成。シンプルだけど優しい味わいです。');

-- 34: ビーガントマトパスタ
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 34, 1, NULL, 'パスタを塩ゆでします。トマト・ニンニク・玉ねぎを準備します。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 34, 2, NULL, 'オリーブオイルでニンニクと玉ねぎを炒め、トマトを加えてソースを作ります。');
INSERT INTO RECIPE_STEP VALUES (SEQ_RECIPE_STEP.NEXTVAL, 34, 3, NULL, 'パスタとソースを和え、バジルをたっぷり散らして完成。動物性食品ゼロでも大満足！');

COMMIT;

-- ============================================================
-- 확인 쿼리
-- ============================================================

SELECT COUNT(*) AS recipe_count FROM RECIPE;
SELECT RECIPE_ID, TITLE, THUMBNAIL, CATEGORY_ID FROM RECIPE ORDER BY RECIPE_ID;
