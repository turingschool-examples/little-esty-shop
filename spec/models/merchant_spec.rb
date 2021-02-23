require 'rails_helper'

RSpec.describe Merchant, type: :model do
  
  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  it 'is created with status enabled when not provided' do
    cool = Merchant.create!(name: "Cool Beans")

    expect(cool.status).to eq("enabled")
  end

  it 'can have status disabled' do
    cool = Merchant.create!(name: "Cool Beans")
    cool.update!(status: :disabled)

    expect(cool.status).to eq("disabled")
  end
end
