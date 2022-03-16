require 'pg'

class Bookmarks

  attr_reader :url, :title
  
  def initialize(url,title)
    @url = url
    @title = title
  end

  def self.all
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("SELECT * FROM bookmarks;")
    result.map { |bookmark| Bookmarks.new(bookmark['url'],bookmark['title']) }
  end

  def self.add(url,title)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}','#{title}');")
  end

end