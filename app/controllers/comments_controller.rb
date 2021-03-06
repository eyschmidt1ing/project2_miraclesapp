class CommentsController < ApplicationController

  before_filter :get_post

  def index
    @comments = @post.comments
  end

  def show
    @comment = @post.comments.find(params[:id])
    # Using the above instead of @comment = Comment.find(params[:id]) in order to find comments associated to a specific post.
  end

  def new
    @comment = @post.comments.build
  end

  def create

    @comment = @post.comments.new(params.require(:comment).permit( :user_id, :post_id, :content, :photo_url))

    @comment.user = current_user

    if @comment.save
      redirect_to "/posts#post#{@post.id}", notice: "Comment successfully saved."
    else
      render :new
    end

  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def update

    @comment = @post.comments.find(params[:id])

    if @comment.update_attributes(params.require(:comment).permit( :user_id, :post_id, :content, :photo_url))
      redirect_to "/posts#post#{@post.id}", notice: "Comment successfully updated."
    else
      render :edit
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to "/posts#post#{@post.id}", notice: "Comment was successfully deleted."
  end




  private

    def get_post
      @post = Post.find(params[:post_id])
    end

end
