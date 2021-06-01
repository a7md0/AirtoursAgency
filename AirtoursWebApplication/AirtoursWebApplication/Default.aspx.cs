using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication {
    public partial class _Default : Page {
        protected Customer customer => this.Session["customer"] as Customer;

        protected void Page_Load(object sender, EventArgs e) {
            if (customer is null == false) { // if the customer obj is not null
                this.WelcomeLabel.Text = $"Hello, {this.customer.Fname} {this.customer.Lname}!"; // change the welcome message
                this.HyperLink.Visible = false; // hide the join link
            }
            
        }
    }
}
