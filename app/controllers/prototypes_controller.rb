class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show,]
  #before_action :move_to_index, except: [:index, ]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :index
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)

  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user == @prototype.user
      redirect_to prototypes_path
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
    if prototype.destroy
      redirect_to root_path(@prototype)
    else
      redirect_to root_path(@prototype)
    end
  end

  #def move_to_index
    #unless current_user == @prototype.user
      #redirect_to root_path
    #end
  #end 

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image,).merge(user_id: current_user.id)
  end

 end



      #redirect_to root_path
      #redirect_to prototype_path
      #redirect_to action: :index
