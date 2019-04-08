<%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 4/4/19
  Time: 10:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="summarizeTextDescription">
    When Namibia gained independence in 1990, teenager Pascolena Florry
    was herding goats in the country’s dry, desolate northern savannah.
    Her job ‘unpaid and dangerous’ was to protect her parents’ livestock from preying
    jackals and leopards. She saw wildlife as the enemy, and many of the other indigenous
</div>
<textarea rows="6" cols="80" class="summarizeTextDescription-output" onkeyup="summarizeWrittenText.getInputTextCount()">

</textarea>

<%--<div class="swt-counter">
    <div class="swt-word-counter">
        <span class="word-counter-header">Total word count : </span>
        <span class="word-counter-content"> </span>
    </div>
    <div class="swt-time-counter">
        <span class="time-counter-header">Timer : </span>
        <span class="time-counter-content"> </span>
    </div>
</div>--%>

<%--<div class="swt-answer-analysis">
    <div class="swt-your-answer-close">x</div>
    <div class="swt-your-answer">
          <div class="swt-your-answer-header">Your words :</div>
          <textarea rows="6" cols="60" class="swt-your-answer-content"></textarea>
    </div>

    <div class="swt-sample-answer">
        <div class="swt-sample-header">Sample answer</div>
        <div class="swt-sample-keyPoint-header-one">Children’s Watching TV</div>
        <div class="swt-sample-keyPoint-desc">
            Watching too much television has negative effects on important aspects of children’s life and it is
            not television but the way that parents manage their children’s TV watching, including the time
            they spend on, the programs they watch and even how the family deal with the TV, that matters.
        </div>
        <div class="swt-sample-suggestion-header">Suggested Key Points:</div>
        <div class="suggestion-list">
            <div class="suggestion-list-number">controlling children’s TV watching</div>
            <div class="suggestion-list-number">controlling children’s TV watching </div>
            <div class="suggestion-list-number">controlling children’s TV watching </div>
            <div class="suggestion-list-number">controlling children’s TV watching </div>
        </div>
    </div>

</div>--%>



<div class="swt-control">
    <div class="swt-try-again">Try again</div>
    <div class="swt-check-answer">Check answer</div>
    <div class="swt-save-my-answer">Save answer</div>
</div>


<style type="text/css">

    .swt-answer-analysis {
        width: 80%;
        padding-left: 2%;
        border-left: 5px solid black;
        background-color: rgba(0, 0, 255, 0.54);
        color: white;
    }

    .swt-your-answer-close {
        width: 1%;
        position: absolute;
        margin-left: 76%;
    }

    textarea.swt-your-answer-content {
        width: 95%;
        resize: none;
        outline: none;
    }

    .swt-sample-header,.swt-sample-keyPoint-header-one,.swt-sample-suggestion-header{
        font-size: 18px;
    }

    .swt-sample-header,.swt-sample-keyPoint-header-one,
    .swt-sample-keyPoint-desc,.suggestion-list,.swt-your-answer-content{
        margin-top: 1%;
        margin-bottom: 1%;
    }

    .suggestion-list-number {
        margin-bottom: 2px;
    }

    .swt-try-again,.swt-check-answer,.swt-save-my-answer {
        padding-left: 2%;
        padding-right: 2%;
        padding-top: 4px;
        padding-bottom: 4px;
        background: rgba(239, 165, 31, 0.9);
        color: white;
        border-radius: 7px;
        margin-right: 1%;
        cursor: pointer;
    }

    .swt-control {
        width: 60%;
        display: inline-flex;
    }


</style>