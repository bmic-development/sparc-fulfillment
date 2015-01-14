require 'rails_helper'

RSpec.describe ProtocolsController, type: :controller do

  before :each do
    sign_in
  end

  describe "GET #index" do

    context 'content-type: text/html' do

      it 'renders the :index action' do
        get :index, format: :html

        expect(response).to be_success
        expect(response).to render_template :index
      end

      it 'does not assign @protocols' do
        get :index, format: :html

        expect(assigns(:protocols)).to_not be
      end
    end

    context 'content-type: application/json' do

      it 'renders the :index action' do
        get :index, format: :json

        expect(response).to be_success
      end

      it 'assigns @protocols' do
        get :index, format: :json

        expect(assigns(:protocols)).to be
      end
    end
  end

  describe "GET #show" do

    it "assigns the requested protocol to @protocol" do
      protocol = create(:protocol, sparc_id: 1)
      get :show, id: protocol.sparc_id
      expect(assigns(:protocol)).to eq(protocol)
    end

    it "renders the #show view" do
      get :show, id: create(:protocol)
      expect(response).to render_template :show
    end
  end
end