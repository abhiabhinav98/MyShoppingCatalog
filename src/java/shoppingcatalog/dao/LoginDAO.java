/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shoppingcatalog.dao;
import java.sql.*;
import shoppingcatalog.dbutil.DBConnection;
import shoppingcatalog.dto.UserDTO;

/**
 *
 * @author HP
 */
public class LoginDAO {
    
    
    private static PreparedStatement ps;
    static{
        try{
            ps=DBConnection.getConnection().prepareStatement("Select * from members where username=? and password=? and membertype=?");
        }
        catch(Exception ex){
            System.out.println("Error is in DB Comm: "+ex);
        }
    }
    
    public static boolean validateUser(UserDTO user)throws SQLException{

        ps.setString(1, user.getUsername());
        ps.setString(2, user.getPassword());
        ps.setString(3,user.getUsertype());
        ResultSet rs=ps.executeQuery();
        return rs.next();
    }
    
    
}
