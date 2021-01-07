module ApplicationHelper
  def enum_collection_for_select(attribute, include_blank = true)
    x = attribute.map { |r| [r[0].titleize, r[0]] }
    x.insert(0,['', '']) if include_blank == true
    x
  end
end
