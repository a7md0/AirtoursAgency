using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects {
    public class EmployeeList : DataList<Employee> {
        const string TABLE_NAME = "Employees";

        public EmployeeList() : base(TABLE_NAME) { }

        protected override void GenerateList() {
            list.Clear();

            while (reader.Read()) {
                var employee = new Employee();
                base.SetValues(employee);

                list.Add(employee);
            }

            reader.Close();
            connection.Close();
        }
    }
}
