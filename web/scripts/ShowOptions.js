var item;
var myoptionsarray=[];
var myfunctionnamesarray=[];
var productoptions=["Add","Update","Delete"];
var productoptionsfunctions=["showAddProductForm()","showUpdateProductForm()","showDeleteProductForm()"];
var useroptions=["Remove"];
var useroptionsfunctions=["removeUser()"];
var viewoptions=["Orders"];
var viewoptionsfunctions=["viewOrders()"];
function removeProductForm()
{
    var contdiv=document.getElementById("productcontainer");
    var formdiv=document.getElementById("productform");
    if(formdiv!==null)
    {
        //alert("div has been removed");
        $("#productform").fadeOut("3500");
        contdiv.removeChild(formdiv);   
    }
}
function getItemNames(itemType)
{
    
    item=itemType;
para=document.getElementById(itemType);
var span=para.getElementsByTagName("span")[0];
//alert("span is "+span);
var spantext=span.innerHTML.trim();
//alert("spantext is "+spantext);

if(spantext.indexOf("+")!==-1)
{
    span.innerHTML="-"+itemType;
      
}
else if(spantext.indexOf("-")!==-1)
{
    span.innerHTML="+"+itemType;
    $("#"+item+ " .itemnames").hide("slow");
    removeProductForm();
    return; 
    
}

showItems();
}
function showItems()
{
var olddiv=para.getElementsByClassName("itemnames")[0];
if(typeof olddiv!=='undefined')
{
 //alert("div removed");
 para.removeChild(olddiv);   
}
var newdiv=document.createElement("div");
newdiv.setAttribute("class","itemnames");
var newul=document.createElement("ul");
if(item=="Products")
{
    myoptionsarray=productoptions;
    myfunctionnamesarray=productoptionsfunctions;
}
else if(item=="Users")
{
    myoptionsarray=useroptions;
    myfunctionnamesarray=useroptionsfunctions;
    }
else
{
     myoptionsarray=viewoptions;
     myfunctionnamesarray=viewoptionsfunctions;
}
for(var i=0;i<myoptionsarray.length;i++)
{
    newul.innerHTML+="<li><a href='#' onclick='"+myfunctionnamesarray[i]+"'>"+myoptionsarray[i]+"</a></li>";
    
}
newdiv.appendChild(newul);
para.appendChild(newdiv);
$("#"+item+ " .itemnames").hide();
$("#"+item+ " .itemnames").show("slow");
}
function showAddProductForm()
{
//alert("showAddProduct called");
removeProductForm();
var newdiv=document.createElement("div");
newdiv.setAttribute("id","productform");
newdiv.setAttribute("float","left");
newdiv.setAttribute("padding-left","12px");
newdiv.setAttribute("border","solid 2px red");
newdiv.innerHTML="<h3>Add New Product</h3>";
newdiv.innerHTML=newdiv.innerHTML+"<form method='POST' enctype='multipart/form-data' id='fileUploadForm'><table border='2'><tr><th>Product Name:</th><td><input type='text' id='pname'></td></tr><tr><th>Product Type:</th><td><input type='text' id='ptype'></td></tr><tr><th>Product Price:</th><td><input type='text' id='pprice'></td></tr><tr><th>Product Desc:</th><td><input type='text' id='pdesc'></td></tr><tr><td colspan='2'><input type='file' name='files' value='Select Image'></td></tr><tr><th><input type='button' value='Add Product' onclick='addProduct()' id='addprd'></th><th><input type='reset' value='Clear' onclick='clearText()'></th></tr></table></form>";
newdiv.innerHTML=newdiv.innerHTML+"<span id='addresp'></span>";
var addPrd=$("#productcontainer")[0];
addPrd.appendChild(newdiv);
$("#productform").hide();
$("#productform").fadeIn("3500");

}


function clearText()
{
    $("#addresp").html("");
    $("#updateresp").html("");
    $("#deleteresp").html("");
}
function addProduct()
{
    var form = $('#fileUploadForm')[0];
    var data = new FormData(form);
    alert(data);
    var pname=$("#pname").val();
    var ptype=$("#ptype").val();
    var pdesc=$("#pdesc").val();
    var pprice=$("#pprice").val();
    data.append("pname",pname);
    data.append("ptype",ptype);
    data.append("pdesc",pdesc);
    data.append("pprice",pprice);
    $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "AddNewProductControllerServlet",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {

                $("#addresp").html(data);
            },
            error: function (e) {
                $("#addresp").html(e.responseText);
                         
            }
        });
}




function showUpdateProductForm()
{
//alert("showUpdateProduct called");
removeProductForm();
var str = 'str';
$.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "AdminControllerServlet",
            data: str,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {

                //$("#updateresp").html(data);
               //console.log(data);
                
            },
            error: function (e) {

                $("#updateresp").html(e.responseText);
                
            }
        });

var newdiv=document.createElement("div");
newdiv.setAttribute("id","productform");
newdiv.setAttribute("float","left");
newdiv.setAttribute("padding-left","12px");
newdiv.setAttribute("border","solid 2px red");
newdiv.innerHTML="<h3>Update Product</h3>";
newdiv.innerHTML=newdiv.innerHTML+"<form method='POST' enctype='multipart/form-data' id='fileUploadForm'><table border='2'><tr><th>Product Id:</th><td><select id='pid'></select></td></tr><tr><th>Product Name:</th><td><input type='text' id='pname'></td></tr><tr><th>Product Type:</th><td><input type='text' id='ptype'></td></tr><tr><th>Product Price:</th><td><input type='text' id='pprice'></td></tr><tr><th>Product Desc:</th><td><input type='text' id='pdesc'></td></tr><tr><td colspan='2'><input type='file' name='files' value='Select Image'></td></tr><tr><th><input type='button' value='Add Product' onclick='updateProduct()' id='updateprd'></th><th><input type='reset' value='Clear' onclick='clearText()'></th></tr></table></form>";
newdiv.innerHTML=newdiv.innerHTML+"<span id='updateresp'></span>";
var addPrd=$("#productcontainer")[0];
addPrd.appendChild(newdiv);
$("#productform").hide();
$("#productform").fadeIn("3500");

}


function updateProduct()
{
    var form = $('#fileUploadForm')[0];
    var data = new FormData(form);
    alert(data);
    var pid=$("#pid").val();
    var pname=$("#pname").val();
    var ptype=$("#ptype").val();
    var pdesc=$("#pdesc").val();
    var pprice=$("#pprice").val();
    data.append("pid",pid);
    data.append("pname",pname);
    data.append("ptype",ptype);
    data.append("pdesc",pdesc);
    data.append("pprice",pprice);
    $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "AdminControllerServlet",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {

                $("#updateresp").html(data);
                
            },
            error: function (e) {

                $("#updateresp").html(e.responseText);
                
            }
        });
}





function deleteProduct()
{
    alert("deleteProduct called");
    removeProductForm();
}
function viewOrders()
{
    //alert("viewOrder called");
    removeProductForm();
    $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "vieworders.jsp",
            
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {

                //$("#updateresp").html(data);
               console.log(data);
               //$("#document").html(data);
               var newdiv=document.createElement("div");
               newdiv.setAttribute("id","productform");
               newdiv.setAttribute("float","left");
               newdiv.setAttribute("padding-left","12px");
               newdiv.setAttribute("border","solid 2px red");
               newdiv.innerHTML = newdiv.innerHTML + data;
               var addPrd=$("#productcontainer")[0];
               addPrd.appendChild(newdiv);
                
                
            },
            error: function (e) {

                alert(e.responseText);
                
            }
        });
    
}
function removeUser()
{
    //alert("removeUser called");
    removeProductForm();
    
    $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "removeuser.jsp",
            
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {

                //$("#updateresp").html(data);
               console.log(data);
               //$("#document").html(data);
               var newdiv=document.createElement("div");
               newdiv.setAttribute("id","productform");
               newdiv.setAttribute("float","left");
               newdiv.setAttribute("padding-left","12px");
               newdiv.setAttribute("border","solid 2px red");
               newdiv.innerHTML = newdiv.innerHTML + data;
               var addPrd=$("#productcontainer")[0];
               addPrd.appendChild(newdiv);
                
                
            },
            error: function (e) {

                alert(e.responseText);
                
            }
        });
    
}