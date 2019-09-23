
(function ($) {
    "use strict";

    /*==================================================================
    [ Validate ]*/
    var input = $('.validate-input .input100');

    $('.login100-form-btn').on('click',function(){
        var check = true;
        console.log("Coming 1")
        for(var i=0; i<input.length; i++) {
            if(validate(input[i]) == false){
                showValidate(input[i]);
                check=false;
            }
        }

        return check;
    });


    $('.validate-form .input100').each(function(){
        $(this).focus(function(){
            console.log("Coming 2")
           hideValidate(this);
        });
    });

    function validate (input) {
        if($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
            if($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
                return false;
            }
        }
        else {
            if($(input).val().trim() == ''){
                return false;
            }
        }
    }

    function showValidate(input) {
        var thisAlert = $(input).parent();
        $(thisAlert).addClass('alert-validate');
    }

    function hideValidate(input) {
        var thisAlert = $(input).parent();
        $(thisAlert).removeClass('alert-validate');
    }
    
    /*==================================================================
    [ Show pass ]*/
    var showPass = 0;
    $('.btn-show-pass').on('click', function(){
        console.log("Coming 6")
        if(showPass == 0) {
            console.log("Coming 6.1")
            $(this).next('input').attr('type','text');
            $(this).find('i').removeClass('fa-eye');
            $(this).find('i').addClass('fa-eye-slash');
            showPass = 1;
        }
        else {
            console.log("Coming 6.2")
            $(this).next('input').attr('type','password');
            $(this).find('i').removeClass('fa-eye-slash');
            $(this).find('i').addClass('fa-eye');
            showPass = 0;
        }
        
    });
    

})(jQuery);




var main = {};


$(document).on('click','.login100-form-btn',function () {
    var userName = $('.usn').val();
    var password = $('.pwd').val();
    if(userName!=null  && password !=null){
        $.ajax({
            method:"POST",
            data: {
                userName:userName,
                password:password
            },
            url:"login/ajax/verifyLoginDetails.jsp",
            success:function (data) {
                data = data.trim();
                if(data=="true" || data==true){
                    window.location = 'jsp/executiveDashboard/executiveDashboard.jsp?userName='+userName;
                }else{
                       $('.error-message').css({"visibility":"visible"});
                       setTimeout(function () {
                           $('.error-message').css({"visibility":"hidden"});
                       },2000);
                }
                
            }
            
        })
    }
})

$(document).on('click','.signin-form-btn',function () {
    window.location = "signUp/index.jsp";
});




$(document).ready(function () {
    $('.usn').val("");
    $('pwd').val("");
});


