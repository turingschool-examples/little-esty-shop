require 'rails_helper'

RSpec.describe 'The merchant discounts index page' do
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

    visit merchant_discounts_path(@merchant1.id)
  end

  it 'is on the correct page' do
    expect(current_path).to eq(merchant_discounts_path(@merchant1.id))
    expect(page).to have_content("Bulk Discounts for #{@merchant1.name}")
  end

  it 'displays all of the discounts associated with the merchant and no others' do
    expect(page).to have_content(@discount1.name)
    expect(page).to have_content(@discount2.name)
    expect(page).to have_content(@discount3.name)
    expect(page).to have_content(@discount4.name)
    expect(page).to have_content(@discount5.name)

    expect(page).to_not have_content(@discount6.name)
  end

  it 'displays all of the discounts attributes' do
    expect(page).to have_content(@discount1.percentage)
    expect(page).to have_content(@discount2.percentage)
    expect(page).to have_content(@discount3.percentage)
    expect(page).to have_content(@discount4.percentage)
    expect(page).to have_content(@discount5.percentage)

    expect(page).to have_content(@discount1.threshold)
    expect(page).to have_content(@discount2.threshold)
    expect(page).to have_content(@discount3.threshold)
    expect(page).to have_content(@discount4.threshold)
    expect(page).to have_content(@discount5.threshold)

  end

  it 'displays a link to the individual discount show pages' do
    expect(page).to have_link("#{@discount1.name}")
    expect(page).to have_link("#{@discount2.name}")
    expect(page).to have_link("#{@discount3.name}")
    expect(page).to have_link("#{@discount4.name}")
    expect(page).to have_link("#{@discount5.name}")
  end

  it 'has a show link that actually redirects you to that show page' do
    click_on "#{@discount1.name}"

    expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
  end

  it 'has a section titled Upcoming Holidays' do
    expect(page).to have_content("Upcoming Holidays")
  end

  it 'has the next 3 upcoming US holidays listed in that section' do
    expect(page).to have_content(@holidays.keys.first)
    expect(page).to have_content(@holidays.keys.second)
    expect(page).to have_content(@holidays.keys.third)
    expect(page).to have_content(@holidays.values.first)
    expect(page).to have_content(@holidays.values.second)
    expect(page).to have_content(@holidays.values.third)
  end

  it 'has a button to delete each discount' do
    within("#discount-#{@discount1.id}") do
      expect(page).to have_link("Destroy")
    end
  end

  it 'actually deletes the discount' do
    expect(page).to have_content('Twentyfifty')
    within("#discount-#{@discount4.id}") do
      click_on "Destroy"
    end
    expect(current_path).to eq(merchant_discounts_path(@merchant1))
    expect(page).to_not have_content('Twentyfifty')
  end

  it 'has links to create new discounts for the three listed holidays' do
    expect(page).to have_link("Create discount for #{@holidays.keys.first}")
    expect(page).to have_link("Create discount for #{@holidays.keys.second}")
    expect(page).to have_link("Create discount for #{@holidays.keys.third}")
  end

  it 'directs to to a discount creation new page when clicking those links' do
    click_on "Create discount for #{@holidays.keys.first}"
    expect(current_path).to eq(new_merchant_discount_path(@merchant1))
  end

end
