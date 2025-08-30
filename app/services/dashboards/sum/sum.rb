module Dashboards
  module Sum
    class Sum
      include Interactor

      def call
        ids   = Array(context.accounts).compact.map(&:id)
        scope = Transaction.where(account_id: ids)

        context.total_income  = scope.where(kind: :income).sum(:amount)
        context.total_expense = scope.where(kind: :expense).sum(:amount)

      rescue StandardError => e
        Rails.logger.error("Erro ao aumentar o saldo da conta: #{e.message}")
        context.fail!(error: e.message)
      end

    end
  end
end
