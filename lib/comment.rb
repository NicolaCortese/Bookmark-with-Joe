require 'pg'

class Comment

  attr_reader :id, :text, :bookmark_id

  def initialize(id,text,bookmark_id)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM comments;")
    result.map { |comment| Comment.new(comment['id'],comment['text'],comment['bookmark_id']) }
  end


end