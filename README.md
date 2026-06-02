# 방구석셰프들 (BGGChef)

레시피 공유 동적 웹사이트 - JSP + Servlet + JDBC + Oracle

## 환경

- JDK 17 LTS (Adoptium Temurin 권장)
- Eclipse IDE 2024-12 for Enterprise Java and Web Developers
- Apache Tomcat 9.0.x
- Oracle 11g XE / 19c

## 시작하기

### 1. 저장소 clone
```bash
git clone https://github.com/팀장ID/BGGChef.git
```

### 2. Eclipse에 import
File → Import → General → Existing Projects into Workspace → 위 폴더 선택

### 3. WEB-INF/lib에 라이브러리 배치
- ojdbc8.jar
- jstl-1.2.jar
- commons-fileupload-1.5.jar
- commons-io-2.11.0.jar

### 4. Oracle 계정 생성 후 DB 스크립트 실행
`02_DB_생성_스크립트.sql` 실행

### 5. DBUtil.java의 USER/PWD를 본인 환경에 맞게 수정

### 6. Tomcat 9에 프로젝트 추가 → Start → http://localhost:8080/BGGChef

## 폴더 구조

```
src/main/java/com/bggchef/
├── controller/   Servlet (요청 처리)
├── dao/          DB 접근
├── dto/          데이터 객체
├── service/      비즈니스 로직
├── util/         공통 유틸 (DBUtil 등)
└── filter/       Encoding/Login 필터

src/main/webapp/
├── WEB-INF/
│   ├── lib/      jar 라이브러리
│   ├── views/    JSP (직접 접근 차단)
│   └── web.xml
├── resources/    CSS, JS, 이미지, 업로드
└── index.jsp     /main?리다이렉트
```

## 브랜치 전략

- `main`: 발표 가능한 최종 버전
- `develop`: 개발 통합 (PR로만 머지)
- `feature/이름-기능`: 개인 작업

## 팀원

- 팀장: ?
- 회원: ?
- 레시피: ?
- 리뷰/대댓글: ?
- 추천테마/메인: ?
