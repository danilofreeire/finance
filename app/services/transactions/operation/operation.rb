# frozen_string_literal: true

module Transactions
  module Operation
    class Operation
      include Interactor

      def call

        tx   = context.transaction
        acc  = context.account
        amt  = tx.amount

        if tx.income?
          context.balance = increase_balance(acc, amt)
        elsif tx.expense?
          context.balance = decrease_balance(acc, amt)
        else
          context.fail!(error: "Tipo de transação inválido")
        end
        
      rescue StandardError => e
        Rails.logger.error("Erro ao aumentar o saldo da conta: #{e.message}")
        context.fail!(error: e.message)
      end

      private

      def increase_balance(account, amount)
        account.opening_balance += amount
      end

      def decrease_balance(account, amount)
        account.opening_balance -= amount
      end
    
    end
  end
end
