var signUp = {};


$(document).on('click', '#reset_new', function () {
    $('#first_name').val("");
    $('#last_name').val("");
    $('#email').val("");
    $('#phone_number').val("");
});
    
    
$(document).on('click', '#submit_new', function () {
    var status = true;
    var userName = $('#first_name').val();
    var password = $('#last_name').val();
    var email = $('#email').val();
    var phone = $('#phone_number').val();


    if (userName.length==0) {
        $('#first_name').addClass("error");
        status = false;
        console.log("userName came and shows are error :::::::" + userName)
    }else{
        $('#first_name').removeClass("error");
    }

    if (password.trim().length == 0) {
        $('#last_name').addClass("error");
        status = false;
    }else{
        $('#last_name').removeClass("error");
    }

    /*if(!signUp.emailValidation(email)) status = true;*/
    var emailStatus = signUp.emailValidation(email);
    if(emailStatus==false){
        $('#email').addClass("error");
    }else{
        $('#email').removeClass("error");
    }

/*if(!signUp.emailValidation(email)) status = true;*/
    if (phone.trim().length == 0 || isNaN(phone.trim())) {
        $('#phone_number').addClass("error");
        status = false;
    }else{
        $('#phone_number').removeClass("error");
    }


    if(status){
        $.ajax({
            method: "POST",
            data: {
                userName: userName,
                password: password,
                email: email,
                phone:phone
            },
            url: "ajax/submitUserDetails.jsp",
            success: function (data) {
                 var json = data.trim();
                 if(json=="true"|| json==true){
                     $('.message').show();
                     $('.message').css({"color":"green"});
                     $('.message').html("User register successfully!");
                     setTimeout(function()
                     {    $('.message').hide(); }, 3000);
                     $('#reset_new').click();
                     
                 }else{
                     $('.message').show();
                     $('.message').css({"color":"red"});
                     $('.message').html("User name already exists, Please try with different user name!");
                     setTimeout(function()
                     {    $('.message').hide(); }, 3000);
                 }
            }
        });
    }

    

});


signUp.checkUserName = function () {
    var userName = $('#first_name').val();
    if (userName.length==0) {
        $('#first_name').addClass("error");
    }else{
        $('#first_name').removeClass("error");
    }

}

signUp.checkPassword = function () {
    var password = $('#last_name').val();
    if (password.trim().length == 0) {
        $('#last_name').addClass("error");
        status = false;
    }else{
        $('#last_name').removeClass("error");
    }
}


signUp.checkEmail = function () {
    var email = $('#email').val();
    var emailStatus = signUp.emailValidation(email);
    if(emailStatus==false){
        $('#email').addClass("error");
    }else{
        $('#email').removeClass("error");
    }
}

signUp.checkPhone = function () {
    var phone = $('#phone_number').val();
    if (phone.trim().length == 0 || isNaN(phone.trim())) {
        $('#phone_number').addClass("error");
        status = false;
    }else{
        $('#phone_number').removeClass("error");
    }
}





signUp.emailValidation = function (email) {
    var emailId = email;
    var position = emailId.indexOf("@");
    var dotPosition = emailId.lastIndexOf(".");

    if (position < 1 || dotPosition < position + 2 || dotPosition + 2 >= emailId.length) {
        return false;
    }
    else {
        return true;
    }
}





