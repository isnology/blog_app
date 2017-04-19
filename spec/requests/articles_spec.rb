require 'rails_helper'

RSpec.describe "Articles", type: :request do
  
  before do
    @john = User.create(email: 'john@example.com', password: 'password')
    @fred = User.create(email: 'fred@example.com', password: 'password')
    @article = Article.create!(title: 'Title One', body: 'Body of article One', user: @john)
  end
  
  describe 'GET /articles/:id/edit' do
    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit" }
    
      it 'redirects to the signin page' do
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq sign_in_before_msg # provided by devise
      end
    end
    
    context 'with signed in user who is non-owner' do
      before do
        login_as(@fred)
        get "/articles/#{@article.id}/edit"
      end
      
      it 'redirects to the home page' do
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq only_edit_own_msg
      end
    end
    
    context 'with signed in user as owner successful edit' do
      before do
        login_as(@john)
        get "/articles/#{@article.id}/edit"
      end
      
      it 'successfully edits article' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'delete /articles/:id' do
    context 'with non-signed in user' do
      before { delete "/articles/#{@article.id}" }
    
      it 'redirects to the signin page' do
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq sign_in_before_msg # provided by devise
      end
    end

    context 'with signed in user as owner' do
      before do
        login_as(@john)
        delete "/articles/#{@article.id}"
      end
  
      it 'successfully deletes an article' do
        expect(response.status).to eq 302
        expect(flash[:success]).to eq deleted_msg
      end
    end

    context 'with signed in user as non-owner' do
      before do
        login_as(@fred)
        delete "/articles/#{@article.id}"
      end
  
      it 'does not delete article' do
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq only_delete_own_msg
      end
    end
  end
  
  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }
      
      it 'handles exsting article' do
        expect(response.status).to eq 200
      end
    end
    
    context 'With non-existing article' do
      before { get '/articles/xxxx' }
      
      it 'handles non-existing article' do
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq not_found_msg
      end
    end
  end
end
