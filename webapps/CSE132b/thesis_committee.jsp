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
                        ("jdbc:postgresql://localhost:5433/postgres", 
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
                            "INSERT INTO thesis_committee VALUES (?, ?, ?,?,?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ssn")));
                        pstmt.setString(2, request.getParameter("p1"));
                        pstmt.setString(3, request.getParameter("p2"));
                        pstmt.setString(4, request.getParameter("p3"));
                        pstmt.setString(5, request.getParameter("p4"));


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
                        ("SELECT * FROM thesis_committee");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>Professor 1</th>
                        <th>Professor 2</th>
                        <th>Professor 3</th>   
                        <th>Professor 4 (optional)</th>
                    </tr>
                    <tr>
                        <form action="thesis_committee.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="ssn" size="12" required></th>
                            <th><input value="" name="p1" size="35" required></th>
                            <th><input value="" name="p2" size="35" required></th>
                            <th><input value="" name="p3" size="35" required></th>
                            <th><input value="" name="p4" size="35"></th>
                            <th><input type="submit" value="Insert"></th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="thesis_committee.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the ssn, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("ssn") %>" 
                                    name="ssn" size="10">
                            </td>
    
                            <%-- Get the p1 --%>
                            <td>
                                <input value="<%= rs.getString("p1") %>" 
                                    name="p1" size="35">
                            </td>
    
                            <%-- Get the p2 --%>
                            <td>
                                <input value="<%= rs.getString("p2") %>"
                                    name="p2" size="35">
                            </td>

                            <%-- Get the p3 --%>
                            <td>
                                <input value="<%= rs.getString("p3") %>"
                                    name="p3" size="35">
                            </td>

                            <%-- Get the p4 --%>
                            <td>
                                <input value="<%= rs.getString("p4") %>"
                                    name="p4" size="35">
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
