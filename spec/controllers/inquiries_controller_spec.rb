require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do
  subject{response}

  xdescribe "GET #index" do
    it "returns a sicess response" do
      inquiry = Inquiry.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  xdescribe "GET #show" do
    it "returns a success response" do
      inquiry = Inquiry.create! valid_attributes
      get :show, params: {id: inquiry.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    context "ログイン中" do
      let(:user){create(:user)}
      before do
        session[:user_id] = user.id
        get :new
      end
      it { expect(response).to have_http_status :ok }
    end
    context "ログアウト状態" do
      before do
        get :new
      end
      it { is_expected.to redirect_to login_path }
    end
  end

  xdescribe "GET #edit" do
    it "returns a success response" do
      inquiry = Inquiry.create! valid_attributes
      get :edit, params: {id: inquiry.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "ログイン時" do
      let!(:user){create(:user)}
      let(:inquiry_params){attributes_for(:inquiry)}
      before do
        session[:user_id] = user.id
      end
      context "投稿がvalid" do
        subject{ post :create, params: { inquiry: inquiry_params } }
        it { expect{ post :create, params: { inquiry: inquiry_params } }.to change{Inquiry.count}.by(1) }
        it { is_expected.to redirect_to Inquiry.last }
      end

      context "投稿がinvalid" do
        subject{ post :create, params: { inquiry: attributes_for(:inquiry, subject: "a"*31) } }
        it { is_expected.to render_template "new" }
      end
		end

    context "ログアウト状態" do
      let(:inquiry_params){attributes_for(:inquiry)}
			subject{ post :create, params: { inquiry: inquiry_params } }
      it { is_expected.to redirect_to login_path }
    end
	end

  xdescribe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested inquiry" do
        inquiry = Inquiry.create! valid_attributes
        put :update, params: {id: inquiry.to_param, inquiry: new_attributes}, session: valid_session
        inquiry.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the inquiry" do
        inquiry = Inquiry.create! valid_attributes
        put :update, params: {id: inquiry.to_param, inquiry: valid_attributes}, session: valid_session
        expect(response).to redirect_to(inquiry)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        inquiry = Inquiry.create! valid_attributes
        put :update, params: {id: inquiry.to_param, inquiry: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  xdescribe "DELETE #destroy" do
    it "destroys the requested inquiry" do
      inquiry = Inquiry.create! valid_attributes
      expect {
        delete :destroy, params: {id: inquiry.to_param}, session: valid_session
      }.to change(Inquiry, :count).by(-1)
    end

    it "redirects to the inquiries list" do
      inquiry = Inquiry.create! valid_attributes
      delete :destroy, params: {id: inquiry.to_param}, session: valid_session
      expect(response).to redirect_to(inquiries_url)
    end
  end

end
