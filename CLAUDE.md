# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

BGGChef (방구석셰프들 — "Armchair Chefs") is a recipe-sharing web application built as a team learning project. The goal is to practice traditional Java EE web development: Servlet/JSP, JDBC, and Oracle DB — no frameworks like Spring or ORM.

## Tech Stack

- **Runtime:** Java 17 (Adoptium Temurin), Apache Tomcat 9.0
- **Database:** Oracle 11g XE / 19c (JDBC, no ORM)
- **Views:** JSP + JSTL 1.2 + EL
- **CSS/JS:** Bootstrap 5.3.2, Bootstrap Icons 1.11.3, Vanilla JS
- **Build:** Eclipse IDE only — no Maven or Gradle. Dependencies are JARs in `WEB-INF/lib/`.

## Build & Run

This project has **no CLI build tool**. All compilation and deployment is done through Eclipse IDE:

1. Import as "Existing Projects into Workspace" in Eclipse 2024-12 (Enterprise Java edition)
2. Ensure Tomcat 9.0 is configured as a runtime server in Eclipse
3. Add project to the Tomcat server → Start Tomcat
4. Access at `http://localhost:8080/BGGChef`

JSP changes hot-reload; Java changes require a project rebuild (Eclipse auto-builds, or Project → Build Project).

## Database Setup

- **Driver:** `ojdbc8.jar` (in `WEB-INF/lib/`)
- **Connection:** Hardcoded in `com.bggchef.util.DBUtil` — `jdbc:oracle:thin:@localhost:1521:orcl`, user `bggchef`, password `bggchef1234`
- **Schema:** Create Oracle user `bggchef` and run `02_DB_생성_스크립트.sql`

## Architecture

Strict layered MVC: **Controller → Service → DAO → Oracle DB → DTO → JSP**

```
HTTP Request → Filter(s) → @WebServlet Controller → Service → DAO → DB
                                                        ↓
                                            JSP (WEB-INF/views/) ← DTO
```

- **Filters** (`filter/`): `EncodingFilter` (UTF-8 on all requests), `LoginFilter` (session guard on protected URLs like `/user/mypage`, `/recipe/write`)
- **Controllers** (`controller/`): One servlet per domain area (Recipe, User, Review, Category, Theme, Chef, Ranking, Favorite, Like, Main). URL patterns like `/recipe/*`, `/user/*`
- **Services** (`service/`): Business logic layer — currently mostly TODO stubs; direct DAO calls from controllers are common
- **DAOs** (`dao/`): Raw JDBC — `DBUtil.getConnection()`, manual ResultSet→DTO mapping, `prepareStatement` with positional parameters
- **DTOs** (`dto/`): Plain Java beans for SQL↔Java transfer. `CategoryLDTO` = large (with children), `CategoryMDTO` = medium (leaf)
- **Utils** (`util/`): `DBUtil` (connection singleton), `FileUtil` (UUID filenames + directory creation), `PasswordUtil` (SHA-256 hashing), `PagingUtil` (startRow/endRow calculation)

### URL → Controller mapping

| URL pattern | Controller | Notes |
|---|---|---|
| `/main` | `MainController` | Homepage: top-rated, latest, chef rankings |
| `/recipe/*` | `RecipeController` | CRUD + list |
| `/user/*` | `UserController` | Login, join, mypage |
| `/review/*` | `ReviewController` | Comment + rating |
| `/category/*` | `CategoryController` | Browse by category |
| `/theme/*` | `ThemeController` | Curated collections |
| `/chef/*` | `ChefController` | Chef profile |
| `/ranking/*` | `RankingController` | Daily/weekly |
| `/favorite/*` | `FavoriteController` | |
| `/like/*` | `LikeController` | Toggle like |

### File uploads

Uploaded files land in `src/main/webapp/resources/upload/{profile,recipe,step,theme}/` — this directory is excluded from git (`.gitignore`). `FileUtil` handles UUID-based filename generation.

### View templates

All JSPs are under `WEB-INF/views/` (inaccessible directly by URL). Controllers forward via `RequestDispatcher`. Common layout fragments: `WEB-INF/views/common/header.jsp` and `footer.jsp`.

## Branch Strategy

- `main`: presentation-ready stable
- `develop`: integration branch (merge via PR only)
- `feature/*`: individual feature branches
