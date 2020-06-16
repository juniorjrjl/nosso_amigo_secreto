require 'rails_helper'

RSpec.describe "Campaigns", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/campaigns/show"
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/campaigns/index"
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/campaigns/create"
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/campaigns/update"
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/campaigns/destroy"
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET /raffle" do
    it "returns http success" do
      get "/campaigns/raffle"
      expect(response).to have_http_status(:found)
    end
  end

end
