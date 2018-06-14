require 'rails_helper'


RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_success
    end
  end


  describe "POST #create" do
    context "with valid params" do
      let(:user){build(:user)}
      it "creates a new User" do
        expect { post :create, params: { user: attributes_for(:user) } }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { user: attributes_for(:user, password: "a") }
        expect(response).to render_template :new
      end
    end
  end
end
