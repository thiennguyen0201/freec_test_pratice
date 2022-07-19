require 'rails_helper'

RSpec.describe "Api::V1::Admin::Users", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/admin/users"
      expect(response.status).to eq(200)
    end
  end

  describe "PATCH /update" do
    it "returns http success" do
      patch "/api/v1/admin/users/:id", params: { id: 1 }
      expect(response.status).to eq(200)
    end
  end

  describe "DELETE /destroy" do
    it "returns http success" do
      delete "/api/v1/admin/users/:id", params: { id: 1 }
      expect(response.status).to eq(200)
    end
  end
end