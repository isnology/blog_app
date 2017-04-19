class ArticlesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = created_msg
      redirect_to articles_path
    else
      flash.now[:danger] = not_created_msg
      render :new
    end
  end
  
  def show
  end
  
  def edit
    unless @article.user == current_user
      flash[:alert] = only_edit_own_msg
      redirect_to root_path
    end
  end
  
  def update
    unless @article.user == current_user
      flash[:alert] = only_edit_own_msg
      redirect_to root_path
    else
      if @article.update(article_params)
        flash[:success] = updated_msg
        redirect_to @article
      else
        flash.now[:danger] = not_updated_msg
        render :edit
      end
    end
  end
  
  def destroy
    unless @article.user == current_user
      flash[:alert] = only_delete_own_msg
      redirect_to root_path
    else
      if @article.destroy
        flash[:success] = deleted_msg
        redirect_to articles_path
      end
    end
  end
  
  protected
  
    def resource_not_found
      flash[:alert] = not_found_msg
      redirect_to root_path
    end
  
  private
  
    def article_params
      params.required(:article).permit(:title, :body)
    end
  
    def set_article
      @article = Article.find(params[:id])
    end
end
