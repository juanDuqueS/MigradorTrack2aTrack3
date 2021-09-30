using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace sesiones
{
    public static class clsSesiones
    {
        public static int Cod_Usuario { get; set; }
        public static string Id_Cliente { get; set; }
        public static string LlaveAutorizacion { get; set; }

    }
}
