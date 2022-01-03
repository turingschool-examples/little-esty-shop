require 'rails_helper'

RSpec.describe "merchants/show", type: :view do
  before(:each) do
    @merchant = assign(:merchant, Merchant.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
