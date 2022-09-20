require 'rails_helper'

RSpec.describe 'application layout' do
  describe 'footer content' do
    describe 'api displays' do
      it 'displays github information' do
        allow(GitHubFacade).to receive(:user_names).and_return(%w[AlainaKneiling AstridHecht LlamaBack ajkrumholz])
        allow(GitHubFacade).to receive(:get_pr_total).and_return(96)

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