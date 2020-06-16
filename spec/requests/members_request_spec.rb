require 'rails_helper'

RSpec.describe "Members", type: :request do

  describe "POST /create" do
    it "returns http success" do
      post "/members"
      expect(response).to have_http_status(:found)
    end
  end

  describe "DELETE /destroy" do
    it "returns http success" do
      delete "/members/destroy"
      expect(response).to have_http_status(:found)
    end
  end

  describe "PUT /update" do
    it "returns http success" do
      put "/members/update"
      expect(response).to have_http_status(:found)
    end
  end

end
