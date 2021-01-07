require './app/models/repo_search'

class AdminController < ApplicationController
    include RepoSearch
    layout 'admin'

    def index
        repo_info # how to run module?
        require 'pry'; binding.pry
        @repo_name = Repo.all.first
    end
end