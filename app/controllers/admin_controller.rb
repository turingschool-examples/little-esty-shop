require './app/models/repo_search'
require './app/models/repo'

class AdminController < ApplicationController
    include RepoSearch
    layout 'admin'

    def index
        @repo_name = repo_info.name
    end
end