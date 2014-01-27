class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

   def index
    @microposts = Micropost.paginate(page: params[:page], :per_page => 5)
  end

  def show
    @micropost = Micropost.find(params[:id])
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
      flash[:success] = "Micropost created!"
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

 # def post
  #  @micropost = Micropost.all
 # end
end
