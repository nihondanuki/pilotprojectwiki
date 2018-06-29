require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  subject{response}
  describe "GET #new" do
    before { get :new }

    it { is_expected.to be_successful }
  end

  describe "POST #create" do
    context "login params is valid" do
      let(:user){create(:user)}
      before { post :create, params: { session: { email: user.email, password: user.password }} }
      it { is_expected.to redirect_to inquiries_path }
    end

    context "login params is invalid" do
      let(:user){create(:user)}
      context "email is invalid" do
        before { post :create, params: { session: { email: "foo", password: user.password }} }
        it { is_expected.to render_template "new" }
      end

      context "password is invalid" do
        before { post :create, params: { session: { email: user.email, password: "foo" }} }
        it { is_expected.to render_template "new" }
      end

      context "email is nil" do
        before { post :create, params: { session: { email: nil, password: user.password }} }
        it { is_expected.to render_template "new" }
      end
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy }
    it { is_expected.to redirect_to login_path }
  end

end
