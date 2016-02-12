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
                        // INSERT the student attributes INTO the PREV_DEGREE table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO PREV_DEGREE VALUES (?, ?, ?, ?)");

                       // pstmt.setString(1, request.getParameter("SID"));

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("DEGREEID")));
                        pstmt.setString(3, request.getParameter("INSTITUTION"));
                        pstmt.setString(4, request.getParameter("DEGREETYPE"));
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
                        ("SELECT * FROM PREV_DEGREE");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SID</th>
                        <th>DEGREEID</th>
                        <th>INSTITUTION</th>
                        <th>DEGREETYPE</th>
                       
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="prev_degree.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SID" size="10"></th>
                            <th><input value="" name="DEGREEID" size="10"></th>
                            <th><input value="" name="INSTITUTION" size="10"></th>
                            <th><input value="" name="DEGREETYPE" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="prev_degree.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SID, which is a integer --%>
                            <td>
                                <input value="<%= rs.getInt("SID") %>" 
                                    name="SID" size="10">
                            </td>
                             <%-- Get the DEGREEID, which is a integer --%>
                            <td>
                                <input value="<%= rs.getInt("DEGREEID") %>" 
                                    name="DEGREEID" size="10">
                            </td>

                            <%-- Get the INSITUTION, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("INSTITUTION") %>" 
                                    name="INSITUTION" size="10">
                            </td>

                             <%-- Get the DEGREETYPE, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("DEGREETYPE") %>" 
                                    name="DEGREETYPE" size="10">
                            </td>

    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="prev_degree.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("DEGREEID") %>" name="PREV DEGREE">
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