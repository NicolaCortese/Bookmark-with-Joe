require 'pg'

def setup_test_database
  connection = DatabaseConnection.setup('bookmark_manager_test')

# Clear the bookmarks table
  connection.exec("TRUNCATE bookmarks;")

end
