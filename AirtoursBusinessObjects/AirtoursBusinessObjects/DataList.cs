using System;
using System.Collections.Generic;

using System.Reflection;
using System.Diagnostics;

using System.Data;
using System.Data.SqlClient;

namespace AirtoursBusinessObjects {
    using Builder;
    using Schema;

    public abstract partial class DataList<T> where T : Model, new() {
        protected readonly string table;
        protected readonly string pkColumn;

        protected SqlConnection connection;

        protected List<T> list;
        protected DataTable dataTable;
        protected TableSchema schema;

        protected PropertyInfo[] modelProperties;
        protected Dictionary<string, int> columnsOrdinals;

        protected string[] nonUpdateableColumns;

        public DataList() {
            TableAttribute tableAttribute = typeof(T).GetCustomAttribute<TableAttribute>(); // Get the table attribute linked to the model type

            this.table = tableAttribute.Name; // Extract the table name from the table attribute
            this.pkColumn = tableAttribute.PkColumn; // Extract the table pk from the table attribute

            this.connection = new SqlConnection(Properties.Settings.Default.AirtoursConnectionString); // Create new SQL connection from the connection string in the settings

            this.list = new List<T>(); // Create new list of type T where T is the model passed 
            this.dataTable = new DataTable(table); // Create new data table by the name of the current table

            this.modelProperties = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly); // Get the specific model T properties, for later usage
            this.columnsOrdinals = new Dictionary<string, int>(); // Create dictionary to hold column ordinals (sorting order from the database table)

            this.nonUpdateableColumns = new[] { this.pkColumn }; // Set the non-update-able columns (i.e. PK)

            this.SetDataTableColumns(); // Prepare data table column from the model properties
            this.FetchTableSchema(); // Fetch table schema for later usage
        }

        /// <summary>
        /// Table name used in this data list.
        /// </summary>
        public string Table => this.table;

        /// <summary>
        /// List of current fetched records.
        /// </summary>
        public List<T> List => this.list;

        /// <summary>
        /// DataTable containing the current rows.
        /// </summary>
        public DataTable DataTable => this.dataTable;

        /// <summary>
        /// The table schema specification.
        /// </summary>
        public TableSchema TableSchema => this.schema;

        /// <summary>
        /// Id column of this data list table.
        /// </summary>
        public string PkColumn => this.pkColumn;

        /// <summary>
        /// Create new model which type is associated with this list.
        /// </summary>
        public T NewModel => new T();

        /// <summary>
        /// Create new WhereClause passing the current schema.
        /// </summary>
        public WhereClause WhereClause => new WhereClause(this.schema);

        /// <summary>
        /// Open the connection if it is closed.
        /// <exception cref="InvalidOperationException"></exception>
        /// <exception cref="SqlException"></exception>
        /// </summary>
        protected void OpenConnection() {
            if (this.connection.State.HasFlag(ConnectionState.Closed)) { // if connection state has closed flag
                this.connection.Open(); // open connection
            }
        }

        /// <summary>
        /// Close the connection if it is opened.
        /// <exception cref="SqlException"></exception>
        /// </summary>
        protected void CloseConnection() {
            if (this.connection.State.HasFlag(ConnectionState.Open)) { // if connection state has open flag
                this.connection.Close(); // close connection
            }
        }

        /// <summary>
        /// Calculates the total of all values for a column parameter. (Design Document Requirement #1)
        /// </summary>
        /// <param name="totalColumn">Column to calculate</param>
        /// <returns>The total count of the given column</returns>
        public double TotalValue(string totalColumn) {
            return this.TotalValue<double>(totalColumn, null);
        }

        /// <summary>
        /// Query the maximum primary key value. (Design Document Requirement #2)
        /// </summary>
        /// <returns>Maximum id value</returns>
        public int GetMaxID() {
            return this.MaxValue<int>(this.pkColumn, null);
        }

        /// <summary>
        /// Calculates the total of values for a column parameter where another column parameter is equal to a value. (Design Document Requirement #3)
        /// </summary>
        /// <param name="totalColumn">Column to calculate</param>
        /// <param name="whereColumn">Condition column</param>
        /// <param name="whereValue">Condition value</param>
        /// <returns>The total value of the given column filtered by the given condition</returns>
        public double TotalValue(string totalColumn, string whereColumn, object whereValue) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(whereColumn, whereValue);

                return this.TotalValue<double>(totalColumn, whereClause);
            }
        }

        /// <summary>
        /// generates a list of Item objects where the value in a column parameter is equal to a value parameter, and the value in a second column parameter is equal to a second value parameter. (Design Document Requirement #4)
        /// </summary>
        /// <param name="whereColumn1">Condition column 1</param>
        /// <param name="whereValue1">Condition value 1</param>
        /// <param name="whereColumn2">Condition column 2</param>
        /// <param name="whereValue2">Condition value 2</param>
        public void Filter(string whereColumn1, object whereValue1, string whereColumn2, object whereValue2) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(whereColumn1, whereValue1);
                whereClause.Where(whereColumn2, whereValue2);

                this.Populate(whereClause);
            }
        }

        /// <summary>
        /// Calculates the total of values for a column parameter where two column parameters are equal to two value parameters. (Design Document Requirement #5)
        /// </summary>
        /// <param name="totalColumn">Column to calculate</param>
        /// <param name="whereColumn1">Condition column 1</param>
        /// <param name="whereValue1">Condition value 1</param>
        /// <param name="whereColumn2">Condition column 2</param>
        /// <param name="whereValue2">Condition value 2</param>
        /// <returns>The total value of the given column filtered by the given conditions</returns>
        public double TotalValue(string totalColumn, string whereColumn1, object whereValue1, string whereColumn2, object whereValue2) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(whereColumn1, whereValue1);
                whereClause.Where(whereColumn2, whereValue2);

                return this.TotalValue<double>(totalColumn, whereClause);
            }
        }

        /// <summary>
        /// Calculates the number of values in a column parameter where two column parameters are equal to two value parameters. (Design Document Requirement #6)
        /// </summary>
        /// <param name="whereColumn1">Condition column 1</param>
        /// <param name="whereValue1">Condition value 1</param>
        /// <param name="whereColumn2">Condition column 2</param>
        /// <param name="whereValue2">Condition value 2</param>
        /// <returns>The total count of the given column filtered by the given conditions</returns>
        public int TotalCount(string whereColumn1, object whereValue1, string whereColumn2, object whereValue2) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(whereColumn1, whereValue1);
                whereClause.Where(whereColumn2, whereValue2);

                return this.TotalCount(whereClause);
            }
        }

        /// <summary>
        /// Query sorted list of unique values for given column. (Design Document Requirement #7)
        /// </summary>
        /// <param name="column">Column name</param>
        /// <param name="ascending">Sort the list ascendingly</param>
        /// <returns>Sorted list of unique values</returns>
        public List<string> UniqueValues(string column, bool ascending = true) {
            return this.UniqueValues<string>(column, null, ascending);
        }

        /// <summary>
        /// Generates a list of Item objects where the value in a column parameter is equal to a value parameter, and the value in a second column parameter is greater than a second value parameter. (Design Document Requirement #8)
        /// </summary>
        /// <param name="whereColumn1">Condition column 1</param>
        /// <param name="whereValue1">Condition value 1</param>
        /// <param name="whereColumn2">Condition column 2</param>
        /// <param name="whereValue2">Condition value 2</param>
        public void FilterPlus(string whereColumn1, object whereValue1, string whereColumn2, object whereValue2) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(whereColumn1, whereValue1);
                whereClause.Where(whereColumn2, whereValue2);

                this.Populate(whereClause);
            }
        }

        /// <summary>
        /// Checks if there are any records where a column parameter is equal to a value parameter. (Design Document Requirement #9)
        /// </summary>
        /// <param name="whereColumn">Condition column</param>
        /// <param name="whereValue">Condition value</param>
        /// <returns>Whether there is any records matching the provided filters</returns>
        public bool CheckChildRecords(string whereColumn, object whereValue) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(whereColumn, whereValue);

                return this.CheckChildRecords(whereClause);
            }
        }

        /// <summary>
        /// Deletes records where a column parameter is equal to a value parameter. (Design Document Requirement #10)
        /// </summary>
        /// <param name="whereColumn">Condition column</param>
        /// <param name="whereValue">Condition value</param>
        public void Delete(string whereColumn, object whereValue) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(whereColumn, whereValue);

                this.Delete(whereClause);
            }
        }

        /// <summary>
        /// Deletes records from two joined tables where a column parameter is equal to a value parameter. (Design Document Requirement #11)
        /// </summary>
        /// <param name="whereColumn">Condition column</param>
        /// <param name="whereValue">Condition value</param>
        /// <param name="joinTable">Join table name</param>
        /// <param name="joinColumn">Join column name</param>
        public void Delete(string whereColumn, object whereValue, string joinTable, string joinColumn) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(whereColumn, whereValue);

                this.Delete(whereClause, joinTable, joinColumn);
            }
        }

        /// <summary>
        /// Generates a list of Item objects by joining two related tables where a column value parameter in a related table is equal to a value parameter. (Design Document Requirement #12)
        /// </summary>
        /// <param name="whereColumn">Condition column</param>
        /// <param name="whereValue">Condition value</param>
        /// <param name="joinTable">Join table name</param>
        /// <param name="joinColumn">Join column name</param>
        public void FilterJoin(string whereColumn, string whereValue, string joinTable, string joinColumn) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(whereColumn, whereValue);

                this.FilterJoin(whereClause, joinTable, joinColumn);
            }
        }

        /// <summary>
        /// Generates a list of Item objects by joining two related tables where the values in 3 column parameters are equal to three value parameters. (Design Document Requirement #13)
        /// </summary>
        /// <param name="whereColumn1">Condition column 1</param>
        /// <param name="whereValue1">Condition value 1</param>
        /// <param name="whereColumn2">Condition column 2</param>
        /// <param name="whereValue2">Condition value 2</param>
        /// <param name="joinTable">Join table name</param>
        /// <param name="joinColumn">Join column name</param>
        /// <param name="onColumn">On condition column</param>
        /// <param name="onValue">On condition value</param>
        public void Filter(string whereColumn1, object whereValue1, string whereColumn2, object whereValue2, string joinTable, string joinColumn, string onColumn, object onValue) {
            using (WhereClause whereClause = this.WhereClause)
            using (WhereClause onClause = new WhereClause()) {
                whereClause.Where(whereColumn1, whereValue1);
                whereClause.Where(whereColumn2, whereValue2);

                onClause.Where(onColumn, onValue);

                this.FilterJoin(whereClause, joinTable, joinColumn, onClause);
            }
        }
    }

    partial class DataList<T> {
        /// <summary>
        /// Construct the where clause for given model by the primary key
        /// </summary>
        /// <param name="model"></param>
        /// <returns>Where clause matching the model by primary key</returns>
        protected virtual WhereClause ModelWhereClause(T model) => this.WhereClause.Where(this.pkColumn, model.GetId());

        /// <summary>
        /// Re-fill the supplied model details from the database.
        /// </summary>
        /// <param name="model">Model with valid primary key</param>
        /// <returns></returns>
        public virtual bool Fill(T model) {
            bool found = false;

            using (SqlCommand command = this.connection.CreateCommand())
            using (WhereClause where = this.ModelWhereClause(model)) {
                string whereClause = string.Empty;

                if (where.HasAny) {
                    whereClause = $" WHERE {where.ToString()}";
                }

                command.CommandText = $"SELECT * FROM [{this.table}]{whereClause};";
                if (where?.Parameters is null == false) {
                    command.Parameters.AddRange(where?.Parameters);
                }

                try {
                    this.OpenConnection(); // Open the connection

                    using (SqlDataReader reader = command.ExecuteReader()) { // Execute reader on the command and dispose on the end
                        this.SetColumnsOrdinals(reader); // Set columns ordinals once
                        found = reader.HasRows; // if the reader has any rows

                        if (reader.Read()) {
                            this.SetValues(model, reader); // Set the values of the created model from the reader
                            model.SetError(null); // Reset the error
                        }
                    }
                } catch (Exception ex) {
                    model.SetError(ex.Message);

                    Debug.WriteLine(ex.Message, "DataList.Fill");
                } finally {
                    command.Parameters.Clear();
                    this.CloseConnection(); // Finally close the connection
                }
            }

            return found;
        }

        public virtual T FindOne(string whereColumn, object whereValue) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(whereColumn, whereValue);

                return this.FindOne(whereClause);
            }
        }

        /// <summary>
        /// Query one model with a given condition.
        /// </summary>
        /// <param name="where">Where condition</param>
        /// <returns></returns>
        public virtual T FindOne(WhereClause where) {
            T model = null;

            if (where is null || !where.HasAny) {
                throw new ArgumentNullException("WhereClause cannot be null or empty. Dangerous operation.");
            }

            using (SqlCommand command = this.connection.CreateCommand()) {
                SqlParameter[] sqlParameters = where?.Parameters;
                string whereClause = string.Empty;

                if (where.HasAny) {
                    whereClause = $" WHERE {where.ToString()}";
                }

                command.CommandText = $"SELECT TOP 1 * FROM [{this.table}]{whereClause};";
                if (sqlParameters is null == false) {
                    command.Parameters.AddRange(sqlParameters);
                }

                try {
                    this.OpenConnection(); // Open the connection

                    using (SqlDataReader reader = command.ExecuteReader()) { // Execute reader on the command and dispose on the end
                        this.SetColumnsOrdinals(reader); // Set columns ordinals once

                        if (reader.Read()) { // If the reader could read 1st row
                            // Create new model of type T (the generic type passed to the DataList) // And set inserted attribute to true.
                            model = new T {
                                Inserted = true
                            };

                            this.SetValues(model, reader); // Set the values of the created model from the reader
                        }
                    }
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "DataList.FindOne");
                } finally { // Either the try block is executed or catches an exception
                    command.Parameters.Clear();
                    this.CloseConnection(); // Finally close the connection
                }
            }

            return model;
        }

        /// <summary>
        /// Add new model to the database.
        /// </summary>
        /// <param name="model">Model instance</param>
        /// <returns></returns>
        public virtual bool Add(T model) {
            bool added = false;

            using (SqlCommand command = this.connection.CreateCommand()) // Create new command
            using (InsertClause insert = new InsertClause(this.schema)) { // Initialize insert clause for this table schema
                insert.Add(model, modelProperties); // Pass the model along with the properties

                if (insert.HasAny) {// If the insert has anything (it should)
                    string insertFields = insert.InsertFields; // Get the comma separated fields
                    string insertValues = insert.InsertValues; // Get the comma separated placeholders

                    command.Parameters.AddRange(insert.Parameters); // Add the SqlParamter array to the command
                    command.CommandText = $"INSERT INTO [{this.table}] ({insertFields}) OUTPUT INSERTED.{this.pkColumn} VALUES ({insertValues});"; // Construct the command text

                    try {
                        this.OpenConnection(); // Open the connection

                        object inserted_id = command.ExecuteScalar(); // insert and get the PK value
                        added = true; // indicate that the add is successful

                        if (inserted_id is null == false && inserted_id is DBNull == false) { // if the insert PK is not null
                            model.SetId(inserted_id); // Assign the id to the PK in the model
                        }

                        model.Inserted = true; // Indicate that the model as inserted

                        model.SetError(null); // Reset the errors if there's any
                    } catch (Exception ex) {
                        model.SetError(ex.Message); // Set the errors
                        Debug.WriteLine(ex.Message, "DataList.Add");
                    } finally {
                        command.Parameters.Clear();
                        this.CloseConnection(); // Finally close the connection
                    }
                }
            }

            return added;
        }

        /// <summary>
        /// Update an existing model in the database.
        /// </summary>
        /// <param name="model">Model instance, with valid primary key. Data will be pulled from this model and updated into the database, where the primary key is equal to the saved one</param>
        /// <returns>Whether the row was updated or not</returns>
        public virtual bool Update(T model) {
            using (SqlCommand command = this.connection.CreateCommand())
            using (SetClause set = new SetClause(this.schema))
            using (WhereClause where = this.ModelWhereClause(model)) {
                int affectedRows = 0;

                set.Add(model, modelProperties, this.nonUpdateableColumns);

                if (set.HasAny) {
                    string setClause = set.ToString();
                    string whereClause = $" WHERE {where.ToString()}";

                    command.CommandText = $"UPDATE [{this.table}] {setClause}{whereClause};";

                    if (set?.Parameters is null == false) {
                        command.Parameters.AddRange(set.Parameters);
                    }

                    if (where?.Parameters is null == false) {
                        command.Parameters.AddRange(where.Parameters);
                    }

                    try {
                        this.OpenConnection(); // Open the connection

                        affectedRows = command.ExecuteNonQuery(); // Execute non query and get the affected rows

                        model.SetError(null);
                    } catch (Exception ex) {
                        model.SetError(ex.Message);
                        Debug.WriteLine(ex.Message, "DataList.Update");
                    } finally {
                        command.Parameters.Clear();
                        this.CloseConnection(); // Finally close the connection
                    }
                }

                return affectedRows > 0; // Return whether the affected rows are greater than zero (bool)
            }
        }

        /// <summary>
        /// Delete an existing model in the database.
        /// </summary>
        /// <param name="model">Model instance, with valid primary key. The equivalent row will be deleted permanently from the database.</param>
        /// <returns>Whether the row was deleted or not</returns>
        public virtual bool Delete(T model) {
            using (SqlCommand command = this.connection.CreateCommand())
            using (WhereClause where = this.ModelWhereClause(model)) {
                int affectedRows = 0;

                string whereClause = $" WHERE {where.ToString()}";

                command.CommandText = $"DELETE FROM [{this.table}]{whereClause};";
                if (where?.Parameters is null == false) {
                    command.Parameters.AddRange(where.Parameters);
                }

                try {
                    this.OpenConnection(); // Open the connection

                    affectedRows = command.ExecuteNonQuery(); // Execute non query and get the affected rows

                    model.SetError(null);
                } catch (Exception ex) {
                    model.SetError(ex.Message);
                    Debug.WriteLine(ex.Message, "DataList.Delete");
                } finally {
                    command.Parameters.Clear();
                    this.CloseConnection(); // Finally close the connection
                }

                return affectedRows > 0; // Return whether the affected rows are greater than zero (bool)
            }
        }
    }

    partial class DataList<T> {
        /// <summary>
        /// Populate the list (SELECT *)
        /// </summary>
        public bool Populate() {
            return this.Populate(null);
        }

        /// <summary>
        /// Populate the list with a given condition. (Just for compatibility)
        /// </summary>
        /// <param name="field">Column name</param>
        /// <param name="value">Column value</param>
        /// <returns></returns>
        public bool Populate(string field, object value) {
            using (WhereClause whereClause = this.WhereClause) {
                whereClause.Where(field, value);

                return this.Populate(whereClause);
            }
        }

        /// <summary>
        /// Filter list based on model being the foreign key with additional filtering. (Design Document Requirement #8)
        /// </summary>
        /// <param name="model">Model to be considered the foreign key</param>
        /// <param name="where">Optional where clause for additional filters</param>
        /// <returns>Whether there were any matching results</returns>
        public bool FilterPlus(Model model, WhereClause where = null) {
            using (WhereClause whereClause = where?.Clone() ?? this.WhereClause) {
                TableAttribute tableAttribute = model.GetType().GetCustomAttribute<TableAttribute>();

                string fkColumn = tableAttribute.PkColumn;
                object fkValue = model.GetId();

                whereClause.Where(fkColumn, fkValue);

                return this.Populate(whereClause);
            }
        }

        /// <summary>
        /// Filter list based on model being the foreign key with additional filtering. (Design Document Requirement #8)
        /// </summary>
        /// <param name="fkColumn">Foreign key column name</param>
        /// <param name="fkValue">Foreign key value</param>
        /// <param name="where">Optional where clause for additional filters</param>
        /// <returns>Whether there were any matching results</returns>
        public bool FilterPlus(string fkColumn, object fkValue, WhereClause where = null) {
            using (WhereClause whereClause = where?.Clone() ?? this.WhereClause) {
                whereClause.Where(fkColumn, fkValue);

                return this.Populate(whereClause);
            }
        }

        /// <summary>
        /// Filter the current list based on filters and being joined to another table. (Design Document Requirements #12)
        /// </summary>
        /// <param name="where">Where clause filters</param>
        /// <param name="joinTable">Table name to join with</param>
        /// <param name="joinColumn">Join column between two tables</param>
        /// <returns>Whether there were any matching results</returns>
        public bool FilterJoin(WhereClause where, string joinTable, string joinColumn) => this.FilterJoin(where, joinTable, joinColumn, null);

        /// <summary>
        /// Filter the current list based on filters and being joined to another table. (Design Document Requirements #13)
        /// </summary>
        /// <param name="where">Where clause filters</param>
        /// <param name="on">On clause filters</param>
        /// <param name="joinTable">Table name to join with</param>
        /// <param name="joinColumn">Join column between two tables</param>
        /// <returns>Whether there were any matching results</returns>
        public bool FilterJoin(WhereClause where, string joinTable, string joinColumn, WhereClause on) {
            using (SqlCommand command = this.connection.CreateCommand()) {
                string whereClause = string.Empty;
                string onClause = string.Empty;

                if (where is null == false && where.HasAny) {
                    whereClause = $" WHERE {where.ToString("T")}";
                }

                if (on is null == false && on.HasAny) {
                    onClause = $" AND {on?.ToString("J")}";
                }

                command.CommandText = $@"SELECT T.* FROM [{this.table}] T
                                         INNER JOIN [{joinTable}] J
                                            ON T.[{joinColumn}] = J.[{joinColumn}]{onClause}
                                         {whereClause};";

                if (where?.Parameters is null == false) {
                    command.Parameters.AddRange(where?.Parameters);
                }

                if (on?.Parameters is null == false) {
                    command.Parameters.AddRange(on?.Parameters);
                }

                return this.PopulateWithQuery(command); // Call the base populate with query passing the command
            }
        }

        /// <summary>
        /// Filter the current list based on filters and being joined to three tables.
        /// </summary>
        /// <param name="where">Where clause filters</param>
        /// <param name="joinTable">Table name to join with</param>
        /// <param name="joinColumn">Join column with the previous table</param>
        /// <param name="joinTable2">Table name to join with</param>
        /// <param name="joinColumn2">Join column with the previous table</param>
        /// <param name="joinTable3">Table name to join with</param>
        /// <param name="joinColumn3">Join column with the previous table</param>
        /// <param name="on3">On clause filters for third join</param>
        /// <returns></returns>
        public bool FilterJoin(WhereClause where, string joinTable, string joinColumn, string joinTable2, string joinColumn2, string joinTable3, string joinColumn3, WhereClause on3) {
            using (SqlCommand command = this.connection.CreateCommand()) {
                string whereClause = string.Empty;
                string onClause = string.Empty;

                if (where is null == false && where.HasAny) {
                    whereClause = $" WHERE {where.ToString("T")}";
                }

                if (on3 is null == false && on3.HasAny) {
                    onClause = $" AND {on3?.ToString("J3")}";
                }

                command.CommandText = $@"SELECT DISTINCT T.* FROM [{this.table}] T

                                        INNER JOIN [{joinTable}] J1
                                            ON T.{joinColumn} = J1.{joinColumn}
                                        INNER JOIN [{joinTable2}] J2
                                            ON J1.[{joinColumn2}] = J2.[{joinColumn2}]
                                        INNER JOIN [{joinTable3}] J3
                                            ON J2.[{joinColumn3}] = J3.[{joinColumn3}]{onClause}

                                        {whereClause};";

                if (where?.Parameters is null == false) {
                    command.Parameters.AddRange(where?.Parameters);
                }

                if (on3?.Parameters is null == false) {
                    command.Parameters.AddRange(on3?.Parameters);
                }

                return this.PopulateWithQuery(command); // Call the base populate with query passing the command
            }
        }

        /// <summary>
        /// Populate the current list based on provided filters (Design Document Requirement #4)
        /// </summary>
        /// <param name="where">Where clause filters (Optional)</param>
        /// <returns>Whether there were any matching results</returns>
        public bool Populate(WhereClause where) {
            using (SqlCommand command = this.connection.CreateCommand()) {
                SqlParameter[] sqlParameters = where?.Parameters;
                string whereClause = string.Empty;

                if (where is null == false && where.HasAny) {
                    whereClause = $" WHERE {where?.ToString()}";
                }

                command.CommandText = $"SELECT * FROM [{this.table}]{whereClause};";
                if (sqlParameters is null == false) {
                    command.Parameters.AddRange(sqlParameters);
                }

                return this.PopulateWithQuery(command); // Call the base populate with query passing the command
            }
        }
    }

    partial class DataList<T> {
        protected bool PopulateWithQuery(SqlCommand command) {
            bool hasRows = false;

            try {
                this.OpenConnection(); // Open the connection

                using (SqlDataReader reader = command.ExecuteReader()) { // Execute reader on the command and dispose on the end
                    hasRows = reader.HasRows; // if the reader has any rows

                    this.SetColumnsOrdinals(reader); // Set columns ordinals once
                    this.RepopulateList(reader);
                }
            } catch (Exception ex) {
                Debug.WriteLine(ex.Message, "DataList.populateWithQuery");
            } finally {
                command.Parameters.Clear();
                this.CloseConnection(); // Finally close the connection
            }

            return hasRows;
        }

        /// <summary>
        /// Recreate the current list with the values from the reader. It does empty the list at start.
        /// </summary>
        protected virtual void RepopulateList(SqlDataReader reader) {
            this.list.Clear();
            this.dataTable.Rows.Clear();

            while (reader.Read()) {
                T model = new T();

                this.SetValues(model, reader);
                model.Inserted = true;

                this.list.Add(model);
                this.AddDataTableRow(model);
            }
        }

        /// <summary>
        /// Set values of given model from the current reader.
        /// </summary>
        /// <param name="model">Model to set properties value from the current reader.</param>
        /// <param name="reader">The reader object to read data from</param>
        protected void SetValues(T model, SqlDataReader reader) {
            foreach (PropertyInfo property in modelProperties) {
                try {
                    int ordinal = columnsOrdinals[property.Name]; // Find value by matching property name
                    object value = reader.GetValue(ordinal);

                    if (value is DBNull) {
                        value = null; // Set value to null if matched with db type NULL
                    }

                    property.SetValue(model, value);
                } catch (Exception ex) { // Dictionary throws if key not found
                    Debug.WriteLine(ex.Message, "DataList.setValues");
                }
            }
        }

        /// <summary>
        /// Set columns ordinals (integer order of each column by name). It is inefficient to call within loop, so it being called once after each query and cached for usage.
        /// </summary>
        /// <param name="reader">Data reader to read ordinal from</param>
        protected void SetColumnsOrdinals(SqlDataReader reader) {
            this.columnsOrdinals.Clear();

            foreach (PropertyInfo property in this.modelProperties) {
                try {
                    string propertyName = property.Name;
                    int columnOrdinal = reader.GetOrdinal(propertyName); // throws IndexOutOfRangeException

                    this.columnsOrdinals.Add(propertyName, columnOrdinal);
                } catch (Exception ex) { // No column with the specified name was found.
                    Debug.WriteLine(ex.Message, "DataList.setColumnsOrdinals");
                }
            }
        }

        /// <summary>
        /// Fetch the current table schema and save.
        /// </summary>
        protected void FetchTableSchema() {
            using (SqlCommand command = this.connection.CreateCommand()) { // Create new command
                command.CommandText = $"SELECT * FROM [{this.table}] WHERE 1 = 0;"; // Query the table with zero matches

                try {
                    this.OpenConnection(); // Open the connection

                    using (SqlDataReader reader = command.ExecuteReader(CommandBehavior.SchemaOnly)) { // Execute reader on the command and dispose on the end
                        DataTable schemaTable = reader.GetSchemaTable(); // Get the schema table from the reader

                        this.schema = new TableSchema(schemaTable); // Construct table schema object from the schema data-table
                    }
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "DataList.fetchTableSchema");
                } finally {
                    command.Parameters.Clear();
                    this.CloseConnection(); // Finally close the connection
                }
            }
        }

        protected void SetDataTableColumns() {
            this.dataTable.Clear();
            this.dataTable.Rows.Clear();
            this.dataTable.Columns.Clear();

            DataColumn column;

            foreach (PropertyInfo property in this.modelProperties) {
                column = new DataColumn();

                column.DataType = Nullable.GetUnderlyingType(property.PropertyType) ?? property.PropertyType; // https://forums.asp.net/t/1796259.aspx?how+to+solve+this+DataSet+does+not+support+System+Nullable+
                column.ColumnName = property.Name;

                this.dataTable.Columns.Add(column);
            }
        }

        /// <summary>
        /// Add data-table row for passed model
        /// </summary>
        /// <param name="model">Model to construct from</param>
        protected void AddDataTableRow(T model) {
            DataRow row = this.dataTable.NewRow(); // New data row

            foreach (PropertyInfo property in this.modelProperties) { // for each property of the model properties
                row[property.Name] = property.GetValue(model) ?? DBNull.Value; // https://forums.asp.net/t/1796259.aspx?how+to+solve+this+DataSet+does+not+support+System+Nullable+
            }

            this.dataTable.Rows.Add(row); // Add the row in the data-table
        }
    }

    partial class DataList<T> {
        /// <summary>
        /// Query sorted list of unique values for given column
        /// </summary>
        /// <typeparam name="U">Expected list items data-type</typeparam>
        /// <param name="column">Column name</param>
        /// <param name="ascending">Sort the list ascendingly</param>
        /// <returns>Sorted list of unique values</returns>
        public List<U> UniqueValues<U>(string column, bool ascending = true) => this.UniqueValues<U>(column, null, ascending);

        /// <summary>
        /// Query sorted list of unique values for given column with some filters
        /// </summary>
        /// <param name="column">Column name</param>
        /// <param name="where">Optional where clause filter</param>
        /// <param name="ascending">Sort the list ascendingly</param>
        /// <returns>Sorted list of unique values</returns>
        public List<string> UniqueValues(string column, WhereClause where, bool ascending = true) => this.UniqueValues<string>(column, where, ascending);

        /// <summary>
        /// Query sorted list of unique values for given column with some filters
        /// </summary>
        /// <typeparam name="U">Expected list items data-type</typeparam>
        /// <param name="column">Column name</param>
        /// <param name="where">Optional where clause filter</param>
        /// <param name="ascending">Sort the list ascendingly</param>
        /// <returns>Sorted list of unique values</returns>
        public List<U> UniqueValues<U>(string column, WhereClause where, bool ascending = true) {
            List<U> values = new List<U>();

            using (SqlCommand command = this.connection.CreateCommand())
            using (WhereClause whereClause = where?.Clone() ?? this.WhereClause) {
                whereClause.WhereIs(column, null, false);

                string whereString = whereClause.HasAny ? $" WHERE {whereClause?.ToString()}" : string.Empty;
                string orderBy = ascending ? "ASC" : "DESC";

                command.CommandText = $"SELECT DISTINCT [{column}] FROM [{this.table}]{whereString} ORDER BY [{column}] {orderBy};";
                command.Parameters.AddRange(whereClause.Parameters);

                try {
                    this.OpenConnection(); // Open the connection

                    using (SqlDataReader reader = command.ExecuteReader()) { // Execute reader on the command and dispose on the end
                        while (reader.Read()) {
                            object value = reader.GetValue(0);

                            if (value is DBNull) {
                                continue;
                            }

                            if (typeof(U) != value.GetType()) {
                                value = Convert.ChangeType(value, typeof(U));
                            }

                            values.Add((U) value);
                        }
                    }
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "DataList.UniqueValues");
                } finally {
                    command.Parameters.Clear();
                    this.CloseConnection(); // Finally close the connection
                }
            }

            return values;
        }

        /// <summary>
        /// Checks if there are any records meet these conditions. (Design Document Requirement #9)
        /// </summary>
        /// <param name="where">Where clause instance</param>
        /// <returns>Whether there is any records matching the provided filters</returns>
        public bool CheckChildRecords(WhereClause where) {
            return this.TotalCount(where) > 0;
        }
    }

    partial class DataList<T> {
        protected enum AggregateFunctions {
            AVG, COUNT, MAX, MIN, SUM
        }

        /// <summary>
        /// Calculates the total of all values for a column parameter (Design Document Requirements #1 + #3 + #5)
        /// </summary>
        /// <typeparam name="U">Expected value data-type</typeparam>
        /// <param name="column">Column name to sum</param>
        /// <param name="whereClause">Optional where clause filter</param>
        /// <returns>Sum of all matched values</returns>
        public U TotalValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.SUM, column, whereClause);
        }

        /// <summary>
        /// Count the rows that match the provided filter conditions (Design Document Requirements #6)
        /// </summary>
        /// <param name="whereClause">Optional where clause filter</param>
        /// <returns>Count of matched rows</returns>
        public int TotalCount(WhereClause whereClause = null) {
            return this.AggregateValue<int>(AggregateFunctions.COUNT, this.pkColumn, whereClause);
        }

        /// <summary>
        /// Find the minimum value of a given column parameter
        /// </summary>
        /// <typeparam name="U">Expected value data-type</typeparam>
        /// <param name="column">Column name to compare</param>
        /// <param name="whereClause">Optional where clause filter</param>
        /// <returns>Minimum value of the passed column matching the conditions</returns>
        public U MinValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.MIN, column, whereClause);
        }


        /// <summary>
        /// Find the maximum value of a given column parameter
        /// </summary>
        /// <typeparam name="U">Expected value data-type</typeparam>
        /// <param name="column">Column name to compare</param>
        /// <param name="whereClause">Optional where clause filter</param>
        /// <returns>Maximum value of the passed column matching the conditions</returns>
        public U MaxValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.MAX, column, whereClause);
        }

        /// <summary>
        /// Find the average value of a given column parameter
        /// </summary>
        /// <typeparam name="U">Expected value data-type</typeparam>
        /// <param name="column">Column name to compare</param>
        /// <param name="whereClause">Optional where clause filter</param>
        /// <returns>Average value of the passed column matching the conditions</returns>
        public U AvgValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.AVG, column, whereClause);
        }

        /// <summary>
        /// Perform aggregate value query
        /// </summary>
        /// <typeparam name="U">Expected value data-type</typeparam>
        /// <param name="aggregateFunction">Aggregate function to be used</param>
        /// <param name="column">Column name to be used in the aggregate function</param>
        /// <param name="where">Optional where clause filter</param>
        /// <returns>Aggregate value of the passed column matching the conditions</returns>
        /// <exception cref="ArgumentException">If invalid column name is passed</exception>
        protected U AggregateValue<U>(AggregateFunctions aggregateFunction, string column, WhereClause where = null) {
            U value = default(U);

            string aggregate = aggregateFunction.ToString();

            SqlParameter[] sqlParameters = where?.Parameters;
            string whereClause = (where?.HasAny ?? false) ? $" WHERE {where?.ToString()}" : "";

            if (!this.schema.HasColumn(column)) {
                throw new ArgumentException($"{column} does not exists in this table schema.");
            }

            try {
                object result = this.ScalarQuery($"SELECT {aggregate}([{column}]) FROM [{this.table}]{whereClause};", sqlParameters);

                if (typeof(U) == result.GetType()) {
                    value = (U) result;
                } else {
                    value = (U) Convert.ChangeType(result, typeof(U));
                }
            } catch (Exception ex) {
                Debug.WriteLine(ex.Message, "DataList.aggregateValue");
            }

            return value;
        }

        /// <summary>
        /// Execute scalar query.
        /// </summary>
        /// <param name="query">The query to execute</param>
        /// <param name="parameters">Array of SqlParameter for this query (optional)</param>
        /// <returns>Scalar result</returns>
        protected object ScalarQuery(string query, SqlParameter[] parameters = null) {
            object result = null;

            using (SqlCommand command = this.connection.CreateCommand()) {
                try {
                    command.CommandText = query;

                    if (parameters != null) {
                        command.Parameters.AddRange(parameters);
                    }

                    this.OpenConnection(); // Open the connection
                    result = command.ExecuteScalar();

                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "DataList.scalarQuery");
                } finally {
                    command.Parameters.Clear();
                    this.CloseConnection(); // Finally close the connection
                }
            }

            return result;
        }
    }

    partial class DataList<T> {
        /// <summary>
        /// Update many records from the database.
        /// </summary>
        /// <param name="set">Set clause to update all matching records</param>
        /// <param name="where">Where clause to filter which records will be updated</param>
        /// <returns>Number of affected rows</returns>
        public virtual int Update(SetClause set, WhereClause where) {
            if (set is null || !set.HasAny) {
                throw new ArgumentNullException("SetClause cannot be null or empty. Dangerous operation.");
            }

            if (where is null || !where.HasAny) {
                throw new ArgumentNullException("WhereClause cannot be null or empty. Dangerous operation.");
            }

            using (SqlCommand command = this.connection.CreateCommand()) {
                int affectedRows = 0;

                if (set.HasAny) {
                    string setClause = set.ToString();
                    command.Parameters.AddRange(set.Parameters);

                    string whereClause = $" WHERE {where.ToString()}";
                    command.Parameters.AddRange(where.Parameters);

                    command.CommandText = $"UPDATE [{this.table}] {setClause}{whereClause};";

                    try {
                        this.OpenConnection(); // Open the connection

                        affectedRows = command.ExecuteNonQuery(); // Execute non query and get the affected rows
                    } catch (Exception ex) {
                        Debug.WriteLine(ex.Message, "DataList.UpdateMany");
                    } finally {
                        command.Parameters.Clear();
                        this.CloseConnection(); // Finally close the connection
                    }
                }

                return affectedRows;
            }
        }

        /// <summary>
        /// Delete many records from the databases matching the provided where criteria. (Design Document Requirements #10)
        /// </summary>
        /// <param name="where">Where clause to filter which records will be updated</param>
        /// <returns>Number of affected rows</returns>
        public virtual int Delete(WhereClause where) {
            if (where is null || !where.HasAny) {
                throw new ArgumentNullException("WhereClause cannot be null or empty. Dangerous operation.");
            }

            using (SqlCommand command = this.connection.CreateCommand()) {
                int affectedRows = 0;

                string whereClause = $" WHERE {where.ToString()}";
                command.Parameters.AddRange(where.Parameters);

                command.CommandText = $"DELETE FROM [{this.table}]{whereClause};";

                try {
                    this.OpenConnection(); // Open the connection

                    affectedRows = command.ExecuteNonQuery(); // Execute non query and get the affected rows
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "DataList.DeleteMany");
                } finally {
                    command.Parameters.Clear();
                    this.CloseConnection(); // Finally close the connection
                }

                return affectedRows;
            }
        }

        /// <summary>
        /// Delete many joined records from the databases matching the provided where criteria (Design Document Requirements #11)
        /// </summary>
        /// <param name="where">Filter conditions</param>
        /// <param name="joinTable">Table name to join with</param>
        /// <param name="joinColumn">Join column name</param>
        /// <returns>Number of affected rows</returns>
        public virtual int Delete(WhereClause where, string joinTable, string joinColumn) {
            if (where is null || !where.HasAny) {
                throw new ArgumentNullException("WhereClause cannot be null or empty. Dangerous operation.");
            }

            if (joinTable is null || joinColumn is null) {
                throw new ArgumentNullException("Join table and column cannot be null.");
            }

            using (SqlCommand command = this.connection.CreateCommand()) {
                int affectedRows = 0;

                string whereClause = $" WHERE {where.ToString("T")}";
                command.Parameters.AddRange(where.Parameters);

                command.CommandText = $@"DELETE J
                        FROM [{this.table}] T
                        INNER JOIN [{joinTable}] J
	                        ON T.[{joinColumn}] = J.[{joinColumn}]
                        {whereClause};";

                try {
                    this.OpenConnection(); // Open the connection

                    affectedRows = command.ExecuteNonQuery(); // Execute non query and get the affected rows
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "DataList.DeleteMany");
                } finally {
                    command.Parameters.Clear();
                    this.CloseConnection(); // Finally close the connection
                }

                return affectedRows;
            }
        }
    }
}
