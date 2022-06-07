# this facade is in charge of creating repository, dealing with repo logic and handling fetch calls with service - controllers right hand person(controller tells facade what to grab)
require 'rails_helper'

RSpec.describe RepositoryFacade do
  describe 'creating a repository poros' do
    it 'does the thing', :vcr do
      repo = RepositoryFacade.create_repo


      expect(repo).to be_an_instance_of(Repository)
    end

    it "can create contributors poros", :vcr do
      contributor = RepositoryFacade.contributor
      # binding.pry
      expect(contributor[0]).to be_a(Contributor)
    end
  end
end
