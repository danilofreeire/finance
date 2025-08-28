class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  before_action :set_accounts  # 👈 adiciona isso aqui

  layout "profile"
private
  def set_account
  @account = current_user.accounts.friendly.find(params[:account_id]) if params[:account_id].present?
    end

    
  def set_accounts
    @accounts = current_user.accounts.order(:name)
  end
end