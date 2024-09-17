class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    allowed_users = Follow.where(follower_id: current_user.id, status: 'ok').map(&:followee_id) << current_user.id
    @posts = Post.where(user_id: allowed_users).reverse_order
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
    @likes = Like.where(post_id: params[:id]).count
  end

  private

  def post_params
    params.require(:post).permit(:body, :image_url, :image)
  end
end
