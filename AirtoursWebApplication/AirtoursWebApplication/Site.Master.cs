using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication {
    public partial class SiteMaster : MasterPage {
        protected void Page_Load(object sender, EventArgs e) {
            var customer = (Customer) this.Session["customer"];
            this.UserDisplayName.InnerText = $"Welcome {customer?.Fname} {customer?.Lname}";
        }

        protected void LogoutButton_Click(object sender, EventArgs e) {
            this.Session.RemoveAll();
            this.Session.Abandon();

            FormsAuthentication.SignOut();
            Response.Redirect("/");
        }
    }
}
