class ApplicationController < ActionController::Base
  include ActionView::Helpers::NumberHelper
  before_action :github

  def github
    @info = GithubInfo.new
  end
end
