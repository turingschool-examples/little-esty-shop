class GithubsController < ApplicationController
    def index
        @contributors = GithubFacade.contributors
      end
end