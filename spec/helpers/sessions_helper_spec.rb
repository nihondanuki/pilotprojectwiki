require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe "#logged_in?" do
    context do
      let!(:current_user){create(:user)}
      it { expect(logged_in?).to eq true}
    end

    context do
      let!(:current_user){nil}
      it { expect(logged_in?).to eq false}
    end
  end

  describe "#log_in" do
    context do
      let!(:user){create(:user)}
      it do
        log_in user
        expect(session[:user_id]).to eq user.id
      end
    end
  end

  describe "#current_user" do
    context do
      let!(:user){create(:user)}
      it do
        session[:user_id] = user.id
        expect(current_user).to eq user
      end
    end
  end

  describe "#log_out" do
    let!(:user){create(:user)}
    before do
      session[:user_id] = user.id
      current_user
    end
    it do
      log_out
      expect(current_user).to eq nil
    end
  end
end
