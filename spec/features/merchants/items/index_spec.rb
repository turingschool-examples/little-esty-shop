require 'rails_helper'

RSpec.describe 'Merchant Items Index Page: ' do
  before :each do
    @merch1 = create(:merchant)
    @item1 = create(:item, merchant: @merch1, unit_price: 5700)
    @item2 = create(:item, merchant: @merch1)

    @merch2 = create(:merchant)
    @item3 = create(:item, merchant: @merch2)
    @item4 = create(:item, merchant: @merch2)
    @item5 = create(:item, merchant: @merch2)
  end

  describe 'As a Merchant' do
    describe 'I visit my merchant items index page' do
      it 'I see a list of all my items' do
        visit merchant_items_path(@merch1.id)

        expect(page).to have_content(@merch1.name)
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)

        expect(page).to_not have_content(@item3.name)
        expect(page).to_not have_content(@item4.name)
        expect(page).to_not have_content(@item5.name)
      end

      it 'items are linked to items index page' do
        visit merchant_items_path(@merch2.id)

        within("#item_#{@item3.id}") do
          expect(page).to have_link("#{@item3.name}")
          expect(page).to_not have_link("#{@item4.name}")
          expect(page).to_not have_link("#{@item5.name}")
        end

        within("#item_#{@item4.id}") do
          expect(page).to have_link("#{@item4.name}")
          expect(page).to_not have_link("#{@item3.name}")
          expect(page).to_not have_link("#{@item5.name}")
        end

        expect(page).to have_link("#{@item5.name}")
      end
    end

    describe 'Able to Disable/Enable items' do
      it 'Button next to each item to disable or enable the item' do
        visit merchant_items_path(@merch2.id)

        within("#item_#{@item3.id}") do
          expect(page).to have_button('Disable')
          expect(page).to_not have_button('Enable')
        end

        within("#item_#{@item4.id}") do
          expect(page).to have_button('Disable')
          expect(page).to_not have_button('Enable')
        end

        within("#item_#{@item5.id}") do
          expect(page).to have_button('Disable')
          expect(page).to_not have_button('Enable')
        end
      end

      it 'when clicked, redirected back to item/index page' do
        visit merchant_items_path(@merch1.id)

        within("#item_#{@item1.id}") do
          click_button 'Disable'
        end

        expect(current_path).to eq(merchant_items_path(@merch1.id))
      end

      it 'item status has changed from enabled to disabled' do
        visit merchant_items_path(@merch1.id)

        within("#item_#{@item1.id}") do
          click_button 'Disable'
        end

        within("#item_#{@item1.id}") do
          expect(page).to_not have_button('Disable')
          expect(page).to have_button('Enable')
        end
      end

      describe 'I see two sections, Enabled and Disabled' do
        it 'has Enabled and Disabled sections' do
          visit merchant_items_path(@merch1.id)

          within("#enabled") do
            within("#item_#{@item1.id}") do
              expect(page).to have_link(@item1.name)
              expect(page).to have_button("Disable")
            end
          end
        end

        it 'items are listed in appropriate sections' do
          visit merchant_items_path(@merch1.id)

          within("#enabled") do
            expect(page).to have_link(@item1.name)
            expect(page).to have_link(@item2.name)
          end

          within("#enabled") do
            within("#item_#{@item1.id}") do
              click_button 'Disable'
            end
          end

          within("#enabled") do
            expect(page).to_not have_link(@item1.name)
            within("#item_#{@item2.id}") do
              expect(page).to have_link(@item2.name)
              expect(page).to have_button("Disable")
            end
          end
  
          within("#disabled") do
            within("#item_#{@item1.id}") do
              expect(page).to have_link(@item1.name)
              expect(page).to have_button("Enable")
            end
          end
        end
      end

      describe 'there is a link to create a new item' do
        it 'the link exists on the page' do
        visit merchant_items_path(@merch1.id)
        expect(page).to have_link("New Item")
        end
      end
    end
  end
end