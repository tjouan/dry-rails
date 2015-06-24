feature 'CRUD' do
  let(:article) { { title: 'some title', body: 'some body' } }

  def create_article **attributes
    visit articles_path
    click_link 'New article'

    fill_in 'Title', with: attributes[:title]
    fill_in 'Body', with: attributes[:body]
    click_button 'Create'
  end

  scenario 'creates a new record' do
    create_article article

    expect(current_path).to eq articles_path
    expect(page).to have_content article[:title]
  end

  scenario 'edits existing record' do
    create_article article
    visit articles_path

    click_link article[:title]
    fill_in 'Title', with: 'new article title'
    click_button 'Update'

    expect(current_path).to eq articles_path
    expect(page).to have_content 'new article title'
  end

  scenario 'destroys existing record' do
    create_article article
    visit articles_path

    click_link 'Destroy'

    expect(current_path).to eq articles_path
    expect(page).not_to have_content article[:title]
  end
end
