feature 'Viewing links' do
  before :each do 
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tags',  with: 'education'
    click_on 'Create link'

    visit '/links/new'
    fill_in 'url',   with: 'http://www.flickr.com/'
    fill_in 'title', with: 'Flickr'
    fill_in 'tags',  with: 'photos'
    click_on 'Create link'

    visit '/links/new'
    fill_in 'url',   with: 'http://www.flickr.com/photos/andyuk1'
    fill_in 'title', with: 'My Flickr'
    fill_in 'tags',  with: 'photos'
    click_on 'Create link'
  end

  scenario 'I can see existing links on the links page' do
    visit '/links'
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end

  scenario 'I can filter links by tag' do
    visit '/tags/photos'
    expect(page).to have_content("Links (filtered by 'photos' tag)")
    within 'ul#links' do
      expect(page).not_to have_content('Makers Academy')
      expect(page).to have_content('Flickr')
      expect(page).to have_content('My Flickr')
    end
  end
end