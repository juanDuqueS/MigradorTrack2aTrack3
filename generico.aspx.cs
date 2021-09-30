using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Globalization;
using System.Drawing;
using System.Web.SessionState;
using System.Reflection;
using System.IO;

public partial class formularios_generico : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

      //wmSalir
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static void wmSalir()
    {
        HttpContext.Current.Session.Clear();
        HttpContext.Current.Session.Abandon();
 
    }

}