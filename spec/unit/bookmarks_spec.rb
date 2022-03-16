require 'bookmarks'

describe Class do

  it 'returns a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    
    Bookmarks.add('http://www.makersacademy.com')
    Bookmarks.add('http://www.destroyallsoftware.com')
    Bookmarks.add('http://www.google.com')
    
    bookmarks = Bookmarks.all

    expect(bookmarks).to include "http://www.makersacademy.com"
    expect(bookmarks).to include "http://www.destroyallsoftware.com"
    expect(bookmarks).to include "http://www.google.com"
  end
  
  it 'returns a new bookmark after one has been added' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    Bookmarks.add('www.bbc.co.uk')

    bookmarks = Bookmarks.all

    expect(bookmarks).to include 'www.bbc.co.uk'

  end

end
