class ApplicationController < ActionController::Base
  include ActionView::Helpers::NumberHelper
  @@info = GithubInfo.new

end
