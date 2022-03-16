feature "testing deleting bookmark" do
  scenario "returns that /bookmarks doesn't inlude specified bookmark" do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    add_bookmarks

    visit ('/bookmarks')
    first('.bookmark').click_button 'Delete'

    expect(page).not_to have_content "Makers"
  
  end

end
