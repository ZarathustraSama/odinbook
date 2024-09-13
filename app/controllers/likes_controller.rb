class LikesController < ApplicationController
  before_action :authenticate_user!


  def create
    like = Like.where("user_id = ? AND post_id = ?", current_user.id, like_params[:id])
    if like.any?
      flash[:alert] = 'You already liked this post!'
    else
      like = Like.new
      like.user_id = current_user.id
      like.post_id = like_params[:id]
      like.save!
    end

    redirect_back_or_to(root_path)
  end

  def destroy
    like = Like.where("user_id = ? AND post_id = ?", current_user.id, like_params[:id]).first
    if like.destroy
      redirect_back_or_to(root_path)
    else
      flash[:alert] = 'Something went wrong'
      redirect_to root_path
    end
  end

  private

  def like_params
    params.require(:post).permit(:id)
  end
end
