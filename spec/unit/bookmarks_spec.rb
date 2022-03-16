require 'bookmarks'

describe Class do

  it 'returns a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    
    add_bookmarks
    
    bookmarks = Bookmarks.all

    expect(bookmarks[0].url).to include "http://www.makersacademy.com"
    expect(bookmarks[1].url).to include "http://www.destroyallsoftware.com"
    expect(bookmarks[2].url).to include "http://www.google.com"
  end
  
  it 'returns a new bookmark after one has been added' do
    
    bookmark = Bookmarks.add('www.bbc.co.uk','BBC')
    persisted_data = PG.connect(dbname: 'bookmark_manager_test').query(
      "SELECT * FROM bookmarks WHERE id = #{bookmark.id};")
    

    expect(bookmark).to be_a Bookmarks
    expect(bookmark.id).to eq persisted_data.first['id']
    expect(bookmark.url).to eq "www.bbc.co.uk"
    expect(bookmark.title).to eq "BBC"

  end

end
