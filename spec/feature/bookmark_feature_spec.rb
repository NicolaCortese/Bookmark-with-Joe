

feature "Testing Bookmark Route" do
  scenario "returns List of Bookmarks" do

    connection = PG.connect(dbname: 'bookmark_manager_test')
    
    add_bookmarks
    
    visit ('/bookmarks')

    expect(page).to have_content "Makers"
    expect(page).to have_content "Destroy"
    expect(page).to have_content "Google"
  
  end

  scenario "returns List of Bookmarks" do

    connection = PG.connect(dbname: 'bookmark_manager_test')
    
    add_bookmarks
    
    visit ('/bookmarks')

    expect(page).to have_link("Makers", :href=>'http://www.makersacademy.com')
  
  end

end
