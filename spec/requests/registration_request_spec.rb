require 'rails_helper'

RSpec.describe "Api::V1::Auth::Registration", type: :request do
  describe "POST" do
    it "returns http success" do
      post "/api/v1/auth/registration"
      expect(response.status).to eq(200)
    end
  end
end