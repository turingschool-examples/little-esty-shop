# frozen_string_literal: true

require 'rails_helper'

describe 'edit admin merchant page' do
  before do
    @merchant = create(:merchant)
    @merchant_original_name = @merchant.name
    @merchant_original_id = @merchant.id
    visit edit_admin_merchant_path(@merchant.id)
  end
  describe 'header' do
    it 'should have a page header' do
      expect(page).to have_content "Edit Merchant #{@merchant.id}"
    end
  end

  describe 'update merchant form' do
    describe 'initial state' do
      it 'should be prefilled with the merchant information' do
        expect(page).to have_field('merchant[name]', with: @merchant.name)
      end
    end

    describe 'using the form' do
      before do
        fill_in('merchant[name]', with: 'Enrico Dandolo')
      end

      it 'can fill in new information' do
        expect(page).to have_field('merchant[name]', with: 'Enrico Dandolo')
      end

      describe 'when submit button is clicked' do
        before do
          click_button('Submit')
        end

        it 'should take the user to the merchant show page' do
          expect(current_path).to eq(admin_merchant_path(@merchant.id))
        end

        it 'should show the updated merchant information' do
          expect(page).to have_content('Enrico Dandolo')
        end

        it 'should have the same merchant id' do
          expect(@merchant.id).to eq(@merchant_original_id)
  
        end

        it 'should not have the old merchant information' do
          expect(page).to_not have_content(@merchant_original_name)
        end

        it 'should have a flash message' do
          expect(page).to have_content('Merchant successfully updated!')
        end
      end
    end

    describe 'form sad path' do
      it 'flashes a message for a blank input field' do
        visit edit_admin_merchant_path(@merchant.id)
        fill_in('merchant[name]', with: '')
        click_button('Submit')
        expect(current_path).to eq(edit_admin_merchant_path(@merchant.id))
        expect(page).to have_content('Field cannot be blank')
      end
    
    end
  end
end
