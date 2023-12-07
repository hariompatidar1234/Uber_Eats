require 'rails_helper'


RSpec.describe "Restaurants", type: :request do
  let(:user) { FactoryBot.create(:owner, type: 'Owner') }
  let(:restaurant) {FactoryBot.create(:restaurant , user_id: user.id)}
  let(:restaurant1) {FactoryBot.create(:restaurant , user_id: user.id)}

  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return(user)
    current_user = controller.current_user
  end


  describe "GET /index" do
    it 'is search restaurant with name' do
      get '/restaurants', params: { name: 'panchali' }
        expect(response).to be_successful
    end

    it 'is search restaurant with address' do
      get '/restaurants' , params: {address: "indore"}
      expect(response).to be_successful
    end

    it 'is search restaurant with status' do
      get '/restaurants', params: {status: 'open'}
        expect(response).to be_successful
    end

    it 'it add pagination' do
      get '/restaurants' , params: {page: 2}
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    before do
      get '/restaurants/new'
    end
    it 'renders new template' do
      is_expected.to render_template(:new)
    end
  end

 describe "POST #create" do
    context 'when params are correct' do
      it 'creates a new restaurant' do
        post '/restaurants', params: { restaurant: { name: "panchali", address: "vijay nagar", status: "open" } }
        expect(response).to redirect_to(root_path)
        expect(flash[:message]).to eq('You Created Successfully!')
      end
    end
    context 'when params are not correct' do
      it 'renders the new template with unprocessable entity status' do
        post '/restaurants', params: { restaurant: { name: nil } }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show/:id' do
    context "with data available" do
      it 'render successfully restaurant data' do
        get "/restaurants/#{restaurant.id}"
        expect(response).to have_http_status(:ok)
      end
    end
  end


  # let(:user) { FactoryBot.create(:owner, type: 'Owner') }
  # let(:restaurant) {FactoryBot.create(:restaurant , user_id: user.id)}
  describe 'GET #edit/id' do
    it 'renders edit template' do
      get "/restaurants/#{restaurant.id}/edit"
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT /update/id" do
    context "with valid parameters" do
      it "updates the requested Category" do
        put "/restaurants/#{restaurant.id}" , params: { restaurant: {name: "shreenath",  user_id: user.id} }
        restaurant.reload
        expect(response).to redirect_to restaurant_path(restaurant)
      end
    end

    context "with invalid parameters" do
      it "renders a response status and edit template" do
       put "/restaurants/#{restaurant.id}" , params: { restaurant: {name: nil,  user_id: user.id} }
        is_expected.to render_template(:edit)
        expect(response).to have_http_status(422)
      end
    end


    context "with invalid parameters" do
     let(:user1) { FactoryBot.create(:owner, type: 'Owner') }
      it "renders a response status and edit template" do
       sign_in user1

       put "/restaurants/#{restaurant.id}" , params: { restaurant: {name: "shreenath",  user_id: user1.id} }
        expect(response).to redirect_to restaurant_path(restaurant)
      end
    end
  end

  describe "DELETE /destory/id" do
    context " owner delete  own restaurant" do
      it "destroys the requested category" do
        delete "/restaurants/#{restaurant.id}"
         expect(response).to redirect_to root_path
      end
    end

     context "unatherized owner delete restaurant" do
     let(:user1) { FactoryBot.create(:owner, type: 'Owner') }
     let(:restaurant1) {FactoryBot.create(:restaurant , user_id: user1.id)}
      it "destroys the requested category" do
        delete "/restaurants/#{restaurant1.id}"
         expect(response).to redirect_to restaurant_path(restaurant1)
      end
    end
  end

  describe ' GET /restaurants/my_restaurants_list' do
    context "owner restaurant" do
       it "returns a list of owner's restaurants" do
        restaurant = FactoryBot.create(:restaurant , user_id: user.id)
        restaurant1 = FactoryBot.create(:restaurant , user_id: user.id)
        get "/restaurants/my_restaurants_list"
       expect(response).to render_template("my_restaurants_list")
      end
    end
    context 'if no restaurant' do
      it 'no restaurant found' do
        get '/restaurants/my_restaurants_list'
          expect(response.body).to eq("You haven't added any restaurants yet.")
      end
    end
  end
end
