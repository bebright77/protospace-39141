class PrototypesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index, except: [:index, :show]
  def index
    @prototypes = Prototype.all.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path(@prototype)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    if user_signed_in? && current_user.id == @prototype.user.id
      @comment = Comment.new
      @comment = Comment.save
    else
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end
  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:image, :title, :concept, :catch_copy ).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
