class ApplicationController < ActionController::Base
  before_action :set_logo
  def welcome
    # test = PhotoSearch.new
    # result_1 = test.random_photo
    # result_2 = test.logo
    # result_3 = test.search_result("cat")
    # result_4 = test.search_result("Assumenda Animi")
  end
  
  def set_logo
    photo = PhotoSearch.new
    @logo = photo.logo
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
