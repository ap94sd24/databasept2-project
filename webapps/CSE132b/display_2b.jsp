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
                    Statement statement = conn.createStatement();
                    ResultSet rs = null;
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                        "select distinct r.r_date, r.r_time_start, r.r_time_end"
                        +" from review_ses r"
                        +" where not exists("
                        +" select * "
                        +" from  register r1, section s1"
                        +" where"
                        +" s1.year = 2016"
                        +" AND s1.quarter = 'WI' "
                        +" AND r1.sect_id = s1.sect_id"
                        +" AND ((s1.lec_time_start >= r.r_time_start AND s1.lec_time_start <= r.r_time_end)" 
                        +" OR (s1.lect_time_end >= r.r_time_start AND s1.lect_time_end <= r.r_time_end))"
                        +" AND ((POSITION(s1.lect_date_id IN r.r_date) > 0) OR (POSITION(r.r_date IN s1.lect_date_id) > 0))"
                        +" AND r1.ssn IN"
                        +" (select r2.ssn"
                        +" from register r2"
                        +" where r2.sect_id = ?))"
                        +" ORDER BY r.r_date asc, r.r_time_start asc");

                        
                    pstmt.setInt(1, Integer.parseInt(request.getParameter("SECT_ID")));
                    rs = pstmt.executeQuery();
                    }

            %>
                <table border="1">
                    <tr>
                        <th>Section ID</th>                                          
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="display_2b.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SECT_ID" size="10"></th>
                            <th><input type="submit" value="insert"></th>
                        </form>
                    </tr>

            <table border="1">
                    <tr>
                        <th>Review Date</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                                        

             <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td><%= rs.getString("R_DATE") %></td>
                            <td><%= rs.getTime("R_TIME_START") %></td>
                            <td><%= rs.getTime("R_TIME_END") %></td>
                            
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
