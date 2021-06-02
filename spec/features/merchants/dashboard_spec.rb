require 'spec_helper'

RSpec.describe "dashboard" do
  before(:each) do
    @merchant_1 = Merchant.create!(name:'Gypsy Rose')

    visit "merchants/#{@merchant_1.id}/dashboard"
  end

  it 'has merchant name' do
    expect(page).to have_content(@merchant_1.name)
  end

  it 'has link to merchant items index' do

    expect(page).to have_link('Merchant Items Index')
    click_on 'Merchant Items Index'
    expect(path).to eq("merchants/#{@merchant_1.id}/items")
  end

    it 'has link to merchant items index' do

    expect(page).to have_link('Merchant Invoices Index')
    click_on 'Merchant Invoices Index'
    expect(path).to eq("merchants/#{@merchant_1.id}/invoices")
  end
end