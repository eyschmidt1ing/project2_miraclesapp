class CommentsController < ApplicationController

  before_filter :get_post

  def index
    @comments = @post.comments
  end

  def show
    @comment = @post.comments.find(params[:id])
    # @comment = Comment.find(params[:id])
  end

  def new
    @comment = @post.comments.build
  end

  def create

    # @comment = @post.comments.new(params.require(:comment).permit( :content, :photo_url, :post_id, :user_id, :nickname))
    @comment = @post.comments.new(params.require(:comment).permit( :user_id, :post_id, :content, :photo_url))
    @comment.user = current_user

    if @comment.save
      # redirect_to :back, notice: "Comment successfully saved."
      # redirect_to posts_path(@post), notice: "Comment successfully saved."
      redirect_to "/posts#post#{@post.id}", notice: "Comment successfully saved."
      @updateClass = "in"
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
