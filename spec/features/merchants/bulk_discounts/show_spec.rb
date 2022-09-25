require 'rails_helper'

RSpec.describe 'bulk discount show page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @bulk_discount_1 = create(:bulk_discount, merchant: @merchant_1, discount: 0.25, threshold: 20)
    @bulk_discount_2 = create(:bulk_discount, merchant: @merchant_1, discount: 0.10, threshold: 15)
    @bulk_discount_3 = create(:bulk_discount, merchant: @merchant_1, discount: 0.05, threshold: 12)

    @bulk_discount_4 = create(:bulk_discount, merchant: @merchant_2, discount: 0.45, threshold: 30)
    @bulk_discount_5 = create(:bulk_discount, merchant: @merchant_2, discount: 0.30, threshold: 20)
    @bulk_discount_6 = create(:bulk_discount, merchant: @merchant_2, discount: 0.20, threshold: 10)
  end

  # As a merchant
  # When I visit my bulk discount show page
  # Then I see the bulk discount's quantity threshold and percentage discount

  describe 'User Story 4 - When I visit my bulk discount show page' do
    it 'Then I see the bulk discounts quantity threshold and percentage discount' do
      visit  merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      within "#bulk-discount-info" do
        expect(page).to have_content(@bulk_discount_1.discount)
        expect(page).to have_content(@bulk_discount_1.threshold)
        expect(page).to_not have_content(@bulk_discount_2.discount)
        expect(page).to_not have_content(@bulk_discount_2.threshold)
      end

      visit  merchant_bulk_discount_path(@merchant_2, @bulk_discount_4)
      
      within "#bulk-discount-info" do
        expect(page).to have_content(@bulk_discount_4.discount)
        expect(page).to have_content(@bulk_discount_4.threshold)
        expect(page).to_not have_content(@bulk_discount_5.discount)
        expect(page).to_not have_content(@bulk_discount_5.threshold)
      end
    end
  end

  # As a merchant
  # When I visit my bulk discount show page
  # Then I see a link to edit the bulk discount
  # When I click this link
  # Then I am taken to a new page with a form to edit the discount
  # And I see that the discounts current attributes are pre-poluated in the form
  # When I change any/all of the information and click submit
  # Then I am redirected to the bulk discount's show page
  # And I see that the discount's attributes have been updated
  
  describe 'User Story 5 - When I visit my bulk discount show page' do
    it 'Then I see a link to edit the bulk discount' do
      visit  merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      within "#edit-bulk-discount" do
        find_link({text: "Edit Bulk Discount ID #{@bulk_discount_1.id}", href: edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)}).visible?
      end

      visit  merchant_bulk_discount_path(@merchant_2, @bulk_discount_4)
      
      within "#edit-bulk-discount" do
        find_link({text: "Edit Bulk Discount ID #{@bulk_discount_4.id}", href: edit_merchant_bulk_discount_path(@merchant_2, @bulk_discount_4)}).visible?
      end
    end

    it 'When I click this link Then I am taken to a new page with a form to edit the discount' do
      visit merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      click_on "Edit Bulk Discount ID #{@bulk_discount_1.id}"

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
      save_and_open_page
      expect(page).to have_content(bulk_discount[edit])
    end

    it 'And I see that the discounts current attributes are pre-poluated in the form' do
      
    end

    it 'when I make an edit, I am redirected back to the show page and see the updated attributes' do
      
    end
  end
end