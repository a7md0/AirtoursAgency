using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication {
    public partial class Register : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!this.IsPostBack) {
                CountryDropDownList.DataSource = Application.Get("countries");
                CountryDropDownList.DataBind();
            }
        }

        protected void RegisterButton_Click(object sender, EventArgs e) {
            if (Page.IsValid) {
                var customerList = new CustomerList();
                var customer = new Customer {
                    Fname = this.FirstNameTextBox.Text.NullIfWhiteSpace(),
                    Lname = this.LastNameTextBox.Text.NullIfWhiteSpace(),
                    Phone = this.PhoneTextBox.Text.NullIfWhiteSpace(),
                    Address = this.AddressTextBox.Text.NullIfWhiteSpace(),
                    City = this.CityTextBox.Text.NullIfWhiteSpace(),
                    Country = this.CountryDropDownList.SelectedValue.NullIfWhiteSpace(),
                    Email = this.EmailTextBox.Text.NullIfWhiteSpace(),
                    Password = this.PasswordTextBox.Text.NullIfWhiteSpace(),
                    CreditCardNumber = this.CreditCardNumberTextBox.Text.NullIfWhiteSpace(),
                    SecurityCode = int.Parse(this.SecurityCodeTextBox.Text.DefaultIfWhiteSpace("000")),
                };

                if (customerList.Add(customer)) {
                    this.Session.Add("customer", customer);

                    FormsAuthentication.RedirectFromLoginPage(customer.Email, true);
                }
            } else {
                ValidationSummary.Visible = true;
            }
        }
    }
}
