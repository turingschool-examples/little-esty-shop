class GithubApiController < ApplicationController
    def index 
        @gh = GitHubApi.new
    end
end