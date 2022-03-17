feature "testing adding bookmark" do
  scenario "returns bookmarks with new bookmark" do
    
    visit ('/bookmarks/new')
    fill_in('url', with: 'http://www.bbc.co.uk')
    fill_in('title', with: 'BBC')
    click_on 'Submit'

    expect(page).to have_content "BBC"
  
  end

  scenario "returns error when supplied with an incorrect url" do
    
    visit ('/bookmarks/new')
    fill_in('url', with: 'asdwebbc')
    fill_in('title', with: 'BBC')
    click_on 'Submit'
    expect(page).to have_content 'Please input a complete url'

    
  
  end

end
