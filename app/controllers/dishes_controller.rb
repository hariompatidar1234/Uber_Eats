class DishesController < ApplicationController
  before_action :set_dish, only: %i[show update destroy]

  def index
    if params[:restaurant_id]
      restaurant = Restaurant.find_by_id(params[:restaurant_id])
      filter_dishes(restaurant.dishes)
    else
      @dishes = Dish.all
      filter_dishes(@dishes)
    end
  end

  def new
    @dish = Dish.new
  end

  def create
    @restaurant = Restaurant.find_by_id(params[:dish][:restaurant_id])
    if @restaurant && @restaurant.owner == current_user
      @dish = @restaurant.dishes.new(dish_params)
      if @dish.save
        flash[:message] = "You added dish Successfully!"
        redirect_to dish_path(@dish)
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to root_path
      flash[:message] = 'You are not authorized to add a dish to this restaurant.'
    end
  end

  def show
    @dish = Dish.find_by_id(params[:id])
  end

  def edit
    @dish = Dish.find_by_id(params[:id])
  end

  def update
    if @dish&.restaurant&.owner == current_user
      if @dish.update(dish_params)
         redirect_to dish_path(@dish)
         flash[:message] = 'dish updated successfully'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:message] = 'You are not authorized to update a dish to this restaurant.'
      redirect_to dish_path
      # render  :edit , notice: "You are not authorized to add a dish to this restaurant"
    end
  end

  def destroy
    if @dish&.restaurant&.owner == current_user
       @dish.destroy
        redirect_to root_path
        flash[:message] = 'dish delete successfully'
    else
      redirect_to dish_path(@dish)
      flash[:message] = 'You are not authorized to delete a dish to this restaurant.'
    end
  end

  def owner_dishes
    @owner_dishes = current_user.restaurants.map(&:dishes).flatten
    # @owner_dishes = current_user.restaurants.merge(dishes)
    @owner_dishes = @owner_dishes.select { |dish| dish.name.downcase.include?(params[:name].downcase) } if params[:name].present?
    @owner_dishes = @owner_dishes.select { |dish| dish.category_id == params[:category_id].to_i } if params[:category_id].present?

    # render json: owner_dishes
  end


  private

  def dish_params
    params.require(:dish).permit(:name, :price, :category_id, :restaurant_id, :picture)
  end

  def set_dish
    @dish = Dish.find_by_id(params[:id])
    render json: { error: 'Dish not found' }, status: :not_found unless @dish
  end


  def filter_dishes(dishes)
    @dishes = dishes.where(category_id: params[:category_id]) if params[:category_id]
    @dishes = dishes.where('name LIKE ?', "%#{params[:name]}%") if params[:name]
    @dishes = dishes.page(params[:page]).per(5) if params[:page]
    @dishes = dishes
  end
end
