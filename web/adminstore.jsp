<%-- 
    Document   : adminstore
    Created on : 16 Feb, 2019, 1:51:20 PM
    Author     : HP
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="styles/stylesheet.css"> 
        <script type="text/javascript" src="scripts/jquery.js">
         </script>
        <script type="text/javascript" src="scripts/ShowOptions.js?v=1"></script>
         
        <title>Store Items</title>
    </head>
    <body>
        <%@include file="logo.html"%>
         <%
          String username=(String)session.getAttribute("username");
          System.out.println("inside adminstore username is "+username);
          if(username==null)
          {
             response.sendRedirect("accessdenied.html");
                      
          }
          else
          {
              System.out.println("inside adminstore");
              ArrayList<Integer> itemIdList= (ArrayList<Integer>)session.getAttribute("itemIdList");
              out.println(itemIdList);
              System.out.println(""+itemIdList);
          }
          %>
    </body>
</html>
