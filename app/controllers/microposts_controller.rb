class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :destroy]

   def index
    if params[:tag]
      @microposts = Micropost.paginate(page: params[:page],
                                       :per_page => 5).tagged_with(params[:tag])
    else
      @microposts = Micropost.paginate(page: params[:page], :per_page => 5)
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments.paginate(page: params[:page], :per_page => 10)
  end

   def new
    if signed_in? 
      @micropost = current_user.microposts.build 
    else
      render 'static_pages/home'
    end
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'microposts/new'
    end
  end

  def destroy
    Micropost.find(params[:id]).destroy
    flash[:success] = "Post deleted."
    redirect_to root_url
  end
end
