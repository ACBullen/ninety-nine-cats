class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])

    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find_by(id: params[:id])

    render :edit
  end

  def update
    @cat = Cat.find_by(id: params[:id])

    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def create

    @cat = Cat.new(cat_params)

    if @cat.save
      render :show
    else
      redirect_to "/cats/new"
    end
  end

  private

  def cat_params
    params.require(:cats).permit(:name, :sex, :color, :birth_date, :description)
  end
end
