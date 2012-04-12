<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Task List</title>
    <style type="text/css">
        .tablecell
        {
            border:solid 1px green;
            background-color:Transparent;
        }
        .tableRow
        {
            background-color:#ffffff;
        }
        .tableRowHover
        {
            background-color:#eeeeff;
        }
        .tableRowSelect
        {
            background-color:#ccccff;
        }
    </style>
    <script src="Scripts/jquery-1.3.2.js" type="text/javascript"></script>
    <script src="Scripts/json.js" type="text/javascript"></script>
    <script type="text/javascript">
        <!--
        
        var intSelectedRow = -1;
        var intEditRow = -1;
        var colTaskList = null;
    
        // document.ready is faster than onload because it fires when the doc is ready to be worked on
        $(document).ready(function() {

            colTaskList = new Array();
            LoadSamePageData();

        });
    
        // load same page data
        function LoadSamePageData() {
            $("#divDummyData").load("Default.aspx",
                                    { CallBack: "Data_Tasks" },
                                    DataCallBack
                                    );
            //event.preventDefault();
        }

        // callback method
        function DataCallBack(result) {
            //alert("Callback received: " + result);
            
            // parse the data and start building the table
            colTaskList = eval('(' + result + ')');
            BindTaskList();
        }

        /*---------- Task List Operations ---------*/

        function trTaskRow_click(trRow) {
            //alert("mouse move");
            // clear any selected row
            SelectRow(trRow.currentTarget.pt_rowid);
        }

        function SelectRow(intIndex) {
            intSelectedRow = -1;
            for (var i = 0; i < colTaskList.length; i++) {
                $("#trTaskRow" + i.toString()).removeClass("tableRow");
                $("#trTaskRow" + i.toString()).removeClass("tableRowHighlight");
                $("#trTaskRow" + i.toString()).removeClass("tableRowSelect");
            }
            if (intIndex > -1) {
                $("#trTaskRow" + intIndex.toString()).addClass("tableRowSelect");
                intSelectedRow = intIndex;
            }
        }
        
        function trTaskRow_mousemove(trRow) {
            //alert("mouse move");
            $("#" + trRow.currentTarget.id).removeClass("tableRow");
            $("#" + trRow.currentTarget.id).addClass("tableRowHover");
        }

        function trTaskRow_mouseout(trRow) {
            //alert("mouse move");
            $("#" + trRow.currentTarget.id).removeClass("tableRowHover");
            $("#" + trRow.currentTarget.id).addClass("tableRow");
        }

        function BindTaskList() {
            $("#tblTaskList").empty();
            for (var i = 0; i < colTaskList.length; i++) {

                var currTask = colTaskList[i];
                if (i == intEditRow) {
                    // grab the HTML Edit template
                    var tblRowTemplate = document.getElementById("trEditRowTemplate");
                    var strRowHTML = tblRowTemplate.innerHTML;
                    strRowHTML = strRowHTML.replace("tdEditCheckBox", "tdEditCheckBox" + i.toString());
                    strRowHTML = strRowHTML.replace("tdEditDescription", "tdEditDescription" + i.toString());
                    strRowHTML = strRowHTML.replace("textDescription", "textDescription" + i.toString());
                    // this one we do NOT prefix with Edit because it also exists on the non-edit template
                    strRowHTML = strRowHTML.replace("checkboxEditIsComplete", "checkboxIsComplete" + i.toString());
                    strRowHTML = strRowHTML.replace("tdEditDueDate", "tdEditDueDate" + i.toString());
                    strRowHTML = strRowHTML.replace("textDueDate", "textDueDate" + i.toString());
                    strRowHTML = strRowHTML.replace("tdEditEdit", "tdEditEdit" + i.toString());
                    strRowHTML = strRowHTML.replace("buttonEditSave", "buttonEditSave" + i.toString());

                    $("#tblTaskList").append("<tr id=\"trTaskRow" + i.toString() + "\">" + strRowHTML + "</tr>");
                    $("#trTaskRow" + i.toString()).addClass("tableRow");
                    $("#trTaskRow" + i.toString()).mousemove(trTaskRow_mousemove);
                    $("#trTaskRow" + i.toString()).mouseout(trTaskRow_mouseout);
                    $("#trTaskRow" + i.toString()).click(trTaskRow_click);
                    var trTaskRow = document.getElementById("trTaskRow" + i.toString());
                    trTaskRow.pt_rowid = i;

                    var checkboxIsComplete = document.getElementById("checkboxIsComplete" + i.toString());
                    checkboxIsComplete.checked = currTask.isComplete;
                    var textDescription = document.getElementById("textDescription" + i.toString());
                    textDescription.value = currTask.description;
                    //$("#tdDescription" + i.toString()).append(currTask.description);
                    // parsing date, ex: 2010-01-04
                    var strYear = currTask.dueDate.substring(0, 4);
                    var strMonth = currTask.dueDate.substring(5, 7);
                    var strDay = currTask.dueDate.substring(8, 10);
                    var strDueDate = strMonth + "/" + strDay + "/" + strYear; //Date.parse(strDay + "/" + strMonth + "/" + strYear);
                    var textDueDate = document.getElementById("textDueDate" + i.toString());
                    textDueDate.value = strDueDate;

                }
                else {
                    // grab the HTML template
                    var tblRowTemplate = document.getElementById("trRowTemplate");
                    var strRowHTML = tblRowTemplate.innerHTML;
                    strRowHTML = strRowHTML.replace("tdCheckBox", "tdCheckBox" + i.toString());
                    strRowHTML = strRowHTML.replace("tdDescription", "tdDescription" + i.toString());
                    strRowHTML = strRowHTML.replace("checkboxIsComplete", "checkboxIsComplete" + i.toString());
                    strRowHTML = strRowHTML.replace("tdDueDate", "tdDueDate" + i.toString());
                    strRowHTML = strRowHTML.replace("tdEdit", "tdEdit" + i.toString());
                    strRowHTML = strRowHTML.replace("buttonEdit", "buttonEdit" + i.toString());

                    $("#tblTaskList").append("<tr id=\"trTaskRow" + i.toString() + "\">" + strRowHTML + "</tr>");
                    $("#trTaskRow" + i.toString()).addClass("tableRow");
                    $("#trTaskRow" + i.toString()).mousemove(trTaskRow_mousemove);
                    $("#trTaskRow" + i.toString()).mouseout(trTaskRow_mouseout);
                    $("#trTaskRow" + i.toString()).click(trTaskRow_click);
                    var trTaskRow = document.getElementById("trTaskRow" + i.toString());
                    trTaskRow.pt_rowid = i;

                    var checkboxIsComplete = document.getElementById("checkboxIsComplete" + i.toString());
                    checkboxIsComplete.checked = currTask.isComplete;
                    $("#tdDescription" + i.toString()).append(currTask.description);
                    // parsing date, ex: 2010-01-04
                    var strYear = currTask.dueDate.substring(0, 4);
                    var strMonth = currTask.dueDate.substring(5, 7);
                    var strDay = currTask.dueDate.substring(8, 10);
                    var strDueDate = strMonth + "/" + strDay + "/" + strYear; //Date.parse(strDay + "/" + strMonth + "/" + strYear);
                    $("#tdDueDate" + i.toString()).append(strDueDate);
                }
            }
        }

    /*----- Event Handlers -----*/

        function buttonLoadAll_click(buttonLoadAll) {
            LoadSamePageData();          
            return false;
        }


        function buttonMoveUp_click(buttonMoveUp) {
            // if there is no row selected, or if the selected row is zero then return
            if (intSelectedRow == -1 || intSelectedRow == 0)
                return;
            // swap it with the one behind it, then re-databind
            var tempTask = colTaskList[intSelectedRow - 1];
            colTaskList[intSelectedRow - 1] = colTaskList[intSelectedRow];
            colTaskList[intSelectedRow] = tempTask;

            BindTaskList();
            SelectRow(intSelectedRow - 1);
            return false;
        }

        function buttonMoveDown_click(buttonMoveDown) {
            // if there is no row selected, or if the selected row is zero then return
            if (intSelectedRow == -1 || intSelectedRow == colTaskList.length - 1)
                return;
            // swap it with the one in front of it, then re-databind
            var tempTask = colTaskList[intSelectedRow + 1];
            colTaskList[intSelectedRow + 1] = colTaskList[intSelectedRow];
            colTaskList[intSelectedRow] = tempTask;

            BindTaskList();
            SelectRow(intSelectedRow + 1);
            return false;
        }
        
        function buttonEdit_click(buttonEdit) {
            // get the parent of the button, which is the td
            var tdCell = buttonEdit.parentNode;
            var trTaskRow = tdCell.parentNode;
            var rowId = trTaskRow.pt_rowid;
            
            // change the edit row index and re-bind
            intEditRow = rowId;
            BindTaskList();
            return false;
        }

        function buttonDelete_click(buttonDelete) {
            // get the parent of the button, which is the td
            var tdCell = buttonDelete.parentNode;
            var trTaskRow = tdCell.parentNode;
            var rowId = trTaskRow.pt_rowid;

            // get a new array, copy over all values except this one
            var intCtrOrig = 0;
            var intCtrNew = 0;

            var colNewList = new Array();
            while (intCtrOrig < colTaskList.length) {
                if (intCtrOrig != rowId) {
                    colNewList[intCtrNew] = colTaskList[intCtrOrig];
                    intCtrOrig++;
                    intCtrNew++;
                }
                else {
                    intCtrOrig++;               
                }
            }

            colTaskList = colNewList;
            
            BindTaskList();

            return false;
        }

        function checkboxIsComplete_click(checkboxIsComplete) {
            // get the rowId
            var tdCell = checkboxIsComplete.parentNode;
            var trTaskRow = tdCell.parentNode;
            var rowId = trTaskRow.pt_rowid;

            // if we're in normal mode, automatically change the value
            if (intEditRow == -1) {
                var task = colTaskList[rowId];
                task.isComplete = checkboxIsComplete.checked;
            }

            return false;
        
        }
      
      function buttonEditSave_click(buttonSave)
      {
          // get the parent of the button, which is the td
          var tdCell = buttonSave.parentNode;
          var trTaskRow = tdCell.parentNode;
          var rowId = trTaskRow.pt_rowid;       // the row id we're on

          // use the row id to get values
          var checkboxIsComplete = document.getElementById("checkboxIsComplete" + rowId.toString());
          var textDescription = document.getElementById("textDescription" + rowId.toString());
          var textDueDate = document.getElementById("textDueDate" + rowId.toString());

          // save our data to the current task
          var currTask = colTaskList[rowId];
          currTask.isComplete = checkboxIsComplete.checked;
          currTask.description = textDescription.value;
          // the date is in this format: 01/04/1984
          // need to parse out the pieces
          var strDate = textDueDate.value;
          var arrStrDate = strDate.split("/");
          var strYear = arrStrDate[2];
          var strMonth = arrStrDate[0];
          if (strMonth.length == 1)
              strMonth = "0" + strMonth;
          var strDay = arrStrDate[1];
          if (strDay.length == 1)
              strDay = "0" + strDay;
          currTask.dueDate = strYear + "-" + strMonth + "-" + strDay;

          intEditRow = -1;
          BindTaskList();
          return false;
      }

      function buttonEditCancel_click(buttonEditCancel) {
          intEditRow = -1;
          BindTaskList();
          return false;
      }        
      
      function buttonSaveAll_click(buttonSaveAll)
      {
        // serialize the task list as a JSon string
        var strJSONString = JSON.stringify(colTaskList);

        // then make the callback
        $("#divDummyData").load("Default.aspx",
                                    { CallBack: "Save_Tasks",Data: strJSONString },
                                    SaveCallBack
                                    );       
        return false;
    }

    // callback method
    function SaveCallBack(result) {
        alert("Callback received: " + result);
    }

    function buttonAdd_click(buttonAdd) {
        // if there are 10 tasks already don't allow them to add more
        if (colTaskList.length >= 10) {
            alert("You cannot add more than 10 tasks");
            return false;
        }
    
        // add the new task to the end of the list
        var newTask = new Object();
        newTask.isComplete = false;
        newTask.description = "";
        var d = new Date();
        var strYear = d.getFullYear();
        var strMonth = (d.getMonth() + 1).toString();
        if (strMonth.length == 1)
            strMonth = "0" + strMonth;
        var strDay = d.getDate().toString();
        newTask.dueDate = strYear + "-" + strMonth + "-" + strDay;

        var len = colTaskList.length;
        colTaskList[len] = newTask;
        intEditRow = len;
        BindTaskList();

        //d.getDate()
        //(d.getMonth() + 1).toString().length

        return false;
    }
    //-->
    </script>
</head>
<body>
    <form id="formMain" runat="server">
    <div id="divDummyData" style="display:none;"></div>
    <div style=" position:absolute; top:50px; left:50px; width:1000px; border:solid 0px red;">
        <table id="tableLoadAndFilter" style="border:solid 0px black; width:1000px;" cellspacing="0">
            <tr>
                <td style="text-align:right;">
                    <button id="buttonLoadAll" onclick="return buttonLoadAll_click(this);">Load All</button>
                </td>
            </tr>
        </table>
        <table id="tblTaskList" style="border:solid 1px black; width:1000px;" cellspacing="0">
        </table>
        <table id="tblTaskListTemplate" style="width:1000px; display:none;" cellspacing="0">
            <tr id="trRowTemplate" 
                class="tableRow"
                >
                <td id="tdCheckBox" class="tablecell" style="width:50px; text-align:center;">
                    <input id="checkboxIsComplete" type="checkbox" onchange="return checkboxIsComplete_click(this);"/>
                </td>
                <td id="tdDescription" class="tablecell" style="width:700px">
                    
                </td>
                <td id="tdDueDate" class="tablecell" style="width:100px">
                
                </td>
                <td id="tdEdit" class="tablecell" style="width:150px; text-align:center;">
                    <button id="buttonEdit" onclick="return buttonEdit_click(this);">
                        Edit
                    </button>
                    <button id="buttonDelete" onclick="return buttonDelete_click(this);">
                        Delete
                    </button>
                </td>
            </tr>
            <tr id="trEditRowTemplate" 
                class="tableRow"
                >
                <td id="tdEditCheckBox" class="tablecell" style="width:50px; text-align:center;">
                    <input id="checkboxEditIsComplete" type="checkbox" />
                </td>
                <td id="tdEditDescription" class="tablecell" style="width:700px">
                    <input id="textDescription" style="width:580px" />
                </td>
                <td id="tdEditDueDate" class="tablecell" style="width:100px">
                    <input id="textDueDate" style="width:90px" />                
                </td>
                <td id="tdEditEdit" class="tablecell" style="width:150px; text-align:center;">
                    <button id="buttonEditSave" onclick="return buttonEditSave_click(this);">
                        Save
                    </button>
                    <button id="buttonCancel" onclick="return buttonEditCancel_click(this);">
                        Cancel
                    </button>
                </td>
            </tr>
        </table>
    </div>
    <div style=" position:absolute; top:50px; left:1050px; width:100px; border:solid 0px blue;">
        <button id="buttonMoveUp" 
                style=" position:absolute; top:0px; left:15px; height:30px; width:45px;"
                onclick="return buttonMoveUp_click(this);">
            Up
        </button>
        <button id="buttonMoveDown" 
                style=" position:absolute; top:35px; left:15px; height:30px; width:45px;"
                onclick="return buttonMoveDown_click(this);">
            Down
        </button>
        <button id="buttonSaveAll" 
                style=" position:absolute; top:70px; left:10px; height:40px; width:55px;"
                onclick="return buttonSaveAll_click(this);">
            Save All
        </button>
        <button id="buttonAdd" 
                style=" position:absolute; top:115px; left:10px; height:25px; width:45px;"
                onclick="return buttonAdd_click(this);">
            Add
        </button>
    </div>
    </form>
</body>
</html>
