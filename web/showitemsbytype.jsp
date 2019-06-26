<%@page import="java.util.List"%>
<%@page import="shoppingcatalog.dto.ItemInfoDTO"%>
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


<%
String username = (String) session.getAttribute("username");
    if(username == null){
        session.invalidate();
        response.sendRedirect("accessdenied.html");
    }
    else{
    StringBuffer displayBlock = new StringBuffer("<ul>");
    List<ItemInfoDTO> itemList = (List<ItemInfoDTO>) request.getAttribute("itemList");
    for(ItemInfoDTO obj : itemList){
        
        displayBlock.append("<li id='"+obj.getItemId()+"'><a href='StoreControllerServlet?itemId="+obj.getItemId()+"'>"+obj.getItemName()+" </a></li>");
    }
    displayBlock.append("</ul>");
    out.println(displayBlock);
    
    }
    %>
    </body>
</html>