require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  describe 'userとの関連' do
    it { is_expected.to belong_to(:user)}
  end

  describe '#validate' do
    context 'user_id' do
      it { is_expected.to validate_presence_of(:user_id)}
    end

    context '#body' do
      it { is_expected.to validate_presence_of(:body)}
      it { is_expected.to validate_length_of(:body).is_at_most(1000) }
    end
  
    context '#subject' do
      it { is_expected.to validate_presence_of(:subject)}
      it { is_expected.to validate_length_of(:subject).is_at_most(30) }
    end
  end
  
end