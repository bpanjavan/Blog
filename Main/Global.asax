<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Application Language="C#" %>
<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="BlogEngine.Core" %>
<%@ Import Namespace="BlogEngine.Core.Web.Controls" %>
<%@ Import Namespace="BlogEngine.Core.Web" %>

<script RunAt="server">
  /// <summary>
  /// Hooks up the available extensions located in the App_Code folder.
  /// An extension must be decorated with the ExtensionAttribute to work.
  /// <example>
  ///  <code>
  /// [Extension("Description of the SomeExtension class")]
  /// public class SomeExtension
  /// {
  ///   //There must be a parameterless default constructor.
  ///   public SomeExtension()
  ///   {
  ///     //Hook up to the BlogEngine.NET events.
  ///   }
  /// }
  /// </code>
  /// </example>
  /// </summary>
  void Application_Start(object sender, EventArgs e)
  {
      //ArrayList codeAssemblies = Utils.CodeAssemblies();
      //foreach (Assembly a in codeAssemblies)
      //{
      //    Type[] types = a.GetTypes();
      //    foreach (Type type in types)
      //    {
      //        object[] attributes = type.GetCustomAttributes(typeof(ExtensionAttribute), false);
      //        foreach (object attribute in attributes)
      //        {
      //            if (ExtensionManager.ExtensionEnabled(type.Name))
      //            {
      //                a.CreateInstance(type.FullName);
      //            }
      //        }
      //    }
      //}
  }

  /// <summary>
  /// Sets the culture based on the language selection in the settings.
  /// </summary>
  void Application_PreRequestHandlerExecute(object sender, EventArgs e)
  {
    if (!string.IsNullOrEmpty(BlogSettings.Instance.Culture))
    {
      if (!BlogSettings.Instance.Culture.Equals("Auto"))
      {
        CultureInfo culture = CultureInfo.CreateSpecificCulture(BlogSettings.Instance.Culture);
        Thread.CurrentThread.CurrentUICulture = culture;
        Thread.CurrentThread.CurrentCulture = culture;
      }
    }
  }
 
</script>

