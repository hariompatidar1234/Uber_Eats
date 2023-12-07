class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show update destroy]

  def index
    restaurants = Restaurant.all
    @restaurants = if params[:name]
                    restaurants.where('name LIKE ?', "%#{params[:name]}%").page(params[:page]).per(3)
                  elsif params[:status]
                    restaurants.where(status: params[:status]).page(params[:page]).per(3)
                  elsif params[:address]
                    restaurants.where('address LIKE ?', "%#{params[:address]}%").page(params[:page]).per(3)
                  else
                    restaurants.page(params[:page]).per(5)
                  end
    # render json: @restaurants
  end


  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    # @restaurant = Owner.find(current_user.id).restaurants.new(restaurant_params)
    if @restaurant.save
      redirect_to root_path
      flash[:message] = "You Created Successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @restaurant = Restaurant.find_by_id(params[:id])
  end

  def edit
    @restaurant = Restaurant.find_by_id(params[:id])
  end

  def update
    if @restaurant.owner == current_user
      if @restaurant.update(restaurant_params)
       flash[:success] = 'Restaurant updated successfully'
       redirect_to restaurant_path(@restaurant)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to restaurant_path(@restaurant)
      flash[:message] = 'You are not authorized to update this restaurant.'
    end
  end

  def destroy
    if @restaurant.owner == current_user
      @restaurant.destroy
      redirect_to root_path, status: :see_other
   else
      redirect_to restaurant_path(@restaurant)
      flash[:message] = 'You are not authorized to delete this restaurant.'
    end
  end


  def my_restaurants_list
    @restaurants = current_user.restaurants
    if @restaurants.any?
      render "my_restaurants_list"
    else
      render plain: "You haven't added any restaurants yet."
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :status, :address, :picture)
  end

  def set_restaurant
    @restaurant = Restaurant.find_by_id(params[:id])
    render json: { error: 'Restaurant not found' }, status: :not_found unless @restaurant
  end
end
