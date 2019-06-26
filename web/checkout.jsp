<%-- 
    Document   : checkout
    Created on : 9 Jan, 2019, 10:03:51 AM
    Author     : HP
--%>

<%@page import="shoppingcatalog.dao.StoreDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="shoppingcatalog.dto.ItemDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=UTF-8" >
        <link rel="stylesheet" type="text/css" href="styles/stylesheet.css">
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/showitems.js"></script>
        <title>Checkout</title>
    </head>
    <body>
        <%@include file="logo.html"%>
        <%
            ArrayList<ItemDTO> itemList = new ArrayList<ItemDTO>();
             String username = (String) session.getAttribute("username");
    if(username == null){
        session.invalidate();
        response.sendRedirect("accessdenied.html");
    }
    else{
        double totalAmount = Double.parseDouble(request.getParameter("amount"));
        StringBuffer displayBlock =new StringBuffer("<h1>My Store-Check Out Page </h1>");
        displayBlock.append("<div style ='float: left;'>");
        displayBlock.append("<p><strong>Your payment of Rs." +totalAmount+" is under processing!</strong></p>");
        Enumeration en = session.getAttributeNames();
        while(en.hasMoreElements()){
        Object o =en.nextElement();
        if(o.equals("username")==false){
            ItemDTO item = (ItemDTO)session.getAttribute(o.toString());
            
            itemList.add(item);
            session.removeAttribute(o.toString());
        }
        }
        try{
        boolean result = StoreDAO.addOrder(username, itemList, totalAmount);
        if(result){
            displayBlock.append("Order Placed Successfully!");
        }
        else{
            displayBlock.append("There was a problem while processing");
        }
        }
        catch(Exception ex){
            displayBlock.append("Some error occurred! Please try again later."+ex);
            ex.printStackTrace();
        }
        displayBlock.append("<h4 id='logout'><a href='myorders.jsp'>My Orders</a>&nbsp;&nbsp;&nbsp;<a href='LoginControllerServlet?logout=logout'>Logout</a></h4>");
        out.println(displayBlock);
    }
        %>
    </body>
</html>
