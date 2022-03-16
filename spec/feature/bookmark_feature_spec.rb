feature "Testing Bookmark Route" do
  scenario "returns List of Bookmarks" do

    connection = PG.connect(dbname: 'bookmark_manager_test')
    
    Bookmarks.add('http://www.makersacademy.com','Makers')
    Bookmarks.add('http://www.destroyallsoftware.com','Destroy')
    Bookmarks.add('http://www.google.com','Google')
    
    visit ('/bookmarks')

    expect(page).to have_content "Makers"
    expect(page).to have_content "Destroy"
    expect(page).to have_content "Google"
  
  end

end
