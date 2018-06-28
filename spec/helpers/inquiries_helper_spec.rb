require 'rails_helper'

RSpec.describe InquiriesHelper, type: :helper do
  describe "#inquiry_permit" do
    include SessionsHelper
    subject { permited_user?(inquiry) }
    let!(:inquiry) { create(:inquiry) }
    context "ログインしているユーザーが投稿者" do
      before { log_in inquiry.user }
      it { is_expected.to eq true }
    end

    context "ログインしているユーザーが投稿者と同一ではない" do
      let!(:user) { create(:user, email: "a@a.a") }
      before { log_in user }
      it { is_expected.to eq false }
    end
  end
end
