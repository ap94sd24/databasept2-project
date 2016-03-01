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
                            "INSERT INTO PAST_STUDENT_ENROLLMENT VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt( 1, Integer.parseInt(request.getParameter("SID")));
                        pstmt.setString(2, request.getParameter("CID"));
                        pstmt.setInt( 3, Integer.parseInt(request.getParameter("SECTID")));
                        pstmt.setString(4, request.getParameter("GRADE"));
                        pstmt.setString(5, request.getParameter("QUARTER"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("YEAR")));
                        pstmt.setString(5, request.getParameter("CLASS_TKN_ID"));
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
                            "UPDATE Past_student_enrollment SET SID = ?,CID = ?, SECTID = ?, " +
                            "GRADE = ?, QUARTER = ?, YEAR = ?, CLASS_TKN_ID = ? WHERE SID = ? and CLASS_TKN_ID = ?");

                        pstmt.setInt( 1, Integer.parseInt(request.getParameter("SID")));
                        pstmt.setString(2, request.getParameter("CID"));
                        pstmt.setInt( 3, Integer.parseInt(request.getParameter("SECTID")));
                        pstmt.setString(4, request.getParameter("GRADE"));
                        pstmt.setString(5, request.getParameter("QUARTER"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("YEAR")));
                        pstmt.setString(5, request.getParameter("CLASS_TKN_ID"));
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
                            "DELETE FROM Past_student_enrollment WHERE SID = ? AND CLASS_TKN_ID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SID")));
                      pstmt.setString(
                            2, request.getParameter("SID"));
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
                        ("SELECT * FROM Past_student_enrollment");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SID</th>
                        <th>CID</th>
                        <th>SECTID</th>
                        <th>GRADE</th>
                        <th>QUARTER</th>
                        <th>YEAR</th>
                                           
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="past_student_enroll.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SID" size="10"></th>
                            <th><input value="" name="CID" size="15"></th>
                            <th><input value="" name="SECTID" size="15"></th>
                            <th><input value="" name="GRADE" size="15"></th>
                            <th><input value="" name="QUARTER" size="15"></th>
                            <th><input value="" name="YEAR" size="15"></th>

                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="past_student_enroll.jsp" method="get">
                            <input type="hidden" value="update" name="action">

    
                            <%-- Get the SID --%>
                            <td>
                                <input value="<%= rs.getInt("SID") %>" 
                                    name="SID" size="10">
                            </td>

                             <%-- Get the COURSE ID --%>
                            <td>
                                <input value="<%= rs.getString("CID") %>" 
                                    name="CID" size="15">
                            </td>
    
                            <%-- Get the SECTION ID --%>
                            <td>
                                <input value="<%= rs.getInt("SECTID") %>"
                                    name="SECTID" size="15">
                            </td>
    
                            <%-- Get the GRADE --%>
                            <td>
                                <input value="<%= rs.getString("GRADE") %>" 
                                    name="GRADE" size="15">
                            </td>
    
                             <%-- Get the QUARTER --%>
                            <td>
                                <input value="<%= rs.getString("QUARTER") %>" 
                                    name="QUARTER" size="15">
                            </td>

                             <%-- Get the YEAR --%>
                            <td>
                                <input value="<%= rs.getString("YEAR") %>" 
                                    name="YEAR" size="15">
                            </td>

    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="past_student_enroll.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("SID, CLASS_TKN_ID") %>" name="PAST ENROLLMENTID">
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
