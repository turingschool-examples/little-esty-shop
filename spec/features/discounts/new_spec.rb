require "rails_helper"

RSpec.describe("Discounts New Page") do
  before(:each) do
    @merchant = create(:merchant)
    visit(new_merchant_discount_path(@merchant))
  end
  describe 'When I visit /merchants/:merchant_id/discounts/new' do
    describe 'Then I see' do
      it 'a form to create a new discount' do
        within "#discounts-form-#{@merchant.id}" do
          expect(find('form')).to have_content('Item Threshold:')
          expect(find('form')).to have_content('Discount:')
        end
      end

      describe 'When I fill out the form' do
        context 'given valid data' do
          it 'I am taken to the discount index page and see the new discount listed'
        end
        context 'given invalid data' do
          it 'I am taken to the discount new page and see a flash message'
        end
      end
    end
  end
end