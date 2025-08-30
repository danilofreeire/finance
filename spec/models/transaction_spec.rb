# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Transaction, type: :model) do
  context "associations" do
    it { should belong_to(:account) }
  end
  context "enums" do
    it { is_expected.to define_enum_for(:kind).with_values(income: 0, expense: 1) }
  end
end
