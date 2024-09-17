class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id]).reverse_order
  end

  def update
    user = User.find(current_user.id)
    if user.photo.attach(user_params[:photo])
      redirect_back_or_to(root_path)
    else
      flash[:alert] = 'Something went wrong'
      redirect_back_or_to(root_path)
    end
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end
end
