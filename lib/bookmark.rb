require 'pg'

class Bookmark

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
    result.map { |bookmark| Bookmark.new(bookmark['id'],bookmark['url'],bookmark['title']) }
  end

  def self.add(url,title)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec_params("INSERT INTO bookmarks (url, title) VALUES ($1,$2) RETURNING id, title, url;", [url,title])
    Bookmark.new(result[0]['id'],result[0]['url'],result[0]['title'])
  end

  def self.delete(id)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
   
    connection.exec("DELETE FROM bookmarks WHERE id = #{id};")
  end
 
  def self.update(id,url,title)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
   
    connection.exec_params("UPDATE bookmarks SET url = $2, title = $3 WHERE id = $1;",[id,url,title])
  end

  def self.find(id)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
   
    result = connection.exec("SELECT * FROM bookmarks WHERE id = #{id};")
    Bookmark.new(result[0]['id'],result[0]['url'],result[0]['title'])
  end

end