-- ============================================================
-- BGGChef 스키마 DDL 추출 스크립트
-- 실행:  sqlplus BGGChef/비밀번호@localhost:1521/XE @generate_ddl.sql
-- 결과:  같은 폴더에 BGGChef_schema.sql 생성
-- ============================================================

-- 출력 포맷 설정 (DDL이 잘리지 않게)
SET LONG 200000
SET LONGCHUNKSIZE 200000
SET PAGESIZE 0
SET LINESIZE 32767
SET TRIMSPOOL ON
SET FEEDBACK OFF
SET ECHO OFF
SET HEADING OFF
SET VERIFY OFF

-- DDL을 보기 좋게 + 세미콜론 종결자 붙이기
BEGIN
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', TRUE);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', TRUE);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', FALSE);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', FALSE);
END;
/

SPOOL BGGChef_schema.sql

PROMPT -- ========== TABLES (컬럼 + 제약조건 포함) ==========
SELECT DBMS_METADATA.GET_DDL('TABLE', table_name)
FROM   user_tables
ORDER  BY table_name;

PROMPT -- ========== INDEXES ==========
SELECT DBMS_METADATA.GET_DDL('INDEX', index_name)
FROM   user_indexes
WHERE  index_name NOT LIKE 'SYS_%'
ORDER  BY index_name;

PROMPT -- ========== SEQUENCES ==========
SELECT DBMS_METADATA.GET_DDL('SEQUENCE', sequence_name)
FROM   user_sequences
ORDER  BY sequence_name;

PROMPT -- ========== VIEWS ==========
SELECT DBMS_METADATA.GET_DDL('VIEW', view_name)
FROM   user_views
ORDER  BY view_name;

SPOOL OFF

PROMPT
PROMPT >>> BGGChef_schema.sql 생성 완료
EXIT
