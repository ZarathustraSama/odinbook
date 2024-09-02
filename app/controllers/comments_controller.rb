class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
  end

  private

  def comment_params
  end
end
