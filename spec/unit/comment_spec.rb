require 'comment'

describe Comment do
  it 'creates an object and stores the id, text and bookmark_id' do
    comment = Comment.new(1,"Great resource",4)
    expect(comment.id).to eq 1
    expect(comment.text).to eq "Great resource"
    expect(comment.bookmark_id).to eq 4
  end
end