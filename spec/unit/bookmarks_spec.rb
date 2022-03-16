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
    connection = PG.connect(dbname: 'bookmark_manager_test')

    Bookmarks.add('www.bbc.co.uk','BBC')

    bookmarks = Bookmarks.all

    expect(bookmarks.last.url).to include 'www.bbc.co.uk'

  end

end
