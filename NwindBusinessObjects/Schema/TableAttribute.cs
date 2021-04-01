using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects.Schema {
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct, AllowMultiple = false)]
    class TableAttribute : Attribute {
        /// <summary>
        /// Initializes a new instance of the TableAttribute.
        /// </summary>
        /// <param name="name">Table name</param>
        /// <param name="pkColumn">Primary column name</param>
        public TableAttribute(string name, string pkColumn) : base() {
            this.Name = name;
            this.PkColumn = pkColumn;
        }

        /// <summary>
        /// Gets the name of the table the model is mapped to.
        /// </summary>
        public string Name { get; private set; }

        /// <summary>
        /// Gets the name of the primary column name the model is mapped to.
        /// </summary>
        public string PkColumn { get; private set; }
    }
}
