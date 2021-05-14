using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication {
    public partial class _Default : Page {
        protected void Page_Load(object sender, EventArgs e) {
            var cust = (AirtoursBusinessObjects.Customer) Session["customer"];

            Label1.Text = cust?.Fname ?? "-";
        }
    }
}
