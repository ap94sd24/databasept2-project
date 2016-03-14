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
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO CATEGORY VALUES (?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("CATEG_ID"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("MIN_UNITS")));
                        pstmt.setString(3, request.getParameter("POSSIBLE_CLASSESID"));
                        pstmt.setBoolean(4, Boolean.parseBoolean(request.getParameter("IS_CONCENT")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("GPA_MIN")));
                      
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
                            "UPDATE CATEGORY SET CATEG_ID = ?, MIN_UNITS = ?, POSSIBLE_CLASSID = ?, IS_CONCENT = ?, GPA_MIN = ? WHERE  CATEG_ID= ?");

                        pstmt.setString(1, request.getParameter("CATEG_ID"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("MIN_UNITS")));
                        pstmt.setString(3, request.getParameter("POSSIBLE_CLASSESID"));
                        pstmt.setBoolean(4, Boolean.parseBoolean(request.getParameter("IS_CONCENT")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("GPA_MIN")));
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
                            "DELETE FROM Category WHERE CATEG_ID = ?");

                        pstmt.setString(
                            1, request.getParameter("CATEG_ID"));
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
                        ("SELECT * FROM Category");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Category ID</th>
                        <th>Min Units</th>
                        <th>Possible Class ID</th>
                        <th>CONCENTRATION</th>
                        <th>GPA MIN</th>
                                           
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="category.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="CATEG_ID" size="10"></th>
                            <th><input value="" name="MIN_UNITS" size="10"></th>
                            <th><input value="" name="POSSIBLE_CLASSESID" size="15"></th>
                            <th><input value="" name="IS_CONCENT" size="15"></th>
                            <th><input value="" name="GPA_MIN" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="category.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the CATEG_ID, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("CATEG_ID") %>" 
                                    name="CATEG_ID" size="10">
                            </td>
    
                            <%-- Get the Min Units --%>
                            <td>
                                <input value="<%= rs.getInt("MIN_UNITS") %>" 
                                    name="MIN_UNITS" size="10">
                            </td>

                             <%-- Get the COLLEGE --%>
                            <td>
                                <input value="<%= rs.getString("POSSIBLE_CLASSESID") %>"
                                    name="POSSIBLE_CLASSESID" size="15">
                            </td>
    
                            <%-- Get the IS_CONCENT --%>
                            <td>
                                <input value="<%= rs.getBoolean("IS_CONCENT") %>"
                                    name="IS_CONCENT" size="15">
                            </td>
    
                            <%-- Get the GPA_MIN --%>
                            <td>
                                <input value="<%= rs.getInt("GPA_MIN") %>" 
                                    name="GPA_MIN" size="15">
                            </td>

    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="category.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("CATEG_ID") %>" name="CATEG_ID">
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
