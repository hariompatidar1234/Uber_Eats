require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of(:address) }
  end

  describe  "Associaation" do
    it { should have_many(:order_items).dependent(:destroy)}
    it { should have_many(:dishes).through(:order_items)}
    it { should belong_to(:customer).with_foreign_key('user_id')}
  end
end
