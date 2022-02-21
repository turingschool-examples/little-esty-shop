module ApplicationHelper
    def format_money(integer)
        "$#{(integer.to_f/100).to_s}"
    end
end
