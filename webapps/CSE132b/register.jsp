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
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Class table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Register VALUES (?, ?, ?, ?)");

                       // pstmt.setString(1, request.getParameter("SID"));

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("SECT_ID")));
                        pstmt.setString(3, request.getParameter("GRADE_OPT"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("UNITS")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

             <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Register SET SSN = ?,SECT_ID = ?, GRADE_OPT = ?, " +
                            "UNITS= ? WHERE SSN = ? AND SECT_ID = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("SECT_ID")));
                        pstmt.setString(3, request.getParameter("GRADE_OPT"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("UNITS")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Register WHERE SSN = ? AND SECT_ID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SECT_ID")));

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
                    // the class attributes FROM the Section table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM REGISTER");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>SECTION ID</th>
                        <th>GRADE OPTION</th>
                        <th>UNITS</th>
                       
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="register.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input value="" name="SECT_ID" size="10"></th>
                            <th><input value="" name="GRADE_OPT" size="10"></th>
                            <th><input value="" name="UNITS" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="register.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a integer --%>
                            <td>
                                <input value="<%= rs.getInt("SSN") %>" 
                                    name="SID" size="10">
                            </td>
                             <%-- Get the SECTID, which is a integer --%>
                            <td>
                                <input value="<%= rs.getInt("SECT_ID") %>" 
                                    name="SECT_ID" size="10">
                            </td>

                            <%-- Get the GRADE OPTION, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("GRADE_OPT") %>" 
                                    name="GRADE_OPT" size="10">
                            </td>

                             <%-- Get the UNITS, which is a int --%>
                            <td>
                                <input value="<%= rs.getInt("UNITS") %>" 
                                    name="UNITS" size="10">
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