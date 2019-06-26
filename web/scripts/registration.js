/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var username;
var password;

$(document).ready(function(){
   
    $("#registerbtn").click(function(){
        validate();
    });
    
});

function validate(){
    username = document.getElementById("username").value;
    password = document.getElementById("password").value;
    
        
    
    $("#regresult").css("display","inline");
    if(username==="" || password==="" ){
        $("#regresult").text("Please input all values.");
        $("#regresult").css("font-weight","bold");
        $("#regresult").css("color","red");
        $("#regresult").fadeOut(4000);
        return;
    }
    
    register();
}

function register(){
    
    username = document.getElementById("username").value;
    password = document.getElementById("password").value;
    var data = {username:username,password:password};
    var request=$.post("RegistrationControllerServlet",data,processResponse);
    request.error(handleError);
}

function processResponse(responseText){
    ans = responseText;
    ans=ans.trim();
    
    if(ans === 'uap'){
     $("#regresult").html("This username is already present!").css({"font-weight":"bold","color":"red"});
     return;
     }
     else if(ans === "failure"){
     $("#regresult").html("Sorry! Cannot register! Try again later..").css({"font-weight":"bold","color":"red"});
        
     }
     else if(ans === "success"){
         $("#regresult").html("User Registered.<br>You can now <a href='href.html'>Login</a>").css({"font-weight":"bold","color":"green"});
     }
     
     }
     
     
     function handleError(xhr,textStatus){
    if(textStatus === 'error') 
      $("#regresult").text('An error occurred during your request: ' +  xhr.status );
}


