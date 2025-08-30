# frozen_string_literal: true

module Transactions
  module Increase
    class Increase
      include Interactor

      def call
        context.balance = increase_balance(context.account, context.amount)
      rescue StandardError => e
        Rails.logger.error("Erro ao aumentar o saldo da conta: #{e.message}")
        context.fail!(error: e.message)
      end

      private

      def increase_balance(account, amount)
        account.opening_balance += amount
      end
    end
  end
end
