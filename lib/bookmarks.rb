require 'pg'

class Bookmarks

  attr_reader :id, :url, :title

  def initialize(id, url,title)
    @id = id
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
    result.map { |bookmark| Bookmarks.new(bookmark['id'],bookmark['url'],bookmark['title']) }
  end

  def self.add(url,title)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec_params("INSERT INTO bookmarks (url, title) VALUES ($1,$2) RETURNING id, title, url;", [url,title])
    Bookmarks.new(result[0]['id'],result[0]['url'],result[0]['title'])
  end

  def self.delete(id)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
   
    connection.exec("DELETE FROM bookmarks WHERE id = #{id};")
  end

end