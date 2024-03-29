class PostsController < ApplicationController


  def index
    @q = Post.ransack(params[:q])
      @posts = @q.result.order(id: :desc).page(params[:page]).per(20)
     @counts = Post.count
  end

  def show
    @q = Post.ransack(params[:q])
      @posts = @q.result.order(id: :desc).page(params[:page]).per(20)
     @counts = Post.count
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

  def edit
     @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.update(post_params)
        flash[:success] = '過去問を編集しました。'
      redirect_to '/posts'
    elsif current_user.admin?
      @post.update(post_params)
        flash[:success] = '過去問を編集しました。'
      redirect_to '/posts'
    else
      flash.now[:danger] = '過去問の編集に失敗しました。'
      render 'posts/edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user.admin?
      @post.destroy
      flash[:success] = '過去問を削除しました。'
    redirect_back(fallback_location: root_path)
    else
      if current_user == @post.user
        @post.destroy
        flash[:success] = '過去問を削除しました。'
      redirect_back(fallback_location: root_path)
      end
    end
  end

  def search
    @q = Post.search(search_params)
    @posts = @q.result(distinct: true)
  end
end

  private

  def post_params
    params.require(:post).permit(:problem, :campus, :department, :figure, :year)
  end

  def search_params
    params.require(:q).permit(:problem)
  end
