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
        protected static CustomerList customerList = new CustomerList();

        protected void Page_Load(object sender, EventArgs e) {
            if (!this.IsPostBack) { // If 1st visit (not post-back)
                CountryDropDownList.DataSource = Application.Get("countries"); // Get the all countries from the application
                CountryDropDownList.DataBind(); // Bind data to make them available
            }
        }

        /// <summary>
        /// Event called on the register button click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void RegisterButton_Click(object sender, EventArgs e) { // On the user clicking "Register"
            if (Page.IsValid) { // Call the validation from the page, if valid
                // Create new customer and assign the fields from the form
                Customer customer = new Customer {
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

                if (customerList.CheckChildRecords("Email", customer.Email)) { // Check for matching email
                    Response.Write("<script defer>alert(\"The provided email already exist, try to login.\");</script>"); // Show error message
                    return; // Exit method
                }

                if (customerList.Add(customer)) { // If the customer was added successfully
                    this.Session.Add("customer", customer); // Add the customer obj to the session

                    FormsAuthentication.RedirectFromLoginPage(customer.Email, false); // Redirect to default page or previous one
                }
            } else { // If not valid
                ValidationSummary.Visible = true; // Show the validation summary
            }
        }
    }
}
