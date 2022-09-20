require 'rails_helper'

RSpec.describe 'Merchant Items Index Page: ' do

  before(:each) do
    @merch1 = create(:merchant)
    @item1 = create(:item, merchant: @merch1, unit_price: 5700)
    @item2 = create(:item, merchant: @merch1)

    @merch2 = create(:merchant)
    @item3 = create(:item, merchant: @merch2, unit_price: 500)
    @item4 = create(:item, merchant: @merch2, unit_price: 500)
    @item5 = create(:item, merchant: @merch2, unit_price: 500)
    @item6 = create(:item, merchant: @merch2, unit_price: 500)
    @item7 = create(:item, merchant: @merch2, unit_price: 500)
    @item8 = create(:item, merchant: @merch2, unit_price: 500)
    @item9 = create(:item, merchant: @merch2, unit_price: 500)

    @invoice1 = create(:invoice, status: :completed, created_at: "Sun, 28 Aug 2022")
    @invoice2 = create(:invoice, status: :completed, created_at: "Mon, 29 Aug 2022")
    @invoice3 = create(:invoice, status: :completed, created_at: "Tues, 30 Aug 2022")
    @invoice4 = create(:invoice, status: :completed)
    @invoice5 = create(:invoice, status: :completed)

    @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item3, quantity: 10, unit_price: 100, status: :packaged)
    @inv_item2 = create(:invoice_item, invoice: @invoice2, item: @item4, quantity: 11, unit_price: 100, status: :packaged)
    @inv_item3 = create(:invoice_item, invoice: @invoice3, item: @item5, quantity: 12, unit_price: 100, status: :packaged)
    @inv_item4 = create(:invoice_item, invoice: @invoice4, item: @item6, quantity: 13, unit_price: 100, status: :packaged)
    @inv_item5 = create(:invoice_item, invoice: @invoice5, item: @item7, quantity: 14, unit_price: 100, status: :packaged)
    @inv_item6 = create(:invoice_item, invoice: @invoice1, item: @item8, quantity: 15, unit_price: 100, status: :packaged)
    @inv_item7 = create(:invoice_item, invoice: @invoice2, item: @item9, quantity: 16, unit_price: 100, status: :packaged)
    @inv_item8 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 10, unit_price: 100, status: :packaged)
    @inv_item9 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 11, unit_price: 100, status: :packaged)
    @inv_item10 = create(:invoice_item, invoice: @invoice5, item: @item5, quantity: 12, unit_price: 100, status: :packaged)

    @tranaction1 = create(:transaction, invoice_id: @invoice1.id, result: :success)
    @tranaction2 = create(:transaction, invoice_id: @invoice2.id, result: :failed)
    @tranaction3 = create(:transaction, invoice_id: @invoice3.id, result: :success)
    @tranaction4 = create(:transaction, invoice_id: @invoice4.id, result: :success)
    @tranaction5 = create(:transaction, invoice_id: @invoice5.id, result: :success)
    @tranaction6 = create(:transaction, invoice_id: @invoice1.id, result: :success)
    @tranaction7 = create(:transaction, invoice_id: @invoice2.id, result: :failed)
    @tranaction8 = create(:transaction, invoice_id: @invoice3.id, result: :failed)
    @tranaction9 = create(:transaction, invoice_id: @invoice4.id, result: :failed)
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

      describe 'there are names of the top 5 most popular items ranked by revenue' do
        it 'has a section for top 5' do
          visit merchant_items_path(@merch1.id)

          expect(page).to have_content("Top Items")
        end

        it 'has links to item show page' do
          visit merchant_items_path(@merch2.id)

          within("#top_items") do
            within("#rev_item_#{@item3.id}") do
              expect(page).to have_link(@item3.name)
            end
            expect(page).to_not have_link(@item4.name)
            expect(page).to have_link(@item5.name)
            expect(page).to have_link(@item6.name)
            expect(page).to have_link(@item7.name)
            expect(page).to have_link(@item8.name)
            expect(page).to_not have_link(@item9.name)
          end
        end

        it 'links are ordered by top revenue' do

          visit merchant_items_path(@merch2.id)

          within("#top_items") do
            expect(@item3.name).to appear_before(@item8.name)
            expect(@item8.name).to appear_before(@item5.name)
            expect(@item5.name).to appear_before(@item7.name)
            expect(@item7.name).to appear_before(@item6.name)
          end
        end 

        it 'when link is clicked, taken to show page' do
          visit merchant_items_path(@merch2.id)

          within("#top_items") do
            click_link @item8.name
          end

          expect(current_path).to eq(merchant_item_path(@merch2.id, @item8.id))
        end

        it 'total revenue for item is displayed' do
          visit merchant_items_path(@merch2.id)

          within("#top_items") do
            within("#rev_item_#{@item3.id}") do
              expect(page).to have_content("$30.00")
            end

            within("#rev_item_#{@item8.id}") do
              expect(page).to have_content("$30.00")
            end

            within("#rev_item_#{@item5.id}") do
              expect(page).to have_content("$24.00")
            end

            within("#rev_item_#{@item7.id}") do
              expect(page).to have_content("$14.00")
            end

            within("#rev_item_#{@item6.id}") do
              expect(page).to have_content("$13.00")
            end
          end
        end
      end

      describe 'next to each of the 5 most popular items' do
        it 'I see the date with the most sales for each item' do
          visit merchant_items_path(@merch2.id)

          within("#top_items") do
            within("#rev_item_#{@item3.id}") do
              expect(page).to have_content("#{@invoice1.created_at.strftime("%A, %B %-d, %Y")}")
            end

            within("#rev_item_#{@item8.id}") do
              expect(page).to have_content("#{@invoice1.created_at.strftime("%A, %B %-d, %Y")}")
            end

            within("#rev_item_#{@item5.id}") do
              expect(page).to have_content("#{@invoice5.created_at.strftime("%A, %B %-d, %Y")}")
            end

            within("#rev_item_#{@item7.id}") do
              expect(page).to have_content("#{@invoice5.created_at.strftime("%A, %B %-d, %Y")}")
            end

            within("#rev_item_#{@item6.id}") do
              expect(page).to have_content("#{@invoice4.created_at.strftime("%A, %B %-d, %Y")}")
            end
          end
        end

        it "I see a label 'Top selling date for was '" do
          visit merchant_items_path(@merch2.id)

          within("#top_items") do
            within("#rev_item_#{@item3.id}") do
              expect(page).to have_content("Top selling date for #{@item3.name} was #{@invoice1.created_at.strftime("%A, %B %-d, %Y")}")
            end

            within("#rev_item_#{@item8.id}") do
              expect(page).to have_content("Top selling date for #{@item8.name} was #{@invoice1.created_at.strftime("%A, %B %-d, %Y")}")
            end

            within("#rev_item_#{@item5.id}") do
              expect(page).to have_content("Top selling date for #{@item5.name} was #{@invoice5.created_at.strftime("%A, %B %-d, %Y")}")
            end

            within("#rev_item_#{@item7.id}") do
              expect(page).to have_content("Top selling date for #{@item7.name} was #{@invoice5.created_at.strftime("%A, %B %-d, %Y")}")
            end

            within("#rev_item_#{@item6.id}") do
              expect(page).to have_content("Top selling date for #{@item6.name} was #{@invoice4.created_at.strftime("%A, %B %-d, %Y")}")
            end
          end
        end
      end
    end
  end
end