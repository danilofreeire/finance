# frozen_string_literal: true

module Dashboards
  module Balance
    class DailyTotal
      include Interactor
      # expects: context.accounts (ActiveRecord::Relation ou Array<Account>)
      # optional: context.date (Date)

      def call
        target_date                 = (context.date || Time.zone.today).to_date
        accounts_collection         = Array(context.accounts).compact
        account_ids                 = accounts_collection.map(&:id)

        if account_ids.empty?
          context.total_balance_today   = 0
          context.total_income_today    = 0
          context.total_expense_today   = 0
          context.balance_until_yesterday_total = 0
          context.balances_by_account_id = {}
          return
        end

        # opening_balance por conta
        opening_balance_by_id = Account.where(id: account_ids).pluck(:id, :opening_balance).to_h

        income_kind_value   = Transaction.kinds[:income]
        expense_kind_value  = Transaction.kinds[:expense]

        base_scope = Transaction.where(account_id: account_ids)

        # Variação acumulada até ontem (receitas +, despesas −), agrupada por conta
        delta_until_yesterday_by_id = base_scope
          .where("date < ?", target_date)
          .group(:account_id)
          .sum(
            Arel.sql("CASE
                        WHEN kind = #{income_kind_value}  THEN amount
                        WHEN kind = #{expense_kind_value} THEN -amount
                        ELSE 0
                      END")
          )

        # Movimentos de hoje por conta
        income_today_by_id  = base_scope.where(date: target_date, kind: :income).group(:account_id).sum(:amount)
        expense_today_by_id = base_scope.where(date: target_date, kind: :expense).group(:account_id).sum(:amount)

        balances_by_account_id = {}
        total_opening_plus_yesterday = 0
        total_income_today           = 0
        total_expense_today          = 0
        total_balance_today          = 0

        accounts_collection.each do |account|
          opening_balance              = opening_balance_by_id[account.id] || 0
          delta_until_yesterday        = delta_until_yesterday_by_id[account.id] || 0
          income_today                 = income_today_by_id[account.id] || 0
          expense_today                = expense_today_by_id[account.id] || 0

          balance_until_yesterday      = opening_balance + delta_until_yesterday
          balance_today                = balance_until_yesterday + income_today - expense_today

          balances_by_account_id[account.id] = {
            opening_balance:            opening_balance,
            delta_until_yesterday:      delta_until_yesterday,
            balance_until_yesterday:    balance_until_yesterday,
            income_today:               income_today,
            expense_today:              expense_today,
            balance_today:              balance_today
          }

          total_opening_plus_yesterday += balance_until_yesterday
          total_income_today           += income_today
          total_expense_today          += expense_today
          total_balance_today          += balance_today
        end

        context.balances_by_account_id        = balances_by_account_id
        context.balance_until_yesterday_total = total_opening_plus_yesterday
        context.total_income_today            = total_income_today
        context.total_expense_today           = total_expense_today
        context.total_balance_today           = total_balance_today
      rescue => e
        Rails.logger.error("Erro ao calcular saldo do dia: #{e.message}")
        context.fail!(error: e.message)
      end
    end
  end
end
