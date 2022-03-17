require 'pg'
require 'uri'

class Bookmark

  attr_reader :id, :url, :title

  def initialize(id, url,title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map { |bookmark| Bookmark.new(bookmark['id'],bookmark['url'],bookmark['title']) }
  end

  def self.add(url,title)
    return false unless is_url(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES ($1,$2) RETURNING id, title, url;", [url,title])
    Bookmark.new(result[0]['id'],result[0]['url'],result[0]['title'])
  end

  def self.delete(id)   
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id};")
  end
 
  def self.update(id,url,title)
    DatabaseConnection.query("UPDATE bookmarks SET url = $2, title = $3 WHERE id = $1;",[id,url,title])
  end

  def self.find(id)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id};")
    Bookmark.new(result[0]['id'],result[0]['url'],result[0]['title'])
  end

  def self.add_comment

  end

private

  def self.is_url(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end
  
end