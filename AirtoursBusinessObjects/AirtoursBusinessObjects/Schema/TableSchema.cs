using System;
using System.Data;
using System.Collections.Generic;

namespace AirtoursBusinessObjects.Schema {
    public class TableSchema {
        private Dictionary<string, TableSchemaColumn> columns;

        public TableSchema(DataTable dataTable) {
            this.columns = new Dictionary<string, TableSchemaColumn>();

            var properties = typeof(TableSchemaColumn).GetProperties();

            foreach (DataRow row in dataTable.Rows) {
                var column = new TableSchemaColumn();

                foreach (var property in properties) {
                    var value = row[property.Name];
                    if (value is DBNull) {
                        value = null;
                    }

                    if (value is null && property.PropertyType.IsValueType) {
                        continue;
                    }

                    property.SetValue(column, value);
                }

                this.columns.Add(column.ColumnName, column);
            }
        }

        public TableSchemaColumn this[string column] => this.columns[column];
        public bool HasColumn(string column) => this.columns.ContainsKey(column);
    }

    public class TableSchemaColumn {
        public string ColumnName { get; set; }
        public int ColumnOrdinal { get; set; }
        public int ColumnSize { get; set; }
        public short NumericPrecision { get; set; }
        public short NumericScale { get; set; }
        public bool IsUnique { get; set; }
        public bool IsKey { get; set; }
        public string BaseServerName { get; set; }
        public string BaseCatalogName { get; set; }
        public string BaseColumnName { get; set; }
        public string BaseSchemaName { get; set; }
        public string BaseTableName { get; set; }
        public Type DataType { get; set; }
        public bool AllowDBNull { get; set; }
        public int ProviderType { get; set; }
        public bool IsAliased { get; set; }
        public bool IsExpression { get; set; }
        public bool IsIdentity { get; set; }
        public bool IsAutoIncrement { get; set; }
        public bool IsRowVersion { get; set; }
        public bool IsHidden { get; set; }
        public bool IsLong { get; set; }
        public bool IsReadOnly { get; set; }
        public Type ProviderSpecificDataType { get; set; }
        public string DataTypeName { get; set; }
        public string XmlSchemaCollectionDatabase { get; set; }
        public string XmlSchemaCollectionOwningSchema { get; set; }
        public string XmlSchemaCollectionName { get; set; }
        public string UdtAssemblyQualifiedName { get; set; }
        public int NonVersionedProviderType { get; set; }
        public bool IsColumnSet { get; set; }
    }
}
