# # this facade is in charge of creating repository, dealing with repo logic and handling fetch calls with service - controllers right hand person(controller tells facade what to grab)
# require 'rails_helper'
#
# RSpec.describe RepositoryFacade do
#   describe 'creating a repository poros' do
#     xit 'does the thing', :vcr do
#       repo = RepositoryFacade.create_repo
#
#       expect(repo).to be_an_instance_of(Repository)
#     end
#
#     xit 'can create contributors poros', :vcr do
#       contributor = RepositoryFacade.contributor_or_error
#
#       expect(contributor[0]).to be_a(Contributor)
#     end
#
#     xit 'can create pull requests merged poros', :vcr do
#       merge = RepositoryFacade.merged_or_error
#
#       expect(merge[0]).to be_a(PullRequest)
#     end
#   end
# end
