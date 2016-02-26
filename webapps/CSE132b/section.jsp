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
                        ("jdbc:postgresql://localhost:5432/postgres", 
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
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Section VALUES (?, ?, ?, ?, ?, ?, ?, ? ,?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SECTID")));

                        pstmt.setString(2, request.getParameter("TITLE"));

                        pstmt.setInt(3, Integer.parseInt(request.getParameter("LECTIME")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("LECDATE")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("DISCUSSDATE")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("DISCUSSTIME")));

                        pstmt.setString(7, request.getParameter("BUILDING"));
                        pstmt.setString(8, request.getParameter("ROOM"));
                        pstmt.setInt(9, Integer.parseInt(request.getParameter("MAXCAP")));
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
                        // UPDATE the section attributes in the Section table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Section SET SECTID = ?, TITLE = ?, LECTIME = ?, " +
                            "LECDATE = ?, DISCUSSDATE = ?, DISCUSSTIME = ?, BUILDING = ?," +
                            " ROOM = ?, MAXCAP = ?  WHERE SECTID = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("LECTIME")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("LECDATE")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("DISCUSSDATE")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("DISCUSSTIME")));
                        pstmt.setString(5, request.getParameter("BUILDING"));
                        pstmt.setString(6, request.getParameter("ROOM"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("MAXCAP")));
                        pstmt.setInt(
                            8, Integer.parseInt(request.getParameter("SECTID")));
                         pstmt.setString(9, request.getParameter("TITLE"));
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
                        // DELETE the section FROM the Section table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Section WHERE SECTID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SECTID")));
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
                    // the section attributes FROM the Section table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Section");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SECTID</th>
                        <th>TITLE</th>
                        <th>LECTIME</th>
                        <th>LECDATE</th>
                        <th>DISCUSSDATE</th>
                        <th>DISCUSSTIME</th>
                        <th>BUILDING</th>
                        <th>ROOM</th>
                        <th>MAXCAP</th>

                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="section.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SECTID" size="10"></th>
                            <th><input value="" name="TITLE" size="10"></th>
                            <th><input value="" name="LECTIME" size="10"></th>
                            <th><input value="" name="LECDATE" size="10"></th>
                            <th><input value="" name="DISCUSSTIME" size="10"></th>
                            <th><input value="" name="DISCUSSDATE" size="10"></th>
                            <th><input value="" name="BUILDING" size="10"></th>
                            <th><input value="" name="ROOM" size="10"></th>
                            <th><input value="" name="MAXCAP" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="section.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SECTID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SECTID") %>" 
                                    name="SECTID" size="10">
                            </td>
                             <%-- Get the TITLE, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("TITLE") %>" 
                                    name="TITLE" size="10">
                            </td>

                            <%-- Get the LECTIME, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("LECTIME") %>" 
                                    name="LECTIME" size="10">
                            </td>

                             <%-- Get the LECDATE, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("LECDATE") %>" 
                                    name="LECDATE" size="10">
                            </td>

                             <%-- Get the DISCUSSDATE, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("DISCUSSDATE") %>" 
                                    name="DISCUSSDATE" size="10">
                            </td>

                            <%-- Get the DISCUSSTIME, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("DISCUSSTIME") %>" 
                                    name="DISCUSSTIME" size="10">
                            </td>
    
                            <%-- Get the BUILDING, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("BUILDING") %>" 
                                    name="BUILDING" size="10">
                            </td>

                            <%-- Get the ROOM, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("ROOM") %>" 
                                    name="ROOM" size="10">
                            </td>
                             <%-- Get the maxcap, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("MAXCAP") %>" 
                                    name="MAXCAP" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="section.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("SECTID") %>" name="SECTID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
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
