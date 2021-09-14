require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
    describe 'Display' do
        before :each do
            @merchant = Merchant.create!({
                name: "fuck",
                id: 1,
                created_at: '2012-03-27 14:53:59 UTC',
                updated_at: '2012-03-27 14:53:59 UTC'
            })

            # binding.pry

            visit(merchant_dashboard_index_path(@merchant))
        end

        it 'can display merchant and attribute' do
            expect(page).to have_content("fuck")            
        end

        it 'can display link to merchants Items' do
            click_link "Items"
            expect(current_path).to eq(merchant_item_path(@merchant))
        end

        it 'can display link to merchants items' do
            click_link "Invoices"
            expect(current_path).to eq("ty")
        end
    end
end