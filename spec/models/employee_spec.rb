require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it { should belong_to :department }
  end
end