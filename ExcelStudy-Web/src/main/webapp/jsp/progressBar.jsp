<html>
<head>
    <link href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>

    <script>
        $(document).ready(function(){
            $('#progressBar').progressbar({
                value: 1
            });
        });
        var statusTracker;
        var percentage = 0;

        function checkStatus() {
            percentage = percentage + 5;
            $("#progressBar").animate({
                width : percentage + "%"
            });
            if (percentage == 100) stop();
        }

        function startProgress(){
            statusTracker = setInterval(checkStatus, 500);
        }

        function stop() {
            clearInterval(statusTracker);
        }
    </script>
</head>

<body>
<div id="progressBar" style="opcity:1; height:30px;width:500px;" ></div>
<p>
    <input type="submit" value="Start" onclick="startProgress()"/>

    <input type="submit" value="Stop" onclick="stop()"/>
</p>
</body>
</html>
