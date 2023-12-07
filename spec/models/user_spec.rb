require 'rails_helper'
# require 'Rspec_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it {  should validate_presence_of(:name) }
    it {  should validate_presence_of(:email) }
    it {  should validate_presence_of(:password) }
    it {  should validate_inclusion_of(:type).in_array(['Customer', 'Owner'])}
  end

  describe "active storage attached" do
    it "has one attached image" do
        should have_one_attached(:picture)
    end
  end

  describe ".ransackable_attributes" do
    it "returns the expected array of attributes" do
      expected_attributes = ["created_at", "email", "encrypted_password", "id", "name", "password", "remember_created_at", "reset_password_sent_at", "reset_password_token", "type", "updated_at"]
    end
  end

end
