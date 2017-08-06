require 'rails_helper'

RSpec.describe 'Deposits', type: :request do
  let(:user_rich) do
    _user = User.create({name: 'rich', password: '88888888'})
    _user.create_wallet(balance: 999.99)
    _user
  end
  describe 'POST /api/deposits', skip: true do
    let(:current_user) do
      _user = User.create({name: '1024', password: '123123123'})
      _user.create_wallet(balance: 100.0)
      _user
    end
    context 'success' do
      let(:api_params) do
        Hash[data: { consumer_id: user_rich.id, balance: 100.0 }]
      end
      before do
        post_json_with_current_user "/api/users/#{current_user.id}/deposits", api_params
      end
      it 'response 201' do
        expect(response).to have_http_status(201)
      end
      it 'consumer wallet reduce balance' do
        expect(User.find(user_rich.id).wallet.balance).to be(0)
      end
    end

    context 'conflict' do
      let(:api_params) do
      end
      it 'response 419' do
      end
    end
  end
end
