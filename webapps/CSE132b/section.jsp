 n<html>

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
            <%@ page language="java" import="java.text.*" %>
            <%@ page import="java.util.*" %>

    
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
                            "INSERT INTO Section VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SECT_ID")));
                        pstmt.setString(2, request.getParameter("TITLE"));
                        pstmt.setString(3, request.getParameter("COURSE_NO"));
                        pstmt.setString(4, request.getParameter("LECT_DATE_ID"));
                        pstmt.setString(5, request.getParameter("DIS_DATE_ID"));
                        pstmt.setString(6, request.getParameter("BUILDING"));
                        pstmt.setString(7, request.getParameter("ROOM"));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("MAXCAP")));
                        pstmt.setInt(9, Integer.parseInt(request.getParameter("LAB_ID")));
                        pstmt.setTime(10, java.sql.Time.valueOf(request.getParameter("LECT_TIME_START")));
                        pstmt.setTime(11, java.sql.Time.valueOf(request.getParameter("LECT_TIME_END")));
                        pstmt.setTime(12, java.sql.Time.valueOf(request.getParameter("DIS_TIME_START")));
                        pstmt.setTime(13, java.sql.Time.valueOf(request.getParameter("DIS_TIME_END")));
                        pstmt.setInt(14, Integer.parseInt(request.getParameter("REV_ID")));
                        pstmt.setString(15, request.getParameter("QUARTER"));
                        pstmt.setInt(16, Integer.parseInt(request.getParameter("YEAR")));
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
                            "UPDATE Section SET SECT_ID = ?, TITLE = ?,COURSE_NO = ?, LECT_DATE_ID = ?, DIS_DATE_ID = ?, BUILDING = ?, ROOM = ?, MAXCAP =?, LAB_ID = ?, LECT_TIME_START = ?, LECT_TIME_END = ?, DIS_TIME_START = ?, DIS_TIME_END = ?, REV_ID = ?, QUARTER = ?, YEAR = ? WHERE SID = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setString(2, request.getParameter("STATUS"));
                        pstmt.setString(3, request.getParameter("FIRSTNAME"));
                        pstmt.setString(4, request.getParameter("MIDDLENAME"));
                        pstmt.setString(5, request.getParameter("LASTNAME"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("SECT_ID")));
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
                            "DELETE FROM Section WHERE SECT_ID = ?");

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
                    // the section attributes FROM the Section table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Section");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SECT_ID</th>
                        <th>TITLE</th>
                        <th>COURSE NO</th>
                        <th>LECTURE DATE</th>
                        <th>DISS DATE</th>
                        <th>BUILDING</th>
                        <th>ROOM</th>
                        <th>MAXCAP</th>
                        <th>LAB ID </th>
                        <th>LECT_TIME_START</th>
                        <th>LECT_TIME_END</th>
                        <th>DIS_TIME_START</th>
                        <th>DIS_TIME_END</th>
                        <th>REVIEW ID </th> 
                        <th>QUARTER</th> 
                        <th>YEAR</th> 

                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="section.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SECT_ID" size="10"></th>
                            <th><input value="" name="TITLE" size="10"></th>
                            <th><input value="" name="COURSE_NO" size="10"></th>
                            <th><input value="" name="LECT_DATE_ID" size="10"></th>
                            <th><input value="" name="DIS_DATE_ID" size="10"></th>
                            <th><input value="" name="BUILDING" size="10"></th>
                            <th><input value="" name="ROOM" size="10"></th>
                            <th><input value="" name="MAXCAP" size="10"></th>
                            <th><input value="" name="LAB_ID" size="10"></th>
                            <th><input value="" name="LECT_TIME_START" size="10"></th>
                            <th><input value="" name="LECT_TIME_END" size="10"></th>
                            <th><input value="" name="DIS_TIME_START" size="10"></th>
                            <th><input value="" name="DIS_TIME_END" size="10"></th>
                            <th><input value="" name="REV_ID" size="10"></th>
                            <th><input value="" name="QUARTER" size="10"></th>
                            <th><input value="" name="YEAR" size="10"></th>
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

                            <%-- Get the SECT_ID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SECT_ID") %>" 
                                    name="SECT_ID" size="10">
                            </td>
                             <%-- Get the TITLE, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("TITLE") %>" 
                                    name="TITLE" size="10">
                            </td>

                            <%-- Get the TITLE, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("COURSE_NO") %>" 
                                    name="COURSE_NO" size="10">
                            </td>

                            <%-- Get the LECTDATE, which is a date --%>
                            <td>
                                <input value="<%= rs.getString("LECT_DATE_ID") %>" 
                                    name="LECT_DATE_ID" size="10">
                            </td>

                             <%-- Get the DIS_DATE_ID, which is a date --%>
                            <td>
                                <input value="<%= rs.getString("DIS_DATE_ID") %>" 
                                    name="DIS_DATE_ID" size="10">
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

                             <%-- Get the lab id, which is a string --%>
                            <td>
                                <input value="<%= rs.getInt("LAB_ID") %>" 
                                    name="LAB_ID" size="10">
                            </td>

                            <%-- Get the lecture start time, which is a time --%>
                            <td>
                                <input value="<%= rs.getTime("LECT_TIME_START") %>" 
                                    name="LECT_TIME_START" size="10">
                            </td>

                            <%-- Get the lecture end time, which is a time --%>
                            <td>
                                <input value="<%= rs.getTime("LECT_TIME_END") %>" 
                                    name="LECT_TIME_END" size="10">
                            </td>

                             <%-- Get the discussion start time, which is a time --%>
                            <td>
                                <input value="<%= rs.getTime("DIS_TIME_START") %>" 
                                    name="DIS_TIME_START" size="10">
                            </td>

                            <%-- Get the discussion end time, which is a time --%>
                            <td>
                                <input value="<%= rs.getTime("DIS_TIME_END") %>" 
                                    name="DIS_TIME_END" size="10">
                            </td>

                             <%-- Get the review id, which is a string --%>
                            <td>
                                <input value="<%= rs.getInt("REV_ID") %>" 
                                    name="REV_ID" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("QUARTER") %>" 
                                    name="QUARTER" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("YEAR") %>" 
                                    name="YEAR" size="10">
                            </td>

                          <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="section.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("SECT_ID") %>" name="SECT_ID">
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