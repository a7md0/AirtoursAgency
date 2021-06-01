using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication {
    public partial class Login : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void cmdLogin_Click(object sender, System.EventArgs e) {
            var email = txtUserName.Text;
            var password = txtUserPass.Text;

            if ((null == email) || (0 == email.Length) || (email.Length > 40)) {
                System.Diagnostics.Debug.WriteLine("[ValidateUser] Input validation of userName failed.");
                return;
            }

            // Check for invalid passWord.
            // passWord must not be null and must be between 1 and 25 characters.
            if ((null == password) || (0 == password.Length) || (password.Length > 25)) {
                System.Diagnostics.Debug.WriteLine("[ValidateUser] Input validation of passWord failed.");
                return;
            }

            var customerList = new CustomerList();

            var where = customerList.WhereClause
                                    .Where("Email", email)
                                    .Where("Password", password);

            var customer = customerList.FindOne(where);

            if (customer is null == false) {
                this.Session.Add("customer", customer);

                FormsAuthentication.RedirectFromLoginPage(customer.Email, false);
            }
        }
    }
}
