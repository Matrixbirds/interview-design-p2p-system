require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /sessions" do
    let(:user) { {name: '10241024', password: '102410241024'} }
    let(:create_user) { User.create(user) }
    it "create success" do
      create_user
      post_json "/api/sessions", {data: user}
      expect(response).to have_http_status(201)
    end
  end

  describe "GET /sessions" do
    context "authorized" do
      let(:user) { {name: '10241024', password: '102410241024'} }
      let(:current_user) do
        _user = User.create(user)
        _user.create_wallet(balance: 100.0)
        _user
      end
      it "session profile" do
        get_json_with_current_user "/api/sessions"
        expect(response).to have_http_status(200)
        expect(json.keys).to include(:token, :id, :wallet)
        expect(json[:wallet].keys).to include(:balance)
      end
    end

    context "unauthorized" do
      let(:current_user) do
        OpenStruct.new(:token => nil)
      end
      it "unauthorized" do
        get_json_with_current_user "/api/sessions"
        expect(response).to have_http_status(422)
      end
    end
  end
end
