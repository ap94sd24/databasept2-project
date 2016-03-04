<html>

<body>
    <table border="1"style="background-color:rgba(0,0,0,0.5);">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    // Load Oracle Driver class file
                    DriverManager.registerDriver
                        (new org.postgresql.Driver());
    
                    // Make a connection to the Oracle datasource "cse132b"
                    Connection conn = DriverManager.getConnection
                        ("jdbc:postgresql://localhost:5433/postgres", 
                            "postgres", "cse132b");

            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);                       // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO PREV_CLASSES VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("TITLE"));
                        pstmt.setString(2, request.getParameter("QUARTER"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("YEAR")));


                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM prev_classes");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Class Title</th>
                        <th>Quarter</th>
                        <th>Year</th>
                    </tr>
                    <tr>
                        <form action="prev_classes.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="TITLE" size="25" required></th>
                            <th><input value="" name="QUARTER" size="15" required></th>
                            <th><input value="" name="YEAR" size="10" required></th>
                            <th><input type="submit" value="Insert"></th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="prev_classes.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the name, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("TITLE") %>" 
                                    name="TITLE" size="10">
                            </td>
    
                            <%-- Get the title --%>
                            <td>
                                <input value="<%= rs.getString("QUARTER") %>" 
                                    name="QUARTER" size="35">
                            </td>
    
                            <%-- Get the department --%>
                            <td>
                                <input value="<%= rs.getInt("YEAR") %>"
                                    name="YEAR" size="35">
                            </td>
                    </tr>
            <%
                    }
            %>


            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
