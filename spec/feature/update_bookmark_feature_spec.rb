
feature 'Testing the bookmark/update route' do
  scenario 'updates a bookmark'do
  add_bookmarks

  visit('/bookmarks')
  first('.bookmark').click_button 'Update'
  expect(page).to have_field('new_title', with: "Makers")
  expect(page).to have_field('new_url', with: "http://www.makersacademy.com")
  fill_in 'new_title', with: "MakersAcademy"
  fill_in 'new_url', with: "http://www.makersacademy.com"
  click_on 'Save'
  expect(page).to have_content "MakersAcademy"

  end
end