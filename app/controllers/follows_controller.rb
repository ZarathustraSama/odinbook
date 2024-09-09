class FollowsController < ApplicationController
  before_action :authenticate_user!

  def index
    @follows = Follow.where("follower_id = ? AND followee_id = ?", current_user.id, params[:id])
    @followees = Follow.where("follower_id = ? AND followee_id = ?", params[:id], current_user.id)
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

    redirect_to user_path(follow_params[:id])
  end

  def update
    follow = Follow.where("follower_id = ? AND followee_id = ?", current_user.id, follow_params[:id]).first
    follow.update(status: 'ok') if follow.any?

    redirect_to follows_path
  end

  def destroy
    follow = Follow.where("follower_id = ? AND followee_id = ?", current_user.id, follow_params[:id]).first
    if follow.destroy
      redirect_to user_path(follow_params[:id])
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
