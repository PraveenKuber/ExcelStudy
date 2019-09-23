<%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 14/5/19
  Time: 10:17 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>


<div class="fill-in-the-blanks fbox">
    <span class="normal">To invest, you need to</span>
    <div class="answer-area drop"></div>
    <span class="answer">draw up</span>
    <span class="normal">a clear plan, do your own research,</span>
    <span class="answer-area drop"></span>
    <span class="answer" data-cla>build in</span>
</div>

<div class="answer-pick-area fbox">
    <span class="draggable answer-part" data-option="build in">build in</span>
    <span class="draggable answer-part" data-option="draw up">draw up</span>
</div>


<script type="text/javascript">
    $(document).ready(function () {
        $(".answer-pick-area").sortable({connectWith: ".answer-area"});
        $(".answer-area").sortable({connectWith: ".answer-pick-area"});
    })


   /* $('.answer-area').droppable({
        drop: function (ui, event) {
            console.log("Came here praveen ::::::::::::")
            var dataOption = $(this).($(ui.draggable).attr('class'));
        }
    });*/

</script>


<style>
    #origin {
        background-color: lightgreen;
        min-width: 600px;
        min-height: 120px;
    }

    #origin img, #drop img {
        margin-top: 3px;
        margin-left: 5px;
    }

    #drop {
        background-color: red;
        min-height: 120px;
    }

    .over {
        border: solid 5px purple;
    }

    .draggable {
        border: solid 2px gray;
    }

    .draggable.paragraph {
        margin-top: 1%;
        padding: 1%;
        border-radius: 6px;
        border-color: cadetblue;
        cursor: move;
    }

    .order-paragraph {
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

    .fbox.order-paragraph, .fbox.swapped-text {
        border: 1px solid black;
        padding: 0%;
        width: 49%;
        padding-left: 10px;
        padding-right: 10px;
        -webkit-user-select: none;
    }

    .fbox.order-paragraph {
        margin-left: 1%;
    }

    .draggable.paragraph:hover {
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

        border: 1px solid;
        padding: 2%;
    }

    .answer-part {
        width: 100px;
        display: inline-block;
        height: 20px;
        border: 1px solid;
        cursor: move;
    }


</style>

