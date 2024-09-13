class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(current_user.id)
    if @user.posts.create(post_params)
      redirect_to @user
    else
      flash[:alert] = 'Something went wrong'
      render root_path, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id)
  end

  private

  def post_params
    params.require(:post).permit(:body, :image_url)
  end
end
