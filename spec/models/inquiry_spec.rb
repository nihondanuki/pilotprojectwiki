require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  describe '#user_id' do
    it { is_expected.to validate_presence_of(:user_id)}
  end

  describe '#body' do
    it { is_expected.to validate_presence_of(:body)}
    it { is_expected.to validate_length_of(:name).is_at_most(30) }
  end

  describe '#subject' do
    it { is_expected.to validate_presence_of(:subject)}
    it { is_expected.to validate_length_of(:name).is_at_most(1000) }
  end
  
end
