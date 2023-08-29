class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_article
  
    def index
      @comments = @article.comments
    end
  
    def create
      @comment = @article.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @comment = @article.comments.find(params[:id])
      if @comment.user == current_user && @comment.update(comment_params)
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment = @article.comments.find(params[:id])
      if @comment.user == current_user
        @comment.destroy
        head :no_content
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def set_article
      @article = Article.find(params[:article_id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  