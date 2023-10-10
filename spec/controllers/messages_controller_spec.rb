# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController do
  render_views

  let(:user) { create(:user) }
  let(:recipient) { create(:user) }

  before do
    sign_in user
    request.headers[:referer] = user_messages_path(user)
  end

  describe 'GET #reply' do
    context 'when users had a conversation before' do
      let(:message) { create(:message, sender: recipient, recipient: user) }

      it 'renders the reply page' do
        message
        get :reply, params: {user_id: user, recipient:}
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when users did not a conversation before' do
      it 'does not render the reply page' do
        get :reply, params: {user_id: user, recipient:}
        expect(response).to redirect_to user_messages_path(user)
      end
    end
  end
end
