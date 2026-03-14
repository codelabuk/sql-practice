package sqlpractice;

import java.sql.*;

/**
 * Database configuration.
 *
 * To switch between H2 and SQLite, change the MODE below.
 *
 * H2   → in-memory, wiped every run. Good for quick experiments.
 * SQLite → persists to practice.db in project root. Good for
 *          building up a permanent dataset across sessions.
 */
public class DbConfig {

    public enum Mode { H2, SQLITE }

    // ── Switch here ───────────────────────────────────────────────────────
    private static final Mode MODE = Mode.H2;
    // ─────────────────────────────────────────────────────────────────────

    // H2: in-memory, MySQL compatibility mode (closer to LeetCode)
    private static final String H2_URL  = "jdbc:h2:mem:practice;MODE=MySQL;DB_CLOSE_DELAY=-1";
    private static final String H2_USER = "sa";
    private static final String H2_PASS = "";

    // SQLite: file-based, lives in project root
    private static final String SQLITE_URL = "jdbc:sqlite:practice.db";

    public static Connection getConnection() throws SQLException {
        return switch (MODE) {
            case H2     -> DriverManager.getConnection(H2_URL, H2_USER, H2_PASS);
            case SQLITE -> DriverManager.getConnection(SQLITE_URL);
        };
    }

    public static String describe() {
        return switch (MODE) {
            case H2     -> "H2 in-memory (MySQL mode)";
            case SQLITE -> "SQLite → practice.db";
        };
    }
}
