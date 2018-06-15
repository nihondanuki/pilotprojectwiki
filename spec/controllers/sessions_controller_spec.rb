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
      before do
        post :create,
      end
    end

    context "invalid" do
    end
  end

  describe "DELETE #destroy" do
    it
  end

end
