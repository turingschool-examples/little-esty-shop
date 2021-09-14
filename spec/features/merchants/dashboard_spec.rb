require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
    describe 'Display' do
        before :each do
            merchant = Merchant.create!({
                name: "fuck",
                id: 1,
                created_at: '2012-03-27 14:53:59 UTC',
                updated_at: '2012-03-27 14:53:59 UTC'
            })

            # binding.pry

            visit(merchant_dashboard_index_path(merchant))
        end

        it 'can display merchant and attribute' do
            expect(page).to have_content("fuck")            
        end
    end
end