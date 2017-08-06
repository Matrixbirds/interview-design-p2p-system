require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /api/users" do
    let(:wallet) { attributes_for(:wallet) }
    let(:user) { attributes_for(:user) }
    let(:api_params) { Hash[data: {}.merge(wallet).merge(user)] }
    it 'create success' do
      post_json "/api/users", api_params
      expect(response).to have_http_status(201)
      expect(response.content_type).to eq('application/json')
      expect(json.keys).to include(:token, :id)
    end
    let(:create_user) { User.create(user) }
    it 'create conflict' do
      create_user
      post_json "/api/users", api_params
      expect(response).to have_http_status(422)
      expect(response.content_type).to eq('application/json')
    end
  end
end
