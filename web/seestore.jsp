<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=UTF-8" >
        <link rel="stylesheet" type="text/css" href="styles/stylesheet.css">
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/showitems.js"></script>
        <title>Store Items</title>
    </head>
    <body>

<%@include file="logo.html"%>
<%
   // ArrayList<String> itemList = new ArrayList<String>();
  //  itemList = (ArrayList)request.getAttribute("itemList");
    String username = (String) session.getAttribute("username");
    if(username == null){
        session.invalidate();
        response.sendRedirect("accessdenied.html");
    }
    else{
    StringBuffer displayBlock = new StringBuffer("<h1>My Categories</h1><p>Select a category to see its items.</p>");
    List<String> itemList = (List<String>) request.getAttribute("itemList");
    for(String itemType : itemList){
        displayBlock.append("<p id='"+itemType+"'><strong><a href='#' onclick=getItemNames('"+itemType+"')><span>+"+itemType+"</span></a></strong></p>");
    }
    displayBlock.append("<h4 id='logout'><a href='myorders.jsp'>My Orders</a>&nbsp;&nbsp;&nbsp;<a href='LoginControllerServlet?logout=logout'>Logout</a></h4>");
    out.println(displayBlock);
    }
%>
</body>
</html>