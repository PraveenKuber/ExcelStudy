<%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 26/2/19
  Time: 8:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Speech to Text jQuery Plugin Example</title>

    <link rel="stylesheet" href="http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css">

    <style>
        .input-reset, .input-reset:focus {
            -webkit-box-shadow: none;
            -moz-box-shadow: none;
            box-shadow: none;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 style="margin-top:20px;">Speech to Text jQuery Plugin Example</h1>
    <div class="row"><div class="span16">

        <h3>Usage</h3>
        <p>General usage is to select the input or textarea fields that you would like to enable speech to text on.
        <pre><code class="language-javascript">$("input, textarea").speechToText();</code></pre>

        <h4>Options</h4>
        <p>You may pass a class name in the options parameter which will be used to reset any custom CSS you have applied to input fields. This is used to avoid strange effects on the speech button on textareas.<p>
        <pre><code class="language-javascript">$("textarea").speechToText({inputResetClass:"input-reset-class"});</code></pre>

        <hr />

        <h3>Example</h3>
        <form action="#">
            <div class="clearfix">
                <label for="textInput">Text Inputs</label>
                <div class="input">
                    <input class="xlarge" id="textInput" name="textInput" size="30" type="text">
                </div>
            </div>
            <div class="clearfix">
                <label for="searchInput">Search Inputs</label>
                <div class="input">
                    <input class="xlarge" id="searchInput" name="searchInput" size="30" type="search">
                </div>
            </div>
            <div class="clearfix">
                <label for="textarea">Textareas</label>
                <div class="input">
                    <textarea class="xxlarge" id="textarea" name="textarea" rows="3" style="resize:none;"></textarea>
                </div>
            </div>
            <div class="actions">
                <button type="submit" class="btn primary">Save changes</button>&nbsp;<button type="reset" class="btn">Clear</button>
            </div>
        </form>

    </div></div>

    <footer>Designed by <a href="http://complexcompulsions.com" title="Complex Compulsions">Jeremy Worboys</a>.<span style="float:right;">Email for <a href="mailto:support@complexcompulsions.com">support</a>.</span></footer>
</div>

<!-- Javascript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="jquery.speechToText.min.js"></script>

<!-- This will usually go in your script.js file -->
<script>
    $("input, textarea").speechToText({inputResetClass:"input-reset"});
</script>

</body>
</html>
