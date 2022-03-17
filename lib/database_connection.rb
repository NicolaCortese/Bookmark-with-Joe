class DatabaseConnection

  def self.setup(db_name)
    @connection = PG.connect(dbname: db_name)
  end
  
  def self.query(sql_query, params = [])
    @connection.exec_params(sql_query, params)
  end
end