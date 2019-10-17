module Api::V1
class CommentsController < ApplicationController
  before_action :set_blog
  before_action :set_blog_comment, only: [:show, :update, :destroy]

  # GET /blogs/:blog_id/comments
  def index
    json_response(@blog.comments)
  end

  # GET /blogs/:blog_id/comments/:id
  def show
    json_response(@comment)
  end

  # POST /blogs/:blog_id/comments
  def create
    @blog.comments.create!(comment_params)
    puts params
    puts "####################"
    puts "####################"
    puts "####################"
    json_response(@blog, :created)
  end

  # PUT /blogs/:blog_id/comments/:id
  def update
    @comment.update(comment_params)
    head :no_content
  end

  # DELETE /blogs/:blog_id/comments/:id
  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    puts "####################"
    puts "####################"
    puts "################ffffffffffff####"
    params.permit(:content, :blog_id, :user_id)
  end

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

  def set_blog_comment
    @comment = @blog.comments.find_by!(id: params[:id]) if @blog
  end
end
end
