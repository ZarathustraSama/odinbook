class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(current_user.id)
    comment = user.comments.build(comment_params)
    if comment.save!
      redirect_back_or_to(root_path)
    else
      flash[:alert] = 'Something went wrong'
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
