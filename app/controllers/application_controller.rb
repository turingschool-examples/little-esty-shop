class ApplicationController < ActionController::Base
  before_action :repo_info, only: [:index, :show, :new, :edit]
  before_action :contributor_info, only: [:index, :show, :new, :edit]
   # gives every crud controller this instance variable
  def repo_info
    @repo = RepositoryFacade.repo_or_error
    # @contributor = RepositoryFacade.contributor
  end

  def contributor_info
    @contributor = RepositoryFacade.contributor_or_error
  end
end
