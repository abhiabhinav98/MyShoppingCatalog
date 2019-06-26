<%@page import="java.util.ArrayList"%>
<%@page import="shoppingcatalog.dto.ItemDTO"%>
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
    String username = (String) session.getAttribute("username");
  
    if(username == null)
    {
        session.invalidate();
        response.sendRedirect("accessdenied.html");  
        }
    else{
        
            ItemDTO obj = new ItemDTO();
        obj =(ItemDTO) request.getAttribute("itemDetails");
       StringBuffer displayBlock = new StringBuffer("<h1>My Store-Item Details</h1><p><em>You are viewing:</em><br/>");
      //  displayBlock.append((""+obj.getItemName()+""+obj.getItemDesc()+""+obj.getItemType()+""+obj.getItemPrice()+""+obj.getItemImage()));
      
      
        displayBlock.append("<strong><a href='StoreControllerServlet'>"+obj.getItemType()+"&gt;</a>"+obj.getItemName()+"</strong></p>");  
        displayBlock.append("<div style='float: left; '>");
        displayBlock.append("<img src=\'images/"+obj.getItemImage()+"'></div>");
        displayBlock.append("<div style='float: left;padding-left: 12px'>");
        displayBlock.append("<p><strong>Description:</strong><br/>"+obj.getItemDesc()+"</p>");
        displayBlock.append("<p><strong>Price: </strong>Rs"+obj.getItemPrice()+"</p>");
        
        displayBlock.append("<p><a href='addtocart.jsp?itemId="+obj.getItemId()+"'>Add to cart</a></p></div>");
        displayBlock.append("<h4 id='logout'><a href='myorders.jsp'>My Orders</a>&nbsp;&nbsp;&nbsp;<a href='LoginControllerServlet?logout=logout'>Logout</a></h4>");
    out.println(displayBlock);
    }
%>

    </body>
</html>