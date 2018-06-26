require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do
  subject{response}

  describe "GET #index" do
    subject { get :index }
    it { is_expected.to render_template "index" }
  end

  describe "GET #show" do
    let(:inquiry) { create(:inquiry) }
    before { get :show, params: { id: inquiry.id } }
    it :aggregate_failures do
      is_expected.to render_template "show"
      expect(assigns(:inquiry)).to eq Inquiry.find(inquiry.id)
    end
  end

  describe "GET #show" do
    let(:inquiry) { create(:inquiry) }
    before { get :show, params: { id: inquiry.id } }
    it :aggregate_failures do
      is_expected.to render_template "show"
      expect(assigns(:inquiry)).to eq Inquiry.find(inquiry.id)
    end
  end

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
    subject { get :edit, params: { id: inquiry.id } }
    let(:inquiry) { create(:inquiry) }
    context "ログイン中" do
      before { log_in user }
      context "ユーザーと質問の作成者が同じ" do
        let(:user) { inquiry.user }
        it :aggregate_failures do
          is_expected.to have_http_status :ok
          is_expected.to render_template "edit"
        end
      end

      context "ユーザーと質問の作成者が違う" do
        let(:user) { create(:user, email: "invalid@x.com")}
        it { is_expected.to redirect_to inquiry }
      end
    end

    context "ログアウト状態" do
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
        it :aggregate_failures do
          expect{ post :create, params: { inquiry: inquiry_params } }.to change{Inquiry.count}.by(1)
          is_expected.to redirect_to Inquiry.last
          expect(Inquiry.last.user).to eq user
        end
      end

      context "投稿がinvalid" do
        subject{ post :create, params: { inquiry: attributes_for(:inquiry, subject: "a"*31) } }
        it { is_expected.to render_template "new" }
      end
    end

    context "ログアウト状態" do
      subject{ post :create, params: { inquiry: inquiry_params } }
      let(:inquiry_params) { attributes_for(:inquiry) }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe "PATCH #update" do
    context "ログイン時" do
      context "ユーザーと質問の作成者が同じ" do
        subject { patch :update, params: { id: inquiry.id, inquiry: update_inquiry } }
        let(:inquiry) { create(:inquiry) }
        before { log_in inquiry.user }
        context "投稿がvalid" do
          let(:update_inquiry) { attributes_for(:inquiry, body: "body") }
          it { is_expected.to redirect_to inquiry }
        end
        context "投稿がinvalid" do
          let(:update_inquiry) { attributes_for(:inquiry, body: "a"*1002) }
          it { is_expected.to render_template "edit" }
        end
      end

      context "ユーザーと質問の作成者が違う" do
        let(:inquiry) { create(:inquiry) }
        let(:invalid_user) { create(:user, email: "create@a.com") }
        before do
          log_in invalid_user
          patch :update, params: { id: inquiry.id, inquiry: attributes_for(:inquiry, body: "body") } 
        end
        it { is_expected.to redirect_to inquiry }
      end
    end

    context "ログアウト状態" do
      subject{ patch :update, params: { id: inquiry.id, inquiry: attributes_for(:inquiry, body: "body") } }
      let(:inquiry) { create(:inquiry) }
      it { is_expected.to redirect_to login_path }
    end
  end

end
