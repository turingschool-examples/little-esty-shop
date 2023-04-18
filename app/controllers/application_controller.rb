class ApplicationController < ActionController::Base
  def welcome
    # test = PhotoSearch.new
    # result_1 = test.random_photo
    # result_2 = test.logo
    # result_3 = test.search_result("cat")
    # result_4 = test.search_result("Assumenda Animi")
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
