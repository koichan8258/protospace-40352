class PrototypesController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    if Prototype.create(prototype_params)
     redirect_to root_path
    else
     render :edit,status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
   @prototype =  Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @prototype =  Prototype.find(params[:id])
    if @prototype.destroy
    end
  end

  def move_to_index
    @prototype =  Prototype.find(params[:id])
    unless user_signed_in?&& current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end



end