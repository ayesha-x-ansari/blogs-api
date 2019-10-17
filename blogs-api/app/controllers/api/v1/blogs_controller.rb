module Api::V1
class BlogsController < ApplicationController
    before_action :set_blog, only: [:show, :update, :destroy]
  
    # GET /todos
    def index
      # get current user todos
      #@blogs = Blog.all
      @blogs = Blog.all.paginate(page: params[:page], per_page: 20)
      json_response(@blogs)
      
    end
  
    # GET /todos/:id
    def show
      json_response(@blogs)    
    end
  
    # POST /todos
    def create
      # create todos belonging to current user
      @blogs = Blog.create!(blog_params)
      #puts params
      json_response(@blogs, :created)

    end
  
    # PUT /todos/:id
    def update
      @blogs.update(blog_params)
      head :no_content
    end
  
    # # DELETE /todos/:id
    def destroy
      @blogs.destroy
      head :no_content
    end
  
    private
  
    # remove `created_by` from list of permitted parameters
    def blog_params
      params.permit(:title, :content, :user_id)
    end
  
    def set_blog
      @blogs = Blog.find(params[:id])
    
    end
  end
end

  

