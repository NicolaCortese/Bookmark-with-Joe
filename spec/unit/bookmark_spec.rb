require 'bookmark'

describe Class do

  it 'returns a list of bookmarks' do
    
    add_bookmarks
    
    bookmarks = Bookmark.all

    expect(bookmarks[0].url).to include "http://www.makersacademy.com"
    expect(bookmarks[1].url).to include "http://www.destroyallsoftware.com"
    expect(bookmarks[2].url).to include "http://www.google.com"
  end
  
  it 'returns a new bookmark after one has been added' do
    
    bookmark = Bookmark.add('http://www.bbc.co.uk','BBC')
    persisted_data = PG.connect(dbname: 'bookmark_manager_test').query(
      "SELECT * FROM bookmarks WHERE id = #{bookmark.id};")
    
    expect(bookmark).to be_a Bookmark
    expect(bookmark.id).to eq persisted_data.first['id']
    expect(bookmark.url).to eq "http://www.bbc.co.uk"
    expect(bookmark.title).to eq "BBC"

  end

  it '#update a bookmark with new details' do
    bookmark = Bookmark.add('http://www.bbc.co.uk','BBC')
    Bookmark.update(bookmark.id, "http://www.makersacademy.com","Makers")
    updated_bookmark = PG.connect(dbname: 'bookmark_manager_test').query(
      "SELECT * FROM bookmarks WHERE id = #{bookmark.id};")
    expect(updated_bookmark.first['title']).to eq "Makers"
    expect(updated_bookmark.first['url']).to eq "http://www.makersacademy.com"

  end

  it '#find a bookmark and returns title and url' do
    bookmark = Bookmark.add('http://www.bbc.co.uk','BBC')
    found_bookmark = Bookmark.find(bookmark.id)
    expect(bookmark.title).to eq found_bookmark.title
    expect(bookmark.url).to eq found_bookmark.url

  end

end
