package sqlpractice;

import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * SQL Practice Runner
 *
 * Usage:
 *   SqlRunner.run("sql/topics/topic.sql")
 *   SqlRunner.runTopic("window_functions")
 *
 * Database modes (switch in DbConfig):
 *   H2   — in-memory, reset every run, zero setup
 *   SQLite — file-based (practice.db), persists between runs
 */
public class SqlRunner {

    public static void main(String[] args) throws Exception {
        String sqlFile = "sql/leetcodes/problem-602.sql";

        try (Connection conn = DbConfig.getConnection()) {
            System.out.println("Connected: " + DbConfig.describe());
            System.out.println("Running: " + sqlFile);
            System.out.println("─".repeat(60));
            runFile(conn, sqlFile);
        }
    }


    public static void runFile(Connection conn, String filePath) throws Exception {
        String content = Files.readString(Path.of(filePath));
        String[] statements = content.split(";");

        for (String raw : statements) {
            String stmt = raw.strip();
            if (stmt.isEmpty()) continue;

            System.out.println("\n>> " + firstNonComment(stmt));

            try (Statement s = conn.createStatement()) {
                boolean hasResultSet = s.execute(stmt);
                if (hasResultSet) {
                    printResultSet(s.getResultSet());
                } else {
                    System.out.println("   OK (" + s.getUpdateCount() + " rows affected)");
                }
            } catch (SQLException e) {
                System.out.println("   ERROR: " + e.getMessage());
            }
        }
    }

    public static void printResultSet(ResultSet rs) throws SQLException {
        ResultSetMetaData meta = rs.getMetaData();
        int cols = meta.getColumnCount();

        // Header
        List<String> headers = new ArrayList<>();
        for (int i = 1; i <= cols; i++) headers.add(meta.getColumnLabel(i));

        // Rows
        List<List<String>> rows = new ArrayList<>();
        while (rs.next()) {
            List<String> row = new ArrayList<>();
            for (int i = 1; i <= cols; i++) {
                String val = rs.getString(i);
                row.add(val == null ? "NULL" : val);
            }
            rows.add(row);
        }

        if (rows.isEmpty()) {
            System.out.println("   (no rows)");
            return;
        }

        int[] widths = new int[cols];
        for (int i = 0; i < cols; i++) widths[i] = headers.get(i).length();
        for (List<String> row : rows)
            for (int i = 0; i < cols; i++)
                widths[i] = Math.max(widths[i], row.get(i).length());

        String sep = buildSep(widths);
        System.out.println(sep);
        System.out.println(buildRow(headers, widths));
        System.out.println(sep);
        for (List<String> row : rows) System.out.println(buildRow(row, widths));
        System.out.println(sep);
        System.out.println("   " + rows.size() + " row(s)");
    }

    private static String buildSep(int[] widths) {
        StringBuilder sb = new StringBuilder("   +");
        for (int w : widths) sb.append("-".repeat(w + 2)).append("+");
        return sb.toString();
    }

    private static String buildRow(List<String> cells, int[] widths) {
        StringBuilder sb = new StringBuilder("   |");
        for (int i = 0; i < cells.size(); i++) {
            sb.append(String.format(" %-" + widths[i] + "s |", cells.get(i)));
        }
        return sb.toString();
    }

    private static String firstNonComment(String stmt) {
        for (String line : stmt.split("\n")) {
            String t = line.strip();
            if (!t.isEmpty() && !t.startsWith("--")) return t;
        }
        return stmt.lines().findFirst().orElse("").strip();
    }
}
