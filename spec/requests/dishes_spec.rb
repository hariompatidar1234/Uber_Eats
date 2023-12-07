require 'rails_helper'

RSpec.describe "Dishes", type: :request do
  let(:user) { FactoryBot.create(:owner, type: 'Owner') }

  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return(user)
    current_user = controller.current_user

     @restaurant = FactoryBot.create(:restaurant , user_id: user.id)
    @category = FactoryBot.create(:category)
    @dish = FactoryBot.create(:dish, category_id: @category.id , restaurant_id: @restaurant.id)
    @dish1= FactoryBot.create(:dish, category_id: @category.id , restaurant_id: @restaurant.id)
  end


  describe 'GET /dishes' do
    it 'returns with filtered dishes for a restaurant' do
      get '/dishes?restaurant_id= 2 '
      expect(response).to have_http_status(:ok)
    end
    it 'returns dishes filtered by category_id' do
      get '/dishes?category_id=2'
      expect(response).to have_http_status(:ok)
    end
    it 'returns dishes filtered by name' do
      get '/dishes?name=panner'
      expect(response).to have_http_status(:ok)
    end
    it 'paginates dishes' do
      get '/dishes?page=2'
      expect(response).to have_http_status(:ok)
    end
  end


  describe 'POST /dishes' do
    it 'creates a dish for owners' do
      post '/dishes',params: { dish: { :dish, category_id: @category.id, restaurant_id: @restaurant.id } }
      expect(response).to redirect_to dish_path(dish)
    end
    it 'returns an error for other owner trying to create a dish' do
      post '/dishes',
           params: { name: 'Dish Name', price: 9.99, restaurant_id: @restaurant1.id, category_id: @category.id }
      expect(response).to have_http_status(:unauthorized)
    end
    it 'returns an error for invalid dish creation' do
      post '/dishes', params: { name: nil, price: nil, restaurant_id: @restaurant.id, category_id: @category.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /dishes/:id' do
    it 'shows a dish ' do
      get "/dishes/#{@dish.id}"
      expect(response).to have_http_status(:ok)
    end
  end
end
