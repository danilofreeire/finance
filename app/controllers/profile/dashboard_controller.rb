module Profile

  class DashboardController < ProfileController
    def index
          @accounts = current_user.accounts.order(:name)  # <- ESSA LINHA resolve

    end
  end
end