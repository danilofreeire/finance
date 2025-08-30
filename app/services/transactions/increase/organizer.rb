# frozen_string_literal: true

module Transactions
  module Increase
    class Organizer
      include Interactor::Organizer

      organize(Increase)
    end
  end
end
