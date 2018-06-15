require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    before do
      get :new
    end

    it "returns http success" do
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "valid" do
    end

    context "invalid" do
    end
  end

  describe "DELETE #destroy" do
    it
  end

end
