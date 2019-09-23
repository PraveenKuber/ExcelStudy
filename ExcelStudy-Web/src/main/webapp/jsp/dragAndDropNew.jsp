<%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 9/5/19
  Time: 10:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<div id="test" class="col-md-12">
    <div id="origin" class="fbox col-md-6" >
        <img src="http://placehold.it/140x100" id="one" title="one" class="draggable" />
        <img src="http://placehold.it/150x100" id="two" title="two" class="draggable" />
        <img src="http://placehold.it/160x100" id="three" title="three" class="draggable"  />
        <img src="http://placehold.it/160x100" id="four" title="three" class="draggable"  />
        <img src="http://placehold.it/160x100" id="five" title="three" class="draggable"  />
        <img src="http://placehold.it/160x100" id="six" title="three"  />
    </div>
    <div id="drop" class="fbox col-md-6"> </div>

</div>--%>


<div class="drag-and-drop col-md-12">
    <div class="fbox swapped-text re-order-paragraph col-md-6">
        <div class="draggable paragraph position-1" data-input="1">A simple  speak but for some reason simply have not developed speech.</div>
        <div class="draggable paragraph position-2" data-input="2">A logical candidate for such a species is the chimpanzee, which shares 98.4% of the human genetic code.</div>
        <div class="draggable paragraph position-3" data-input="3">Chimpanzees cannot speak because, unlike humans, their vocal cords are located higher in their throats and cannot be controlled as well as human vocal cords.their vocal cords are located higher in their throats and cannot be controlled as well as human vocal cords their vocal cords are located higher in their throats and cannot be controlled as well as human vocal cords</div>
        <div class="draggable paragraph position-4" data-input="4">It does not follow from their lack of speech, however, that chimpanzees are incapable of language</div>
        <div class="draggable paragraph position-5" data-input="5">rhaps they can acquire grammar and speak if they could only use grammar some way other than with a voice.</div>
    </div>
    <div class="fbox order-paragraph col-md-6 drop"></div>
</div>

<input type="button" class="check-exist">



<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>


<script>

    $(document).ready(function () {
         var height = $('.swapped-text').height();
        $('.swapped-text').css({"min-height":(height+"px")});
        $('.order-paragraph').css({"min-height":(height+"px")});
    });

    $(document).on('click','.check-exist',function () {
       for(i=1;i<=5;i++){
         /* var nextNumber =  $('.position-'+i).next(".paragraph").attr("data-input");
           if((i+1)==nextNumber){
               $('.position-'+i).css({"background-color":"green"});
               $('.position-'+nextNumber).css({"background-color":"green"});
           }*/
           var index = $('.position-'+i).index();
           index = index+1;
           console.log("index is :::::::::"+i+":::::::"+index)
           if(index==i){
               $('.position-'+i).css({"background-color":"green"});
           }else{
               $('.position-'+i).css({"background-color":"red"});
           }
       }
    });




   /* $("#origin").sortable({connectWith: "#drop"});

    $("#drop").sortable({connectWith: "#origin"});

    $(".re-order-paragraph").sortable({connectWith: ".drop"});

    $(".drop").sortable({connectWith: ".re-order-paragraph"});*/





</script>



<style>
    #origin
    {
        background-color: lightgreen;
        min-width: 600px;
        min-height: 120px;
    }

    #origin img, #drop img {
        margin-top: 3px;
        margin-left: 5px;
    }


    #drop
    {
        background-color: red;
        min-height: 120px;
    }
    .over {
        border: solid 5px purple;
    }
    .draggable
    {
        border: solid 2px gray;
    }


    .draggable.paragraph {
        margin-top: 1%;
        padding: 1%;
        border-radius: 6px;
        border-color: cadetblue;
        cursor: move;
    }

    .order-paragraph{
        min-height: 277px;
        border: 1px solid black;
        cursor: pointer;
    }

    .swapped-text {
        border: 1px solid;
        padding: 1%;
    }

    .drag-and-drop {
        margin-top: 1%;
    }

    .fbox.order-paragraph,.fbox.swapped-text{
        border: 1px solid black;
        padding: 0%;
        width: 49%;
        padding-left: 10px;
        padding-right: 10px;
        -webkit-user-select: none;
    }

    .fbox.order-paragraph{
        margin-left: 1%;
    }

    .draggable.paragraph:hover{
        background-color: aquamarine;
    }


    .answer-area {
        width: 100px;
        height: 20px;
        display: inline-block;
        border: 1px solid;
        cursor: pointer;
    }

    .answer-pick-area {
        width: 50%;
        margin-left: 5%;
        margin-top: 2%;
    }

    .answer-part {
        width: 10%;
        display: inline-block;
        border: 1px solid;
        margin-left: 2%;
        cursor: move;
    }








</style>
