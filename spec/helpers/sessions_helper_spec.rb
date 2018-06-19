require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe "#logged_in?" do
    subject{logged_in?}
    context "ログインしているとき" do
      let!(:current_user){create(:user)}
      it { is_expected.to eq true}
    end

    context "ログインしているとき" do
      let!(:current_user){nil}
      it { is_expected.to eq false}
    end
  end

  describe "#log_in" do
    let(:user){create(:user)}
    before do
      log_in user
    end
    it { expect(session[:user_id]).to eq user.id }
  end

  describe "#current_user" do
    let(:user){create(:user)}
    before do
      session[:user_id] = user.id
    end
    it { expect(current_user).to eq user }
  end

  describe "#log_out" do
    let(:user){create(:user)}
    before do
      session[:user_id] = user.id
      current_user
      log_out
    end
    it { expect(current_user).to eq nil }
    it { expect(session[:user_id]).to eq nil }
  end
end
