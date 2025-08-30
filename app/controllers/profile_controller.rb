# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  before_action :set_accounts # 👈 adiciona isso aqui

  layout "profile"

  private

  def set_account
    account_id = params[:account_id] || params[:id]
    @account = current_user.accounts.friendly.find(account_id) if account_id.present?
  end

  def set_accounts
    @accounts = current_user.accounts.order(:name)
  end
end
