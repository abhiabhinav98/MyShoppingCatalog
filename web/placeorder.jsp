<%@page import="shoppingcatalog.dto.ItemDTO"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=UTF-8" >
        <link rel="stylesheet" type="text/css" href="styles/stylesheet.css">
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/showitems.js"></script>
        <title>Place Order Page</title>
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
        double amount =0.0;
        Enumeration en = session.getAttributeNames();
        StringBuffer displayBlock = new StringBuffer("<h1>My Store-Order Details</h1>");
        
        
        displayBlock.append("<table border='1'>");
        displayBlock.append("<tr><th>Item Names</th><th>Item Price</th></tr>");
        while(en.hasMoreElements()){
        Object o =en.nextElement();
        if(o.equals("username")==false){
            ItemDTO item = (ItemDTO)session.getAttribute(o.toString());
            displayBlock.append("<tr><td>"+item.getItemName()+"</td><td>"+item.getItemPrice()+"</td><td><a href='#'>Remove</a></td></tr>");
            amount += item.getItemPrice();
        }
        }
        displayBlock.append("</table>");
        displayBlock.append("<p><strong>Total Amount to pay: </strong>"+amount+"</p>");
        displayBlock.append("<p><a href='StoreControllerServlet'>Continue Shopping</a>&nbsp;&nbsp;&nbsp;");
        displayBlock.append("<a href='checkout.jsp?amount="+amount+"'>Checkout</a></p>");
        displayBlock.append("<h4 id='logout'><a href='myorders.jsp'>My Orders</a>&nbsp;&nbsp;&nbsp;<a href='LoginControllerServlet?logout=logout'>Logout</a></h4>");
        out.println(displayBlock);
    }
         %>
    </body>
</html>
