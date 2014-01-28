class CommentsController < ApplicationController

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to micropost_path(@micropost)
    else
      render micropost_url
    end
  end

  def destroy
  end
end
