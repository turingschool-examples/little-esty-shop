require 'rails_helper'

RSpec.describe "AdminMerchants", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admin_merchants/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin_merchants/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/admin_merchants/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/admin_merchants/create"
      expect(response).to have_http_status(:success)
    end
  end

end
