# frozen_string_literal: true

module Dashboards
  module Sum
    class Organizer
      include Interactor::Organizer

      organize(Sum)
    end
  end
end
