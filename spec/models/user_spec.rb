require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validate' do
    context "name" do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end
  
    context 'email' do
      it { is_expected.to validate_presence_of(:email)}
      it { is_expected.to validate_length_of(:email).is_at_most(50) }
      it { is_expected.not_to allow_value("invalid").for(:email)}
      it { is_expected.to allow_value("a@a.com").for(:email)}
      it { create :user }
      it { is_expected.to validate_uniqueness_of(:email) }
    end

    context 'password' do
      it { is_expected.to have_secure_password }
      it { is_expected.to validate_length_of(:password).is_at_least(9).is_at_most(200) }
    end
  end

  describe '#has_many inquiry' do
    it { is_expected.to have_many(:inquiries)}
  end

end
