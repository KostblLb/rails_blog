class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "blogger", password: "1234", except:[:index,:show]
 def index
  @articles = Article.all
 end
 def search 
  search_param[:q].gsub!(/[ ]+/,'-')
  @articles = Article.any_of(tags: /[\w]*#{search_param[:q]}[\w]*/)
  render 'index'
 end
 def edit
  @article = Article.find(params[:id])
 end
 def show
  @article = Article.find(params[:id])
 end
 def new
  @article = Article.new
 end
 def create
  @article = Article.new(article_params)
  if @article.save 
   redirect_to @article
   #render plain: article_params[:tags]
  else 
   render 'new'
  end
 end

def update
  @article = Article.find(params[:id])
 
  if @article.update(article_params)
    redirect_to @article
  else
    render 'edit'
  end
end

def destroy
  @article = Article.find(params[:id])
  @article.destroy
 
  redirect_to articles_path
end

 private
  def article_params
    safe_params = params.require(:article).permit(:title, :text, :tags)
    safe_params[:tags].gsub!(/,/,' ')
    safe_params
  end
  def search_param
    params.permit(:q)
  end


end
