require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    before do
      get :new
    end

    it { expect(response).to be_successful }
  end

  describe "POST #create" do
    context "valid" do
      let!(:user){create(:user)}
      before do
        post :create, params: { session: { email: user.email, password: user.password }}
      end
      it { expect(response).to redirect_to user }
      it { is_expected.to be_logged_in }
    end

    context "invalid" do
      let!(:user){create(:user)}
      before do
        post :create, params: { session: { email: "foo", password: user.password }}
      end
      it { expect(response).to render_template "new" }
      it { is_expected.not_to be_logged_in }
    end
  end

  describe "DELETE #destroy"

end
