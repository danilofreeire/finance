class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_header_data
  layout "profile"

  def set_header_data
    @header_accounts = current_user&.accounts || []

  end
end