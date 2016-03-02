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
                        conn.setAutoCommit(false);                       // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.


                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO review_ses VALUES (?, ?, ?, ?, ?, ?, ?)");
                        pstmt.setString(1, request.getParameter("LAB_ID"));  
                        pstmt.setDate(2, java.sql.Date.valueOf(request.getParameter("l_DATE")));   
                        pstmt.setTime(3, java.sql.Time.valueOf(request.getParameter("l_TIME_START")));
                        pstmt.setTime(4, java.sql.Time.valueOf(request.getParameter("l_TIME_STOP")));
                        pstmt.setString(5, request.getParameter("BUILDING"));
                        pstmt.setString(6, request.getParameter("ROOM"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("MAXCAP")));

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
                            "DELETE FROM LABS WHERE LAB_ID = ?");

                        pstmt.setString(
                            1, request.getParameter("LAB_ID"));
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
                        ("SELECT * FROM labs");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                       <th>Lab ID</th>
                        <th>Lab Date</th>
                        <th>Start Time</th>
                        <th>End time</th>
                        <th>Lab Room</th>
                       <th> Lab Building</th>
                       <th> Lab Capacity</th>

                       <th>Action</th>
                    </tr>
                    <tr>
                        <form action="labs.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="lAB_ID" size="12"></th>
                            <th><input value="" name="l_DATE" size="12"></th>
                            <th><input value="" name="l_TIME_START" size="35"></th>
                            <th><input value="" name="l_TIME_STOP" size="12"></th>
                            <th><input value="" name="l_ROOM" size="35"></th>
                            <th><input value="" name="l_BUILDING" size="35"></th>
                            <th><input value="" name="l_CAPA" size="35"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="labs.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the lab id, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("LAB_ID") %>" 
                                    name="LAB_ID" size="10">
                            </td>

                            <%-- Get the lab date, which is a date --%>
                            <td>
                                <input value="<%= rs.getDate("l_DATE") %>" 
                                    name="sectionid" size="10">
                            </td>
    
                            <%-- Get the l_TIME_START --%>
                            <td>
                                <input value="<%= rs.getTime("l_TIME_START") %>" 
                                    name="l_TIME_START" size="35">
                            </td>

                             <%-- Get the l_TIME_START --%>
                            <td>
                                <input value="<%= rs.getTime("l_TIME_STOP") %>" 
                                    name="l_TIME_STOP" size="35">
                            </td>

                            <%-- Get the lab room --%>
                            <td>
                                <input value="<%= rs.getString("l_ROOM") %>" 
                                    name="l_ROOM" size="35">
                            </td>
                            
                             <%-- Get the lab building --%>
                            <td>
                                <input value="<%= rs.getString("l_BUILDING") %>" 
                                    name="l_BUILDING" size="35">
                            </td>

                            <%-- Get the l_CAPA --%>
                            <td>
                                <input value="<%= rs.getInt("l_CAPA") %>"
                                    name="l_CAPA" size="35">
                            </td>
                        
                      <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="labs.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("lab_ID") %>" name="LAB_ID">
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
