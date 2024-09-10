class FollowsController < ApplicationController
  before_action :authenticate_user!

  def index
    f = Follow.where(followee_id: current_user.id)
    @followers = f.where(status: 'ok')
    @pending = f.where(status: 'pending')
    @followees = Follow.where(follower_id: current_user.id)
  end

  def create
    follow = Follow.where("follower_id = ? AND followee_id = ?", current_user.id, follow_params[:id])
    if follow.any?
      flash[:alert] = follow.status == 'ok' ? 'You already are following this user!' : 'You already tried following this user, please wait their response'
    else
      follow = Follow.new
      follow.follower_id = current_user.id
      follow.followee_id = follow_params[:id]
      follow.status = 'pending'
      follow.save!
    end

    redirect_back_or_to(root_path)
  end

  def update
    follow = Follow.find_by("followee_id = ? AND follower_id = ?", current_user.id, follow_params[:id])
    if follow.update(status: 'ok')
      redirect_back_or_to(root_path)
    else
      flash[:alert] = 'Something went wrong'
      render root_path, status: :unprocessable_entity
    end
  end

  def destroy
    follow = Follow.where("follower_id = ? AND followee_id = ?", current_user.id, follow_params[:id]).first
    if follow.destroy
      redirect_back_or_to(root_path)
    else
      flash[:alert] = 'Something went wrong'
      render root_path, status: :unprocessable_entity
    end
  end

  private

  def follow_params
    params.require(:user).permit(:id)
  end
end
