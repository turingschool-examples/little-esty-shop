require 'rails_helper'

RSpec.describe 'The merchants discount show page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Tom Holland')
    @merchant2 = Merchant.create!(name: 'Hom Tolland')

    @discount1 = @merchant1.discounts.create(name: 'Threeteen', threshold: 3, percentage: 15)
    @discount2 = @merchant1.discounts.create(name: 'Fourscore', threshold: 4, percentage: 20)
    @discount3 = @merchant1.discounts.create(name: 'Ninetwentynine', threshold: 9, percentage: 29)
    @discount4 = @merchant1.discounts.create(name: 'Twentyfifty', threshold: 20, percentage: 50)
    @discount5 = @merchant1.discounts.create(name: 'Hundredseventyfive', threshold: 100, percentage: 75)
    @discount6 = @merchant2.discounts.create(name: 'Two', threshold: 2, percentage: 2)

    allow(API).to receive(:next_three_holidays).and_return({"Labour Day" => "2021-09-06", "Columbus Day" => "2021-10-11", "Veterans Day" => '2021-11-11'})
    @holidays = API.next_three_holidays

    visit merchant_discount_path(@merchant1, @discount1)
  end

  it 'displays the threshold and percentage discount' do
    expect(page).to have_content(@discount1.threshold)
    expect(page).to have_content(@discount1.percentage)
  end

  it 'does not display any other discounts information' do
    expect(page).to_not have_content(@discount3.percentage)
    expect(page).to_not have_content(@discount4.threshold)
    expect(page).to_not have_content(@discount5.percentage)
  end

  it 'has a link to edit the discount' do
    expect(page).to have_link("Edit #{@discount1.name}")
  end

  it 'reroutes the user to edit the discount after clicking the link' do
    click_on "Edit #{@discount1.name}"
    expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))
  end
end
