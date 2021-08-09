require 'rails_helper'

RSpec.describe 'The merchant discounts new discount page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Tom Holland')
    allow(API).to receive(:next_three_holidays).and_return({"Labour Day" => "2021-09-06", "Columbus Day" => "2021-10-11", "Veterans Day" => '2021-11-11'})

    @holidays = API.next_three_holidays

    visit new_merchant_discount_path(@merchant1)
  end

  it 'is on the correct page' do
    expect(current_path).to eq(new_merchant_discount_path(@merchant1))
    expect(page).to have_content("New Discount for #{@merchant1.name}")
  end

  it 'will not let you submit an incomplete form' do
    fill_in 'Name', with: "test"
    click_on 'Create Discount'

    expect(current_path).to eq(new_merchant_discount_path(@merchant1))
    expect(page).to have_content("Discount was not created")
    save_and_open_page
  end

  it 'will not let you submit an incomplete form' do
    fill_in 'Name', with: "test"
    fill_in 'Threshold', with: '5'
    click_on 'Create Discount'

    expect(current_path).to eq(new_merchant_discount_path(@merchant1))
    expect(page).to have_content("Discount was not created")

  end

  it 'will not let you submit an incomplete form' do
    fill_in 'Name', with: "test"
    fill_in 'Percentage', with: '5'
    click_on 'Create Discount'

    expect(current_path).to eq(new_merchant_discount_path(@merchant1))
    expect(page).to have_content("Discount was not created")
  end

  it 'will submit a new form and redirect you to the index page' do
    fill_in 'Name', with: "fife"
    fill_in 'Percentage', with: '5'
    fill_in 'Threshold', with: '5'
    click_on 'Create Discount'

    expect(current_path).to eq(merchant_discounts_path(@merchant1))
    expect(page).to have_content("Discount was successfully created")
  end
end
