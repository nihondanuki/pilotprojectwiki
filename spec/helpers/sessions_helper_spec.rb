require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe "#logged_in?" do
    subject{logged_in?}
    context "login" do
      let!(:current_user){create(:user)}
      it { is_expected.to eq true}
    end

    context "not login" do
      it { is_expected.to eq false}
    end
  end

  describe "#log_in" do
    let(:user){create(:user)}
    before { log_in user }
    it { expect(session[:user_id]).to eq user.id }
  end

  describe "#current_user" do
    let(:user){create(:user)}
    before { session[:user_id] = user.id }
    it { expect(current_user).to eq user }
  end

  describe "#log_out" do
    let(:user){create(:user)}
    before do
      session[:user_id] = user.id
      log_out
    end
    it :aggregate_failures do
      expect(current_user).to eq nil
      expect(session[:user_id]).to eq nil
    end
  end
end
