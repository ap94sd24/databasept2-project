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
                        "select distinct s2.course_no, s2.sect_id"
                            +" from section s1, section s2, register r"
                            +" where"
                            +" r.ssn = ?"
                            +" AND r.sect_id = s1.sect_id"
                            +" AND s1.year = 2016"
                            +" AND s1.quarter='WI' "
                            +" AND s1.sect_id <> s2.sect_id"
                            +" AND ((s1.lec_time_start >= s2.lec_time_start AND s1.lec_time_start <= s2.lect_time_end)" 
                            +" OR (s1.lect_time_end >= s2.lec_time_start AND s1.lect_time_end <= s2.lect_time_end))"
                            +" AND ((POSITION(s1.lect_date_id IN s2.lect_date_id) > 0) OR (POSITION(s2.lect_date_id IN s1.lect_date_id) > 0));");

                        
                    pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                    rs = pstmt.executeQuery();
                    }

            %>
                <table border="1">
                    <tr>
                        <th>SSN</th>                                          
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="display_2a.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input type="submit" value="insert"></th>
                        </form>
                    </tr>

            <table border="1">
                    <tr>
                        <h3>Conflicted Classes</h3>
                        <th>COURSE NO</th>
                        <th>SECT_ID</th>
                                        

             <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td><%= rs.getString("COURSE_NO") %></td>
                            <td><%= rs.getString("SECT_ID") %></td>
                            
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
