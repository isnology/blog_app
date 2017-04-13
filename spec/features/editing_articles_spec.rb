require 'rails_helper'

RSpec.feature "Editing an article", type: :feature do
  
  before do
    john = User.create(email: 'john@example.com', password: 'password')
    login_as(john)
    @article = Article.create(title: 'Title One', body: 'body of article one', user: john)
  end

  scenario 'A user updates an article' do
    visit '/'
    
    click_link @article.title
    click_link 'Edit Article'
    
    fill_in 'Title', with: 'Update Title'
    fill_in 'Body', with: 'Updated Body of article'
    click_button 'Update Article'
    
    expect(page).to have_content('Article has been updated')
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario 'A user fails to updates an article' do
    visit '/'
  
    click_link @article.title
    click_link 'Edit Article'
  
    fill_in 'Title', with: ''
    fill_in 'Body', with: 'Updated Body of article'
    click_button 'Update Article'
  
    expect(page).to have_content('Article has not been updated')
    expect(page.current_path).to eq(article_path(@article))
  end
end
