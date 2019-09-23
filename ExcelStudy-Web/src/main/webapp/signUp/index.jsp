<%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 9/8/19
  Time: 4:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>ADWIZE SIGN UP</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="vendor/nouislider/nouislider.min.css">

    <!-- Main css -->
    <link rel="stylesheet" href="css/style.css">


<div class="main">

    <div class="container">
        <div class="signup-content">
            <div class="signup-img">
                <img src="images/form-img.jpg" alt="">
                <div class="adwize-signin">
                    <h2>ADWIZE</h2>
                </div>
                <div class="signup-img-content">
                    <h2>Register now </h2>
                </div>
            </div>
            <div class="signup-form">
                <form method="POST" class="register-form" id="register-form">
                    <div class="form-row">
                        <div class="form-group">
                            <div class="form-input">
                                <label for="first_name" class="required">User name</label>
                                <input type="text" name="first_name" id="first_name" onchange="signUp.checkUserName()" />
                            </div>
                            <div class="form-input">
                                <label for="last_name" class="required">Password</label>
                                <input type="password" name="last_name" id="last_name" onchange="signUp.checkPassword()"/>
                            </div>
                         <%--   <div class="form-input">
                                <label for="company" class="required">Company</label>
                                <input type="text" name="company" id="company" />
                            </div>--%>
                            <div class="form-input">
                                <label for="email" class="required">Email</label>
                                <input type="text" name="email" id="email" onchange="signUp.checkEmail()" />
                            </div>
                            <div class="form-input">
                                <label for="phone_number" class="required">Phone number</label>
                                <input type="text" name="phone_number" id="phone_number" onchange="signUp.checkPhone()"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-submit">
                        <input type="button" value="Submit" class="" id="submit_new" name="submit">
                        <input type="button" value="Reset" class="" id="reset_new" name="reset">

                        <h2 class="login-redirect" onclick="logout.performLoginOperation();">Login</h2>
                    </div>

                </form>

                <div class="message" style="display:none"></div>
            </div>
        </div>
    </div>

</div>

<!-- JS -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/nouislider/nouislider.min.js"></script>
<script src="vendor/wnumb/wNumb.js"></script>
<script src="vendor/jquery-validation/dist/jquery.validate.min.js"></script>
<script src="vendor/jquery-validation/dist/additional-methods.min.js"></script>
<script src="../js/logout/logoutOCE.js"></script>
<script src="js/main.js"></script>


<style type="text/css">

    .container {
        width: 50% !important;
    }


    .form-row .form-group {
        width: 75% !important;
        padding: 0px !important;
    }


    .form-input{
        margin-bottom: 4px !important;
        margin-top: 20px;
        margin-left: 35px;

    }

    label {
        font-weight: normal !important;
        margin-bottom: 0px !important;
    }

    input {
        padding: 4px 0px !important;
    }

    .form-submit {
        margin-top: 15px !important;
        text-align: left !important;
        margin-left: -22px;
    }

    .register-form {
         padding: 0px !important;
    }


    .signup-form {
        width: 100% !important;
    }

    img {
        max-width: 73% !important;
    }

    .signup-img {
        width: 500px !important;
        margin-bottom: 0px !important;
     }

    .form-row {
        margin-left: -60px !important;
    }

    .submit {
        width: 100px !important;
        height: 30px !important;
    }

    .signup-img-content {
        top: 60% !important;
        left: 38% !important;
    }

    label.error:after {
        top: 18px !important;
    }

    #submit_new,#reset_new{
        background: #329e5e;
        color: #fff;
        display: inline-block;
        width: 24%;
        cursor: pointer;
    }


    .message {
        width: 100%;
        margin-top: 8%;
        margin-left: -4%;
        font-family: sans-serif;
    }

    .adwize-signin {
        position: absolute;
        margin-left: 18%;
        margin-top: -178%;
    }

    h2.login-redirect {
        display: inline-flex;
        margin-left: 28%;
        font: caption;
        color: green;
        border-bottom: 1px solid;
        cursor: pointer;
    }

</style>

