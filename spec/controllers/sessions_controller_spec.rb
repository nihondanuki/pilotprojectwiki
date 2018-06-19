require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    before { get :new }

    it { expect(response).to be_successful }
  end

  describe "POST #create" do
    context "login params is valid" do
      let(:user){create(:user)}
      before { post :create, params: { session: { email: user.email, password: user.password }} }
      it { expect(response).to redirect_to user }
    end

    context "login params is invalid" do
      let(:user){create(:user)}
      context "email is invalid" do
        before { post :create, params: { session: { email: "foo", password: user.password }} }
        it { expect(response).to render_template "new" }
      end

      context "password is invalid" do
        before { post :create, params: { session: { email: user.email, password: "foo" }} }
        it { expect(response).to render_template "new" }
      end

      context "email is nil" do
        before { post :create, params: { session: { email: nil, password: user.password }} }
        it { expect(response).to render_template "new" }
      end
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy }
    it { expect(response).to render_template "new" }
  end

end
