require 'rails_helper'

RSpec.describe 'Merchant Discount Edit Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @pretty_plumbing = create(:merchant)

    @discounts = create_list(:discount, 5, merchant: @pretty_plumbing)
    @discounts_1 = create_list(:discount, 5, merchant: @merchant_1)

  end

#   As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated
  describe 'user story 5-solo' do
     it 'When I click the edit discount link I am taken to a new page with a form to edit' do
       visit merchant_discount_path(@merchant_1, @discounts_1[2])

       within("#discount-#{@discounts_1[2].id}") do
         click_link "Edit Discount"
       end

       expect(current_path).to eq(edit_merchant_discount_path(@merchant_1, @discounts_1[2]))

       visit merchant_discount_path(@pretty_plumbing, @discounts[4])

       within("#discount-#{@discounts[4].id}") do
         click_link "Edit Discount"
       expect(current_path).to eq(edit_merchant_discount_path(@pretty_plumbing, @discounts[4]))
     end
   end

   it 'I see that the discounts current attributes are pre-populated in the form' do
     visit edit_merchant_discount_path(@pretty_plumbing, @discounts[4])
     expect(page).to have_content(@discounts[4].bulk_discount.round(2))
     expect(page).to have_content(@discounts[4].item_threshold)

     visit edit_merchant_discount_path(@merchant_1, @discounts_1[2])
     expect(page).to have_content(@discounts_1[2].bulk_discount.round(2))
     expect(page).to have_content(@discounts_1[2].item_threshold)
   end

   it 'I change any/all of the information and click submit
   Then I am redirected to the bulk discounts show page
   And I see that the discounts attributes have been updated' do

    visit edit_merchant_discount_path(@pretty_plumbing, @discounts[4])

    fill_in "Item threshold",	with: 15
    click_button"Update Discount"

    expect(current_path).to eq(merchant_discount_path(@pretty_plumbing, @discounts[4]))
    expect(page).to have_content(15)
    expect(page).to_not have_content(20)
  end
 end
end
