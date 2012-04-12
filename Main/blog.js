function $(id)
{
  return document.getElementById(id);
}

function SetFlag(iso)
{  
  if (iso.length > 0)
    flagImage.src = KEYwebRoot + "pics/flags/" + iso + ".png";
  else
    flagImage.src = KEYwebRoot + "pics/pixel.gif";
}

// Shows the preview of the comment
function ToggleCommentMenu(element)
{
  element.className = 'selected';
  if (element.id == 'preview')
  {
    $('compose').className = '';    
    $('commentCompose').style.display = 'none';
    $('commentPreview').style.display = 'block';
    $('commentPreview').innerHTML = '<img src="' + KEYwebRoot + 'pics/ajax-loader.gif" alt="Loading" />';
    var argument = $('commentPreview').innerHTML;
    AddComment(true);
  }
  else
  {
    $('preview').className = '';    
    $('commentPreview').style.display = 'none';
    $('commentCompose').style.display = 'block';    
  }
}

function EndShowPreview(arg, context)
{
  $('commentPreview').innerHTML = arg;
}

function AddComment(preview)
{
  var isPreview = preview == true;
  if (!isPreview)
  {
    $("btnSaveAjax").disabled = true;
    $("ajaxLoader").style.display = "inline";
    $("status").className = "";
    $("status").innerHTML = KEYsavingTheComment;
  }
  
  var author = nameBox.value;
  var email = emailBox.value;
  var website = websiteBox.value;
  var country = countryDropDown ? countryDropDown.value : "";  
  var content = contentBox.value;
  var notify = $("cbNotify").checked;
  var captcha = captchaField.value;
   
  var callback = isPreview ? EndShowPreview : AppendComment;
  var argument = author + "-|-" + email + "-|-" + website + "-|-" + country + "-|-" + content + "-|-" + notify + "-|-" + isPreview + "-|-" + captcha;
  
  WebForm_DoCallback('ctl00$cphBody$CommentView1',argument, callback,'comment',null,false);
  
  if (!isPreview && typeof OnComment != "undefined")
    OnComment(author, email, website, country, content);
}

function AppendComment(args, context)
{
  if (context == "comment")
  {
    var commentList = $("commentlist");
    
    if (commentList.innerHTML.length < 10)
      commentList.innerHTML = "<h1 id='comment'>" + KEYcomments + "</h1>"
      
    commentList.innerHTML += args;
    commentList.style.display = 'block';
    contentBox.value = "";
    $("ajaxLoader").style.display = "none";
    $("status").className = "success";
    
    if (!moderation)
      $("status").innerHTML = KEYcommentWasSaved;
    else
      $("status").innerHTML = KEYcommentWaitingModeration;    
  }
  
  $("btnSaveAjax").disabled = false;
}

function CheckAuthorName(sender, args)
{
  args.IsValid = true;
  
  if (checkName)
  {
    var author = postAuthor;
    var visitor = nameBox.value;  
    args.IsValid = !Equal(author, visitor);
  }
}

function AddBbCode(v) {
  try
  {
    if (contentBox.selectionStart) // firefox
    {      
      var pretxt = contentBox.value.substring(0, contentBox.selectionStart);
      var therest = contentBox.value.substr(contentBox.selectionEnd);
      var sel = contentBox.value.substring(contentBox.selectionStart, contentBox.selectionEnd);
      contentBox.value = pretxt + "[" + v + "]" + sel + "[/" + v + "]" + therest;
      contentBox.focus();
    }
    else if (document.selection && document.selection.createRange) // IE
    {
      var str = document.selection.createRange().text;
      contentBox.focus();
      var sel = document.selection.createRange();
      sel.text = "[" + v + "]" + str + "[/" + v + "]";
    }
  }
  catch (ex) {}
  
  return;
}

// Searches the blog based on the entered text and
// searches comments as well if chosen.
function Search(root)
{
  var input = $("searchfield");
  var check = $("searchcomments");
  
  var search = "search.aspx?q=" + encodeURIComponent(input.value);
  if (check != null && check.checked)
    search += "&comment=true";
  
  top.location.href = root + search;
  
  return false;
}

// Clears the search fields on focus.
function SearchClear(defaultText)
{
  var input = $("searchfield");
  if (input.value == defaultText)
    input.value = "";
  else if (input.value == "")
    input.value = defaultText;
}

function Rate(id, rating)
{
  CreateCallback("rating.axd?id=" + id + "&rating=" + rating, RatingCallback);
}

function RatingCallback(response)
{
  var rating = response.substring(0, 1);
  var status = response.substring(1);
  
  if (status == "OK")
  {
    if (typeof OnRating != "undefined")
      OnRating(rating);
    
    alert("You rating has been registered. Thank you!");
  }  
  else if (status == "HASRATED")
  {
    alert(KEYhasRated);
  }
  else
  {
    alert("An error occured while registering your rating. Please try again");
  }    
}

/// <summary>
/// Creates a client callback back to the requesting page
/// and calls the callback method with the response as parameter.
/// </summary>
function CreateCallback(url, callback)
{
  var http = GetHttpObject();
  http.open("GET", url, true);
  
  http.onreadystatechange = function() 
  {
	  if (http.readyState == 4) 
	  {
	    if (http.responseText.length > 0 && callback != null)
        callback(http.responseText);
	  }
  };
  
  http.send(null);
}

/// <summary>
/// Creates a XmlHttpRequest object.
/// </summary>
function GetHttpObject() 
{
    if (typeof XMLHttpRequest != 'undefined')
        return new XMLHttpRequest();
    
    try 
    {
        return new ActiveXObject("Msxml2.XMLHTTP");
    } 
    catch (e) 
    {
        try 
        {
            return new ActiveXObject("Microsoft.XMLHTTP");
        } 
        catch (e) {}
    }
    
    return false;
}

// Updates the calendar from client-callback
function UpdateCalendar(args, context)
{
  var cal = $('calendarContainer');
  cal.innerHTML = args;
  months[context] = args;
}

function ToggleMonth(year)
{
  var monthList = $("monthList");
  var years = monthList.getElementsByTagName("ul");
  for (i = 0; i < years.length; i++)
  {
    if (years[i].id == year)
    {
      var state = years[i].className == "open" ? "" : "open";
      years[i].className = state;
      break;
    }
  }
}

// Adds a trim method to all strings.
function Equal(first, second) 
{
  var f = first.toLowerCase().replace(new RegExp(' ','gi'), '');
  var s = second.toLowerCase().replace(new RegExp(' ','gi'), '');
	return f == s;
}

/*-----------------------------------------------------------------------------
                              XFN HIGHLIGHTER
-----------------------------------------------------------------------------*/
var xfnRelationships = ['friend', 'acquaintance', 'contact', 'met'
						            , 'co-worker', 'colleague', 'co-resident'
						            , 'neighbor', 'child', 'parent', 'sibling'
						            , 'spouse', 'kin', 'muse', 'crush', 'date'
						            , 'sweetheart', 'me'];

// Applies the XFN tags of a link to the title tag
function HightLightXfn()
{
  var content = $('content');
  if (content == null)
    return;
    
  var links = content.getElementsByTagName('a')
  for (i = 0; i < links.length; i++)
  {
    var link = links[i];
    var rel = link.getAttribute('rel');
    if (rel && rel != "nofollow") 
    {
      for (j = 0; j < xfnRelationships.length; j++)
      {
        if(rel.indexOf(xfnRelationships[j]) > -1)
        {
          link.title = 'XFN relationship: ' + rel;
          break;
        }
      }
    }
  }
}

// Adds event to window.onload without overwriting currently assigned onload functions.
// Function found at Simon Willison's weblog - http://simon.incutio.com/
function addLoadEvent(func)
{	
	var oldonload = window.onload;
	if (typeof window.onload != 'function')
	{
    	window.onload = func;
	} 
	else 
	{
		window.onload = function()
		{
			oldonload();
			func();
		}
	}
}

function filterByAPML()
{
  var width = document.documentElement.clientWidth + document.documentElement.scrollLeft;
  var height = document.documentElement.clientHeight + document.documentElement.scrollTop;
  document.body.style.position = 'static';

  var layer = document.createElement('div');
  layer.style.zIndex = 2;
  layer.id = 'layer';
  layer.style.position = 'absolute';
  layer.style.top = '0px';
  layer.style.left = '0px';
  layer.style.height = document.documentElement.scrollHeight + 'px';
  layer.style.width = width + 'px';
  layer.style.backgroundColor = 'black';
  layer.style.opacity = '.6';
  layer.style.filter += ("progid:DXImageTransform.Microsoft.Alpha(opacity=60)");
  document.body.appendChild(layer);  
  
  var div = document.createElement('div');
  div.style.zIndex = 3;
  div.id = 'apmlfilter';
  div.style.position = (navigator.userAgent.indexOf('MSIE 6') > -1) ? 'absolute' : 'fixed';
  div.style.top = '200px';
  div.style.left = (width / 2) - (400 / 2) + 'px';	
  div.style.height = '50px';
  div.style.width = '400px';
  div.style.backgroundColor = 'white';
  div.style.border = '2px solid silver';
  div.style.padding = '20px';
  document.body.appendChild(div);  
  
  var p = document.createElement('p');
  p.innerHTML = KEYapmlDescription;
  p.style.margin = '0px';
  div.appendChild(p);
  
  var form = document.createElement('form');
  form.method = 'get';
  form.style.display = 'inline';
  form.action = KEYwebRoot;
  div.appendChild(form);
  
  var textbox = document.createElement('input');
  textbox.type = 'text';
  textbox.value = getCookieValue('url') || 'http://',
  textbox.style.width = '325px';
  textbox.id = 'txtapml';
  textbox.name = 'apml';
  textbox.style.background = 'url('+KEYwebRoot+'pics/apml.png) no-repeat 2px center';
  textbox.style.paddingLeft = '16px';
  form.appendChild(textbox);
  textbox.focus();
  
  var button = document.createElement('input');
  button.type = 'submit';
  button.value = KEYfilter;
  button.onclick = function(){ location.href = KEYwebRoot + '?apml=' + encodeURIComponent($('txtapml').value)};  
  form.appendChild(button);
  
  var br = document.createElement('br');
  div.appendChild(br);
  
  var a = document.createElement('a');
  a.innerHTML = KEYcancel;
  a.href = 'javascript:void(0)';
  a.onclick = function() {document.body.removeChild($('layer'));document.body.removeChild($('apmlfilter'));document.body.style.position = '';};
  div.appendChild(a);
}

function getCookieValue(name)
{
  var cookie = new String(document.cookie);

  if (cookie != null && cookie.indexOf('comment=') > -1)
  {
    var start = cookie.indexOf(name + '=') + name.length + 1;
    var end = cookie.indexOf('&', start);
    if (end > start && start > -1)
      return cookie.substring(start, end);
  }
  
  return null;
}

addLoadEvent(HightLightXfn);
