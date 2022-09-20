require 'rails_helper'

RSpec.describe 'application layout' do
  describe 'footer content' do
    describe 'api displays' do
      it 'displays the names of all collaborators on the repo' do
        visit admin_merchants_path

        expect(page).to have_content('ajkrumholz')
        expect(page).to have_content('AstridHecht')
        expect(page).to have_content('LlamaBack')
        expect(page).to have_content('AlainaKneiling')
      end
    end
  end
end