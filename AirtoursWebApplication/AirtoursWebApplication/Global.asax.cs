using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

using System.Globalization;

namespace AirtoursWebApplication {
    public class Global : HttpApplication {
        void Application_Start(object sender, EventArgs e) {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            this.fillCountries();
        }

        void Session_Start() {
            if (Request.IsAuthenticated) {
                object customer = Session["customer"];

                if (customer is null) {
                    FormsAuthentication.SignOut();
                    FormsAuthentication.RedirectToLoginPage();
                }
            }
        }

        private void fillCountries() {
            List<string> countries = new List<string>() {
                "Bahrain", "Afghanistan", "Albania", "Algeria", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bangladesh", "Belarus", "Belgium", "Belize", "Bhutan", "Bolivia", "Bosnia & Herzegovina", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Cambodia", "Cameroon", "Canada", "Caribbean", "Chile", "China", "Colombia", "Congo (DRC)", "Costa Rica", "Côte d'Ivoire", "Croatia", "Cuba", "Czechia", "Denmark", "Djibouti", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Eritrea", "Estonia", "Ethiopia", "Faroe Islands", "Finland", "France", "Georgia", "Germany", "Greece", "Greenland", "Guatemala", "Haiti", "Honduras", "Hong Kong SAR", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Korea", "Kuwait", "Kyrgyzstan", "Laos", "Latin America", "Latvia", "Lebanon", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macao SAR", "Malaysia", "Maldives", "Mali", "Malta", "Mexico", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Myanmar", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan", "Palestine", "Panama", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Puerto Rico", "Qatar", "Réunion", "Romania", "Russia", "Rwanda", "Saudi Arabia", "Senegal", "Serbia", "Singapore", "Slovakia", "Slovenia", "Somalia", "South Africa", "Spain", "Sri Lanka", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Thailand", "Trinidad & Tobago", "Tunisia", "Turkey", "Turkmenistan", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Venezuela", "Vietnam", "World", "Yemen", "Zimbabwe"
            };

            Application.Add("countries", countries);
        }
    }
}
