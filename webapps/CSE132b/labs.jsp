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
                            "INSERT INTO LABS VALUES (?, ?, ?, ?, ?, ?, ?,?,?)");
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("LAB_ID")));  
                        pstmt.setString(2, request.getParameter("LAB_DATE"));   
                        pstmt.setTime(3, java.sql.Time.valueOf(request.getParameter("L_TIME_START")));
                        pstmt.setTime(4, java.sql.Time.valueOf(request.getParameter("L_TIME_STOP")));
                        pstmt.setString(5, request.getParameter("L_ROOM"));
                        pstmt.setString(6, request.getParameter("L_BUILDING"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("L_CAPA")));
                        pstmt.setString(8, request.getParameter("QUARTER"));
                        pstmt.setInt(9, Integer.parseInt(request.getParameter("L_CAPA")));


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
                       <th>Quarter</th>
                       <th>Year</th>   

                       <th>Action</th>
                    </tr>
                    <tr>
                        <form action="labs.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="LAB_ID" size="5"></th>
                            <th><input value="" name="LAB_DATE" size="12"></th>
                            <th><input value="" name="L_TIME_START" size="32"></th>
                            <th><input value="" name="L_TIME_STOP" size="12"></th>
                            <th><input value="" name="L_ROOM" size="10"></th>
                            <th><input value="" name="L_BUILDING" size="10"></th>
                            <th><input value="" name="L_CAPA" size="5"></th>
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
                        <form action="labs.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the lab id, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("LAB_ID") %>" 
                                    name="LAB_ID" size="10">
                            </td>

                            <%-- Get the lab date, which is a date --%>
                            <td>
                                <input value="<%= rs.getString("LAB_DATE") %>" 
                                    name="LAB_DATE" size="10">
                            </td>
    
                            <%-- Get the l_TIME_START --%>
                            <td>
                                <input value="<%= rs.getTime("L_TIME_START") %>" 
                                    name="L_TIME_START" size="35">
                            </td>

                             <%-- Get the l_TIME_START --%>
                            <td>
                                <input value="<%= rs.getTime("L_TIME_STOP") %>" 
                                    name="L_TIME_STOP" size="35">
                            </td>

                            <%-- Get the lab room --%>
                            <td>
                                <input value="<%= rs.getString("L_ROOM") %>" 
                                    name="L_ROOM" size="35">
                            </td>
                            
                             <%-- Get the lab building --%>
                            <td>
                                <input value="<%= rs.getString("L_BUILDING") %>" 
                                    name="L_BUILDING" size="35">
                            </td>

                            <%-- Get the l_CAPA --%>
                            <td>
                                <input value="<%= rs.getInt("L_CAPA") %>"
                                    name="L_CAPA" size="35">
                            </td>

                             <%-- Get the lab building --%>
                            <td>
                                <input value="<%= rs.getString("QUARTER") %>" 
                                    name="QUARTER" size="35">
                            </td>
                            
                            <%-- Get the l_CAPA --%>
                            <td>
                                <input value="<%= rs.getInt("YEAR") %>"
                                    name="YEAR" size="35">
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
