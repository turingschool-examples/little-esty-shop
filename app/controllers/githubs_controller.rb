class GithubsController < ApplicationController
    def index
        @contributors = GithubFacade.contributors



        # binding.pry



      end
end