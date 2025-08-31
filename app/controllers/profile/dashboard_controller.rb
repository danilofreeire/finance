# frozen_string_literal: true

module Profile
  class DashboardController < ProfileController
    def index
    result = Dashboards::Balance::DailyTotal.call(
        accounts: @accounts,
        date:     Time.zone.today
      )

      @balances_by_account_id         = result.balances_by_account_id || {}
      @balance_until_yesterday_total  = result.balance_until_yesterday_total || 0
      @total_income_today             = result.total_income_today || 0
      @total_expense_today            = result.total_expense_today || 0
      @total_balance_today            = result.total_balance_today || 0

      flash[:error] = result.error unless result.success?
    end
  end
end
