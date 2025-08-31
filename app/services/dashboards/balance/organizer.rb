# frozen_string_literal: true

module Dashboards
  module Balance
    class Organizer
      include Interactor::Organizer

      organize(Sum)
    end
  end
end
