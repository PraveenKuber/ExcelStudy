/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * <%-- 
    Document   : isExist
    Created on : Nov 24, 2017, 11:05:08 AM
    Author     : Bhaskara
--%>
xmlhttp.readyState == 4 && 
 */

           
function checkExist()
{
var xmlhttp;
var username=document.forms["userCreateForm"]["loginid"].value;
var urls="isExist.jsp?username="+username;
 
if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
else
  {
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status == 200)
    {
     
        
        document.getElementById("isE").innerHTML=xmlhttp.responseText;
        
    }
  }
xmlhttp.open("GET",urls,true);
xmlhttp.send();
}

            
      function formValidation()  
        {  
          var fn = document.forms["userCreateForm"]["fname"].value;
          var ln = document.forms["userCreateForm"]["lname"].value;
          var numExp = /^[a-z A-Z]+$/;
          
          var lid = document.forms["userCreateForm"]["loginid"].value;
          var em = document.forms["userCreateForm"]["emailid"].value;
          var atpos = em.indexOf("@");
          var dotpos = em.lastIndexOf(".");
         // var em2 = document.forms["userCreateForm"]["loginid"].value;
          
          var pw = document.forms["userCreateForm"]["password0"].value;
          var confirm_pw = document.forms["userCreateForm"]["password"].value;
          var img = document.forms["userCreateForm"]["fileToUpload"].value;

          var cno = document.forms["userCreateForm"]["cellw"].value;
          var cno2 = document.forms["userCreateForm"]["cella"].value;
          var numExp2 = /^[0-9]+$/;
          
          
          var ad = document.forms["userCreateForm"]["adrs"].value;     


           if (lid == null || lid == "") {

                        document.getElementById('isE').innerHTML="Choose an ID !";
                        document.forms["userCreateForm"]["loginid"].focus();
                    return false;
                        }    
              
                
           else if (em == null || em == "") {

                        document.getElementById('isE').innerHTML="Email-id left blank !";
                        document.forms["userCreateForm"]["emailid"].focus();
                    return false;
                        }    
                        
             else if (atpos<1 || dotpos<atpos+2 || dotpos+2>=em.length) {
                        document.getElementById('isE').innerHTML="Not a valid Email-id";
                        document.forms["userCreateForm"]["emailid"].focus();
                return false;
                }            

             else if (pw == null || pw == "") {

                        document.getElementById('isE').innerHTML="Kindly set a Password !";
                        document.forms["userCreateForm"]["password0"].focus();
                    return false;
                        }

             else if (confirm_pw == null || confirm_pw == "") {

                        document.getElementById('isE').innerHTML="Kindly Retype Password !";
                        document.forms["userCreateForm"]["password"].focus();
                    return false;
                        }
                        
             else if(pw != confirm_pw) {
                        document.getElementById('isE').innerHTML="Passwords did not match!";
                        document.forms["userCreateForm"]["password"].focus();
                    return false;
                        }   
            if (fn == null || fn == "") {

                     document.getElementById('isE').innerHTML="First name Cannot be empty !";
                     document.forms["userCreateForm"]["fname"].focus();
                    return false;
                } 
          
          
             else if(!document.forms["userCreateForm"]["fname"].value.match(numExp)){
                     document.getElementById('isE').innerHTML="Must be Alphabetic";
                     document.forms["userCreateForm"]["fname"].focus();
                     return false;
                }
            
             else if (ln == null || ln == "") {

                    document.getElementById('isE').innerHTML=" Last name cannot be empty !";
                    document.forms["userCreateForm"]["lname"].focus();
                    return false;
                }

                        else if(!document.forms["userCreateForm"]["lname"].value.match(numExp)){
                     document.getElementById('isE').innerHTML=" Must be Alphabetic ";
                     document.forms["userCreateForm"]["lname"].focus();
                     return false;
                } 

             else if (cno == null || cno == "") {

                                document.getElementById('isE').innerHTML="Enter your cella number  !";
                                document.forms["userCreateForm"]["cella"].focus();
                    return false;
                        }

                        else if (document.forms["userCreateForm"]["cella"].value.length !== 10) {

                                document.getElementById('isE').innerHTML="Contact number must be 10 digits !";
                                document.forms["userCreateForm"]["cella"].focus();
                    return false;
                }
                        else if(!document.forms["userCreateForm"]["cella"].value.match(numExp2)){
                     document.getElementById('isE').innerHTML="Numerics only";
                     document.forms["userCreateForm"]["cella"].focus();
                     return false;
                        }

                    else if (cno2 == null || cno2 == "") {

                                   document.getElementById('isE').innerHTML="Enter your cella number  !";
                                   document.forms["userCreateForm"]["cellw"].focus();
                       return false;
                           }

                           else if (document.forms["userCreateForm"]["cellw"].value.length !== 10) {

                                   document.getElementById('isE').innerHTML="Contact number must be 10 digits !";
                                   document.forms["userCreateForm"]["cellw"].focus();
                       return false;
                   }
                           else if(!document.forms["userCreateForm"]["cellw"].value.match(numExp2)){
                        document.getElementById('isE').innerHTML="Numerics only";
                        document.forms["userCreateForm"]["cellw"].focus();
                        return false;
                           }                  
                
                        else if (ad == null || ad == "") {

                                document.getElementById('isE').innerHTML="Address is left blank";
                                document.forms["userCreateForm"]["adrs"].focus();
                    return false;
                }
                
                 
                        else if (( img == null) || (img == "") ){
                            document.getElementById('isE').innerHTML="Upload your picture !";
                        document.forms["userCreateForm"]["fileToUpload"].focus();
                    return false;
                        }
                        
                else {
                    return true;
                }
        }
		      



