# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication' do
  let(:user) { create(:admin) }
  let(:password) { attributes_for(:admin)[:password] }

  context 'when signed out' do
    before { visit(root_path) }

    it 'displays a sign in link' do
      expect(page).to have_content(I18n.t('common.button.log_in'))
    end

    context 'with valid credentials' do
      it 'allows to sign in' do
        click_link(I18n.t('common.button.log_in'))
        fill_in(I18n.t('users.sessions.new.email.label'), with: user.email)
        fill_in(I18n.t('users.sessions.new.password.label'), with: password)
        click_button(I18n.t('common.button.log_in'))
        expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
      end
    end

    context 'with invalid credentials' do
      it 'does not allow to sign in' do
        click_link(I18n.t('common.button.log_in'))
        fill_in('Email', with: user.email)
        fill_in('Password', with: password.reverse)
        click_button(I18n.t('common.button.log_in'))
        expect(page).to have_content(I18n.t('devise.failure.invalid', authentication_keys: 'Email'))
      end
    end
  end

  context 'when signed in' do
    before do
      sign_in(user, password)
      visit(root_path)
    end

    it "displays the user's email" do
      expect(page).to have_content(user.email)
    end

    it 'displays a sign out link' do
      expect(page).to have_content(I18n.t('application.session.button.log_out'))
    end

    it 'allows to sign out' do
      click_link(I18n.t('application.session.button.log_out'))
      expect(page).to have_content(I18n.t('devise.sessions.signed_out'))
    end
  end
end
