class BlogsController < ApplicationController
  before_action :set_blog, only:[:show, :edit, :update, :destroy]
  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
    @blog = Blog.new
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to blogs_path, notice: "ブログが作成されました！"
      else
        render :new
      end
    end
  end

  def show
    if current_user.id == @blog.user.id
        @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    else
      redirect_to blogs_path
    end
  end

  def edit
    if current_user.id == @blog.user.id
      @blog
    else
      redirect_to blogs_path
    end
  end

  def update
    @blog.update(blog_params)
    redirect_to blogs_path, notice: "ブログが編集されました。"
  end

  def destroy
    if current_user.id == @blog.user.id
      @blog
      @blog.destroy
      redirect_to blogs_path, notice: "ブログが削除されました!"
    end
    end

  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end
