<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="cc1" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.0.30930.28736, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GiftCardFormUserControl.ascx.cs" Inherits="GiftCardForm.GiftCardForm.GiftCardFormUserControl" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.12.1/themes/cupertino/jquery-ui.css" />
<link href="http://njspdevd01:2544/SiteAssets/GiftCardForm.css" rel="stylesheet" type="text/css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js" type="text/javascript"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js" type="text/javascript"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>

<style type="text/css">
.ui-autocomplete{
    position: absolute;
    top: 100%;
    left: 0;
    z-index: 1000;
    float: left;
    display: none;
    min-width: 160px;   
    padding: 4px 0;
    margin: 0 0 10px 25px;
    list-style: none;
    background-color: #ffffff;
    border-color: #ccc;
    border-color: rgba(0, 0, 0, 0.2);
    border-style: solid;
    border-width: 1px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    -webkit-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
    -moz-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
    box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
    -webkit-background-clip: padding-box;
    -moz-background-clip: padding;
    background-clip: padding-box;
    border-right-width: 2px;
    border-bottom-width: 2px;
}

.ui-menu-item, a.ui-corner-all{
    display: block;
    padding: 3px 15px;
    clear: both;
    font-weight: normal;
    line-height: 18px;
    color: #555555;
    white-space: nowrap;
    text-decoration: none;
}

.ui-state-hover, .ui-state-active{
    color: #ffffff;
    text-decoration: none;
    background-color: #0088cc;
    border-radius: 0px;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    background-image: none;
}

</style>

<script type="text/javascript">
    $(function () {
        var namesA = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesA").html();
        var namesB = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesB").html();
        var namesC = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesC").html();
        var namesD = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesD").html();
        var namesE = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesE").html();
        var namesF = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesF").html();
        var namesG = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesG").html();
        var namesH = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesH").html();
        var namesI = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesI").html();
        var namesJ = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesJ").html();
        var namesK = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesK").html();
        var namesL = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesL").html();
        var namesM = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesM").html();
        var namesN = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesN").html();
        var namesO = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesO").html();
        var namesP = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesP").html();
        var namesQ = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesQ").html();
        var namesR = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesR").html();
        var namesS = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesS").html();
        var namesT = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesT").html();
        var namesU = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesU").html();
        var namesV = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesV").html();
        var namesW = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesW").html();
        var namesX = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesX").html();
        var namesY = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesY").html();
        var namesZ = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesZ").html();

        var employeesA = namesA.split('~');
        var employeesB = namesB.split('~');
        var employeesC = namesC.split('~');
        var employeesD = namesD.split('~');
        var employeesE = namesE.split('~');
        var employeesF = namesF.split('~');
        var employeesG = namesG.split('~');
        var employeesH = namesH.split('~');
        var employeesI = namesI.split('~');
        var employeesJ = namesJ.split('~');
        var employeesK = namesK.split('~');
        var employeesL = namesL.split('~');
        var employeesM = namesM.split('~');
        var employeesN = namesN.split('~');
        var employeesO = namesO.split('~');
        var employeesP = namesP.split('~');
        var employeesQ = namesQ.split('~');
        var employeesR = namesR.split('~');
        var employeesS = namesS.split('~');
        var employeesT = namesT.split('~');
        var employeesU = namesU.split('~');
        var employeesV = namesV.split('~');
        var employeesW = namesW.split('~');
        var employeesX = namesX.split('~');
        var employeesY = namesY.split('~');
        var employeesZ = namesZ.split('~');

        var employees = [];

        employees = employees.concat(employeesA, employeesB, employeesC, employeesD, employeesE,
        employeesF, employeesG, employeesH, employeesI, employeesJ, employeesK,
        employeesL, employeesM, employeesN, employeesO, employeesP, employeesQ,
        employeesR, employeesS, employeesT, employeesU, employeesV, employeesW,
        employeesX, employeesY, employeesZ);

        /*
        $(".drop").autocomplete({
            source: employees
        });
        */

        if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType_0").is(":checked")) {
            $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name").autocomplete({
                source: employees
            });
        }

        if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType2_0").is(":checked")) {
            $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name2").autocomplete({
                source: employees
            });
        }

        if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType3_0").is(":checked")) {
            $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name3").autocomplete({
                source: employees
            });
        }

        if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType4_0").is(":checked")) {
            $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name4").autocomplete({
                source: employees
            });
        }

        if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType5_0").is(":checked")) {
            $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name5").autocomplete({
                source: employees
            });
        }

        if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType6_0").is(":checked")) {
            $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name6").autocomplete({
                source: employees
            });
        }

        if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType7_0").is(":checked")) {
            $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name7").autocomplete({
                source: employees
            });
        }

        if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType8_0").is(":checked")) {
            $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name8").autocomplete({
                source: employees
            });
        }

        if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType9_0").is(":checked")) {
            $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name9").autocomplete({
                source: employees
            });
        }

        if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType10_0").is(":checked")) {
            $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name10").autocomplete({
                source: employees
            });
        }
    });

    var numForms = 0;
    // Checks to see if the text is numeric.
    // If it is, it stays.
    // If not, anything non-numeric is removed
    function isNumeric(n, text) {
        if (!isNaN(parseFloat(n)) && isFinite(n) && parseFloat(n) > 0) {
            return true;
        } else {
            n = n.replace(/[^0-9-]+/, "");
            text.value = n;
            return false;
        }
    }
    
    // Formats the dollar amount in the textbox, adding a dollar sign
    // at the beginning,
    // and adds commas if the number exceeds 4 digits.
    // For example, 25 becomes $25.00
    // 100000 becomes $100,000.00
    // The number must be entered raw, or else it will not parse correctly
    // e.g. putting in the dollar sign directly will lead to a blank textbox.
    function formatMoney(text) {
        var x = text.value;
        if (isNumeric(x, text)) {
            var y = parseFloat(x).toFixed(2);
            y = numberWithCommas(y);
            document.getElementById("ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_amountLabel").innerHTML = "$" + y;
        }
    }

    // Formats the money when the user leaves the textbox
    function onBlur(text) {
        text.value = document.getElementById("ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_amountLabel").innerHTML;
        document.getElementById("ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_amountLabel").innerHTML = "";
    }

    // Gives a dollar amount commas.
    // For example, 1234567890 becomes 1,234,567,890
    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    // Programmatically adds an event listener to a JS object
    function addEvent(evnt, elem, func) {
        if (elem.addEventListener) {// W3C DOM
            elem.addEventListener(evnt, func, false);
        } else if (elem.attachEvent) { // IE DOM
            elem.attachEvent("on" + evnt, func);
        } else { // Not much to do
            elem["on" + evnt] = func;
        }
    }

    // Hides the "All Requests" pill by setting its CSS "visibility" property to "hidden".
    function hideAll() {
        var allButton = document.getElementById("allrequestsbutton");
        var canAccessAll = document.getElementById("ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_canAccessAll").innerHTML;

        if (canAccessAll == "F") {
            allButton.style.visibility = "hidden";
        }
    }

    // Opens the linked file in a new tab
    function openInNewTab() {
        window.document.forms[0].target = '_blank';
        setTimeout(function () {
            window.document.forms[0].target = ''; 
        }, 0);
    }

    // Unbinds and re-binds the datepicker functionality on the respective textboxes
    // and allows the recipient name textboxes to use the autocomplete functionality
    // if the "Yes" button on the "Is this recipient an employee?" button group is checked.
    function pageLoad() {
        $(".datepicker").unbind();
        var $j = jQuery.noConflict();
        $j(".datepicker").datepicker({
            minDate: 0
        });

        // Load all of the names into JavaScript
        var namesA = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesA").html();
        var namesB = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesB").html();
        var namesC = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesC").html();
        var namesD = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesD").html();
        var namesE = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesE").html();
        var namesF = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesF").html();
        var namesG = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesG").html();
        var namesH = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesH").html();
        var namesI = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesI").html();
        var namesJ = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesJ").html();
        var namesK = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesK").html();
        var namesL = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesL").html();
        var namesM = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesM").html();
        var namesN = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesN").html();
        var namesO = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesO").html();
        var namesP = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesP").html();
        var namesQ = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesQ").html();
        var namesR = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesR").html();
        var namesS = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesS").html();
        var namesT = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesT").html();
        var namesU = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesU").html();
        var namesV = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesV").html();
        var namesW = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesW").html();
        var namesX = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesX").html();
        var namesY = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesY").html();
        var namesZ = $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_employeesZ").html();

        // Make arrays of names
        var employeesA = namesA.split('~');
        var employeesB = namesB.split('~');
        var employeesC = namesC.split('~');
        var employeesD = namesD.split('~');
        var employeesE = namesE.split('~');
        var employeesF = namesF.split('~');
        var employeesG = namesG.split('~');
        var employeesH = namesH.split('~');
        var employeesI = namesI.split('~');
        var employeesJ = namesJ.split('~');
        var employeesK = namesK.split('~');
        var employeesL = namesL.split('~');
        var employeesM = namesM.split('~');
        var employeesN = namesN.split('~');
        var employeesO = namesO.split('~');
        var employeesP = namesP.split('~');
        var employeesQ = namesQ.split('~');
        var employeesR = namesR.split('~');
        var employeesS = namesS.split('~');
        var employeesT = namesT.split('~');
        var employeesU = namesU.split('~');
        var employeesV = namesV.split('~');
        var employeesW = namesW.split('~');
        var employeesX = namesX.split('~');
        var employeesY = namesY.split('~');
        var employeesZ = namesZ.split('~');

        var employees = [];

        // Combine the arrays into one
        employees = employees.concat(employeesA, employeesB, employeesC, employeesD, employeesE,
        employeesF, employeesG, employeesH, employeesI, employeesJ, employeesK,
        employeesL, employeesM, employeesN, employeesO, employeesP, employeesQ,
        employeesR, employeesS, employeesT, employeesU, employeesV, employeesW,
        employeesX, employeesY, employeesZ);

        // Unbind the event listeners
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name").unbind();
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name2").unbind();
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name3").unbind();
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name4").unbind();
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name5").unbind();
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name6").unbind();
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name7").unbind();
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name8").unbind();
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name9").unbind();
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name10").unbind();

        // Create an empty array for if the Yes button is unchecked
        var none = [];

        // The following functions will perform autocomplete only if the appropriate "Yes"
        // button is checked. If "No" is checked or if neither are checked, nothing will appear
        // as the user types.
        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name").keyup(function () {
            var $j = jQuery.noConflict();
            if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType_0").is(":checked")) {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name").autocomplete({
                    source: employees
                });
            } else {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name").autocomplete({
                    source: none
                });
            }
        });

        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name2").keyup(function () {
            var $k = jQuery.noConflict();
            if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType2_0").is(":checked")) {
                $k("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name2").autocomplete({
                    source: employees
                });
            } else {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name2").autocomplete({
                    source: none
                });
            }
        });

        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name3").keyup(function () {
            var $l = jQuery.noConflict();
            if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType3_0").is(":checked")) {
                $l("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name3").autocomplete({
                    source: employees
                });
            } else {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name3").autocomplete({
                    source: none
                });
            }
        });

        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name4").keyup(function () {
            var $m = jQuery.noConflict();
            if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType4_0").is(":checked")) {
                $m("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name4").autocomplete({
                    source: employees
                });
            } else {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name4").autocomplete({
                    source: none
                });
            }
        });

        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name5").keyup(function () {
            var $n = jQuery.noConflict();
            if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType5_0").is(":checked")) {
                $n("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name5").autocomplete({
                    source: employees
                });
            } else {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name5").autocomplete({
                    source: none
                });
            }
        });

        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name6").keyup(function () {
            var $o = jQuery.noConflict();
            if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType6_0").is(":checked")) {
                $o("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name6").autocomplete({
                    source: employees
                });
            } else {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name6").autocomplete({
                    source: none
                });
            }
        });

        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name7").keyup(function () {
            var $p = jQuery.noConflict();
            if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType7_0").is(":checked")) {
                $p("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name7").autocomplete({
                    source: employees
                });
            } else {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name7").autocomplete({
                    source: none
                });
            }
        });

        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name8").keyup(function () {
            var $q = jQuery.noConflict();
            if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType8_0").is(":checked")) {
                $q("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name8").autocomplete({
                    source: employees
                });
            } else {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name8").autocomplete({
                    source: none
                });
            }
        });

        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name9").keyup(function () {
            var $r = jQuery.noConflict();
            if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType9_0").is(":checked")) {
                $r("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name9").autocomplete({
                    source: employees
                });
            } else {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name9").autocomplete({
                    source: none
                });
            }
        });

        $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name10").keyup(function () {
            var $s = jQuery.noConflict();
            if ($("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_recipientType10_0").is(":checked")) {
                $s("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name10").autocomplete({
                    source: employees
                });
            } else {
                $j("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_name10").autocomplete({
                    source: none
                });
            }
        });
    }

    // These functions all open their respective links in a new tab
    // This functionality may not always work in Google Chrome.
    $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_mygrid_ctl08_layW9Link").click(function (event) {
        event.preventDefault();
        event.stopPropagation();
        window.open(this.href, "_blank");
    });

    $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_mygrid_ctl08_layApprovalLink").click(function (event) {
        event.preventDefault();
        event.stopPropagation();
        window.open(this.href, "_blank");
    });

    $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_allgrid_ctl08_adminW9Link").click(function (event) {
        event.preventDefault();
        event.stopPropagation();
        window.open(this.href, "_blank");
    });

    $("#ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_allgrid_ctl08_adminApprovalLink").click(function (event) {
        event.preventDefault();
        event.stopPropagation();
        window.open(this.href, "_blank");
    });

    // Enables scrolling on the body of the webpage
    // and hides the All Requests button for users who
    // do not have Full Control
    $(document).ready(function () {
        $('body').attr("scroll", "auto");

        hideAll();
    });

    // Auxiliary datepicker function
    $(function () {
        var $j = jQuery.noConflict();
        $j(".datepicker").datepicker({
            minDate: 0
        });
    });
    
    // Names for reference
    var textBox = "ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_amount";
    var hiddenLabel = "ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_amountLabel";

    var pattern = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/;

    // Checks to see if an email address is valid
    function isEmailAddress(str) {
        var pattern = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        return pattern.test(str);  // returns a boolean 
    }

    function getValue(dropDownList) {
        var value = dropDownList.options[dropDownList.selectedIndex].value;
        var label = document.getElementById("ctl00_ctl23_g_f43d11fc_789e_476f_800d_9295dda459d7_ctl00_choice");
        label.innerHTML = value;
    }
</script>
<!--

Project: Gift Card Form

Author: Ryan King

Date: August 16, 2019

Purpose: This file is the HTML for the Sharp Gift Card Request Form.
It contains 10 identical forms sectioned off in their own fieldsets, 
all of which can be filled out independently of one another. 

Only the first form is initially visible. The user needs to click
the "Another" button in order to show the next one in sequence.
This shows the second, the third, and so on, all the way up to the tenth.

The requester name and email address depend on the user, and are filled in
automatically when the user opens the form.

The Yes/No radio buttons that tell if the recipient is an employee will also 
determine if the person needs a W-9 submitted. This is required if the requester
is ordering $600 or more in gift cards for a non-employee in the current calendar year.
Employees' gift cards are handled through payroll, so they are exempt from this.
If the user uploads a W-9 anyway, it will be ignored.

The Yes/No radio buttons that tell if a recipient is an employee will also activate
an autocomplete function that takes employee names from a list in SharePoint.
This list will only be displayed if the "Yes" option is checked.

When uploading a file, it is important that the user chooses his/her file, and then
clicks the corresponding Upload button before proceeding. This will maintain the file
for submission into SharePoint and is critical for a successful submission.
If this button is not clicked, the user will have to choose
the file again and click the Upload button.

The Gift Card Amount field only allows numbers and decimal points to be typed in.
It expects the user to type in any positive number. Once the user
leaves the textbox, it will automatically format the number with
a dollar sign at the beginning, commas, and two trailing decimal places.
Zero and negative values will be deleted upon leaving.
Gift cards must have a minimum denomination of $10.00 and a maximum denomination of $1,000.00.

The Mailing Address section contains the parts found in a typical
American street address. The Apartment/Suite field is optional.

The Approval Document is always required. This follows the same rules
as the W-9, which is explained above.

The second through tenth forms all contain a "Clear" button,
which allows the user to clear and hide the form if s/he does not need it.

Upon clicking the Submit button, each form is validated
one at a time. Any errors that may occur will be reported
by ASP.NET CustomValidators in red, under their respective fields, in the sequence in which
they were detected. An additional warning will be
put into place at the bottom of the page near the Submit button
to alert the user if s/he did not see the prior warnings further up the page.

If there are no errors on a form, the results label
of it will simply read "Success!" in green.
The label at the bottom will also say, "All forms were submitted successfully".

All W-9s and approval documents will be automatically sent to
sharpgiftcard@sharpsec.com upon submission.

Each form has its own unique ID which is determined when it 
gets submitted. This is of the format YYYYMMDDHHMMSSII,
where YYYY represents the year,
MM represents the month (e.g. January would be 01 and October would be 10),
DD represents the day (with leading zeros as above),
HH represents the hours since midnight in 24-hour time (e.g. 1 o'clock P.M. would read as 13),
MM represents the minutes (again, padded with one leading zero if only one digit),
SS represents the seconds (padded, as with the rest of the numbers),
and II represents the index of the form (e.g. form 1 has index 01, form 2 has 02, and so on).
This field cannot be changed after the form is submitted, and is read-only, even on the All Requests grid in edit mode.

The top of the page uses dynamic pills to cleanly transition between different parts of the page.

The left pill is the one selected by default, and it represents the gift card form itself.
Any user can access this pill anytime.

The center pill is the My Requests pill, which allows any user to view his/her own forms.
The lay user will not be able to edit any information in this table.
The lay user can only see his/her own forms due to a hidden "Created By" field, which is not visible
on the regular table. This field is set depending on the current user, and is read-only.
All of a user's submissions are queried with this "Created By" field before they are added and displayed in the grid.

The right pill is the All Requests pill, which allows the Site Owner to view all forms of all users.
The owner also retains edit privileges, allowing him/her to change every field except for the Unique ID,
Timestamp, and Created By fields. They also have access to a secondary grid, which pertains to the ordering
and delivery of the gift cards. Both tables under the right pill are initially hidden, and can be shown or
hidden again by clicking the appropriate buttons.

Lay users (those who do not administer this form) will be able to submit any number of submissions, 10 at a time, and 
view all the forms they have submitted. The All Requests pill will never be visible at any time.

The Site Owner has all privileges of a lay user, but can also edit any submission as s/he sees fit and open and edit the additional grid for ordering purposes.

-->
<h1 style="text-align: center">Sharp Gift Card Request Form</h1>

<br />

<asp:Label ID="employeesA" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesB" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesC" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesD" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesE" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesF" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesG" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesH" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesI" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesJ" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesK" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesL" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesM" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesN" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesO" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesP" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesQ" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesR" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesS" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesT" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesU" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesV" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesW" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesX" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesY" class="invisible" runat="server"></asp:Label>
<asp:Label ID="employeesZ" class="invisible" runat="server"></asp:Label>

<div class="container">

  <ul class="nav nav-pills">
    <li class="active"><a data-toggle="pill" href="#home">Gift Card Form</a></li>
    <li><a data-toggle="pill" href="#menu1">My Requests</a></li>
    <li><a data-toggle="pill" id="allrequestsbutton" href="#menu2">All Requests</a></li>
  </ul>

    <div class="tab-content">
    <div id="home" class="tab-pane fade in active">
      <h3 class="pillheader header">Gift Card Form</h3>
        <p class="header">Please fill out all of the following information. Submissions not completed fully will result in a delay in receiving your gift card.
        All supporting documentation must be sent to <a href="mailto:sharpgiftcard@sharsec.com">sharpgiftcard@sharpsec.com</a></p>
        <br />

        <p class="footer fieldnote"><em><span class="required">*</span> denotes a required field.</em></p>
        <!--Beginning of huge update panel-->
        <!--Since this panel does not need a full postback for everything except submission and file uploads, I made all the addition
        and clearing form buttons asynchronous. This will ensure that file data is not erased.-->
        <asp:UpdatePanel runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
        
        <Triggers>
            <asp:PostBackTrigger ControlID="submit" />
            
            <asp:AsyncPostBackTrigger ControlID="btnAnother" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnClear2" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnClear3" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnClear4" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnClear5" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnClear6" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnClear7" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnClear8" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnClear9" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnClear10" EventName="Click" />

            <asp:AsyncPostBackTrigger ControlID="allgridTop" EventName="RowUpdating" />
            <asp:AsyncPostBackTrigger ControlID="allgridTop" EventName="RowDataBound" />
            <asp:AsyncPostBackTrigger ControlID="allgridTop" EventName="RowUpdating" />
            <asp:AsyncPostBackTrigger ControlID="allgridTop" EventName="RowCancelingEdit" />
            <asp:AsyncPostBackTrigger ControlID="allgridTop" EventName="RowDataBound" />

            <asp:AsyncPostBackTrigger ControlID="allgridBottom" EventName="RowUpdating" />
            <asp:AsyncPostBackTrigger ControlID="allgridBottom" EventName="RowDataBound" />
            <asp:AsyncPostBackTrigger ControlID="allgridBottom" EventName="RowUpdating" />
            <asp:AsyncPostBackTrigger ControlID="allgridBottom" EventName="RowCancelingEdit" />
            <asp:AsyncPostBackTrigger ControlID="allgridBottom" EventName="RowDataBound" />

            <asp:PostBackTrigger ControlID="w9Upload" />
            <asp:PostBackTrigger ControlID="approvalFileUpload" />
            <asp:PostBackTrigger ControlID="w92Upload" />
            <asp:PostBackTrigger ControlID="approvalFile2Upload" />
            <asp:PostBackTrigger ControlID="w93Upload" />
            <asp:PostBackTrigger ControlID="approvalFile3Upload" />
            <asp:PostBackTrigger ControlID="w94Upload" />
            <asp:PostBackTrigger ControlID="approvalFile4Upload" />
            <asp:PostBackTrigger ControlID="w95Upload" />
            <asp:PostBackTrigger ControlID="approvalFile5Upload" />
            <asp:PostBackTrigger ControlID="w96Upload" />
            <asp:PostBackTrigger ControlID="approvalFile6Upload" />
            <asp:PostBackTrigger ControlID="w97Upload" />
            <asp:PostBackTrigger ControlID="approvalFile7Upload" />
            <asp:PostBackTrigger ControlID="w98Upload" />
            <asp:PostBackTrigger ControlID="approvalFile8Upload" />
            <asp:PostBackTrigger ControlID="w99Upload" />
            <asp:PostBackTrigger ControlID="approvalFile9Upload" />
            <asp:PostBackTrigger ControlID="w910Upload" />
            <asp:PostBackTrigger ControlID="approvalFile10Upload" />
        </Triggers>

        <ContentTemplate>
        <!--The beginning of the first form. Unlike every other form, this form is always visible and will never disappear.
            The requester email address and name will be the same for all 10 forms, as is the hidden Created By field.-->
<span id="form1" runat="server">
        <span class="outer">
            <p class="subheader">Requester Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Email Address <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="email" class="text" runat="server" />
                    <br />
                    <asp:Label ID="created" class="invisible" runat="server"></asp:Label>
                    <asp:CustomValidator ID="cvEmail" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="email" OnServerValidate="cvEmail_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Requester <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="requester" class="text" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvRequester" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter an email address" ControlToValidate="requester" OnServerValidate="cvEmail_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
        </span>
        <!--End of requester information-->
        <br />
        <br />
        <br />
        <fieldset>
        <legend class="label legend">Form #1</legend>
        <span class="outer">
            <p class="subheader">Recipient Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Recipient Name <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="name" class="text drop" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvName" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="name" OnServerValidate="cvName_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
            <!--Determine if the recipient is an employee. This will be critical for validation on the submission of this form.-->
            <asp:Label class="label" runat="server">Is this recipient an employee? <span class="required" title="required">*</span></asp:Label>
            <asp:RadioButtonList ID="recipientType" class="radio text" runat="server">
                <asp:ListItem class="item" Text="Yes" Value="Yes" />
                <asp:ListItem class="item" Text="No" Value="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvRecipientType" class="validator" ValidateEmptyText="true" ErrorMessage="Please select Yes or No" ControlToValidate="recipientType" OnServerValidate="cvRecipientType_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <!--These fields are not marked as required because the recipient may or may not be an employee.-->
            <asp:Label class="label" runat="server">If the answer is Yes, please specify this employee’s branch:</asp:Label>
            <br />
            <asp:DropDownList ID="branch" class="text" runat="server">
                <asp:ListItem class="item" Value=""></asp:ListItem>
                <asp:ListItem class="item" Value="SBS">SBS</asp:ListItem>
                <asp:ListItem class="item" Value="SEC">SEC</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label class="label" runat="server">If the answer is No, please provide further details:</asp:Label>
            <br />
            <asp:TextBox id="otherRecipient" class="text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvOtherRecipient" class="validator" OnServerValidate="cvOtherRecipient_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />

            <!--Determines if this recipient needs a W-9. Not necessary for employees.-->
            <asp:Label class="label" runat="server">For Non-Employees: Has this recipient received $600 of total gift cards in one calendar year?</asp:Label>
            <asp:RadioButtonList ID="yesNo" class="radio top bottom" runat="server">
                <asp:ListItem class="item" value="Yes" Text="Yes (Please submit a W-9 to sharpgiftcard@sharpsec.com)" />
                <asp:ListItem class="item" value="No" Text="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvYesNo" class="validator" ErrorMessage="Please select if this recipient needs a W-9" OnServerValidate="cvYesNo_ServerValidate" runat="server"></asp:CustomValidator>
            <!--This field is not marked as required because the recipient may or may not be an employee. If it is required is determined automatically upon submission-->
            <br />
            <br />
            <asp:Label class="label" runat="server">For non-employees receiving $600 or more, please attach a W-9 and click <strong>Upload</strong> when finished:</asp:Label>
            <br />
            <br />
            <asp:FileUpload ID="w9" class="text" runat="server" />
            <br />
            <asp:Button ID="w9Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="w9Upload_Click" />
            <asp:Label ID="w9Outcome" Visible="false" class="label uploadOutcome successMessage" runat="server"></asp:Label>
            <!--These invisible labels will contain the filename, its content, and its URL for storage in SharePoint-->
            <asp:Label ID="w9Name" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w9Content" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w9Url" class="invisible" runat="server"></asp:Label>
            <br />
            <asp:CustomValidator ID="cvW9" ControlToValidate="w9" class="validator" ErrorMessage="Please upload a W-9" ValidateEmptyText="true" OnServerValidate="cvW9_ServerValidate" runat="server"></asp:CustomValidator>
        </span><!--End of recipient information-->
        <br />
        <br />
        <br />

        <span class="outer">
            <p class="subheader">Gift Card Information</p>
            <!--This invisible label contains the formatted amount for not only this amount textbox, but all other amount textboxes on the other 9 forms.-->
            <asp:Label id="amountLabel" class="invisible" runat="server"></asp:Label>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label for="amount" class="label" runat="server">Gift Card Amount (minimum $10, maximum $1,000) <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox ID="amount" class="text amount" onkeyup="formatMoney(this)" onblur="onBlur(this)" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvAmount" class="validator" ValidateEmptyText="true" ControlToValidate="amount" ErrorMessage="Please enter an amount between $10 and $1,000" OnServerValidate="cvAmount_ServerValidate" runat="server"></asp:CustomValidator>
                </span>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Type <span class="required" title="required" runat="server">*</span></asp:Label>

                    <asp:RadioButtonList class="radio" ID="giftCardType" runat="server">
                        <asp:ListItem class="item" Text="American Express" />
                        <asp:ListItem class="item" Text="Other" />
                    </asp:RadioButtonList>
                    <asp:TextBox ID="otherGiftCardType" class="text" runat="server"></asp:TextBox>
                    <br />
                    <asp:CustomValidator ID="cvGiftCardType" class="validator" ErrorMessage="Please select a gift card type" OnServerValidate="cvOtherGiftCardType_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>

            <br />
            <br />

            <asp:Label class="label" for="purpose" runat="server">Purpose of Gift (Please give a brief description) <span class="required" title="required">*</span></asp:Label>
            <br />         
            <!--This text area is used for larger descriptions than could span multiple lines-->
            <asp:TextBox id="purpose" class="text" runat="server" TextMode="MultiLine"></asp:TextBox><br />
            <asp:CustomValidator ID="cvPurpose" class="validator" ControlToValidate="purpose" ValidateEmptyText="true" ErrorMessage="Please enter a purpose" OnServerValidate="cvPurpose_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <span class="block">
            <!--The mailing address will be where this gift card is sent to be picked up-->
            <asp:Label class="subheader" runat="server">Mailing Address</asp:Label>
            <br />
            <br />
            <asp:Label class="label" runat="server">Street Address <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="streetAddress" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvStreetAddress" class="validator" ControlToValidate="streetAddress" ValidateEmptyText="true" ErrorMessage="Please enter a street address" OnServerValidate="cvStreetAddress_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">Apartment Number</asp:Label>
            <br />
            <asp:TextBox ID="aptNumber" class="text" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <br />
            <asp:Label class="label" runat="server">City <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="city" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvCity" class="validator" ControlToValidate="city" ValidateEmptyText="true" ErrorMessage="Please enter a city" OnServerValidate="cvCity_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">State <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="state" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvState" class="validator" ControlToValidate="state" ValidateEmptyText="true" ErrorMessage="Please enter a state" OnServerValidate="cvAmount_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">ZIP Code <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="zipCode" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvZipCode" class="validator" ControlToValidate="zipCode" ValidateEmptyText="true" ErrorMessage="Please enter a ZIP code" OnServerValidate="cvAmount_ServerValidate" runat="server"></asp:CustomValidator>
            </span>
        </span>

        <br />
        <br />
        <br />
        <span class="outer">
              <p class="subheader">Approval Information</p>
              <asp:Label class="label" title="required" runat="server">Approved By <span class="required">*</span></asp:Label>

                <!--All gift cards require an approval document of some kind, as well as knowledge of who approved it.-->
                <asp:RadioButtonList ID="approval" class="radio top" runat="server">
                    <asp:ListItem class="item" Value="SBS" Text="SBS - Paul Malatesta or Steve Orander (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="SEC" Text="SEC (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="Other" Text="Other (Please specify):"/>       
                </asp:RadioButtonList>
                <!--Any approval credentials that are not the same as above-->
                <br />
                <asp:TextBox id="otherApprovalText" class="text" runat="server" />
                <br />
                <asp:CustomValidator ID="cvOtherApprovalText" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter valid approval credentials" OnServerValidate="cvOtherApprovalText_ServerValidate" runat="server"></asp:CustomValidator>
                <br />
                <br />
                <asp:Label class="label" runat="server">Please attach an approval document here and click <strong>Upload</strong> when finished: <span class="required" title="required">*</span></asp:Label>
                <br />
                <br />
                <!--Upload the approval file here-->
                <asp:FileUpload ID="approvalFile" class="text" runat="server" />
                <br />
                <!--Invisible labels which will contain the filename, content, and URL-->
                <asp:Button ID="approvalFileUpload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="approvalFileUpload_Click" />
                <asp:Label ID="approvalFileOutcome" Visible="false" class="uploadOutcome label successMessage" runat="server">File uploaded successfully!</asp:Label>
                <asp:Label ID="approvalFileName" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFileContent" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFileUrl" class="invisible" runat="server"></asp:Label> 
                <br />
                <asp:CustomValidator Display="Dynamic" ID="cvApprovalFile" ControlToValidate="approvalFile" class="validator" ValidateEmptyText="true" ErrorMessage="Please upload an approval document" OnServerValidate="cvApprovalFile_ServerValidate" runat="server"></asp:CustomValidator>              
                <br />

            <br />
            <!--This date contains a JQuery datepicker and is validated on submission-->
            <asp:Label class="label" runat="server">Date Needed By <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="date" class="datepicker text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvDate" class="validator" ControlToValidate="date" ValidateEmptyText="true" ErrorMessage="Please enter a date at least four business days away" OnServerValidate="cvDate_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
        </span>
        <asp:Label ID="outcome" class="uploadOutcome required" Visible="false" runat="server"></asp:Label>
        <br />

    </fieldset>
    <br />
    <br />
</span><!--Actual end of form 1-->   
<!--Forms 2 through 10 are set invisible by default and can only be seen by clicking the "Another" button.
They appear in sequence. All forms can be filled out independently of one another.-->
<span id="form2" Visible="false" runat="server">
    <fieldset>
        <legend class="label legend">Form #2</legend>
        <span class="outer">
            <p class="subheader">Recipient Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Recipient Name <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="name2" class="text drop" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvName2" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="name2" OnServerValidate="cvName2_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
            <!--Determine if the recipient is an employee. This will be critical for validation on the submission of this form.-->
            <asp:Label class="label" runat="server">Is this recipient an employee? <span class="required" title="required">*</span></asp:Label>
            <asp:RadioButtonList ID="recipientType2" class="radio text" runat="server">
                <asp:ListItem class="item" Text="Yes" Value="Yes" />
                <asp:ListItem class="item" Text="No" Value="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvRecipientType2" class="validator" ValidateEmptyText="true" ErrorMessage="Please select Yes or No" ControlToValidate="recipientType2" OnServerValidate="cvRecipientType2_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <!--This field is not marked as required because the recipient may or may not be an employee.-->
            <asp:Label class="label" runat="server">If the answer is Yes, please specify this employee’s branch:</asp:Label>
            <br />
            <asp:DropDownList ID="branch2" class="text" runat="server">
                <asp:ListItem class="item" Value=""></asp:ListItem>
                <asp:ListItem class="item" Value="SBS">SBS</asp:ListItem>
                <asp:ListItem class="item" Value="SEC">SEC</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label class="label" runat="server">If the answer is No, please provide further details:</asp:Label>
            <br />
            <asp:TextBox id="otherRecipient2" class="text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvOtherRecipient2" class="validator" OnServerValidate="cvOtherRecipient2_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />

            <!--Determines if this recipient needs a W-9. Not necessary for employees.-->
            <asp:Label class="label" runat="server">For Non-Employees: Has this recipient received $600 of total gift cards in one calendar year?</asp:Label>
            <asp:RadioButtonList ID="yesNo2" class="radio top bottom" runat="server">
                <asp:ListItem class="item" value="Yes" Text="Yes (Please submit a W-9 to sharpgiftcard@sharpsec.com)" />
                <asp:ListItem class="item" value="No" Text="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvYesNo2" class="validator" ErrorMessage="Please select if this recipient needs a W-9" OnServerValidate="cvYesNo2_ServerValidate" runat="server"></asp:CustomValidator>
            <!--This field is not marked as required because the recipient may or may not be an employee. If it is required is determined automatically upon submission-->
            <br />
            <br />
            <asp:Label class="label" runat="server">For non-employees receiving $600 or more, please attach a W-9 and click <strong>Upload</strong> when finished:</asp:Label>
            <br />
            <br />
            <asp:FileUpload ID="w92" class="text" runat="server" />
            <br />
            <asp:Button ID="w92Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="w92Upload_Click" />
            <asp:Label ID="w92Outcome" Visible="false" class="label uploadOutcome successMessage" runat="server"></asp:Label>
            <!--These invisible labels will contain the filename, its content, and its URL for storage in SharePoint-->
            <asp:Label ID="w92Name" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w92Content" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w92Url" class="invisible" runat="server"></asp:Label>
            <br />
            <asp:CustomValidator ID="cvW92" class="validator" ErrorMessage="Please upload a W-9" ValidateEmptyText="true" OnServerValidate="cvW92_ServerValidate" runat="server"></asp:CustomValidator>
        </span><!--End of recipient information-->
        <br />
        <br />
        <br />

        <span class="outer">
            <p class="subheader">Gift Card Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Amount (minimum $10, maximum $1,000) <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox ID="amount2" class="text amount" onkeyup="formatMoney(this)" onblur="onBlur(this)" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvAmount2" class="validator" ValidateEmptyText="true" ControlToValidate="amount2" ErrorMessage="Please enter an amount between $10 and $1,000" OnServerValidate="cvAmount2_ServerValidate" runat="server"></asp:CustomValidator>
                </span>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Type <span id="Span1" class="required" title="required" runat="server">*</span></asp:Label>

                    <asp:RadioButtonList class="radio" ID="giftCardType2" runat="server">
                        <asp:ListItem class="item" Text="American Express" />
                        <asp:ListItem class="item" Text="Other" />
                    </asp:RadioButtonList>
                    <asp:TextBox ID="otherGiftCardType2" class="text" runat="server"></asp:TextBox>
                    <br />
                    <asp:CustomValidator ID="cvGiftCardType2" class="validator" ErrorMessage="Please select a gift card type" OnServerValidate="cvOtherGiftCardType2_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>

            <br />
            <br />

            <asp:Label class="label" runat="server">Purpose of Gift (Please give a brief description) <span class="required" title="required">*</span></asp:Label>
            <br />         
            <!--This text area is used for larger descriptions than could span multiple lines-->
            <asp:TextBox id="purpose2" class="text" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvPurpose2" class="validator" ControlToValidate="purpose2" ValidateEmptyText="true" ErrorMessage="Please enter a purpose" OnServerValidate="cvPurpose2_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <span class="block">
            <!--The mailing address will be where this gift card is sent to be picked up-->
            <asp:Label class="subheader" runat="server">Mailing Address</asp:Label>
            <br />
            <br />
            <asp:Label class="label" runat="server">Street Address <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="streetAddress2" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvStreetAddress2" class="validator" ControlToValidate="streetAddress2" ValidateEmptyText="true" ErrorMessage="Please enter a street address" OnServerValidate="cvStreetAddress2_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">Apartment Number</asp:Label>
            <br />
            <asp:TextBox ID="aptNumber2" class="text" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <br />
            <asp:Label class="label" runat="server">City <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="city2" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvCity2" class="validator" ControlToValidate="city" ValidateEmptyText="true" ErrorMessage="Please enter a city" OnServerValidate="cvCity2_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">State <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="state2" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvState2" class="validator" ControlToValidate="state" ValidateEmptyText="true" ErrorMessage="Please enter a state" OnServerValidate="cvState2_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">ZIP Code <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="zipCode2" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvZipCode2" class="validator" ControlToValidate="zipCode2" ValidateEmptyText="true" ErrorMessage="Please enter a ZIP code" OnServerValidate="cvZipCode2_ServerValidate" runat="server"></asp:CustomValidator>
            </span>
        </span>

        <br />
        <br />
        <br />
        <span class="outer">
              <p class="subheader">Approval Information</p>
              <asp:Label class="label" title="required" runat="server">Approved By <span class="required">*</span></asp:Label>

                <!--All gift cards require an approval document of some kind, as well as knowledge of who approved it.-->
                <asp:RadioButtonList ID="approval2" class="radio top" runat="server">
                    <asp:ListItem class="item" Value="SBS" Text="SBS - Paul Malatesta or Steve Orander (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="SEC" Text="SEC (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="Other" Text="Other (Please specify):"/>       
                </asp:RadioButtonList>
                <!--Any approval credentials that are not the same as above-->
                <br />
                <asp:TextBox id="otherApprovalText2" class="text" runat="server" />
                <br />
                <asp:CustomValidator ID="cvOtherApprovalText2" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter valid approval credentials" OnServerValidate="cvOtherApprovalText2_ServerValidate" runat="server"></asp:CustomValidator>
                <br />
                <br />
                <asp:Label class="label" runat="server">Please attach an approval document here and click <strong>Upload</strong> when finished: <span class="required" title="required">*</span></asp:Label>
                <br />
                <br />
                <!--Upload the approval file here-->
                <asp:FileUpload ID="approvalFile2" class="text" runat="server" />
                <br />
                <!--Invisible labels which will contain the filename, content, and URL-->
                <asp:Button ID="approvalFile2Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="approvalFile2Upload_Click" />
                <asp:Label ID="approvalFile2Outcome" Visible="false" class="uploadOutcome label successMessage" runat="server">File uploaded successfully!</asp:Label>
                <asp:Label ID="approvalFile2Name" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile2Content" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile2Url" class="invisible" runat="server"></asp:Label> 
                <br />
                <asp:CustomValidator ID="cvApprovalFile2" class="validator" Display="Dynamic" ValidateEmptyText="true" ErrorMessage="Please upload an approval document" OnServerValidate="cvApprovalFile2_ServerValidate" runat="server"></asp:CustomValidator>              
                <br />

            <br />
            <!--This date contains a JQuery datepicker and is validated on submission-->
            <asp:Label class="label" runat="server">Date Needed By <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="date2" class="datepicker text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvDate2" class="validator" ControlToValidate="date" ValidateEmptyText="true" ErrorMessage="Please enter a date at least four business days away" OnServerValidate="cvDate2_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
        </span>
        <asp:Label ID="outcome2" class="uploadOutcome required" Visible="false" runat="server"></asp:Label>
        <br />
        <asp:Button CssClass="btnSubmit upload" ID="btnClear2" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear2_Click" />
    </fieldset>
    <br />
    <br />
</span>

<span id="form3" Visible="false" runat="server">
    <fieldset>
        <legend class="label legend">Form #3</legend>
        <span class="outer">
            <p class="subheader">Recipient Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Recipient Name <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="name3" class="text drop" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvName3" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="name3" OnServerValidate="cvName3_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
            <!--Determine if the recipient is an employee. This will be critical for validation on the submission of this form.-->
            <asp:Label class="label" runat="server">Is this recipient an employee? <span class="required" title="required">*</span></asp:Label>
            <asp:RadioButtonList ID="recipientType3" class="radio text" runat="server">
                <asp:ListItem class="item" Text="Yes" Value="Yes" />
                <asp:ListItem class="item" Text="No" Value="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvRecipientType3" class="validator" ValidateEmptyText="true" ErrorMessage="Please select Yes or No" ControlToValidate="recipientType3" OnServerValidate="cvRecipientType3_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <!--This field is not marked as required because the recipient may or may not be an employee.-->
            <asp:Label class="label" runat="server">If the answer is Yes, please specify this employee’s branch:</asp:Label>
            <br />
            <asp:DropDownList ID="branch3" class="text" runat="server">
                <asp:ListItem class="item" Value=""></asp:ListItem>
                <asp:ListItem class="item" Value="SBS">SBS</asp:ListItem>
                <asp:ListItem class="item" Value="SEC">SEC</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label class="label" runat="server">If the answer is No, please provide further details:</asp:Label>
            <br />
            <asp:TextBox id="otherRecipient3" class="text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvOtherRecipient3" class="validator" OnServerValidate="cvOtherRecipient3_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />

            <!--Determines if this recipient needs a W-9. Not necessary for employees.-->
            <asp:Label class="label" runat="server">For Non-Employees: Has this recipient received $600 of total gift cards in one calendar year?</asp:Label>
            <asp:RadioButtonList ID="yesNo3" class="radio top bottom" runat="server">
                <asp:ListItem class="item" value="Yes" Text="Yes (Please submit a W-9 to sharpgiftcard@sharpsec.com)" />
                <asp:ListItem class="item" value="No" Text="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvYesNo3" class="validator" ErrorMessage="Please select if this recipient needs a W-9" OnServerValidate="cvYesNo3_ServerValidate" runat="server"></asp:CustomValidator>
            <!--This field is not marked as required because the recipient may or may not be an employee. If it is required is determined automatically upon submission-->
            <br />
            <br />
            <asp:Label class="label" runat="server">For non-employees receiving $600 or more, please attach a W-9 and click <strong>Upload</strong> when finished:</asp:Label>
            <br />
            <br />
            <asp:FileUpload ID="w93" class="text" runat="server" />
            <br />
            <asp:Button ID="w93Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="w93Upload_Click" />
            <asp:Label ID="w93Outcome" Visible="false" class="label uploadOutcome successMessage" runat="server"></asp:Label>
            <!--These invisible labels will contain the filename, its content, and its URL for storage in SharePoint-->
            <asp:Label ID="w93Name" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w93Content" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w93Url" class="invisible" runat="server"></asp:Label>
            <br />
            <asp:CustomValidator ID="cvW93" class="validator" ErrorMessage="Please upload a W-9" ValidateEmptyText="true" OnServerValidate="cvW93_ServerValidate" runat="server"></asp:CustomValidator>
        </span><!--End of recipient information-->
        <br />
        <br />
        <br />

        <span class="outer">
            <p class="subheader">Gift Card Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Amount (minimum $10, maximum $1,000) <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox ID="amount3" class="text amount" onkeyup="formatMoney(this)" onblur="onBlur(this)" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvAmount3" class="validator" ValidateEmptyText="true" ControlToValidate="amount3" ErrorMessage="Please enter an amount between $10 and $1,000" OnServerValidate="cvAmount3_ServerValidate" runat="server"></asp:CustomValidator>
                </span>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Type <span id="Span2" class="required" title="required" runat="server">*</span></asp:Label>

                    <asp:RadioButtonList class="radio" ID="giftCardType3" runat="server">
                        <asp:ListItem class="item" Text="American Express" />
                        <asp:ListItem class="item" Text="Other" />
                    </asp:RadioButtonList>
                    <asp:TextBox ID="otherGiftCardType3" class="text" runat="server"></asp:TextBox>
                    <br />
                    <asp:CustomValidator ID="cvGiftCardType3" class="validator" ErrorMessage="Please select a gift card type" OnServerValidate="cvOtherGiftCardType3_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>

            <br />
            <br />

            <asp:Label class="label" runat="server">Purpose of Gift (Please give a brief description) <span class="required" title="required">*</span></asp:Label>
            <br />         
            <!--This text area is used for larger descriptions than could span multiple lines-->
            <asp:TextBox id="purpose3" class="text" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvPurpose3" class="validator" ControlToValidate="purpose3" ValidateEmptyText="true" ErrorMessage="Please enter a purpose" OnServerValidate="cvPurpose3_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <span class="block">
            <!--The mailing address will be where this gift card is sent to be picked up-->
            <asp:Label class="subheader" runat="server">Mailing Address</asp:Label>
            <br />
            <br />
            <asp:Label class="label" runat="server">Street Address <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="streetAddress3" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvStreetAddress3" class="validator" ControlToValidate="streetAddress3" ValidateEmptyText="true" ErrorMessage="Please enter a street address" OnServerValidate="cvStreetAddress3_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">Apartment Number</asp:Label>
            <br />
            <asp:TextBox ID="aptNumber3" class="text" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <br />
            <asp:Label class="label" runat="server">City <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="city3" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvCity3" class="validator" ControlToValidate="city" ValidateEmptyText="true" ErrorMessage="Please enter a city" OnServerValidate="cvCity3_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">State <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="state3" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvState3" class="validator" ControlToValidate="state" ValidateEmptyText="true" ErrorMessage="Please enter a state" OnServerValidate="cvState3_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">ZIP Code <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="zipCode3" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvZipCode3" class="validator" ControlToValidate="zipCode3" ValidateEmptyText="true" ErrorMessage="Please enter a ZIP code" OnServerValidate="cvZipCode3_ServerValidate" runat="server"></asp:CustomValidator>
            </span>
        </span>

        <br />
        <br />
        <br />
        <span class="outer">
              <p class="subheader">Approval Information</p>
              <asp:Label class="label" title="required" runat="server">Approved By <span class="required">*</span></asp:Label>

                <!--All gift cards require an approval document of some kind, as well as knowledge of who approved it.-->
                <asp:RadioButtonList ID="approval3" class="radio top" runat="server">
                    <asp:ListItem class="item" Value="SBS" Text="SBS - Paul Malatesta or Steve Orander (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="SEC" Text="SEC (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="Other" Text="Other (Please specify):"/>       
                </asp:RadioButtonList>
                <!--Any approval credentials that are not the same as above-->
                <br />
                <asp:TextBox id="otherApprovalText3" class="text" runat="server" />
                <br />
                <asp:CustomValidator ID="cvOtherApprovalText3" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter valid approval credentials" OnServerValidate="cvOtherApprovalText3_ServerValidate" runat="server"></asp:CustomValidator>
                <br />
                <br />
                <asp:Label class="label" runat="server">Please attach an approval document here and click <strong>Upload</strong> when finished: <span class="required" title="required">*</span></asp:Label>
                <br />
                <br />
                <!--Upload the approval file here-->
                <asp:FileUpload ID="approvalFile3" class="text" runat="server" />
                <br />
                <!--Invisible labels which will contain the filename, content, and URL-->
                <asp:Button ID="approvalFile3Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="approvalFile3Upload_Click" />
                <asp:Label ID="approvalFile3Outcome" Visible="false" class="uploadOutcome label successMessage" runat="server">File uploaded successfully!</asp:Label>
                <asp:Label ID="approvalFile3Name" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile3Content" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile3Url" class="invisible" runat="server"></asp:Label> 
                <br />
                <asp:CustomValidator ID="cvApprovalFile3" class="validator" Display="Dynamic" ValidateEmptyText="true" ErrorMessage="Please upload an approval document" OnServerValidate="cvApprovalFile3_ServerValidate" runat="server"></asp:CustomValidator>              
                <br />

            <br />
            <!--This date contains a JQuery datepicker and is validated on submission-->
            <asp:Label class="label" runat="server">Date Needed By <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="date3" class="datepicker text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvDate3" class="validator" ControlToValidate="date" ValidateEmptyText="true" ErrorMessage="Please enter a date at least four business days away" OnServerValidate="cvDate3_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
        </span>
        <asp:Label ID="outcome3" class="uploadOutcome required" Visible="false" runat="server"></asp:Label>
        <br />
        <asp:Button CssClass="btnSubmit upload" ID="btnClear3" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear3_Click" />
    </fieldset>
    <br />
    <br />
</span>

<span id="form4" Visible="false" runat="server">
    <fieldset>
        <legend class="label legend">Form #4</legend>
        <span class="outer">
            <p class="subheader">Recipient Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Recipient Name <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="name4" class="text drop" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvName4" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="name4" OnServerValidate="cvName4_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
            <!--Determine if the recipient is an employee. This will be critical for validation on the submission of this form.-->
            <asp:Label class="label" runat="server">Is this recipient an employee? <span class="required" title="required">*</span></asp:Label>
            <asp:RadioButtonList ID="recipientType4" class="radio text" runat="server">
                <asp:ListItem class="item" Text="Yes" Value="Yes" />
                <asp:ListItem class="item" Text="No" Value="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvRecipientType4" class="validator" ValidateEmptyText="true" ErrorMessage="Please select Yes or No" ControlToValidate="recipientType4" OnServerValidate="cvRecipientType4_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <!--This field is not marked as required because the recipient may or may not be an employee.-->
            <asp:Label class="label" runat="server">If the answer is Yes, please specify this employee’s branch:</asp:Label>
            <br />
            <asp:DropDownList ID="branch4" class="text" runat="server">
                <asp:ListItem class="item" Value=""></asp:ListItem>
                <asp:ListItem class="item" Value="SBS">SBS</asp:ListItem>
                <asp:ListItem class="item" Value="SEC">SEC</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label class="label" runat="server">If the answer is No, please provide further details:</asp:Label>
            <br />
            <asp:TextBox id="otherRecipient4" class="text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvOtherRecipient4" class="validator" OnServerValidate="cvOtherRecipient4_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />

            <!--Determines if this recipient needs a W-9. Not necessary for employees.-->
            <asp:Label class="label" runat="server">For Non-Employees: Has this recipient received $600 of total gift cards in one calendar year?</asp:Label>
            <asp:RadioButtonList ID="yesNo4" class="radio top bottom" runat="server">
                <asp:ListItem class="item" value="Yes" Text="Yes (Please submit a W-9 to sharpgiftcard@sharpsec.com)" />
                <asp:ListItem class="item" value="No" Text="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvYesNo4" class="validator" ErrorMessage="Please select if this recipient needs a W-9" OnServerValidate="cvYesNo4_ServerValidate" runat="server"></asp:CustomValidator>
            <!--This field is not marked as required because the recipient may or may not be an employee. If it is required is determined automatically upon submission-->
            <br />
            <br />
            <asp:Label class="label" runat="server">For non-employees receiving $600 or more, please attach a W-9 and click <strong>Upload</strong> when finished:</asp:Label>
            <br />
            <br />
            <asp:FileUpload ID="w94" class="text" runat="server" />
            <br />
            <asp:Button ID="w94Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="w94Upload_Click" />
            <asp:Label ID="w94Outcome" Visible="false" class="label uploadOutcome successMessage" runat="server"></asp:Label>
            <!--These invisible labels will contain the filename, its content, and its URL for storage in SharePoint-->
            <asp:Label ID="w94Name" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w94Content" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w94Url" class="invisible" runat="server"></asp:Label>
            <br />
            <asp:CustomValidator ID="cvW94" class="validator" ErrorMessage="Please upload a W-9" ValidateEmptyText="true" OnServerValidate="cvW94_ServerValidate" runat="server"></asp:CustomValidator>
        </span><!--End of recipient information-->
        <br />
        <br />
        <br />

        <span class="outer">
            <p class="subheader">Gift Card Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Amount (minimum $10, maximum $1,000) <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox ID="amount4" class="text amount" onkeyup="formatMoney(this)" onblur="onBlur(this)" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvAmount4" class="validator" ValidateEmptyText="true" ControlToValidate="amount4" ErrorMessage="Please enter an amount between $10 and $1,000" OnServerValidate="cvAmount4_ServerValidate" runat="server"></asp:CustomValidator>
                </span>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Type <span id="Span3" class="required" title="required" runat="server">*</span></asp:Label>

                    <asp:RadioButtonList class="radio" ID="giftCardType4" runat="server">
                        <asp:ListItem class="item" Text="American Express" />
                        <asp:ListItem class="item" Text="Other" />
                    </asp:RadioButtonList>
                    <asp:TextBox ID="otherGiftCardType4" class="text" runat="server"></asp:TextBox><br />
                    <asp:CustomValidator ID="cvGiftCardType4" class="validator" ErrorMessage="Please select a gift card type" OnServerValidate="cvOtherGiftCardType4_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>

            <br />
            <br />

            <asp:Label class="label" runat="server">Purpose of Gift (Please give a brief description) <span class="required" title="required">*</span></asp:Label>
            <br />         
            <!--This text area is used for larger descriptions than could span multiple lines-->
            <asp:TextBox id="purpose4" class="text" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvPurpose4" class="validator" ControlToValidate="purpose4" ValidateEmptyText="true" ErrorMessage="Please enter a purpose" OnServerValidate="cvPurpose4_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <span class="block">
            <!--The mailing address will be where this gift card is sent to be picked up-->
            <asp:Label class="subheader" runat="server">Mailing Address</asp:Label>
            <br />
            <br />
            <asp:Label class="label" runat="server">Street Address <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="streetAddress4" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvStreetAddress4" class="validator" ControlToValidate="streetAddress4" ValidateEmptyText="true" ErrorMessage="Please enter a street address" OnServerValidate="cvStreetAddress4_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">Apartment Number</asp:Label>
            <br />
            <asp:TextBox ID="aptNumber4" class="text" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <br />
            <asp:Label class="label" runat="server">City <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="city4" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvCity4" class="validator" ControlToValidate="city" ValidateEmptyText="true" ErrorMessage="Please enter a city" OnServerValidate="cvCity4_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">State <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="state4" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvState4" class="validator" ControlToValidate="state" ValidateEmptyText="true" ErrorMessage="Please enter a state" OnServerValidate="cvState4_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">ZIP Code <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="zipCode4" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvZipCode4" class="validator" ControlToValidate="zipCode4" ValidateEmptyText="true" ErrorMessage="Please enter a ZIP code" OnServerValidate="cvZipCode4_ServerValidate" runat="server"></asp:CustomValidator>
            </span>
        </span>

        <br />
        <br />
        <br />
        <span class="outer">
              <p class="subheader">Approval Information</p>
              <asp:Label class="label" title="required" runat="server">Approved By <span class="required">*</span></asp:Label>

                <!--All gift cards require an approval document of some kind, as well as knowledge of who approved it.-->
                <asp:RadioButtonList ID="approval4" class="radio top" runat="server">
                    <asp:ListItem class="item" Value="SBS" Text="SBS - Paul Malatesta or Steve Orander (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="SEC" Text="SEC (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="Other" Text="Other (Please specify):"/>       
                </asp:RadioButtonList>
                <!--Any approval credentials that are not the same as above-->
                <br />
                <asp:TextBox ID="otherApprovalText4" class="text" runat="server" />
                <br />
                <asp:CustomValidator ID="cvOtherApprovalText4" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter valid approval credentials" OnServerValidate="cvOtherApprovalText4_ServerValidate" runat="server"></asp:CustomValidator>
                <br />
                <br />
                <asp:Label class="label" runat="server">Please attach an approval document here and click <strong>Upload</strong> when finished: <span class="required" title="required">*</span></asp:Label>
                <br />
                <br />
                <!--Upload the approval file here-->
                <asp:FileUpload ID="approvalFile4" class="text" runat="server" />
                <br />
                <!--Invisible labels which will contain the filename, content, and URL-->
                <asp:Button ID="approvalFile4Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="approvalFile4Upload_Click" />
                <asp:Label ID="approvalFile4Outcome" Visible="false" class="uploadOutcome label successMessage" runat="server">File uploaded successfully!</asp:Label>
                <asp:Label ID="approvalFile4Name" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile4Content" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile4Url" class="invisible" runat="server"></asp:Label> 
                <br />
                <asp:CustomValidator ID="cvApprovalFile4" class="validator" Display="Dynamic" ValidateEmptyText="true" ErrorMessage="Please upload an approval document" OnServerValidate="cvApprovalFile4_ServerValidate" runat="server"></asp:CustomValidator>              
                <br />

            <br />
            <!--This date contains a JQuery datepicker and is validated on submission-->
            <asp:Label class="label" runat="server">Date Needed By <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="date4" class="datepicker text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvDate4" class="validator" ControlToValidate="date" ValidateEmptyText="true" ErrorMessage="Please enter a date at least four business days away" OnServerValidate="cvDate4_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
        </span>
        <asp:Label ID="outcome4" class="uploadOutcome required" Visible="false" runat="server"></asp:Label>
        <br />
        <asp:Button CssClass="btnSubmit upload" ID="btnClear4" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear4_Click" />
    </fieldset>
    <br />
    <br />
</span>

<span id="form5" Visible="false" runat="server">
    <fieldset>
        <legend class="label legend">Form #5</legend>
        <span class="outer">
            <p class="subheader">Recipient Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Recipient Name <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="name5" class="text drop" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvName5" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="name5" OnServerValidate="cvName5_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
            <!--Determine if the recipient is an employee. This will be critical for validation on the submission of this form.-->
            <asp:Label class="label" runat="server">Is this recipient an employee? <span class="required" title="required">*</span></asp:Label>
            <asp:RadioButtonList ID="recipientType5" class="radio text" runat="server">
                <asp:ListItem class="item" Text="Yes" Value="Yes" />
                <asp:ListItem class="item" Text="No" Value="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvRecipientType5" class="validator" ValidateEmptyText="true" ErrorMessage="Please select Yes or No" ControlToValidate="recipientType5" OnServerValidate="cvRecipientType5_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <!--This field is not marked as required because the recipient may or may not be an employee.-->
            <asp:Label class="label" runat="server">If the answer is Yes, please specify this employee’s branch:</asp:Label>
            <br />
            <asp:DropDownList ID="branch5" class="text" runat="server">
                <asp:ListItem class="item" Value=""></asp:ListItem>
                <asp:ListItem class="item" Value="SBS">SBS</asp:ListItem>
                <asp:ListItem class="item" Value="SEC">SEC</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label class="label" runat="server">If the answer is No, please provide further details:</asp:Label>
            <br />
            <asp:TextBox id="otherRecipient5" class="text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvOtherRecipient5" class="validator" OnServerValidate="cvOtherRecipient5_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />

            <!--Determines if this recipient needs a W-9. Not necessary for employees.-->
            <asp:Label class="label" runat="server">For Non-Employees: Has this recipient received $600 of total gift cards in one calendar year?</asp:Label>
            <asp:RadioButtonList ID="yesNo5" class="radio top bottom" runat="server">
                <asp:ListItem class="item" value="Yes" Text="Yes (Please submit a W-9 to sharpgiftcard@sharpsec.com)" />
                <asp:ListItem class="item" value="No" Text="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvYesNo5" class="validator" ErrorMessage="Please select if this recipient needs a W-9" OnServerValidate="cvYesNo5_ServerValidate" runat="server"></asp:CustomValidator>
            <!--This field is not marked as required because the recipient may or may not be an employee. If it is required is determined automatically upon submission-->
            <br />
            <br />
            <asp:Label class="label" runat="server">For non-employees receiving $600 or more, please attach a W-9 and click <strong>Upload</strong> when finished:</asp:Label>
            <br />
            <br />
            <asp:FileUpload ID="w95" class="text" runat="server" />
            <br />
            <asp:Button ID="w95Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="w95Upload_Click" />
            <asp:Label ID="w95Outcome" Visible="false" class="label uploadOutcome successMessage" runat="server"></asp:Label>
            <!--These invisible labels will contain the filename, its content, and its URL for storage in SharePoint-->
            <asp:Label ID="w95Name" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w95Content" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w95Url" class="invisible" runat="server"></asp:Label>
            <br />
            <asp:CustomValidator ID="cvW95" class="validator" ErrorMessage="Please upload a W-9" ValidateEmptyText="true" OnServerValidate="cvW95_ServerValidate" runat="server"></asp:CustomValidator>
        </span><!--End of recipient information-->
        <br />
        <br />
        <br />

        <span class="outer">
            <p class="subheader">Gift Card Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Amount (minimum $10, maximum $1,000) <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox ID="amount5" class="text amount" onkeyup="formatMoney(this)" onblur="onBlur(this)" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvAmount5" class="validator" ValidateEmptyText="true" ControlToValidate="amount5" ErrorMessage="Please enter an amount between $10 and $1,000" OnServerValidate="cvAmount5_ServerValidate" runat="server"></asp:CustomValidator>
                </span>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Type <span id="Span4" class="required" title="required" runat="server">*</span></asp:Label>

                    <asp:RadioButtonList class="radio" ID="giftCardType5" runat="server">
                        <asp:ListItem class="item" Text="American Express" />
                        <asp:ListItem class="item" Text="Other" />
                    </asp:RadioButtonList>
                    <asp:TextBox ID="otherGiftCardType5" class="text" runat="server"></asp:TextBox>
                    <br />
                    <asp:CustomValidator ID="cvGiftCardType5" class="validator" ErrorMessage="Please select a gift card type" OnServerValidate="cvOtherGiftCardType5_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>

            <br />
            <br />

            <asp:Label class="label" runat="server">Purpose of Gift (Please give a brief description) <span class="required" title="required">*</span></asp:Label>
            <br />         
            <!--This text area is used for larger descriptions than could span multiple lines-->
            <asp:TextBox id="purpose5" class="text" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvPurpose5" class="validator" ControlToValidate="purpose5" ValidateEmptyText="true" ErrorMessage="Please enter a purpose" OnServerValidate="cvPurpose5_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <span class="block">
            <!--The mailing address will be where this gift card is sent to be picked up-->
            <asp:Label class="subheader" runat="server">Mailing Address</asp:Label>
            <br />
            <br />
            <asp:Label class="label" runat="server">Street Address <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="streetAddress5" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvStreetAddress5" class="validator" ControlToValidate="streetAddress5" ValidateEmptyText="true" ErrorMessage="Please enter a street address" OnServerValidate="cvStreetAddress5_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">Apartment Number</asp:Label>
            <br />
            <asp:TextBox ID="aptNumber5" class="text" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <br />
            <asp:Label class="label" runat="server">City <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="city5" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvCity5" class="validator" ControlToValidate="city" ValidateEmptyText="true" ErrorMessage="Please enter a city" OnServerValidate="cvCity5_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">State <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="state5" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvState5" class="validator" ControlToValidate="state" ValidateEmptyText="true" ErrorMessage="Please enter a state" OnServerValidate="cvState5_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">ZIP Code <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="zipCode5" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvZipCode5" class="validator" ControlToValidate="zipCode5" ValidateEmptyText="true" ErrorMessage="Please enter a ZIP code" OnServerValidate="cvZipCode5_ServerValidate" runat="server"></asp:CustomValidator>
            </span>
        </span>

        <br />
        <br />
        <br />
        <span class="outer">
              <p class="subheader">Approval Information</p>
              <asp:Label class="label" title="required" runat="server">Approved By <span class="required">*</span></asp:Label>

                <!--All gift cards require an approval document of some kind, as well as knowledge of who approved it.-->
                <asp:RadioButtonList ID="approval5" class="radio top" runat="server">
                    <asp:ListItem class="item" Value="SBS" Text="SBS - Paul Malatesta or Steve Orander (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="SEC" Text="SEC (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="Other" Text="Other (Please specify):"/>       
                </asp:RadioButtonList>
                <!--Any approval credentials that are not the same as above-->
                <br />
                <asp:TextBox id="otherApprovalText5" class="text" runat="server" />
                <br />
                <asp:CustomValidator ID="cvOtherApprovalText5" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter valid approval credentials" OnServerValidate="cvOtherApprovalText5_ServerValidate" runat="server"></asp:CustomValidator>
                <br />
                <br />
                <asp:Label class="label" runat="server">Please attach an approval document here and click <strong>Upload</strong> when finished: <span class="required" title="required">*</span></asp:Label><br />
                <br />
                <!--Upload the approval file here-->
                <asp:FileUpload ID="approvalFile5" class="text" runat="server" />
                <br />
                <!--Invisible labels which will contain the filename, content, and URL-->
                <asp:Button ID="approvalFile5Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="approvalFile5Upload_Click" />
                <asp:Label ID="approvalFile5Outcome" Visible="false" class="uploadOutcome label successMessage" runat="server">File uploaded successfully!</asp:Label>
                <asp:Label ID="approvalFile5Name" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile5Content" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile5Url" class="invisible" runat="server"></asp:Label> 
                <br />
                <asp:CustomValidator ID="cvApprovalFile5" class="validator" Display="Dynamic" ValidateEmptyText="true" ErrorMessage="Please upload an approval document" OnServerValidate="cvApprovalFile5_ServerValidate" runat="server"></asp:CustomValidator>              
                <br />

            <br />
            <!--This date contains a JQuery datepicker and is validated on submission-->
            <asp:Label class="label" runat="server">Date Needed By <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="date5" class="datepicker text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvDate5" class="validator" ControlToValidate="date" ValidateEmptyText="true" ErrorMessage="Please enter a date at least four business days away" OnServerValidate="cvDate5_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
        </span>
        <asp:Label ID="outcome5" class="uploadOutcome required" Visible="false" runat="server"></asp:Label>
        <br />
        <asp:Button CssClass="btnSubmit upload" ID="btnClear5" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear5_Click" />
    </fieldset>
    <br />
    <br />
</span>

<span id="form6" Visible="false" runat="server">
    <fieldset>
        <legend class="label legend">Form #6</legend>
        <span class="outer">
            <p class="subheader">Recipient Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Recipient Name <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="name6" class="text drop" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvName6" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="name6" OnServerValidate="cvName6_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
            <!--Determine if the recipient is an employee. This will be critical for validation on the submission of this form.-->
            <asp:Label class="label" runat="server">Is this recipient an employee? <span class="required" title="required">*</span></asp:Label>
            <asp:RadioButtonList ID="recipientType6" class="radio text" runat="server">
                <asp:ListItem class="item" Text="Yes" Value="Yes" />
                <asp:ListItem class="item" Text="No" Value="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvRecipientType6" class="validator" ValidateEmptyText="true" ErrorMessage="Please select Yes or No" ControlToValidate="recipientType6" OnServerValidate="cvRecipientType6_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <!--This field is not marked as required because the recipient may or may not be an employee.-->
            <asp:Label class="label" runat="server">If the answer is Yes, please specify this employee’s branch:</asp:Label>
            <br />
            <asp:DropDownList ID="branch6" class="text" runat="server">
                <asp:ListItem class="item" Value=""></asp:ListItem>
                <asp:ListItem class="item" Value="SBS">SBS</asp:ListItem>
                <asp:ListItem class="item" Value="SEC">SEC</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label class="label" runat="server">If the answer is No, please provide further details:</asp:Label>
            <br />
            <asp:TextBox id="otherRecipient6" class="text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvOtherRecipient6" class="validator" OnServerValidate="cvOtherRecipient6_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />

            <!--Determines if this recipient needs a W-9. Not necessary for employees.-->
            <asp:Label class="label" runat="server">For Non-Employees: Has this recipient received $600 of total gift cards in one calendar year?</asp:Label>
            <asp:RadioButtonList ID="yesNo6" class="radio top bottom" runat="server">
                <asp:ListItem class="item" value="Yes" Text="Yes (Please submit a W-9 to sharpgiftcard@sharpsec.com)" />
                <asp:ListItem class="item" value="No" Text="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvYesNo6" class="validator" ErrorMessage="Please select if this recipient needs a W-9" OnServerValidate="cvYesNo6_ServerValidate" runat="server"></asp:CustomValidator>
            <!--This field is not marked as required because the recipient may or may not be an employee. If it is required is determined automatically upon submission-->
            <br />
            <br />
            <asp:Label class="label" runat="server">For non-employees receiving $600 or more, please attach a W-9 and click <strong>Upload</strong> when finished:</asp:Label>
            <br />
            <br />
            <asp:FileUpload ID="w96" class="text" runat="server" />
            <br />
            <asp:Button ID="w96Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="w96Upload_Click" />
            <asp:Label ID="w96Outcome" Visible="false" class="label uploadOutcome successMessage" runat="server"></asp:Label>
            <!--These invisible labels will contain the filename, its content, and its URL for storage in SharePoint-->
            <asp:Label ID="w96Name" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w96Content" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w96Url" class="invisible" runat="server"></asp:Label>
            <br />
            <asp:CustomValidator ID="cvW96" class="validator" ErrorMessage="Please upload a W-9" ValidateEmptyText="true" OnServerValidate="cvW96_ServerValidate" runat="server"></asp:CustomValidator>
        </span><!--End of recipient information-->
        <br />
        <br />
        <br />

        <span class="outer">
            <p class="subheader">Gift Card Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Amount (minimum $10, maximum $1,000) <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox ID="amount6" class="text amount" onkeyup="formatMoney(this)" onblur="onBlur(this)" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvAmount6" class="validator" ValidateEmptyText="true" ControlToValidate="amount6" ErrorMessage="Please enter an amount between $10 and $1,000" OnServerValidate="cvAmount6_ServerValidate" runat="server"></asp:CustomValidator>
                </span>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Type <span id="Span5" class="required" title="required" runat="server">*</span></asp:Label>

                    <asp:RadioButtonList class="radio" ID="giftCardType6" runat="server">
                        <asp:ListItem class="item" Text="American Express" />
                        <asp:ListItem class="item" Text="Other" />
                    </asp:RadioButtonList>
                    <asp:TextBox ID="otherGiftCardType6" class="text" runat="server"></asp:TextBox>
                    <br />
                    <asp:CustomValidator ID="cvGiftCardType6" class="validator" ErrorMessage="Please select a gift card type" OnServerValidate="cvOtherGiftCardType6_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>

            <br />
            <br />

            <asp:Label class="label" runat="server">Purpose of Gift (Please give a brief description) <span class="required" title="required">*</span></asp:Label>
            <br />         
            <!--This text area is used for larger descriptions than could span multiple lines-->
            <asp:TextBox id="purpose6" class="text" runat="server" TextMode="MultiLine"></asp:TextBox><br />
            <asp:CustomValidator ID="cvPurpose6" class="validator" ControlToValidate="purpose6" ValidateEmptyText="true" ErrorMessage="Please enter a purpose" OnServerValidate="cvPurpose6_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <span class="block">
            <!--The mailing address will be where this gift card is sent to be picked up-->
            <asp:Label class="subheader" runat="server">Mailing Address</asp:Label>
            <br />
            <br />
            <asp:Label class="label" runat="server">Street Address <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="streetAddress6" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvStreetAddress6" class="validator" ControlToValidate="streetAddress6" ValidateEmptyText="true" ErrorMessage="Please enter a street address" OnServerValidate="cvStreetAddress6_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">Apartment Number</asp:Label>
            <br />
            <asp:TextBox ID="aptNumber6" class="text" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <br />
            <asp:Label class="label" runat="server">City <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="city6" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvCity6" class="validator" ControlToValidate="city" ValidateEmptyText="true" ErrorMessage="Please enter a city" OnServerValidate="cvCity6_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">State <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="state6" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvState6" class="validator" ControlToValidate="state" ValidateEmptyText="true" ErrorMessage="Please enter a state" OnServerValidate="cvState6_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">ZIP Code <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="zipCode6" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvZipCode6" class="validator" ControlToValidate="zipCode6" ValidateEmptyText="true" ErrorMessage="Please enter a ZIP code" OnServerValidate="cvZipCode6_ServerValidate" runat="server"></asp:CustomValidator>
            </span>
        </span>

        <br />
        <br />
        <br />
        <span class="outer">
              <p class="subheader">Approval Information</p>
              <asp:Label class="label" title="required" runat="server">Approved By <span class="required">*</span></asp:Label>

                <!--All gift cards require an approval document of some kind, as well as knowledge of who approved it.-->
                <asp:RadioButtonList ID="approval6" class="radio top" runat="server">
                    <asp:ListItem class="item" Value="SBS" Text="SBS - Paul Malatesta or Steve Orander (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="SEC" Text="SEC (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="Other" Text="Other (Please specify):"/>       
                </asp:RadioButtonList>
                <!--Any approval credentials that are not the same as above-->
                <br />
                <asp:TextBox id="otherApprovalText6" class="text" runat="server" />
                <br />
                <asp:CustomValidator ID="cvOtherApprovalText6" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter valid approval credentials" OnServerValidate="cvOtherApprovalText6_ServerValidate" runat="server"></asp:CustomValidator>
                <br />
                <br />
                <asp:Label class="label" runat="server">Please attach an approval document here and click <strong>Upload</strong> when finished: <span class="required" title="required">*</span></asp:Label><br />
                <br />
                <!--Upload the approval file here-->
                <asp:FileUpload ID="approvalFile6" class="text" runat="server" />
                <br />
                <!--Invisible labels which will contain the filename, content, and URL-->
                <asp:Button ID="approvalFile6Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="approvalFile6Upload_Click" />
                <asp:Label ID="approvalFile6Outcome" Visible="false" class="uploadOutcome label successMessage" runat="server">File uploaded successfully!</asp:Label>
                <asp:Label ID="approvalFile6Name" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile6Content" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile6Url" class="invisible" runat="server"></asp:Label> 
                <br />
                <asp:CustomValidator ID="cvApprovalFile6" class="validator" Display="Dynamic" ValidateEmptyText="true" ErrorMessage="Please upload an approval document" OnServerValidate="cvApprovalFile6_ServerValidate" runat="server"></asp:CustomValidator>              
                <br />

            <br />
            <!--This date contains a JQuery datepicker and is validated on submission-->
            <asp:Label class="label" runat="server">Date Needed By <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="date6" class="datepicker text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvDate6" class="validator" ControlToValidate="date" ValidateEmptyText="true" ErrorMessage="Please enter a date at least four business days away" OnServerValidate="cvDate6_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
        </span>
        <asp:Label ID="outcome6" class="uploadOutcome required" Visible="false" runat="server"></asp:Label>
        <br />
        <asp:Button CssClass="btnSubmit upload" ID="btnClear6" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear6_Click" />
    </fieldset>
    <br />
    <br />
</span>

<span id="form7" visible="false" runat="server">
    <fieldset>
        <legend class="label legend">Form #7</legend>
        <span class="outer">
            <p class="subheader">Recipient Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Recipient Name <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="name7" class="text drop" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvName7" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="name7" OnServerValidate="cvName7_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
            <!--Determine if the recipient is an employee. This will be critical for validation on the submission of this form.-->
            <asp:Label class="label" runat="server">Is this recipient an employee? <span class="required" title="required">*</span></asp:Label>
            <asp:RadioButtonList ID="recipientType7" class="radio text" runat="server">
                <asp:ListItem class="item" Text="Yes" Value="Yes" />
                <asp:ListItem class="item" Text="No" Value="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvRecipientType7" class="validator" ValidateEmptyText="true" ErrorMessage="Please select Yes or No" ControlToValidate="recipientType7" OnServerValidate="cvRecipientType7_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <!--This field is not marked as required because the recipient may or may not be an employee.-->
            <asp:Label class="label" runat="server">If the answer is Yes, please specify this employee’s branch:</asp:Label>
            <br />
            <asp:DropDownList ID="branch7" class="text" runat="server">
                <asp:ListItem class="item" Value=""></asp:ListItem>
                <asp:ListItem class="item" Value="SBS">SBS</asp:ListItem>
                <asp:ListItem class="item" Value="SEC">SEC</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label class="label" runat="server">If the answer is No, please provide further details:</asp:Label>
            <br />
            <asp:TextBox id="otherRecipient7" class="text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvOtherRecipient7" class="validator" OnServerValidate="cvOtherRecipient7_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />

            <!--Determines if this recipient needs a W-9. Not necessary for employees.-->
            <asp:Label class="label" runat="server">For Non-Employees: Has this recipient received $600 of total gift cards in one calendar year?</asp:Label>
            <asp:RadioButtonList ID="yesNo7" class="radio top bottom" runat="server">
                <asp:ListItem class="item" value="Yes" Text="Yes (Please submit a W-9 to sharpgiftcard@sharpsec.com)" />
                <asp:ListItem class="item" value="No" Text="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvYesNo7" class="validator" ErrorMessage="Please select if this recipient needs a W-9" OnServerValidate="cvYesNo7_ServerValidate" runat="server"></asp:CustomValidator>
            <!--This field is not marked as required because the recipient may or may not be an employee. If it is required is determined automatically upon submission-->
            <br />
            <br />
            <asp:Label class="label" runat="server">For non-employees receiving $700 or more, please attach a W-9 and click <strong>Upload</strong> when finished:</asp:Label>
            <br />
            <br />
            <asp:FileUpload ID="w97" class="text" runat="server" />
            <br />
            <asp:Button ID="w97Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="w97Upload_Click" />
            <asp:Label ID="w97Outcome" Visible="false" class="label uploadOutcome successMessage" runat="server"></asp:Label>
            <!--These invisible labels will contain the filename, its content, and its URL for storage in SharePoint-->
            <asp:Label ID="w97Name" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w97Content" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w97Url" class="invisible" runat="server"></asp:Label>
            <br />
            <asp:CustomValidator ID="cvW97" class="validator" ErrorMessage="Please upload a W-9" ValidateEmptyText="true" OnServerValidate="cvW97_ServerValidate" runat="server"></asp:CustomValidator>
        </span><!--End of recipient information-->
        <br />
        <br />
        <br />

        <span class="outer">
            <p class="subheader">Gift Card Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Amount (minimum $10, maximum $1,000) <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox ID="amount7" class="text amount" onkeyup="formatMoney(this)" onblur="onBlur(this)" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvAmount7" class="validator" ValidateEmptyText="true" ControlToValidate="amount7" ErrorMessage="Please enter an amount between $10 and $1,000" OnServerValidate="cvAmount7_ServerValidate" runat="server"></asp:CustomValidator>
                </span>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span class="block">
                    <asp:Label ID="Label26" class="label" runat="server">Gift Card Type <span id="Span6" class="required" title="required" runat="server">*</span></asp:Label>

                    <asp:RadioButtonList class="radio" ID="giftCardType7" runat="server">
                        <asp:ListItem class="item" Text="American Express" />
                        <asp:ListItem class="item" Text="Other" />
                    </asp:RadioButtonList>
                    <asp:TextBox ID="otherGiftCardType7" class="text" runat="server"></asp:TextBox>
                    <br />
                    <asp:CustomValidator ID="cvGiftCardType7" class="validator" ErrorMessage="Please select a gift card type" OnServerValidate="cvOtherGiftCardType7_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>

            <br />
            <br />

            <asp:Label class="label" runat="server">Purpose of Gift (Please give a brief description) <span class="required" title="required">*</span></asp:Label>
            <br />         
            <!--This text area is used for larger descriptions than could span multiple lines-->
            <asp:TextBox id="purpose7" class="text" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvPurpose7" class="validator" ControlToValidate="purpose7" ValidateEmptyText="true" ErrorMessage="Please enter a purpose" OnServerValidate="cvPurpose7_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <span class="block">
            <!--The mailing address will be where this gift card is sent to be picked up-->
            <asp:Label class="subheader" runat="server">Mailing Address</asp:Label>
            <br />
            <br />
            <asp:Label class="label" runat="server">Street Address <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="streetAddress7" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvStreetAddress7" class="validator" ControlToValidate="streetAddress7" ValidateEmptyText="true" ErrorMessage="Please enter a street address" OnServerValidate="cvStreetAddress7_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">Apartment Number</asp:Label>
            <br />
            <asp:TextBox ID="aptNumber7" class="text" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <br />
            <asp:Label class="label" runat="server">City <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="city7" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvCity7" class="validator" ControlToValidate="city" ValidateEmptyText="true" ErrorMessage="Please enter a city" OnServerValidate="cvCity7_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">State <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="state7" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvState7" class="validator" ControlToValidate="state" ValidateEmptyText="true" ErrorMessage="Please enter a state" OnServerValidate="cvState7_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">ZIP Code <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="zipCode7" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvZipCode7" class="validator" ControlToValidate="zipCode7" ValidateEmptyText="true" ErrorMessage="Please enter a ZIP code" OnServerValidate="cvZipCode7_ServerValidate" runat="server"></asp:CustomValidator>
            </span>
        </span>

        <br />
        <br />
        <br />
        <span class="outer">
              <p class="subheader">Approval Information</p>
              <asp:Label class="label" title="required" runat="server">Approved By <span class="required">*</span></asp:Label>

                <!--All gift cards require an approval document of some kind, as well as knowledge of who approved it.-->
                <asp:RadioButtonList ID="approval7" class="radio top" runat="server">
                    <asp:ListItem class="item" Value="SBS" Text="SBS - Paul Malatesta or Steve Orander (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="SEC" Text="SEC (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="Other" Text="Other (Please specify):"/>       
                </asp:RadioButtonList>
                <!--Any approval credentials that are not the same as above-->
                <br />
                <asp:TextBox id="otherApprovalText7" class="text" runat="server" />
                <br />
                <asp:CustomValidator ID="cvOtherApprovalText7" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter valid approval credentials" OnServerValidate="cvOtherApprovalText7_ServerValidate" runat="server"></asp:CustomValidator>
                <br />
                <br />
                <asp:Label class="label" runat="server">Please attach an approval document here and click <strong>Upload</strong> when finished: <span class="required" title="required">*</span></asp:Label><br />
                <br />
                <!--Upload the approval file here-->
                <asp:FileUpload ID="approvalFile7" class="text" runat="server" />
                <br />
                <!--Invisible labels which will contain the filename, content, and URL-->
                <asp:Button ID="approvalFile7Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="approvalFile7Upload_Click" />
                <asp:Label ID="approvalFile7Outcome" Visible="false" class="uploadOutcome label successMessage" runat="server">File uploaded successfully!</asp:Label>
                <asp:Label ID="approvalFile7Name" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile7Content" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile7Url" class="invisible" runat="server"></asp:Label> 
                <br />
                <asp:CustomValidator ID="cvApprovalFile7" class="validator" Display="Dynamic" ValidateEmptyText="true" ErrorMessage="Please upload an approval document" OnServerValidate="cvApprovalFile7_ServerValidate" runat="server"></asp:CustomValidator>              
                <br />

            <br />
            <!--This date contains a JQuery datepicker and is validated on submission-->
            <asp:Label class="label" runat="server">Date Needed By <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="date7" class="datepicker text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvDate7" class="validator" ControlToValidate="date" ValidateEmptyText="true" ErrorMessage="Please enter a date at least four business days away" OnServerValidate="cvDate7_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
        </span>
        <asp:Label ID="outcome7" class="uploadOutcome required" Visible="false" runat="server"></asp:Label>
        <br />
        <asp:Button CssClass="btnSubmit upload" ID="btnClear7" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear7_Click" />
    </fieldset>
    <br />
    <br />
</span>

<span id="form8" visible="false" runat="server">
    <fieldset>
        <legend class="label legend">Form #8</legend>
        <span class="outer">
            <p class="subheader">Recipient Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Recipient Name <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="name8" class="text drop" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvName8" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="name8" OnServerValidate="cvName8_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
            <!--Determine if the recipient is an employee. This will be critical for validation on the submission of this form.-->
            <asp:Label class="label" runat="server">Is this recipient an employee? <span class="required" title="required">*</span></asp:Label>
            <asp:RadioButtonList ID="recipientType8" class="radio text" runat="server">
                <asp:ListItem class="item" Text="Yes" Value="Yes" />
                <asp:ListItem class="item" Text="No" Value="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvRecipientType8" class="validator" ValidateEmptyText="true" ErrorMessage="Please select Yes or No" ControlToValidate="recipientType8" OnServerValidate="cvRecipientType8_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <!--This field is not marked as required because the recipient may or may not be an employee.-->
            <asp:Label class="label" runat="server">If the answer is Yes, please specify this employee’s branch:</asp:Label>
            <br />
            <asp:DropDownList ID="branch8" class="text" runat="server">
                <asp:ListItem class="item" Value=""></asp:ListItem>
                <asp:ListItem class="item" Value="SBS">SBS</asp:ListItem>
                <asp:ListItem class="item" Value="SEC">SEC</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label class="label" runat="server">If the answer is No, please provide further details:</asp:Label><br />
            <asp:TextBox id="otherRecipient8" class="text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvOtherRecipient8" class="validator" OnServerValidate="cvOtherRecipient8_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />

            <!--Determines if this recipient needs a W-9. Not necessary for employees.-->
            <asp:Label class="label" runat="server">For Non-Employees: Has this recipient received $600 of total gift cards in one calendar year?</asp:Label>
            <asp:RadioButtonList ID="yesNo8" class="radio top bottom" runat="server">
                <asp:ListItem class="item" value="Yes" Text="Yes (Please submit a W-9 to sharpgiftcard@sharpsec.com)" />
                <asp:ListItem class="item" value="No" Text="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvYesNo8" class="validator" ErrorMessage="Please select if this recipient needs a W-9" OnServerValidate="cvYesNo8_ServerValidate" runat="server"></asp:CustomValidator>
            <!--This field is not marked as required because the recipient may or may not be an employee. If it is required is determined automatically upon submission-->
            <br />
            <br />
            <asp:Label class="label" runat="server">For non-employees receiving $800 or more, please attach a W-9 and click <strong>Upload</strong> when finished:</asp:Label>
            <br />
            <br />
            <asp:FileUpload ID="w98" class="text" runat="server" />
            <br />
            <asp:Button ID="w98Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="w98Upload_Click" />
            <asp:Label ID="w98Outcome" Visible="false" class="label uploadOutcome successMessage" runat="server"></asp:Label>
            <!--These invisible labels will contain the filename, its content, and its URL for storage in SharePoint-->
            <asp:Label ID="w98Name" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w98Content" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w98Url" class="invisible" runat="server"></asp:Label>
            <br />
            <asp:CustomValidator ID="cvW98" class="validator" ErrorMessage="Please upload a W-9" ValidateEmptyText="true" OnServerValidate="cvW98_ServerValidate" runat="server"></asp:CustomValidator>
        </span><!--End of recipient information-->
        <br />
        <br />
        <br />

        <span class="outer">
            <p class="subheader">Gift Card Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Amount (minimum $10, maximum $1,000) <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox ID="amount8" class="text amount" onkeyup="formatMoney(this)" onblur="onBlur(this)" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvAmount8" class="validator" ValidateEmptyText="true" ControlToValidate="amount8" ErrorMessage="Please enter an amount between $10 and $1,000" OnServerValidate="cvAmount8_ServerValidate" runat="server"></asp:CustomValidator>
                </span>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Type <span id="Span7" class="required" title="required" runat="server">*</span></asp:Label>

                    <asp:RadioButtonList class="radio" ID="giftCardType8" runat="server">
                        <asp:ListItem class="item" Text="American Express" />
                        <asp:ListItem class="item" Text="Other" />
                    </asp:RadioButtonList>
                    <asp:TextBox ID="otherGiftCardType8" class="text" runat="server"></asp:TextBox><br />
                    <asp:CustomValidator ID="cvGiftCardType8" class="validator" ErrorMessage="Please select a gift card type" OnServerValidate="cvOtherGiftCardType8_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>

            <br />
            <br />

            <asp:Label class="label" runat="server">Purpose of Gift (Please give a brief description) <span class="required" title="required">*</span></asp:Label>
            <br />         
            <!--This text area is used for larger descriptions than could span multiple lines-->
            <asp:TextBox id="purpose8" class="text" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvPurpose8" class="validator" ControlToValidate="purpose8" ValidateEmptyText="true" ErrorMessage="Please enter a purpose" OnServerValidate="cvPurpose8_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <span class="block">
            <!--The mailing address will be where this gift card is sent to be picked up-->
            <asp:Label class="subheader" runat="server">Mailing Address</asp:Label>
            <br />
            <br />
            <asp:Label class="label" runat="server">Street Address <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="streetAddress8" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvStreetAddress8" class="validator" ControlToValidate="streetAddress8" ValidateEmptyText="true" ErrorMessage="Please enter a street address" OnServerValidate="cvStreetAddress8_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">Apartment Number</asp:Label><br />
            <asp:TextBox ID="aptNumber8" class="text" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <br />
            <asp:Label class="label" runat="server">City <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="city8" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvCity8" class="validator" ControlToValidate="city" ValidateEmptyText="true" ErrorMessage="Please enter a city" OnServerValidate="cvCity8_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">State <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="state8" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvState8" class="validator" ControlToValidate="state" ValidateEmptyText="true" ErrorMessage="Please enter a state" OnServerValidate="cvState8_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">ZIP Code <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="zipCode8" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvZipCode8" class="validator" ControlToValidate="zipCode8" ValidateEmptyText="true" ErrorMessage="Please enter a ZIP code" OnServerValidate="cvZipCode8_ServerValidate" runat="server"></asp:CustomValidator>
            </span>
        </span>

        <br />
        <br />
        <br />
        <span class="outer">
              <p class="subheader">Approval Information</p>
              <asp:Label class="label" title="required" runat="server">Approved By <span class="required">*</span></asp:Label>

                <!--All gift cards require an approval document of some kind, as well as knowledge of who approved it.-->
                <asp:RadioButtonList ID="approval8" class="radio top" runat="server">
                    <asp:ListItem class="item" Value="SBS" Text="SBS - Paul Malatesta or Steve Orander (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="SEC" Text="SEC (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="Other" Text="Other (Please specify):"/>       
                </asp:RadioButtonList>
                <!--Any approval credentials that are not the same as above-->
                <br />
                <asp:TextBox id="otherApprovalText8" class="text" runat="server" />
                <br />
                <asp:CustomValidator ID="cvOtherApprovalText8" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter valid approval credentials" OnServerValidate="cvOtherApprovalText8_ServerValidate" runat="server"></asp:CustomValidator>
                <br />
                <br />
                <asp:Label class="label" runat="server">Please attach an approval document here and click <strong>Upload</strong> when finished: <span class="required" title="required">*</span></asp:Label><br />
                <br />
                <!--Upload the approval file here-->
                <asp:FileUpload ID="approvalFile8" class="text" runat="server" />
                <br />
                <!--Invisible labels which will contain the filename, content, and URL-->
                <asp:Button ID="approvalFile8Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="approvalFile8Upload_Click" />
                <asp:Label ID="approvalFile8Outcome" Visible="false" class="uploadOutcome label successMessage" runat="server">File uploaded successfully!</asp:Label>
                <asp:Label ID="approvalFile8Name" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile8Content" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile8Url" class="invisible" runat="server"></asp:Label> 
                <br />
                <asp:CustomValidator ID="cvApprovalFile8" class="validator" Display="Dynamic" ValidateEmptyText="true" ErrorMessage="Please upload an approval document" OnServerValidate="cvApprovalFile8_ServerValidate" runat="server"></asp:CustomValidator>              
                <br />

            <br />
            <!--This date contains a JQuery datepicker and is validated on submission-->
            <asp:Label class="label" runat="server">Date Needed By <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="date8" class="datepicker text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvDate8" class="validator" ControlToValidate="date" ValidateEmptyText="true" ErrorMessage="Please enter a date at least four business days away" OnServerValidate="cvDate8_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
        </span>
        <asp:Label ID="outcome8" class="uploadOutcome required" Visible="false" runat="server"></asp:Label>
        <br />
        <asp:Button CssClass="btnSubmit upload" ID="btnClear8" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear8_Click" />
    </fieldset>
    <br />
    <br />
</span>

<span id="form9" Visible="false" runat="server">
    <fieldset>
        <legend class="label legend">Form #9</legend>
        <span class="outer">
            <p class="subheader">Recipient Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Recipient Name <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="name9" class="text drop" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvName9" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="name9" OnServerValidate="cvName9_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
            <!--Determine if the recipient is an employee. This will be critical for validation on the submission of this form.-->
            <asp:Label class="label" runat="server">Is this recipient an employee? <span class="required" title="required">*</span></asp:Label>
            <asp:RadioButtonList ID="recipientType9" class="radio text" runat="server">
                <asp:ListItem class="item" Text="Yes" Value="Yes" />
                <asp:ListItem class="item" Text="No" Value="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvRecipientType9" class="validator" ValidateEmptyText="true" ErrorMessage="Please select Yes or No" ControlToValidate="recipientType9" OnServerValidate="cvRecipientType9_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <!--This field is not marked as required because the recipient may or may not be an employee.-->
            <asp:Label class="label" runat="server">If the answer is Yes, please specify this employee’s branch:</asp:Label>
            <br />
            <asp:DropDownList ID="branch9" class="text" runat="server">
                <asp:ListItem class="item" Value=""></asp:ListItem>
                <asp:ListItem class="item" Value="SBS">SBS</asp:ListItem>
                <asp:ListItem class="item" Value="SEC">SEC</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label ID="Label23" class="label" runat="server">If the answer is No, please provide further details:</asp:Label>
            <br />
            <asp:TextBox id="otherRecipient9" class="text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvOtherRecipient9" class="validator" OnServerValidate="cvOtherRecipient9_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />

            <!--Determines if this recipient needs a W-9. Not necessary for employees.-->
            <asp:Label class="label" runat="server">For Non-Employees: Has this recipient received $600 of total gift cards in one calendar year?</asp:Label>
            <asp:RadioButtonList ID="yesNo9" class="radio top bottom" runat="server">
                <asp:ListItem class="item" value="Yes" Text="Yes (Please submit a W-9 to sharpgiftcard@sharpsec.com)" />
                <asp:ListItem class="item" value="No" Text="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvYesNo9" class="validator" ErrorMessage="Please select if this recipient needs a W-9" OnServerValidate="cvYesNo9_ServerValidate" runat="server"></asp:CustomValidator>
            <!--This field is not marked as required because the recipient may or may not be an employee. If it is required is determined automatically upon submission-->
            <br />
            <br />
            <asp:Label class="label" runat="server">For non-employees receiving $900 or more, please attach a W-9 and click <strong>Upload</strong> when finished:</asp:Label><br />
            <br />
            <asp:FileUpload ID="w99" class="text" runat="server" />
            <br />
            <asp:Button ID="w99Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="w99Upload_Click" />
            <asp:Label ID="w99Outcome" Visible="false" class="label uploadOutcome successMessage" runat="server"></asp:Label>
            <!--These invisible labels will contain the filename, its content, and its URL for storage in SharePoint-->
            <asp:Label ID="w99Name" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w99Content" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w99Url" class="invisible" runat="server"></asp:Label>
            <br />
            <asp:CustomValidator ID="cvW99" class="validator" ErrorMessage="Please upload a W-9" ValidateEmptyText="true" OnServerValidate="cvW99_ServerValidate" runat="server"></asp:CustomValidator>
        </span><!--End of recipient information-->
        <br />
        <br />
        <br />

        <span class="outer">
            <p class="subheader">Gift Card Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Amount (minimum $10, maximum $1,000) <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox ID="amount9" class="text amount" onkeyup="formatMoney(this)" onblur="onBlur(this)" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvAmount9" class="validator" ValidateEmptyText="true" ControlToValidate="amount9" ErrorMessage="Please enter an amount between $10 and $1,000" OnServerValidate="cvAmount9_ServerValidate" runat="server"></asp:CustomValidator>
                </span>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Type <span id="Span8" class="required" title="required" runat="server">*</span></asp:Label>

                    <asp:RadioButtonList class="radio" ID="giftCardType9" runat="server">
                        <asp:ListItem class="item" Text="American Express" />
                        <asp:ListItem class="item" Text="Other" />
                    </asp:RadioButtonList>
                    <asp:TextBox ID="otherGiftCardType9" class="text" runat="server"></asp:TextBox>
                    <br />
                    <asp:CustomValidator ID="cvGiftCardType9" class="validator" ErrorMessage="Please select a gift card type" OnServerValidate="cvOtherGiftCardType9_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>

            <br />
            <br />

            <asp:Label class="label" runat="server">Purpose of Gift (Please give a brief description) <span class="required" title="required">*</span></asp:Label><br />         
            <!--This text area is used for larger descriptions than could span multiple lines-->
            <asp:TextBox id="purpose9" class="text" runat="server" TextMode="MultiLine"></asp:TextBox><br />
            <asp:CustomValidator ID="cvPurpose9" class="validator" ControlToValidate="purpose9" ValidateEmptyText="true" ErrorMessage="Please enter a purpose" OnServerValidate="cvPurpose9_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <span class="block">
            <!--The mailing address will be where this gift card is sent to be picked up-->
            <asp:Label class="subheader" runat="server">Mailing Address</asp:Label>
            <br />
            <br />
            <asp:Label class="label" runat="server">Street Address <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="streetAddress9" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvStreetAddress9" class="validator" ControlToValidate="streetAddress9" ValidateEmptyText="true" ErrorMessage="Please enter a street address" OnServerValidate="cvStreetAddress9_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">Apartment Number</asp:Label>
            <br />
            <asp:TextBox ID="aptNumber9" class="text" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <br />
            <asp:Label class="label" runat="server">City <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="city9" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvCity9" class="validator" ControlToValidate="city" ValidateEmptyText="true" ErrorMessage="Please enter a city" OnServerValidate="cvCity9_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">State <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="state9" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvState9" class="validator" ControlToValidate="state" ValidateEmptyText="true" ErrorMessage="Please enter a state" OnServerValidate="cvState9_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">ZIP Code <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="zipCode9" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvZipCode9" class="validator" ControlToValidate="zipCode9" ValidateEmptyText="true" ErrorMessage="Please enter a ZIP code" OnServerValidate="cvZipCode9_ServerValidate" runat="server"></asp:CustomValidator>
            </span>
        </span>

        <br />
        <br />
        <br />
        <span class="outer">
              <p class="subheader">Approval Information</p>
              <asp:Label class="label" title="required" runat="server">Approved By <span class="required">*</span></asp:Label>

                <!--All gift cards require an approval document of some kind, as well as knowledge of who approved it.-->
                <asp:RadioButtonList ID="approval9" class="radio top" runat="server">
                    <asp:ListItem class="item" Value="SBS" Text="SBS - Paul Malatesta or Steve Orander (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="SEC" Text="SEC (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="Other" Text="Other (Please specify):"/>       
                </asp:RadioButtonList>
                <!--Any approval credentials that are not the same as above-->
                <br />
                <asp:TextBox id="otherApprovalText9" class="text" runat="server" />
                <br />
                <asp:CustomValidator ID="cvOtherApprovalText9" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter valid approval credentials" OnServerValidate="cvOtherApprovalText9_ServerValidate" runat="server"></asp:CustomValidator>
                <br />
                <br />
                <asp:Label class="label" runat="server">Please attach an approval document here and click <strong>Upload</strong> when finished: <span class="required" title="required">*</span></asp:Label><br />
                <br />
                <!--Upload the approval file here-->
                <asp:FileUpload ID="approvalFile9" class="text" runat="server" />
                <br />
                <!--Invisible labels which will contain the filename, content, and URL-->
                <asp:Button ID="approvalFile9Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="approvalFile9Upload_Click" />
                <asp:Label ID="approvalFile9Outcome" Visible="false" class="uploadOutcome label successMessage" runat="server">File uploaded successfully!</asp:Label>
                <asp:Label ID="approvalFile9Name" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile9Content" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile9Url" class="invisible" runat="server"></asp:Label> 
                <br />
                <asp:CustomValidator ID="cvApprovalFile9" class="validator" Display="Dynamic" ValidateEmptyText="true" ErrorMessage="Please upload an approval document" OnServerValidate="cvApprovalFile9_ServerValidate" runat="server"></asp:CustomValidator>              
                <br />

            <br />
            <!--This date contains a JQuery datepicker and is validated on submission-->
            <asp:Label class="label" runat="server">Date Needed By <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="date9" class="datepicker text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvDate9" class="validator" ControlToValidate="date" ValidateEmptyText="true" ErrorMessage="Please enter a date at least four business days away" OnServerValidate="cvDate9_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
        </span>
        <asp:Label ID="outcome9" class="uploadOutcome required" Visible="false" runat="server"></asp:Label>
        <br />
        <asp:Button CssClass="btnSubmit upload" ID="btnClear9" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear9_Click" />
    </fieldset>
    <br />
    <br />
</span>

<span id="form10" visible="false" runat="server">
    <fieldset>
        <legend class="label legend">Form #10</legend>
        <span class="outer">
            <p class="subheader">Recipient Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Recipient Name <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox id="name10" class="text drop" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvName10" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter a name" ControlToValidate="name10" OnServerValidate="cvName10_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>
            <br />
            <br />
            <!--Determine if the recipient is an employee. This will be critical for validation on the submission of this form.-->
            <asp:Label class="label" runat="server">Is this recipient an employee? <span class="required" title="required">*</span></asp:Label>
            <asp:RadioButtonList ID="recipientType10" class="radio text" runat="server">
                <asp:ListItem class="item" Text="Yes" Value="Yes" />
                <asp:ListItem class="item" Text="No" Value="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvRecipientType10" class="validator" ValidateEmptyText="true" ErrorMessage="Please select Yes or No" ControlToValidate="recipientType10" OnServerValidate="cvRecipientType10_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <!--This field is not marked as required because the recipient may or may not be an employee.-->
            <asp:Label class="label" runat="server">If the answer is Yes, please specify this employee’s branch:</asp:Label>
            <br />
            <asp:DropDownList ID="branch10" class="text" runat="server">
                <asp:ListItem class="item" Value=""></asp:ListItem>
                <asp:ListItem class="item" Value="SBS">SBS</asp:ListItem>
                <asp:ListItem class="item" Value="SEC">SEC</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label class="label" runat="server">If the answer is No, please provide further details:</asp:Label>
            <br />
            <asp:TextBox id="otherRecipient10" class="text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvOtherRecipient10" class="validator" OnServerValidate="cvOtherRecipient10_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />

            <!--Determines if this recipient needs a W-9. Not necessary for employees.-->
            <asp:Label class="label" runat="server">For Non-Employees: Has this recipient received $600 of total gift cards in one calendar year?</asp:Label>
            <asp:RadioButtonList ID="yesNo10" class="radio top bottom" runat="server">
                <asp:ListItem class="item" value="Yes" Text="Yes (Please submit a W-9 to sharpgiftcard@sharpsec.com)" />
                <asp:ListItem class="item" value="No" Text="No" />
            </asp:RadioButtonList>
            <asp:CustomValidator ID="cvYesNo10" class="validator" ErrorMessage="Please select if this recipient needs a W-9" OnServerValidate="cvYesNo10_ServerValidate" runat="server"></asp:CustomValidator>
            <!--This field is not marked as required because the recipient may or may not be an employee. If it is required is determined automatically upon submission-->
            <br />
            <br />
            <asp:Label class="label" runat="server">For non-employees receiving $600 or more, please attach a W-9 and click <strong>Upload</strong> when finished:</asp:Label>
            <br />
            <br />
            <asp:FileUpload ID="w910" class="text" runat="server" />
            <br />
            <asp:Button ID="w910Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="w910Upload_Click" />
            <asp:Label ID="w910Outcome" Visible="false" class="label uploadOutcome successMessage" runat="server"></asp:Label>
            <!--These invisible labels will contain the filename, its content, and its URL for storage in SharePoint-->
            <asp:Label ID="w910Name" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w910Content" class="invisible" runat="server"></asp:Label>
            <asp:Label ID="w910Url" class="invisible" runat="server"></asp:Label>
            <br />
            <asp:CustomValidator ID="cvW910" class="validator" ErrorMessage="Please upload a W-9" ValidateEmptyText="true" OnServerValidate="cvW910_ServerValidate" runat="server"></asp:CustomValidator>
        </span><!--End of recipient information-->
        <br />
        <br />
        <br />

        <span class="outer">
            <p class="subheader">Gift Card Information</p>
            <span class="inlineflex">
                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Amount (minimum $10, maximum $1,000) <span class="required" title="required">*</span></asp:Label>
                    <br />
                    <asp:TextBox ID="amount10" class="text amount" onkeyup="formatMoney(this)" onblur="onBlur(this)" runat="server" />
                    <br />
                    <asp:CustomValidator ID="cvAmount10" class="validator" ValidateEmptyText="true" ControlToValidate="amount10" ErrorMessage="Please enter an amount between $10 and $1,000" OnServerValidate="cvAmount10_ServerValidate" runat="server"></asp:CustomValidator>
                </span>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span class="block">
                    <asp:Label class="label" runat="server">Gift Card Type <span id="Span9" class="required" title="required" runat="server">*</span></asp:Label>

                    <asp:RadioButtonList class="radio" ID="giftCardType10" runat="server">
                        <asp:ListItem class="item" Text="American Express" />
                        <asp:ListItem class="item" Text="Other" />
                    </asp:RadioButtonList>
                    <asp:TextBox ID="otherGiftCardType10" class="text" runat="server"></asp:TextBox>
                    <br />
                    <asp:CustomValidator ID="cvGiftCardType10" class="validator" ErrorMessage="Please select a gift card type" OnServerValidate="cvOtherGiftCardType10_ServerValidate" runat="server"></asp:CustomValidator>
                </span>
            </span>

            <br />
            <br />

            <asp:Label class="label" runat="server">Purpose of Gift (Please give a brief description) <span class="required" title="required">*</span></asp:Label>
            <br />         
            <!--This text area is used for larger descriptions than could span multiple lines-->
            <asp:TextBox id="purpose10" class="text" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvPurpose10" class="validator" ControlToValidate="purpose10" ValidateEmptyText="true" ErrorMessage="Please enter a purpose" OnServerValidate="cvPurpose10_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <span class="block">
            <!--The mailing address will be where this gift card is sent to be picked up-->
            <asp:Label class="subheader" runat="server">Mailing Address</asp:Label>
            <br />
            <br />
            <asp:Label class="label" runat="server">Street Address <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="streetAddress10" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvStreetAddress10" class="validator" ControlToValidate="streetAddress10" ValidateEmptyText="true" ErrorMessage="Please enter a street address" OnServerValidate="cvStreetAddress10_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">Apartment Number</asp:Label><br />
            <asp:TextBox ID="aptNumber10" class="text" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <br />
            <asp:Label class="label" runat="server">City <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="city10" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvCity10" class="validator" ControlToValidate="city" ValidateEmptyText="true" ErrorMessage="Please enter a city" OnServerValidate="cvCity10_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">State <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="state10" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvState10" class="validator" ControlToValidate="state" ValidateEmptyText="true" ErrorMessage="Please enter a state" OnServerValidate="cvState10_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
            <asp:Label class="label" runat="server">ZIP Code <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="zipCode10" class="text" runat="server"></asp:TextBox>
            <br />
            <asp:CustomValidator ID="cvZipCode10" class="validator" ControlToValidate="zipCode10" ValidateEmptyText="true" ErrorMessage="Please enter a ZIP code" OnServerValidate="cvZipCode10_ServerValidate" runat="server"></asp:CustomValidator>
            </span>
        </span>

        <br />
        <br />
        <br />
        <span class="outer">
              <p class="subheader">Approval Information</p>
              <asp:Label class="label" title="required" runat="server">Approved By <span class="required">*</span></asp:Label>

                <!--All gift cards require an approval document of some kind, as well as knowledge of who approved it.-->
                <asp:RadioButtonList ID="approval10" class="radio top" runat="server">
                    <asp:ListItem class="item" Value="SBS" Text="SBS - Paul Malatesta or Steve Orander (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="SEC" Text="SEC (Please submit approval to sharpgiftcard@sharpsec.com)" />
                    <asp:ListItem class="item" Value="Other" Text="Other (Please specify):"/>       
                </asp:RadioButtonList>
                <!--Any approval credentials that are not the same as above-->
                <br />
                <asp:TextBox id="otherApprovalText10" class="text" runat="server" />
                <br />
                <asp:CustomValidator ID="cvOtherApprovalText10" class="validator" ValidateEmptyText="true" ErrorMessage="Please enter valid approval credentials" OnServerValidate="cvOtherApprovalText10_ServerValidate" runat="server"></asp:CustomValidator>
                <br />
                <br />
                <asp:Label class="label" runat="server">Please attach an approval document here and click <strong>Upload</strong> when finished: <span class="required" title="required">*</span></asp:Label>
                <br />
                <br />
                <!--Upload the approval file here-->
                <asp:FileUpload ID="approvalFile10" class="text" runat="server" />
                <br />
                <!--Invisible labels which will contain the filename, content, and URL-->
                <asp:Button ID="approvalFile10Upload" CssClass="btnSubmit upload" runat="server" Text="Upload" CausesValidation="false" onclick="approvalFile10Upload_Click" />
                <asp:Label ID="approvalFile10Outcome" Visible="false" class="uploadOutcome label successMessage" runat="server">File uploaded successfully!</asp:Label>
                <asp:Label ID="approvalFile10Name" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile10Content" class="invisible" runat="server"></asp:Label>
                <asp:Label ID="approvalFile10Url" class="invisible" runat="server"></asp:Label> 
                <br />
                <asp:CustomValidator ID="cvApprovalFile10" class="validator" Display="Dynamic" ValidateEmptyText="true" ErrorMessage="Please upload an approval document" OnServerValidate="cvApprovalFile10_ServerValidate" runat="server"></asp:CustomValidator>              
                <br />

            <br />
            <!--This date contains a JQuery datepicker and is validated on submission-->
            <asp:Label class="label" runat="server">Date Needed By <span class="required" title="required">*</span></asp:Label>
            <br />
            <asp:TextBox ID="date10" class="datepicker text" runat="server" />
            <br />
            <asp:CustomValidator ID="cvDate10" class="validator" ControlToValidate="date" ValidateEmptyText="true" ErrorMessage="Please enter a date at least four business days away" OnServerValidate="cvDate10_ServerValidate" runat="server"></asp:CustomValidator>
            <br />
            <br />
        </span>
        <asp:Label ID="outcome10" class="uploadOutcome required" Visible="false" runat="server"></asp:Label>
        <br />
        <asp:Button CssClass="btnSubmit upload" ID="btnClear10" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear10_Click" />
    </fieldset>
    <br />
    <br />
</span>

    <asp:Label ID="allErrors" class="label lowerError required" visible="false" runat="server">There were errors in the following form(s):</asp:Label>
    <br />
    <asp:Label ID="errorForms" class="label lowerError" visible="false" runat="server"></asp:Label>
    <br />
    <asp:Label ID="resubmit" class="label lowerError required"  visible="false" runat="server">Please correct the error(s) and submit the form(s) again.</asp:Label>
    <br />
    <br />  
    <asp:Button ID="btnAnother" CssClass="btnSubmit" CausesValidation="false" runat="server" Text="Another" onclick="btnAnother_Click" />
    <asp:Button ID="submit" runat="server" Text="Submit" CssClass="btnSubmit" onclick="btnSubmit_Click" />
</ContentTemplate>
</asp:UpdatePanel>
    <!--End of huge update panel-->
    </div><!--End of all forms-->
    <asp:Label ID="canAccessAll" class="invisible" runat="server"></asp:Label>
    <div id="menu1" class="tab-pane fade"><!--Beginning of user menu-->
      <h3 class="pillheader header">My Requests</h3>
      <asp:Label ID="queryresults" class="label header" runat="server"></asp:Label>
      <br />
      <br />
        <asp:UpdatePanel runat="server">
        <ContentTemplate>
        <!--This grid allows any user to view his/her own gift card applications. S/he will not be able to edit anything here.-->
        <asp:GridView ID="mygrid" class="grid" AutoGenerateColumns="false" GridLines="Both" runat="server">  
            <HeaderStyle HorizontalAlign="Center" BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
            <RowStyle HorizontalAlign="Center" BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
            <Columns>
                <asp:BoundField DataField="EmailAddress" HeaderText="Email" />  
                <asp:BoundField DataField="RequesterName" HeaderText="Requester" />
                <asp:BoundField DataField="RecipientName" HeaderText="Recipient Name" />
                <asp:BoundField DataField="RecipientStatus" HeaderText="Recipient Status" />
                <asp:BoundField DataField="Branch" HeaderText="Branch" />
                <asp:BoundField DataField="ReceivedSixHundred" HeaderText="Received $600?" />
                <asp:BoundField DataField="GiftCardAmount" HeaderText="Amount" />
                <asp:TemplateField HeaderText="W-9">
                    <ItemTemplate>
                        <asp:HyperLink ID="layW9Link" NavigateUrl='<%# Bind("W9") %>' Text='<%# Bind("W9") %>' runat="server"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="GiftCardType" HeaderText="Type" />
                <asp:BoundField DataField="Purpose" HeaderText="Purpose" />
                <asp:BoundField DataField="ApprovedBy" HeaderText="Approved By" />
                <asp:TemplateField HeaderText="Approval Document">
                    <ItemTemplate>
                        <asp:HyperLink ID="layApprovalLink" NavigateUrl='<%# Bind("ApprovalDocument") %>' Text='<%# Bind("ApprovalDocument") %>' runat="server"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="DateNeededBy" HeaderText="Needed By" />
                <asp:BoundField DataField="StreetAddress" HeaderText="Address" />
                <asp:BoundField DataField="ApartmentNumber" HeaderText="Apt/Ste" />
                <asp:BoundField DataField="City" HeaderText="City" />
                <asp:BoundField DataField="State" HeaderText="State" />
                <asp:BoundField DataField="ZIPCode" HeaderText="ZIP Code" />
                <asp:BoundField DataField="Status" HeaderText="Request Status" />
            </Columns>
        </asp:GridView>
        </ContentTemplate>
        </asp:UpdatePanel>
    </div><!--End of user menu-->

    <div id="menu2" class="tab-pane fade"><!--Beginning of all menu-->
      <h3 class="pillheader header" id="allrequests">All Requests</h3>
      <asp:Label ID="allrequestslabel" class="label header" runat="server"></asp:Label>
      <br />
      <br />
      <asp:UpdatePanel runat="server">
      <ContentTemplate>
        <!--This grid allows the Site Owner to view all gift card records. S/he can edit any field except the Unique ID, Timestamp, and Created By fields-->
        <asp:Button id="requesterButton" class="btnSubmit" Text="Show Requester Information" OnClick="requesterButton_Click" runat="server" />
        <div id="topGrid" runat="server">
        <asp:GridView ID="allgridTop" class="grid" runat="server" 
            onrowdatabound="allgridTop_RowDataBound" BorderStyle="Solid" BorderWidth="1" 
            BorderColor="Black" AutoGenerateColumns="False" GridLines="Both"
            onpageindexchanging="allgridTop_PageIndexChanging" 
            onrowediting="allgridTop_RowEditing"> 
            <HeaderStyle HorizontalAlign="Center" BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
            <RowStyle HorizontalAlign="Center" BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
            <Columns>
                <asp:BoundField DataField="UniqueID" HeaderText="Unique ID" />                 
                <asp:BoundField DataField="Timestamp" HeaderText="Timestamp" />
                <asp:BoundField DataField="Created By" HeaderText="Created By" />
                <asp:TemplateField HeaderText="Email">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminEmailText" Text='<%# Bind("EmailAddress") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminEmailLabel" Text='<%# Bind("EmailAddress") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>  
                <asp:TemplateField HeaderText="Requester">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminRequesterNameText" Text='<%# Bind("RequesterName") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminRequesterNameLabel" Text='<%# Bind("RequesterName") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Recipient Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminRecipientNameText" Text='<%# Bind("RecipientName") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminRecipientNameLabel" Text='<%# Bind("RecipientName") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Recipient Status">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminRecipientStatusText" Text='<%# Bind("RecipientStatus") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminRecipientStatusLabel" Text='<%# Bind("RecipientStatus") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Branch">
                    <EditItemTemplate>
                        <asp:DropDownList ID="branchTxt" SelectedValue='<%# Bind("Branch") %>' class="text" runat="server">
                            <asp:ListItem clas="item" Value="" runat="server"></asp:ListItem>
                            <asp:ListItem class="item" Value="SBS" runat="server">SBS</asp:ListItem>
                            <asp:ListItem class="item" Value="SEC" runat="server">SEC</asp:ListItem>
                        </asp:DropDownList>
                        <asp:HiddenField ID="branch" Value='<%# Bind("Branch") %>' runat="server" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminBranchLabel" Text='<%# Bind("Branch") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Received $600?">
                    <EditItemTemplate>
                        <asp:DropDownList ID="adminSixHundredText" SelectedValue='<%# Bind("ReceivedSixHundred") %>' runat="server">
                            <asp:ListItem Value="Yes">Yes</asp:ListItem>
                            <asp:ListItem Value="No">No</asp:ListItem>
                            <asp:ListItem Value="N/A">N/A</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminSixHundredLabel" Text='<%# Bind("ReceivedSixHundred") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminAmountText" Text='<%# Bind("GiftCardAmount") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminAmountLabel" Text='<%# Bind("GiftCardAmount") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="W-9">
                    <ItemTemplate>
                        <asp:HyperLink ID="adminW9Link" NavigateUrl='<%# Bind("W9") %>' Text='<%# Bind("W9") %>' Target="_blank" runat="server"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Type">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminTypeText" Text='<%# Bind("GiftCardType") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminTypeLabel" Text='<%# Bind("GiftCardType") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Purpose">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminPurposeText" Text='<%# Bind("Purpose") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminPurposeLabel" Text='<%# Bind("Purpose") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Approved By">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminApprovedByText" Text='<%# Bind("ApprovedBy") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminApprovedByLabel" Text='<%# Bind("ApprovedBy") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Approval Document">
                    <ItemTemplate>
                        <asp:HyperLink ID="adminApprovalLink" NavigateUrl='<%# Bind("ApprovalDocument") %>' Text='<%# Bind("ApprovalDocument") %>' runat="server"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Needed By">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminDateNeededByText" Text='<%# Bind("DateNeededBy") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminDateNeededByLabel" Text='<%# Bind("DateNeededBy") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Address">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminAddressText" Text='<%# Bind("StreetAddress") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminAddressLabel" Text='<%# Bind("StreetAddress") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Apt/Ste">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminApartmentText" Text='<%# Bind("ApartmentNumber") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminApartmentLabel" Text='<%# Bind("ApartmentNumber") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="City">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminCityText" Text='<%# Bind("City") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminCityLabel" Text='<%# Bind("City") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="State">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminStateText" Text='<%# Bind("State") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminStateLabel" Text='<%# Bind("State") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ZIP Code">
                    <EditItemTemplate>
                        <asp:TextBox ID="adminZIPCodeText" Text='<%# Bind("ZIPCode") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminZIPCodeLabel" Text='<%# Bind("ZIPCode") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Request Status">
                    <EditItemTemplate>
                        <asp:DropDownList ID="adminStatusTxt" SelectedValue='<%# Bind("Status") %>' class="text" runat="server">
                            <asp:ListItem class="item" Value="New" runat="server">New</asp:ListItem>
                            <asp:ListItem class="item" Value="Processing" runat="server">Processing</asp:ListItem>
                            <asp:ListItem class="item" Value="Completed" runat="server">Completed</asp:ListItem>
                        </asp:DropDownList>
                        <asp:HiddenField ID="status" Value='<%# Bind("Status") %>' runat="server" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="adminStatusLabel" Text='<%# Bind("Status") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" Text="Update" runat="server" OnClick="allgridTop_RowUpdating" />
                        <asp:LinkButton ID="LinkButton2" Text="Cancel" runat="server" OnClick="allgridTop_RowCancelingEdit" />
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        </div>
        <br />
        <br />
        <br />
        <asp:Button id="purchaserButton" class="btnSubmit" Text="Show Purchaser Information" OnClick="purchaserButton_Click" runat="server" />
        <div id="bottomGrid" runat="server">

        <!--This grid contains all internal information about the gift card's purchase. It can only be viewed and edited by the site owner.-->

        <asp:GridView ID="allgridBottom" class="grid" OnRowDataBound="allgridBottom_RowDataBound"
        BorderStyle="Solid" BorderWidth="1" BorderColor="Black" AutoGenerateColumns="False" GridLines="Both"
        OnRowEditing="allgridBottom_RowEditing" OnPageIndexChanging="allgridBottom_PageIndexChanging"
        runat="server">
        <HeaderStyle HorizontalAlign="Center" BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
        <RowStyle HorizontalAlign="Center" BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
            <Columns>
                <asp:TemplateField HeaderText="Vendor Purchased From">
                    <EditItemTemplate>
                        <asp:TextBox ID="vendorText" Text='<%# Bind("VendorPurchasedFrom") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="vendorPurchasedFrom" Text='<%# Bind("VendorPurchasedFrom") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date Purchased">
                    <EditItemTemplate>
                        <asp:TextBox ID="datePurchasedText" Text='<%# Bind("DatePurchased") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="datePurchased" Text='<%# Bind("DatePurchased") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Purchased By">
                    <EditItemTemplate>
                        <asp:TextBox ID="purchasedByText" Text='<%# Bind("PurchasedBy") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="purchasedBy" Text='<%# Bind("PurchasedBy") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Gift Card Serial Number">
                    <EditItemTemplate>
                        <asp:TextBox ID="serialNumberText" Text='<%# Bind("GiftCardSerialNumber") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="serialNumber" Text='<%# Bind("GiftCardSerialNumber") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date Given">
                    <EditItemTemplate>
                        <asp:TextBox ID="dateGivenText" Text='<%# Bind("DateGiven") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="dateGiven" Text='<%# Bind("DateGiven") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Person Given To">
                    <EditItemTemplate>
                        <asp:TextBox ID="personGivenToText" Text='<%# Bind("PersonGivenTo") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="personGivenTo" Text='<%# Bind("PersonGivenTo") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date Info Sent to Payroll">
                    <EditItemTemplate>
                        <asp:TextBox ID="dateInfoSentToPayrollText" Text='<%# Bind("DateInfoSentToPayroll") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="dateInfoSentToPayroll" Text='<%# Bind("DateInfoSentToPayroll") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="W-9 Received">
                    <EditItemTemplate>
                        <asp:TextBox ID="w9ReceivedText" Text='<%# Bind("W9Received") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="w9Received" Text='<%# Bind("W9Received") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <EditItemTemplate>
                        <asp:TextBox ID="notesText" Text='<%# Bind("Notes") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="notes" Text='<%# Bind("Notes") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton3" Text="Update" runat="server" OnClick="allgridBottom_RowUpdating" />
                        <asp:LinkButton ID="LinkButton4" Text="Cancel" runat="server" OnClick="allgridBottom_RowCancelingEdit" />
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        </div>
        </ContentTemplate>
        </asp:UpdatePanel>
    </div><!--End of all menu-->
</div>
</div>