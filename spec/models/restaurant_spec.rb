require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:address) }
    it { should define_enum_for(:status).
         with_values(
           open: "open",
           closed: "closed"
         ).
         backed_by_column_of_type(:string) }
    # it { should validate_uniqueness_of(:name).scoped_to(:address) }
  end
  describe "association" do
     it { should have_many(:dishes).dependent(:destroy) }
     it { should belong_to(:owner).with_foreign_key('user_id')}
     it { should have_one_attached(:picture)}
  end
end
