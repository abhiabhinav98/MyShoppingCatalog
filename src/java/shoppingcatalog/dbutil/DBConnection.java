/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shoppingcatalog.dbutil;
import java.sql.*;
/**
 *
 * @author HP
 */
public class DBConnection {
    private static Connection conn;
    static{
        try{
            Class.forName("oracle.jdbc.OracleDriver");
            System.out.println("Driver Successfully loaded");
            conn=DriverManager.getConnection("jdbc:oracle:thin:@//LAPTOP-7OJKGVAD:1521/xe","onlineshopping","shopping");
            }
        catch(Exception ex){
            System.out.println("Exception in opening connection in DBConnection "+ex);
        }
    }
    
    public static Connection getConnection(){
        return conn;
    }
    
    public static void closeConnection(){
        try{
            conn.close();
        }
        catch(Exception ex){
            System.out.println("Exception occurred"+ex);
        }
    }
        
}