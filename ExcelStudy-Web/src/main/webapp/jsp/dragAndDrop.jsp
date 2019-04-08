<!doctype html>
<html lang="en">
<head>
    <title>jQuery UI Droppable</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/
							themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <style type="text/css">
        #drag
        {
            width: 100px;
            height: 100px;
            float: left;
            margin: 10px;
            background-color :aqua;
            padding:10px;
        }
        #drop
        {
            width: 150px;
            height: 150px;
            float: left;
            margin: 10px;
            background-color:yellow;
            padding:10px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js">
    </script>
    <script>
        $( function() {
            $( "#drag" ).draggable();
            $( "#drop" ).droppable(
                    {
                        drop :function()
                        {
                            alert("I am dropped");
                        }
                    } );
        } );
    </script>
</head>
<body>
<center>
    <h1 align="center">Welcome to GeeksforGeeks</h1>
    <div id="drag">
        <p>Drag Me</p>
    </div>
    <div id="drop">
        <p>Drop On Me</p>
    </div>
</center>
</body>
</html>
