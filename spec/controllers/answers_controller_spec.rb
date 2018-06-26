require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      let(:inquiry) { create(:inquiry) }
      get :create
      expect(response).to redirect_to inquiry
    end
  end

end
