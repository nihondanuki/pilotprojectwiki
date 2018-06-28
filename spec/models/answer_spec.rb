require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'userとの関連' do
    it { is_expected.to belong_to(:user)}
  end

  describe 'inquiryとの関連' do
    it { is_expected.to belong_to(:user)}
  end

  describe '#validate' do
    context 'user_id' do
      it { is_expected.to validate_presence_of(:user_id)}
    end

    context 'inquiry_id' do
      it { is_expected.to validate_presence_of(:inquiry_id)}
    end

    context '#content' do
      it { is_expected.to validate_presence_of(:content)}
      it { is_expected.to validate_length_of(:content).is_at_most(1000) }
    end
  end
end
