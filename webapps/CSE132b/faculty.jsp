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
                        conn.setAutoCommit(false);                       // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO FACULTY VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("fname"));
                        pstmt.setString(2, request.getParameter("title"));
                        pstmt.setString(3, request.getParameter("deptname"));


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
                        ("SELECT * FROM FACULTY");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Faculty Name</th>
                        <th>Title</th>
                        <th>Department</th>
                    </tr>
                    <tr>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="fname" size="12" required></th>
                            <th><input value="" name="title" size="35" required></th>
                            <th><input value="" name="deptname" size="35" required></th>
                            <th><input type="submit" value="Insert"></th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the name, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("fname") %>" 
                                    name="fname" size="10">
                            </td>
    
                            <%-- Get the title --%>
                            <td>
                                <input value="<%= rs.getString("title") %>" 
                                    name="title" size="35">
                            </td>
    
                            <%-- Get the department --%>
                            <td>
                                <input value="<%= rs.getString("deptname") %>"
                                    name="deptname" size="35">
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
