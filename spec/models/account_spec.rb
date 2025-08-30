# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Account, type: :model) do
  context "associations" do
    it { should have_many(:transactions).dependent(:destroy) }
    it { should belong_to(:user) }
  end
  context "enums" do
    it { is_expected.to(define_enum_for(:kind).with_values(checking: 0, savings: 1, cash: 2, wallet: 3, credit_card: 4, investment: 5, loan: 6, other: 7)) }
  end
end
