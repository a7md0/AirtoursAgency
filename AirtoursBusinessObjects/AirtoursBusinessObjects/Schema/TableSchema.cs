using System;
using System.Data;
using System.Collections.Generic;

namespace AirtoursBusinessObjects.Schema {
    /// <summary>
    /// Table schema representation of a given table, custom made to replace the data-table output from the SQL command
    /// </summary>
    public class TableSchema {
        private Dictionary<string, TableSchemaColumn> columns;

        /// <summary>
        /// Construct new table schema from data-table
        /// </summary>
        /// <param name="dataTable">Table schema in data-table</param>
        public TableSchema(DataTable dataTable) {
            this.columns = new Dictionary<string, TableSchemaColumn>(); // Initialize new dictionary

            var properties = typeof(TableSchemaColumn).GetProperties(); // Get the properties of the table schema column (reflection)

            foreach (DataRow row in dataTable.Rows) { // For each row in the data-table
                var column = new TableSchemaColumn(); // Create new schema column

                foreach (var property in properties) { // For each property
                    var value = row[property.Name]; // Grab the value from the data-table row
                    if (value is DBNull) { // if the value is db-null
                        value = null; // set the value to null
                    }

                    property.SetValue(column, value); // Set property of the col to the value
                }

                this.columns.Add(column.ColumnName, column); // Add the column to the dictionary
            }
        }

        /// <summary>
        /// Getter for specific column
        /// </summary>
        /// <param name="column">Column name</param>
        /// <returns>TableSchemaColumn</returns>
        /// <example>tableSchema["ID"]</example>
        public TableSchemaColumn this[string column] => this.columns[column]; // Getter for a specific columns

        /// <summary>
        /// Check if the schema has a specific column
        /// </summary>
        /// <param name="column">Column name</param>
        /// <returns>Boolean indicating whether the column does exists</returns>
        public bool HasColumn(string column) => this.columns.ContainsKey(column);
    }

    public class TableSchemaColumn {
        public string ColumnName { get; set; }
        //public int ColumnOrdinal { get; set; }
        //public int ColumnSize { get; set; }
        //public short NumericPrecision { get; set; }
        //public short NumericScale { get; set; }
        //public bool IsUnique { get; set; }
        //public bool IsKey { get; set; }
        //public string BaseServerName { get; set; }
        //public string BaseCatalogName { get; set; }
        //public string BaseColumnName { get; set; }
        //public string BaseSchemaName { get; set; }
        //public string BaseTableName { get; set; }
        //public Type DataType { get; set; }
        public bool AllowDBNull { get; set; }
        //public int ProviderType { get; set; }
        //public bool IsAliased { get; set; }
        //public bool IsExpression { get; set; }
        //public bool IsIdentity { get; set; }
        public bool IsAutoIncrement { get; set; }
        //public bool IsRowVersion { get; set; }
        //public bool IsHidden { get; set; }
        //public bool IsLong { get; set; }
        //public bool IsReadOnly { get; set; }
        //public Type ProviderSpecificDataType { get; set; }
        public string DataTypeName { get; set; }
        //public string XmlSchemaCollectionDatabase { get; set; }
        //public string XmlSchemaCollectionOwningSchema { get; set; }
        //public string XmlSchemaCollectionName { get; set; }
        //public string UdtAssemblyQualifiedName { get; set; }
        //public int NonVersionedProviderType { get; set; }
        //public bool IsColumnSet { get; set; }
    }
}
