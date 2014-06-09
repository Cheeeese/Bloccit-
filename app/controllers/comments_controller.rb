class CommentsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @comment = Comment.new
    authorize @comment
  end

  def edit
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comment = Comment.find(params[:id])
    authorize @comment 
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment 
    if @comment.save 
      flash[:notice] = "Comment was saved."
    else
      flash[:error] = "There was an error saving the post. Please try again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end

  end

end
