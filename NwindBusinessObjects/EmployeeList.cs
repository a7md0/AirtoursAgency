using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects {
    public class EmployeeList : DataList<Employee> {
        const string TABLE_NAME = "Employees";
        const string PK_COLUMN = "EmployeeID";

        public EmployeeList() : base(TABLE_NAME, PK_COLUMN) { }
    }
}
