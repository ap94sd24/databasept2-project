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
                        // INSERT the student attributes INTO the Participate table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO UNDERGRADUATES VALUES (?,?,?,?)");

                       // pstmt.setString(1, request.getParameter("TITLE"));

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setString(2, request.getParameter("COLLEGE")); 
                        pstmt.setString(3, request.getParameter("MAJOR_TITLE"));  
                        pstmt.setString(4, request.getParameter("MINOR_TITLE"));         
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
                        ("SELECT * FROM UNDERGRADUATES");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th> COLLEGE </th> 
                        <th>Major </th>
                        <th> Minor </th>


                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="undergraduates.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input value="" name="COLLEGE" size="10"></th>
                            <th><input value="" name="MAJOR_TITLE" size="10"></th>
                            <th><input value="" name="MINOR_TITLE" size="10"></th>

                           
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="undergraduates.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a integer --%>
                            <td>
                                <input value="<%= rs.getInt("SSN") %>" 
                                    name="SSN" size="10">
                            </td>
                              <%-- Get the COLLEGE, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("COLLEGE") %>" 
                                    name="COLLEGE" size="10">
                            </td>

                             <%-- Get the MTITLE, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("MAJOR_TITLE") %>" 
                                    name="MAJOR_TITLE" size="30">
                            </td>

                              <%-- Get the TITLE, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("MINOR_TITLE") %>" 
                                    name="MINOR_TITLE" size="10">
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