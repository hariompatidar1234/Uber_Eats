class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update destroy]

  def index
    @categories = Category.all
    # render json: @categories
  end

  def new
    @category = Category.new
  end


  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
      # render json: { data: @category, message: 'Category created' }, status: :created
    else
      # render json: { error: @category.errors.full_messages }, status: :unprocessable_entity
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find_by_id(params[:id])
    @dishes = @category.dishes
  end

  def edit
    @category = Category.find_by_id(params[:id])
  end

  def update
    if @category.update(category_params)
      # render json: { data: @category, message: 'Category updated' }
      redirect_to categories_path, notice: "update category"
    else
      # render json: { error: @category.errors.full_messages }, status: :unprocessable_entity
        render :edit, status: :unprocessable_entity
    end
  end

  def destroy
     @category.destroy
      # render json: { message: 'Category deleted' }
      redirect_to categories_path
  end

  # def category_dish
  #   @categoy = Category.find_by_id(params[:id])
  #   redirect_to
  # end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find_by_id(params[:id])
    render json: { error: 'Category not found by name' }, status: :not_found unless @category
  end
end
