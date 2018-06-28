require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe "POST #create" do
    context "ログインしているとき" do
      subject { post :create, params: { answer: { inquiry: inquiry, content: answer.content } } }
      let(:user) { create(:user) }
      let(:inquiry) { create(:inquiry, user: user ) }
      let(:answer) { create(:answer, user: user, inquiry: inquiry) }
      it do
        binding.pry
      end
      before { log_in user }
      it { is_expected.to redirect_to inquiry }
    end

    context "ログインしていないとき" do
      subject { post :create, params: { answer: { } } }
      let(:user) { create(:user) }
      let(:inquiry) { create(:inquiry, user: user ) }
      let(:answer) { create(:answer, user: user, inquiry: inquiry) }
      it { is_expected.to redirect_to login_path }
    end
  end
end
