#region using

using System;
using System.Web;
using System.Web.UI;
using BlogEngine.Core.Web.Controls;
using BlogEngine.Core;

#endregion

/// <summary>
/// Breaks a post where [more] is found in the body and adds a link to full post.
/// </summary>
[Extension("Breaks a post where [more] is found in the body and adds a link to full post", "1.2", "BlogEngine.NET")]
public class BreakPost
{

  /// <summary>
  /// Hooks up an event handler to the Post.Serving event.
  /// </summary>
  static BreakPost()
  {
    Post.Serving += new EventHandler<ServingEventArgs>(Post_Serving);
  }

  /// <summary>
  /// Handles the Post.Serving event to take care of the [more] keyword.
  /// </summary>
  private static void Post_Serving(object sender, ServingEventArgs e)
  {
    if (!e.Body.Contains("[more]"))
      return;

    if (e.Location == ServingLocation.PostList)
    {
      AddMoreLink(sender, e);
    }
    else if (e.Location == ServingLocation.SinglePost)
    {
      PrepareFullPost(e);
    }
    else if (e.Location == ServingLocation.Feed)
    {
      e.Body = e.Body.Replace("[more]", string.Empty);
    }
  }

  /// <summary>
  /// Replaces the [more] string with a hyperlink to the full post.
  /// </summary>
  private static void AddMoreLink(object sender, ServingEventArgs e)
  {
    Post post = (Post)sender;
    int index = e.Body.IndexOf("[more]");
    string link = "<a class=\"more\" href=\"" + post.RelativeLink + "#continue\">" + Resources.labels.more + "...</a>";
    e.Body = e.Body.Substring(0, index) + link;
  }

  /// <summary>
  /// Replaces the [more] string on the full post page.
  /// </summary>
  private static void PrepareFullPost(ServingEventArgs e)
  {
    HttpRequest request = HttpContext.Current.Request;
    if (request.UrlReferrer == null || request.UrlReferrer.Host != request.Url.Host)
    {
      e.Body = e.Body.Replace("[more]", string.Empty);
    }
    else
    {
      e.Body = e.Body.Replace("[more]", "<span id=\"continue\"></span>");
    }
  }

}
