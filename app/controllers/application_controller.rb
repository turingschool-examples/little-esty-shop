class ApplicationController < ActionController::Base
  before_action :api_request

  def api_request
    @search = ApiSearch.new
  end
end
