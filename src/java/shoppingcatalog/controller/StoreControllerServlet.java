/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shoppingcatalog.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import shoppingcatalog.dao.StoreDAO;
import shoppingcatalog.dto.ItemDTO;
import shoppingcatalog.dto.ItemInfoDTO;

/**
 *
 * @author HP
 */
public class StoreControllerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        RequestDispatcher rd = null;
        try{
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        if (username == null){
            session.invalidate();
            rd=request.getRequestDispatcher("accessdenied.html");
        }
        else{
            String itemId =(String) request.getParameter("itemId");
            String itemType = request.getParameter("itemType");
            if( itemType == null && itemId == null){
                List<String> itemList = StoreDAO.getItemTypes();
                request.setAttribute("itemList", itemList);
               // request.setAttribute("username",username);
                rd=request.getRequestDispatcher("seestore.jsp");
            }
            else if( itemType != null){
                List<ItemInfoDTO> itemList =  StoreDAO.getItemsByTypes(itemType);
                request.setAttribute("itemList", itemList);
               // request.setAttribute("username",username);
                rd=request.getRequestDispatcher("showitemsbytype.jsp");
            }
            else if( itemId !=null){
                ItemDTO obj = StoreDAO.getItemDetails(Integer.parseInt(itemId));
                request.setAttribute("itemDetails", obj);
               // request.setAttribute("username",username);
                rd = request.getRequestDispatcher("showitemdetails.jsp");
            }
            
        }
        }
        catch(Exception e){
            request.setAttribute("exception", e);
            rd=request.getRequestDispatcher("showexception.jsp");
            e.printStackTrace();
        }
        finally{ 
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
