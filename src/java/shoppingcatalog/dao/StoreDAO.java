/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shoppingcatalog.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import shoppingcatalog.dbutil.DBConnection;
import shoppingcatalog.dto.ItemDTO;
import shoppingcatalog.dto.ItemInfoDTO;
import shoppingcatalog.dto.OrderDTO;

/**
 *
 * @author HP
 */
public class StoreDAO {
    private static PreparedStatement ps1,ps2,ps3,ps4,ps5,ps6,ps7,ps8,ps9,ps10,ps11,ps12,ps13;
    private static  Statement st,st2;
    
        static{
            try{
                 st = DBConnection.getConnection().createStatement();
                 ps1 = DBConnection.getConnection().prepareStatement("Select id,item_name from store_items where item_type=?");
                 ps2 = DBConnection.getConnection().prepareStatement("Select * from store_items where id=?");
                 ps3 = DBConnection.getConnection().prepareStatement("insert into order_master values(?,?,?,?)");
                 ps4 = DBConnection.getConnection().prepareStatement("insert into order_details values(?,?,?)");
                 ps5 = DBConnection.getConnection().prepareStatement("select count(*) as count from order_master");
                 ps6 = DBConnection.getConnection().prepareStatement("select order_id,order_amount,order_date from order_master where cust_name=?");
                 ps7=DBConnection.getConnection().prepareStatement("Select item_name from store_items WHERE id =?");
                 ps8=DBConnection.getConnection().prepareStatement("Select max(id) as count from store_items");
                 ps9=DBConnection.getConnection().prepareStatement("Insert into store_items values(?,?,?,?,?,?)");
                 ps10=DBConnection.getConnection().prepareStatement("delete from members where membertype='CUSTOMER' and username=? ");
                 ps11=DBConnection.getConnection().prepareStatement("delete from store_items where id=?");
                 ps12=DBConnection.getConnection().prepareStatement("select * from order_master");
                 ps13=DBConnection.getConnection().prepareStatement("select username from members where membertype='CUSTOMER'");
                 st2=DBConnection.getConnection().createStatement();
                
            }
            catch(Exception e){
                System.out.println("Error is DB :"+e);
                e.printStackTrace();
            }
        }
    
        public static ArrayList<String> getItemTypes()throws SQLException{
            ArrayList<String> itemList = new ArrayList<String>();
            ResultSet rs = st.executeQuery("Select distinct item_type from store_items");
            while(rs.next()){
                itemList.add(rs.getString(1));
            }
            return itemList;
            
        }
        
        public static List<ItemInfoDTO> getItemsByTypes(String itemType)throws SQLException{
            ArrayList<ItemInfoDTO> itemList = new ArrayList<ItemInfoDTO>();
            ps1.setString(1, itemType);
            ResultSet rs = ps1.executeQuery();
            while(rs.next()){
                ItemInfoDTO obj = new ItemInfoDTO();
                obj.setItemId(rs.getInt(1));
                obj.setItemName(rs.getString(2));
                itemList.add(obj);
            }
            return itemList;
        }
        
        public static ItemDTO getItemDetails(int id)throws SQLException{
            ItemDTO obj = null;
            ps2.setInt(1, id);
            ResultSet rs = ps2.executeQuery();
            if(rs.next()){
                obj = new ItemDTO();
                obj.setItemId(id);
                obj.setItemType(rs.getString(2));
                obj.setItemName(rs.getString(3));
                obj.setItemPrice(rs.getDouble(4));
                obj.setItemDesc(rs.getString(5));
                obj.setItemImage(rs.getString(6));
            }
            return obj;
        }
        
        
        
        public static boolean addOrder(String name, ArrayList<ItemDTO> itemList, double amount)throws SQLException{
            ResultSet rs= ps5.executeQuery();
            rs.next();
            int lastId = rs.getInt(1);
            String nextId = "ORD-00"+(lastId+1);
            ps3.setString(1, nextId);
            ps3.setString(2, name);
            ps3.setDouble(3, amount);
            java.util.Date today = new java.util.Date();
            long ms = today.getTime();
            java.sql.Date currDate = new java.sql.Date(ms);
            ps3.setDate(4, currDate);
            int ans1 = ps3.executeUpdate();
            int count = 0;
            for(ItemDTO item: itemList){
            ps4.setString(1, nextId);
            ps4.setString(2, item.getItemName());
            ps4.setDouble(3, item.getItemPrice());
            int ans2 = ps4.executeUpdate();
            if(ans2==1)
                ++count;
            
        }
            return (ans1==1 && count==itemList.size());
        }
        
       
        public static ArrayList<OrderDTO> getOrdersByCustomer(String custName)throws SQLException{
            ArrayList<OrderDTO> orderList = new ArrayList<OrderDTO>();
            ps6.setString(1, custName);
            ResultSet rs = ps6.executeQuery();
            while(rs.next()){
                OrderDTO order = new OrderDTO();
                order.setOrderId(rs.getString(1));
                order.setOrderAmount(rs.getDouble(2));
                order.setOrderDate(rs.getDate(3));
                orderList.add(order);
            }
            return orderList;
        }
        
        
        public static boolean addNewProduct(ItemDTO obj)throws SQLException
{
    ResultSet rs=ps8.executeQuery();
    rs.next();
    int lastId=rs.getInt(1);
    int nextId=lastId+1;
    ps9.setInt(1, nextId);
    ps9.setString(2, obj.getItemType());
    ps9.setString(3, obj.getItemName());
    ps9.setDouble(4, obj.getItemPrice());
    ps9.setString(5, obj.getItemDesc());
    ps9.setString(6, obj.getItemImage());
    int ans=ps9.executeUpdate();
    return ans==1;
}
        
        
public static ArrayList<Integer> getAllProductId()throws SQLException
{
   ArrayList<Integer> itemIdList=new ArrayList<Integer>();
   ResultSet rs=st2.executeQuery("Select id from store_items");
    while(rs.next())
    {
        itemIdList.add(rs.getInt(1));
    }
     
        System.out.println("List is of "+itemIdList.size()+" items");
        return itemIdList; 
}

public static int removeUser(String username)throws SQLException{
    ps10.setString(1, username);
    int ans = ps10.executeUpdate();
    return ans;
}

public static ArrayList<String> getAllcustomerNames()throws SQLException{
    ArrayList<String> custnames = new ArrayList<String>();
    ResultSet rs = ps13.executeQuery();
    while(rs.next()){
        custnames.add(rs.getString(1));
    }
    return custnames;
    
}
    


public static int removeProduct(int id)throws SQLException{
    ps11.setInt(1, id);
    int ans = ps11.executeUpdate();
    return ans;
}

public static ArrayList<OrderDTO> viewAllOrders()throws SQLException{
            ArrayList<OrderDTO> orderList = new ArrayList<OrderDTO>();
            
            ResultSet rs = ps12.executeQuery();
            while(rs.next()){
                OrderDTO order = new OrderDTO();
                order.setOrderId(rs.getString(1));
                order.setOrderAmount(rs.getDouble(3));
                order.setOrderDate(rs.getDate(4));
                orderList.add(order);
            }
            return orderList;
        }

}
