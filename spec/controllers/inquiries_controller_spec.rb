require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do
  subject{response}

  describe "GET #new" do
    context "ログイン中" do
      let(:user) { create(:user) }
      before do
        log_in user
        get :new
      end
      it { expect(response).to have_http_status :ok }
    end
    context "ログアウト状態" do
      before { get :new }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe "GET #edit" do
    context "ログイン中" do
      context "ユーザーが質問の作成者である" do
        let(:inquiry) { create(:inquiry) }
        before do
          log_in inquiry.user
          get :edit, params: { id: inquiry.id }
        end
        it { expect(response).to have_http_status :ok }
      end

      context "ユーザーは作成者じゃない場合" do
        let(:inquiry) { create(:inquiry) }
        let(:invalid_user) { User.create(attributes_for(:user, email: "invalid@x.com"))}
        before do
          log_in invalid_user
          get :edit, params: { id: inquiry.id }
        end
        it { is_expected.to redirect_to inquiry }
      end
    end

    context "ログアウト状態" do
      let(:inquiry) { create(:inquiry) }
      before { get :edit, params: { id: inquiry.id } }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe "POST #create" do
    context "ログイン時" do
      let!(:user) { create(:user) }
      let(:inquiry_params) { attributes_for(:inquiry) }
      before { log_in user }
      context "投稿がvalid" do
        before { post :create, params: { inquiry: inquiry_params } }
        it { expect{ post :create, params: { inquiry: inquiry_params } }.to change{Inquiry.count}.by(1) }
        it { is_expected.to redirect_to Inquiry.last }
        it { expect(Inquiry.last.user).to eq user }
      end

      context "投稿がinvalid" do
        subject{ post :create, params: { inquiry: attributes_for(:inquiry, subject: "a"*31) } }
        it { is_expected.to render_template "new" }
      end
    end

    context "ログアウト状態" do
      let(:inquiry_params) { attributes_for(:inquiry) }
      subject{ post :create, params: { inquiry: inquiry_params } }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe "PATCH #update" do
    context "ログイン時" do
      context "ユーザーが質問の作成者である" do
        let(:inquiry) { create(:inquiry) }
        before { log_in inquiry.user }
        context "投稿がvalid" do
          before { patch :update, params: { id: inquiry.id, inquiry: attributes_for(:inquiry, body: "body") } }
          it { is_expected.to redirect_to inquiry }
        end
        context "投稿がinvalid" do
          before { patch :update, params: { id: inquiry.id, inquiry: attributes_for(:inquiry, body: "a"*1002) } }
          it { is_expected.to render_template "edit" }
        end
      end
    end

    context "ログアウト状態" do
      let(:inquiry) { create(:inquiry) }
      subject{ patch :update, params: { id: inquiry.id, inquiry: attributes_for(:inquiry, body: "body") } }
      it { is_expected.to redirect_to login_path }
    end
  end

end
