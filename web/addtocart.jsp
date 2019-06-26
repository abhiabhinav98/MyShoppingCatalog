<%@page import="java.util.Enumeration"%>
<%@page import="shoppingcatalog.dao.StoreDAO"%>
<%@page import="shoppingcatalog.dto.ItemDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=UTF-8" >
        <link rel="stylesheet" type="text/css" href="styles/stylesheet.css">
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/showitems.js"></script>
        <title>Add to Cart</title>
    </head>
    <body>
        <%@include file="logo.html"%>
        <%
            String username = (String) session.getAttribute("username");
  
    if(username == null)
    {
        session.invalidate();
        response.sendRedirect("accessdenied.html");  
        }
    else{
        String itemId =(String)request.getParameter("itemId");
        ItemDTO obj = StoreDAO.getItemDetails(Integer.parseInt(itemId));
        session.setAttribute(String.valueOf(obj.getItemId()),obj);
        
        StringBuffer displayBlock = new StringBuffer("<h1>Items In your Cart</h1>");
        displayBlock.append("<div style='float: left; '>");
        displayBlock.append("<p><strong>Item Added Successfully!</strong></p>");
        displayBlock.append("<p><strong>ItemId: </strong>"+obj.getItemId()+"</p>");
        displayBlock.append("<p><strong>Name: </strong>"+obj.getItemName()+"</p>");
        displayBlock.append("<p><strong>Price: </strong>Rs"+obj.getItemPrice()+"</p>");
        Enumeration en = session.getAttributeNames();
        int count = 0;
        while(en.hasMoreElements()){
            ++count;
            en.nextElement();
        }
        displayBlock.append("<p><strong>You have currently "+(count-1)+" item(s) in your cart</strong></p>");
                displayBlock.append("<p><a href='StoreControllerServlet'>Continue Shopping</a>&nbsp;&nbsp;&nbsp;");

        displayBlock.append("<a href='placeorder.jsp?itemId="+obj.getItemId()+"'>Add to cart</a></p></div>");
        displayBlock.append("<h4 id='logout'><a href='myorders.jsp'>My Orders</a>&nbsp;&nbsp;&nbsp;<a href='LoginControllerServlet?logout=logout'>Logout</a></h4>");
    out.println(displayBlock);
    }
        %>
    </body>
</html>
