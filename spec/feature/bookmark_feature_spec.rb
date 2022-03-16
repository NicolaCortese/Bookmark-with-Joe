feature "Testing Bookmark Route" do
  scenario "returns List of Bookmarks" do

    connection = PG.connect(dbname: 'bookmark_manager_test')
    
    Bookmarks.add('http://www.makersacademy.com')
    Bookmarks.add('http://www.destroyallsoftware.com')
    Bookmarks.add('http://www.google.com')
    
    visit ('/bookmarks')

    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.destroyallsoftware.com"
    expect(page).to have_content "http://www.google.com"
  
  end

end
