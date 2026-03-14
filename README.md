# sql-practice

Personal SQL practice project — LeetCode problems + topic drills.

## Quick start

### 1. Build the gradle project

`./gradlew build`

Gradle will auto-import. 

### 2. Choose your database

Open `src/main/java/sqlpractice/DbConfig.java` and set `MODE`:

| Mode     | When to use |
|----------|-------------|
| `H2`     | Default. In-memory, reset each run. Zero setup. MySQL-compatible. |
| `SQLITE` | When you want data to persist across runs (`practice.db` in root). |

### 3. Run a query

Open `SqlRunner.java`, change the `sqlFile` path at the top of `main()`, then run it.

```java
String sqlFile = "sql/leetcode/problem.sql";
```

Each `.sql` file is self-contained: it creates its own tables, seeds data, and runs the solution.

---

## Project structure

```
sql-practice/
├── schema/
│   └── 01_master_seed.sql        ← all common tables in one place
├── sql/
│   └── topics/
│       ├── window_functions/
│       │   └── window_functions_overview.sql
│       ├── joins/
│       ├── aggregations/
│       ├── subqueries/
│       └── ctes/
├── src/main/java/sqlpractice/
│   ├── DbConfig.java             ← switch H2 ↔ SQLite here
│   └── SqlRunner.java            ← main entry point
├── build.gradle
└── settings.gradle
```

