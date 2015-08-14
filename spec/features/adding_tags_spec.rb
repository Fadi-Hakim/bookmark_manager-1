feature 'Adding tags' do
    before :each do
        visit '/links/new'
        fill_in 'url',      with:  'http://www.makersacademy.com/'
        fill_in 'title',    with:  'Makers Academy'
    end

    scenario 'I can add a single tag to a new link' do
        fill_in 'tags',  with: 'education'
        click_button 'Create link'
        expect(page).to have_content 'education'
    end

    scenario 'I can add multiple tags to a new link' do
        fill_in 'tags',  with: 'education ruby'
        click_button 'Create link'
        expect(page).to have_content 'education'
        expect(page).to have_content 'ruby'
    end
end