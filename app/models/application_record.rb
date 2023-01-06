class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include ActionView::Helpers::NumberHelper
end
