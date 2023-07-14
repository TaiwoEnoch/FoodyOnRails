require 'rails_helper'

RSpec.describe 'Food', type: :request do
  before do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    sign_in @user
  end

  describe 'GET /foods' do
    it 'should respond with success' do
      get '/foods'
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      get '/foods'
      expect(response).to render_template('index')
    end
  end

  describe 'POST /foods' do
    it 'creates a new food' do
      expect do
        post '/foods',
             params: { food: { name: 'test food', measurement_unit: '2', price: 10, unit_quantity: 'kgs' } }
      end.to change { Food.count }.by(1)

      created_food = Food.last
      expect(created_food.name).to eq('test food')
      expect(created_food.measurement_unit).to eq('2')
      expect(created_food.price).to eq(10)
    end

    it 'redirects to the created food' do
      post '/foods',
           params: { food: { name: 'test food', measurement_unit: 2, price: 10, unit_quantity: 'kgs' } }

      expect(response).to redirect_to(foods_path)
    end
  end

end
