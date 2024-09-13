class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(comment_params[:id])
    comment = post.comments.build(comment_params)
    comment.user_id = current_user.id
    if comment.save!
      redirect_back_or_to(root_path)
    else
      flash[:alert] = 'Something went wrong'
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :content)
  end
end
