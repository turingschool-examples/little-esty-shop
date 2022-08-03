class GithubsController < ApplicationController
    def index
      @contributors = GithubFacade.contributors
      # @pull_requests = GithubFacade.pull_requests
    end
end