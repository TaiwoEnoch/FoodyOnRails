require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:user) { User.create(name: 'John Doe') }

  before :each do
    @inventory = Inventory.create(
      name: 'My Inventory',
      user_id: user,
      description: 'This is a test inventory'
    )
  end

  it 'should have a name' do
    expect(@inventory.name).to eq('My Inventory')
  end

  it 'should have a description' do
    expect(@inventory.description).to eq('This is a test inventory')
  end
end
