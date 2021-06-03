using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

using AirtoursBusinessObjects;
using AirtoursBusinessObjects.Builder;

namespace AirtoursWebApplication {
    public partial class Login : System.Web.UI.Page {
        protected static CustomerList customerList = new CustomerList();

        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void LoginButton_Click(object sender, System.EventArgs e) {
            var email = txtUserName.Text;
            var password = txtUserPass.Text;

            if ((null == email) || (0 == email.Length) || (email.Length > 30)) {
                System.Diagnostics.Debug.WriteLine("[ValidateUser] Input validation of userName failed.");
                return;
            }

            // Check for invalid passWord.
            // passWord must not be null and must be between 1 and 25 characters.
            if ((null == password) || (0 == password.Length) || (password.Length > 25)) {
                System.Diagnostics.Debug.WriteLine("[ValidateUser] Input validation of passWord failed.");
                return;
            }

            // Build where clause matching an email and password as provided from the user
            WhereClause where = customerList.WhereClause
                                    .Where("Email", email)
                                    .Where("Password", password);

            Customer customer = customerList.FindOne(where); // Find matching customer with the where clause

            if (customer is null == false) { // if the obj is not null (found)
                this.Session.Add("customer", customer); // Add the customer obj to the session

                FormsAuthentication.RedirectFromLoginPage(customer.Email, false); // Redirect to default page or previous one
            } else {
                Response.Write("<script defer>alert(\"Invalid email or password are entered, please try again.\");</script>");
            }
        }
    }
}
