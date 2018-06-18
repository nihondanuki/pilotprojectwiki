require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    before do
      get :new
    end
    it { expect(response).to be_successful }
  end
end
