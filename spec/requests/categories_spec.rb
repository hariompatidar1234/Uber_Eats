require 'rails_helper'

RSpec.describe "Categories", type: :request do
 let(:user) { FactoryBot.create(:user , type: "Owner") }
 let!(:category) {FactoryBot.create(:category)}
   before(:each) do
     sign_in user
     allow(controller).to receive(:current_user).and_return(user)
     current_user = controller.current_user
   end

   describe "GET /index" do
     it 'is expected to assign skill instance variable' do
       get '/categories'
       expect(assigns[:categories]).to eq(Category.all)
     end
   end

   describe 'GET #new' do
     before do
       get '/categories/new'
     end
     it 'renders new template' do
       is_expected.to render_template(:new)
     end
   end

   describe 'POST #create' do
    context 'when params are correct' do
      let(:category) {FactoryBot.build(:category)}
      it 'is expected to create new skill successfully' do
        post '/categories', params: {category: category.as_json }
        expect(response).to redirect_to categories_path
      end
    end
   context 'when params are not correct' do
     it 'is expected to render new template' do
      post '/categories', params:  { category: { name: ''} }
       is_expected.to render_template(:new)
       expect(response).to have_http_status(422)
     end
   end
  end

  describe 'GET #show/:id' do
    context "with data available" do
      it 'render successfully Category data' do
        get "/categories/#{category.id}"
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #edit/id' do
    it 'renders edit template' do
      get "/categories/#{category.id}/edit"
      expect(response).to render_template(:edit)
    end
  end


  describe "PATCH /update/id" do
    context "with valid parameters" do
      it "updates the requested Category" do
        put "/categories/#{category.id}" , params: { category: {name: "indian "} }
        category.reload
        expect(response).to redirect_to categories_path
      end
    end

    context "with invalid parameters" do
      it "renders a response status and edit template" do
       put "/categories/#{category.id}" , params: { category: {name: nil} }
        is_expected.to render_template(:edit)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE /destory/id" do
    it "destroys the requested category" do
      delete "/categories/#{category.id}"
       expect(response).to redirect_to categories_path
    end
  end
end
