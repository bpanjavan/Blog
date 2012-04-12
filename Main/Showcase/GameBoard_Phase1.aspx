<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Showcase.master" AutoEventWireup="true" CodeFile="GameBoard_Phase1.aspx.cs" Inherits="Showcase_Intrepid_Phase1" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
    <title>Game Board Phase 1</title>
    <style type="text/css">
    html, body {
	    height: 100%;
	    overflow: auto;
    }
    body {
	    padding: 0;
	    margin: 0;
    }
    #silverlightControlHost {
	    height: 100%;
	    text-align:center;
    }
    </style>
    <script type="text/javascript" src="/Intrepid/Silverlight.js"></script>
    <script type="text/javascript">
        function onSilverlightError(sender, args) {
            var appSource = "";
            if (sender != null && sender != 0) {
              appSource = sender.getHost().Source;
            }
            
            var errorType = args.ErrorType;
            var iErrorCode = args.ErrorCode;

            if (errorType == "ImageError" || errorType == "MediaError") {
              return;
            }

            var errMsg = "Unhandled Error in Silverlight Application " +  appSource + "\n" ;

            errMsg += "Code: "+ iErrorCode + "    \n";
            errMsg += "Category: " + errorType + "       \n";
            errMsg += "Message: " + args.ErrorMessage + "     \n";

            if (errorType == "ParserError") {
                errMsg += "File: " + args.xamlFile + "     \n";
                errMsg += "Line: " + args.lineNumber + "     \n";
                errMsg += "Position: " + args.charPosition + "     \n";
            }
            else if (errorType == "RuntimeError") {           
                if (args.lineNumber != 0) {
                    errMsg += "Line: " + args.lineNumber + "     \n";
                    errMsg += "Position: " +  args.charPosition + "     \n";
                }
                errMsg += "MethodName: " + args.methodName + "     \n";
            }

            throw new Error(errMsg);
        }
    </script>
</asp:Content>
<asp:Content ID="contentTop" ContentPlaceHolderID="ContentPlaceHolderTop" Runat="Server">
    <h4>Phase 1 - The Game Board</h4>
</asp:Content>
<asp:Content ID="contentMain" ContentPlaceHolderID="ContentPlaceHolderMain" Runat="Server">
    <div id="silverlightControlHost" 
        style="margin-left:5px; margin-right:auto; text-align:left;
                border:solid 0px green;">
<p>
<b>Requirements:</b>
<br />
"A game board is a flat plane divided by even sized square spaces.  The game board is used to host a game / match between 2 or more teams.  For this scope, we will create a game board that we can add pieces to and not yet be concerned about teams or the game / match.  Pieces can be moved from space to space.  2 pieces can NOT occupy the same space at the same time."
</p>
<p>
<b>Testing:</b>
<br />
&nbsp;&nbsp;1. Click on a space occupied by one of the pieces.<br />
&nbsp;&nbsp;2. Click on an unoccupied space.  The piece moves accordingly.<br />
</p>
<center>
        <object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="800" height="500">
		  <param name="source" value="/Intrepid/GameBoard/ClientBin/Intrepid.App.xap"/>
		  <param name="onError" value="onSilverlightError" />
		  <param name="background" value="white" />
		  <param name="minRuntimeVersion" value="3.0.40624.0" />
		  <param name="autoUpgrade" value="true" />
		  <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=3.0.40624.0" style="text-decoration:none">
 			  <img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style:none"/>
		  </a>
	    </object><iframe id="_sl_historyFrame" style="visibility:hidden;height:0px;width:0px;border:0px"></iframe>
</center>
<p>
<b>Challenges:</b><br />
&nbsp;&nbsp;1. My initial thought was to use one of Silverlight's data controls, like some sort of Data Grid View.  However, after a little thought I figured that just wouldn't suffice.  This is because the graphical layout had to me more dynamic and flexible than that, and the pieces had to animate movement across spaces.  The grid I needed was more for presentation and less a data-driven grid.<br />
&nbsp;&nbsp;2. I had to get around the idea that it was the pieces that were selected.  Notice that with the cursor, it's not the pieces that get selected, but the spaces that they occupy.  You often don't think about these things until you have to program them.<br />
</p>
</div>
</asp:Content>

