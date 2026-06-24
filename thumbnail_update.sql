-- ============================================================
-- 레시피 썸네일 업데이트 (TITLE 기반 매핑)
-- 이미지 내용과 레시피 제목이 일치하는 방식
-- ============================================================

UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe1.jpg'  WHERE TITLE = '辛いキムチチゲ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe2.jpg'  WHERE TITLE = '辛いプデチゲ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe3.jpg'  WHERE TITLE = '爽やかわかめスープ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe4.jpg'  WHERE TITLE = 'お正月のトックク';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe5.jpg'  WHERE TITLE = 'カリカリサムギョプサル';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe6.jpg'  WHERE TITLE = 'ヤンニョムLAカルビ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe7.jpg'  WHERE TITLE = 'チーズタッカルビ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe8.jpg'  WHERE TITLE = 'サバの塩焼き';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe9.jpg'  WHERE TITLE = '5分キムチチャーハン';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe10.jpg' WHERE TITLE = '辛いチェユクポックム';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe11.jpg' WHERE TITLE = 'いりこ炒め';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe12.jpg' WHERE TITLE = 'イカ炒め';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe13.jpg' WHERE TITLE = 'トマトパスタ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe14.jpg' WHERE TITLE = '5分アーリオオーリオ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe15.jpg' WHERE TITLE = 'クリームエビパスタ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe16.jpg' WHERE TITLE = 'ヒレステーキ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe17.jpg' WHERE TITLE = 'ハンバーグステーキ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe18.jpg' WHERE TITLE = 'サーロインステーキ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe19.jpg' WHERE TITLE = '手作りジャージャー麺';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe20.jpg' WHERE TITLE = '辛いチャンポン';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe21.jpg' WHERE TITLE = '海鮮丼';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe22.jpg' WHERE TITLE = 'ツナマヨ寿司';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe23.jpg' WHERE TITLE = 'ニューヨークチーズケーキ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe24.jpg' WHERE TITLE = 'チョコガナッシュケーキ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe25.jpg' WHERE TITLE = 'キャロットケーキ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe26.jpg' WHERE TITLE = 'チョコチップクッキー';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe27.jpg' WHERE TITLE = 'マカロン作り';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe28.jpg' WHERE TITLE = 'ブラウニー';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe29.jpg' WHERE TITLE = '国民的トッポッキ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe30.jpg' WHERE TITLE = 'ラーポッキ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe31.jpg' WHERE TITLE = 'チーズトッポッキ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe32.jpg' WHERE TITLE = '醤油トッポッキ';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe33.jpg' WHERE TITLE = '豆腐野菜炒め';
UPDATE RECIPE SET THUMBNAIL = '/resources/upload/recipe/recipe34.jpg' WHERE TITLE = 'ビーガントマトパスタ';

COMMIT;
