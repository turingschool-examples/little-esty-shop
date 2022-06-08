require 'rails_helper'

RSpec.describe RepositoryFacade do
  describe 'create repository poros' do
    it "creates objects from the repository", :vcr do
      repo = RepositoryFacade.create_repository

      expect(repo).to be_an_instance_of(Repository)
    end
  end

  # describe 'create contributor poros' do
  #   it "creates contributor objects", :vcr do
  #     contributor = RepositoryFacade.create_contributors
  #     require "pry"; binding.pry
  #
  #     expect(contributor).to be_an_instance_of(Contributor)
  #   end
  # end
end
