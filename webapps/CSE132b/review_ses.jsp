<html>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page language="java" import="java.text.*" %>
    
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
                            "INSERT INTO review_ses VALUES (?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("sectionid")));
                        pstmt.setString(2, request.getParameter("R_DATE"));
                        pstmt.setString(3, request.getParameter("R_TIME"));
                        pstmt.setString(4, request.getParameter("building"));

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
                        ("SELECT * FROM review_ses");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Section ID</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Building</th>
                    </tr>
                    <tr>
                        <form action="review_ses.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="sectionid" size="12"></th>
                            <th><input value="" name="R_DATE" size="35"></th>
                            <th><input value="" name="R_TIME" size="35"></th>
                            <th><input value="" name="building" size="35"></th>
                            <th><input type="submit" value="Insert"></th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="review_ses.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the sectionid, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("sectionid") %>" 
                                    name="sectionid" size="10">
                            </td>
    
                            <%-- Get the R_DATE --%>
                            <td>
                                <input value="<%= rs.getString("R_DATE") %>" 
                                    name="R_DATE" size="35">
                            </td>
    
                            <%-- Get the R_TIME --%>
                            <td>
                                <input value="<%= rs.getString("R_TIME") %>"
                                    name="R_TIME" size="35">
                            </td>
                            <%-- Get the building --%>
                            <td>
                                <input value="<%= rs.getString("building") %>"
                                    name="building" size="35">
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
