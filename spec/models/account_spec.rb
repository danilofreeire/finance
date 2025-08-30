# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Account, type: :model) do
  context "associations" do
    it { should have_many(:transactions).dependent(:destroy) }
    it { should belong_to(:user) }
  end
end
