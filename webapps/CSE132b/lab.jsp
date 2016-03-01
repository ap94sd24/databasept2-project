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
            <%@ page import="java.text.DateFormat" %>
            <%@ page import="java.text.SimpleDateFormat" %>
    
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
                        // INSERT the student attributes INTO the Class table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO LAB VALUES (?, ?, ?, ?, ?, ?, ?)");

                       // pstmt.setString(1, request.getParameter("TITLE"));

                        pstmt.setString(1, request.getParameter("LAB_ID"));
                        Date labDate = java.sql.Date.valueOf(request.getParameter("l_DATE"));
                        pstmt.setDate(2, labDate);

                        DateFormat formatter = new SimpleDateFormat("HH:mm:ss");
                        Time timeStart = new java.sql.Time(formatter.parse(request.getParameter("l_TIME_START")).getTime());
                        pstmt.setTime(3, timeStart); 
                        Time timeEnd = new java.sql.Time(formatter.parse(request.getParameter("l_TIME_STOP")).getTime());
                        pstmt.setTime(4, timeEnd); 
                        pstmt.setString(5, request.getParameter("l_ROOM")); 
                        pstmt.setString(6, request.getParameter("l_BUILDING")); 
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("l_CAPA"))); 
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
                            "UPDATE Lab SET LAB_ID = ?,l_DATE = ?, l_TIME_START = ?, " +
                            "l_TIME_STOP = ?, l_ROOM = ?, l_BUILDING = ?, l_CAPA = ? WHERE LAB_ID = ?");

                        pstmt.setString(1,  request.getParameter("LAB_ID"));
                       Date labDate = java.sql.Date.valueOf(request.getParameter("l_DATE"));
                        pstmt.setDate(2, labDate);

                        DateFormat formatter = new SimpleDateFormat("HH:mm:ss");
                        Time timeStart = new java.sql.Time(formatter.parse(request.getParameter("l_TIME_START")).getTime());
                        pstmt.setTime(3, timeStart); 
                        Time timeEnd = new java.sql.Time(formatter.parse(request.getParameter("l_TIME_STOP")).getTime());
                        pstmt.setTime(4, timeEnd); 
                        pstmt.setString(5, request.getParameter("l_ROOM")); 
                        pstmt.setString(6, request.getParameter("l_BUILDING")); 
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("l_CAPA"))); 
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
                            "DELETE FROM Lab WHERE LAB_ID = ?");

                        pstmt.setString(
                            1,  request.getParameter("Lab_ID"));
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
                        ("SELECT * FROM LAB");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>LAB_ID</th>
                        <th>l_DATE</th>
                        <th>l_TIME_START </th> 
                        <th> l_TIME_END </th>
                        <th> l_ROOM </th>
                        <th> l_BUILDING </th> 
                        <th> l_CAPA </th>  
                      

                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="lab.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="LAB_ID" size="10"></th>
                            <th><input value="" name="l_DATE" size="10"></th>
                            <th><input value="" name="l_TIME_START" size  ="10"></th>
                            <th><input value="" name="l_TIME_STOP" size="10"></th> 
                            <th><input value="" name="l_ROOM" size="10"></th> 
                            <th><input value="" name="l_BUILDING" size="10"></th> 
                            <th><input value="" name"=l_CAPA" size="10"></th>
                  
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="lab.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the lab id , which is a string --%>
                            <td>
                                <input value="<%= rs.getString("LAB_ID") %>" 
                                    name="LAB_ID" size="10">
                            </td>

                            <%-- Get the lab date , which is a date --%>
                            <td>
                                <input value="<%= rs.getDate("l_DATE") %>" 
                                    name="l_DATE" size="10">
                            </td>

                             <%-- Get the l_TIME_START , which is a time --%>
                            <td>
                                <input value="<%= rs.getTime("l_TIME_START") %>" 
                                    name="l_TIME_START" size="10">
                            </td>
                            <%-- Get the l_TIME_STOP , which is a time --%>
                            <td>
                                <input value="<%= rs.getTime("l_TIME_STOP") %>" 
                                    name="l_TIME_STOP" size="10">
                            </td>
                            <%-- Get the l_ROOM , which is a string --%>
                            <td>
                                <input value="<%= rs.getString("l_ROOM") %>" 
                                    name="l_ROOM" size="10">
                            </td>
                             <%-- Get the l_BUILDING , which is a string --%>
                            <td>
                                <input value="<%= rs.getString("l_BUILDING") %>" 
                                    name="l_BUILDING" size="10">
                            </td>

                             <%-- Get the lab capacity, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("l_CAPA") %>" 
                                    name="l_CAPA" size="10">
                            </td>

                             
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="lab.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("LAB_ID") %>" name="LAB_ID">
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