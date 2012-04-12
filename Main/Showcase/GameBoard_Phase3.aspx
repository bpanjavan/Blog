<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Showcase.master" AutoEventWireup="true" CodeFile="GameBoard_Phase1.aspx.cs" Inherits="Showcase_Intrepid_Phase1" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
<title>GameBoard Phase 3</title>
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
<h4>Phase 3 - Battle</h4>
</asp:Content>
<asp:Content ID="contentMain" ContentPlaceHolderID="ContentPlaceHolderMain" Runat="Server">
    <div id="silverlightControlHost" 
        style="margin-left:5px; margin-right:auto; text-align:left;
                border:solid 0px green;">
<p>
<b>Requirements:</b>
<br />
"A battle takes place between 2 characters on the board.  A character can initiate a battle with an opponent character.  For this phase, after a character battles, they can no longer move for the turn.  The character who initiated the battle will always attack first.  The attack will subtract life points from the other character.  The total amount of damage is determined by various factors, including the strength of the attacker and the defense of the defender.  After the initial attack, the opponent will counterattack.  For this phase, the opponent will always counterattack.  The logic follows the same as the initial attack.  After both parties have completed their atack, the turn of the initiator ends."
</p>
<p>
"After an attack by either party, if a character's lifepoints reach zero, the battle ends.  Upon the battle ending, the piece who's lifepoints are zero will be removed from the board."
</p>
<p>
<b>Testing:</b>
<br />
&nbsp;&nbsp;1. Akin to the prior phase, select a player piece and move it by clicking an unoccupied space.  The intended attack range of the piece is shown, although for this phase you are able to attack an opponent occupying any space on the board (the coding is not very "tight" yet, allowing you to attack your own team, including yourself!).<br />
&nbsp;&nbsp;2. The menu on the right allows you to attack or end the character's turn.  Choose attack to proceed to attack an opponent piece. <br />
&nbsp;&nbsp;3. The cursor turns red as you now select a piece to attack.<br />
&nbsp;&nbsp;4. Once you select a piece to attack, the battle screen overlays the Game Board.  For this phase note the following details:<br />
&nbsp;&nbsp;&nbsp;&nbsp;- The player and opponent both start out with 20 life points.  These values are displayed in the upper corners of their respective sides.<br />
&nbsp;&nbsp;&nbsp;&nbsp;- The player has an attack power of 10, while the opponent has an attack power of 5.<br />
&nbsp;&nbsp;&nbsp;&nbsp;- Both players' defense is 0.  This means that when a character attacks, the full amount of their attack power will subtract against the life points of the opposing character.<br />
&nbsp;&nbsp;&nbsp;&nbsp;- You will witness the player attack first, then the opponent counter-attack.<br />
&nbsp;&nbsp;5. When a battle ends, the current character turn ends.  As stated in the requirements, at any moment if a character's life points are zero, their respective piece is removed from the board.<br />
</p>
<center>
        <object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="800" height="500">
		  <param name="source" value="/Intrepid/Phase3ClientBin/Intrepid.App.xap"/>
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
&nbsp;&nbsp;1. Obviously something had to be added graphically.  The addition meant more events fired from the model in which the UI had to queue up and show.<br />
&nbsp;&nbsp;2. More properties were added to the Character class to represent his attack, defense, and life-points.<br />
&nbsp;&nbsp;3. The order of the game is a little less linear now.  There are more possibilities, and more things to consider dependent on the player's choices.  A player's turn no longer immediately ends after movement, but another menu is shown and the model must wait for input from the UI.  The Game Board selection now has different modes of selection, dependent on what the model is waiting for.<br />
</p>
</div>
</asp:Content>

