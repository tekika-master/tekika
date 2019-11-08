class PostsController < ApplicationController


  def index
    @q = Post.ransack(params[:q])
      @posts = @q.result.order(id: :desc).page(params[:page]).per(20)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '過去問を投稿しました。'
      redirect_to '/posts'
    else
      flash.now[:danger] = '過去問の投稿に失敗しました。'
      render 'posts/new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.update(post_params)
      flash[:success] = '過去問を編集しました。'
      redirect_to root_url
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '過去問を削除しました。'
    redirect_to root_url
  end

  def search
    @q = Post.search(search_params)
    @posts = @q.result(distinct: true)
  end


  private

  def post_params
    params.require(:post).permit(:problem, :campus, :department, :image)
  end

  def search_params
    params.require(:q).permit(:problem)
  end

  # def correct_user
  #   @post = current_user.posts.find_by(id: params[:id])
  #   unless @post
  #     redirect_to root_url
  #   end
  # end
  #
  # def picture_size
  #     if picture.size > 5.megabytes
  #       errors.add(:picture, "should be less than 5MB")
  #     end
  # end
end
