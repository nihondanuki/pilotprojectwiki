require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).
      is_at_most(50)
    }
  end
  
  describe '#email' do
    it { is_expected.to validate_presence_of(:email)}
    it { is_expected.to validate_length_of(:email).
      is_at_most(50)
    }
    it { is_expected.not_to allow_value("invalid").for(:email)}
    it { is_expected.to allow_value("a@a.com").for(:email)}
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end