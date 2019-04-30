<%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 9/4/19
  Time: 11:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<style>
    #myProgress {
        width: 100%;
        background-color: #ddd;
    }

    #myBar {
        width: 0%;
        height: 30px;
        background-color: #4CAF50;
    }
</style>
<body>

<h1>JavaScript Progress Bar</h1>

<div id="myProgress">
    <div id="myBar"></div>
</div>

<br>
<button onclick="processProgressBar(20)">Click Me</button>
<button onclick="stopProcessBar()">Stop bar</button>

<script>
    var id;
    function  processProgressBar(recordableTime) {
        var elem = document.getElementById("myBar");
        var width = 0;
        var processWidth = 100/recordableTime;
        id = setInterval(moveProcessBar,1000);
        function moveProcessBar() {
            if (width >= 100) {
                clearInterval(id);
            } else {
                width = width + processWidth;
                elem.style.width = width + '%';
            }
        }
    }

    function  stopProcessBar() {
       clearInterval(id);
    }




</script>

</body>
</html>

