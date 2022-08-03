class ApplicationController < ActionController::Base
  require 'httparty'
  require 'json'
  require 'pry'
  require './app/poros/username_search'

  def index
    search = UsernameSearch.new
  end

end
