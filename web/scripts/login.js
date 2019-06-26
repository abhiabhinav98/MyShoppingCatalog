/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var username;
var password;
var usertype;
var res;
$(document).ready(function(){
   
    $("#loginbtn").click(function(){
        validate();
    });
    
});

function validate(){
    
    $("#result").css("display","inline");
    username = document.getElementById("username").value;
    password = document.getElementById("password").value;
    usertype = document.getElementById("usertype").value;
    if(username==="" || password==="" ){
        $("#loginresult").text("Please input all values.");
        $("#loginresult").css("font-weight","bold");
        $("#loginresult").css("color","red");
        $("#loginresult").fadeOut(4000);
        return;
    }
    
    login();
}

function login(){
    
    username = document.getElementById("username").value;
    password = document.getElementById("password").value;
    usertype = document.getElementById("usertype").value;
    var data = {username:username,password:password,usertype:usertype};
    var request=$.post("LoginControllerServlet",data,processResponse);
    request.error(handleError);
}

function processResponse(responseText){
    ans = responseText;
    ans=ans.trim();
    if(ans === 'error'){
     $("#loginresult").html("Login Denied").css({"font-weight":"bold","color":"red"});
     return;
     }
     if(ans.indexOf("jsessionid")!==-1){
     $("#loginresult").html("Login Accepted! Redirecting to store page.").css({"font-weight":"bold","color":"green"});
        setTimeout(redirect,3000);
     }
     }
     function redirect(){
         window.location=ans;
     }
     
     function handleError(xhr,textStatus){
    if(textStatus === 'error') 
      $("#loginresult").text('An error occurred during your request: ' +  xhr.status );
}

