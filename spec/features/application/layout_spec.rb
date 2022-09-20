require 'rails_helper'

RSpec.describe 'application layout' do
  describe 'footer content' do
    describe 'api displays' do
      it 'displays github information' do
        visit admin_merchants_path

        expect(page).to have_content('ajkrumholz')
        expect(page).to have_content('AstridHecht')
        expect(page).to have_content('LlamaBack')
        expect(page).to have_content('AlainaKneiling')
        expect(page).to have_content("Our total pull requests: 96")
      end
    end
  end
end