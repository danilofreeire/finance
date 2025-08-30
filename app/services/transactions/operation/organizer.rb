# frozen_string_literal: true

module Transactions
  module Operation
    class Organizer
      include Interactor::Organizer

      organize(Operation)
    end
  end
end
