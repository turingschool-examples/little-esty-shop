class ApplicationController < ActionController::Base
  before_action :api_request

  def api_request
    @search = RepoSearch.new
  end
end
