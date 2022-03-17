feature "testing adding comment" do
  scenario "returns bookmarks with new comment" do
    
    add_bookmarks

    visit('/bookmarks')
    first('.bookmark').click_button 'Add Comment'
    fill_in 'new_comment', with: "Great resource"
    click_on 'Save'
    expect(page).to have_content "Great resource"
  end

end