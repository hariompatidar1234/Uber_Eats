require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe "association" do
    it { should belong_to(:dish)}
    it { should belong_to(:cart)}
  end

  describe "Validtions" do
    it {should validate_presence_of(:quantity)}
    it { should validate_numericality_of(:quantity).is_greater_than(1) }
  end
end
