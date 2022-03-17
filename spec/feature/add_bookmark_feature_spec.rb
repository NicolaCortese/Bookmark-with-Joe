feature "testing adding bookmark" do
  scenario "returns bookmarks with new bookmark" do
    
    visit ('/bookmarks/new')
    fill_in('url', with: 'www.bbc.co.uk')
    fill_in('title', with: 'BBC')
    click_on 'Submit'

    expect(page).to have_content "BBC"
  
  end

end
