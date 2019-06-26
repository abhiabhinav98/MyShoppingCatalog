

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="shoppingcatalog.dao.StoreDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shoppingcatalog.dto.OrderDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="styles/stylesheet.css">
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/ShowOptions.js?v=1"></script>
        <title>My Orders</title>
    </head>
    <body>
        
        <%
         
    String username = (String) session.getAttribute("username");
    StringBuffer displayBlock = new StringBuffer("");
    
    if(username == null)
    {
        session.invalidate();
        response.sendRedirect("accessdenied.html");  
        }
    else{
        try{
            System.out.println("inside removeuser");
            ArrayList<String> custname = new ArrayList<String>();
            custname = StoreDAO.getAllcustomerNames();
            if(custname.size()==0){
                displayBlock.append("<p><strong>No customers present.</strong></p>");
            }
            else{
                //SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
                displayBlock.append("<div style ='float: left;'>");
                displayBlock.append("<table border='1'>");
                //displayBlock.append("<tr><th>Order Id</th><th>Order Amount</th><th>Order Date</th></tr>");
                for(String str : custname){
                    //String dateStr = sdf.format(obj.getOrderDate());
                    // displayBlock.append("<tr><td>"+obj.getOrderId()+"</td><td>"+obj.getOrderAmount()+"</td><td>"+dateStr+"</td></tr>");
                }
                displayBlock.append("</table>");
                
            }
            displayBlock.append("<h4 id='logout'><a href='LoginControllerServlet?logout=logout'>Logout</a></h4>");
            out.println(displayBlock);
            
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }
        %>
    </body>
</html>