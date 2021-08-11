require 'rails_helper'

RSpec.describe 'Merchants Index Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Tom Holland')
    @merchant2 =  Merchant.create!(name: 'Hol Tommand')
    @merchant3 =  Merchant.create!(name: 'Boss Baby Records')

    visit merchants_path
  end

  it 'is on the correct page' do
    expect(current_path).to eq(merchants_path)
    expect(page).to have_content('Merchants')
  end

  it 'can display all merchants' do
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end

  it 'can take user to merchant dashboard page' do
    click_on "#{@merchant1.name}"

    expect(current_path).to eq(merchant_dashboard_index_path(@merchant1.id))
  end

  it 'can sort merchants by name and updated date' do
    expect(@merchant1.name).to appear_before(@merchant2.name)
    expect(@merchant2.name).to appear_before(@merchant3.name)

    click_on "Sort Alphabetically"

    expect(current_path).to eq(merchants_path)
    expect(@merchant3.name).to appear_before(@merchant2.name)
    expect(@merchant2.name).to appear_before(@merchant1.name)

    @merchant1.update(name: 'Dom Tolland')
    click_on "Sort by Updated Date"

    expect(current_path).to eq(merchants_path)
    expect(@merchant1.name).to appear_before(@merchant2.name)
  end
end
