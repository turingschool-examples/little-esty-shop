module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def cents_to_dollars(integer)
    number_to_currency(integer.fdiv(100))
  end
end
