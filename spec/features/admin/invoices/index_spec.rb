require 'rails_helper'

describe "the admin/invoices index page" do
  before (:each) do
  end

  describe "when I visit the admin/invoices index" do
    it "displays a list of all invoices" do
      visit "/admin/invoices"


    end

    it "has each name as a link to that show page" do
      visit "/admin/merchants"

    end
  end
end
