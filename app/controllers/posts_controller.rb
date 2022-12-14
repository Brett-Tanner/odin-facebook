class PostsController < ApplicationController

  private

  def post_params
    params.require(:post).permit(:id, :user_id, :content)
  end
end
