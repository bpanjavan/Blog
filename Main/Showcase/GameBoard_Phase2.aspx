<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Showcase.master" AutoEventWireup="true" CodeFile="GameBoard_Phase1.aspx.cs" Inherits="Showcase_Intrepid_Phase1" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
<title>GameBoard Phase 2</title>
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
<h4>Phase 2 - The Game</h4>
</asp:Content>
<asp:Content ID="contentMain" ContentPlaceHolderID="ContentPlaceHolderMain" Runat="Server">
    <div id="silverlightControlHost" 
        style="margin-left:5px; margin-right:auto; text-align:left;
                border:solid 0px green;">
<p>
<b>Requirements:</b>
<br />
" 'Game' in this context refers to a match between the player team and the opponent (computer) team.  A turn based game has most often 2, but potentially 3 teams occupying the board.  They are: allies, opponents, and other team.  Each team is a set of characters, each of which typically occupies one space on the board (but a character might occupy more than one space)."
</p>
<p>
"The game proceeds in phases.  1 phase for each team.  During each team's phase each character on the team may perform their allowed actions, then they are finished.  Under circumstances, a character may be re-enabled to perform actions (deferred).  When all characters on a team have finished, the phase ends and the next phase initiates.  Additionally, the phase can be ended before all characters act (deferred)."
</p>
<p>
<b>Testing:</b>
<br />
&nbsp;&nbsp;1. First notice bottom output indicating the current game phase.  The beginning phase is the player phase.<br />
&nbsp;&nbsp;2. Click one of the spaces occupied by a player (blue) piece.  Then click any unoccupied space.    Notice the piece moves, then darkens, indicating it is now inactive.<br />
&nbsp;&nbsp;3. Repeat step 2 until all player pieces have finished moving.  In this case there are only 2 player pieces.<br />
&nbsp;&nbsp;4. The bottom output indicates the phase shift to opponent phase.  The opponent pieces move one by one.  Then the opponent phase ends and the phase shifts back to player.<br />
</p>
<center>
        <object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="800" height="500">
		  <param name="source" value="/Intrepid/ClientBin/Intrepid.App.xap"/>
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
&nbsp;&nbsp;1.  Phase 1 was mostly graphical.  Now that the concept of a game is introduced, the real programming begins.  Classes were created to represent the game, the player teams, the characters, etc.<br />
&nbsp;&nbsp;2.  Recall that we're using the MVC (Model-View-Controller) pattern.  Every object fires events to alert the UI of what to do next.  In this case, the UI must take these events (ex: piece moved, character turn ended) and queue them up in order to allow the current event (ex: player moving) to finish then execute the next event.<br />
&nbsp;&nbsp;3. The opponent pieces needed to move on their own.  Albeit the AI isn't very sophisticated, I still needed to introduce an AI that would assess the character piece's current position, and move in accordance to a valid space.<br />
</p>
</div>
</asp:Content>

