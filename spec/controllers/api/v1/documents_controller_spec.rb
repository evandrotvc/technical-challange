require 'rails_helper'

RSpec.describe Api::V1::DocumentsController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  # let(:do_request) do
#   post :create, params: { user: valid_attributes }, as: :json
# end

  describe 'GET /list' do
    context 'with valid parameters' do
      let!(:document) { create(:document) }
      let!(:document2) { create(:document) }
      let!(:document3) { create(:document) }

      let(:do_request) do
        get :list
      end

      before { do_request }
      it 'must to return all documents' do
        expect(response).to have_http_status(:ok)
        expect(json['documents'].count).to eq(3)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do

      let(:params) do
        {
          description: 'teste',
          document_data: {
            customer_name: "Tomás",
            contract_value: "R$ 1.990,90",
          },
          template: '<h1>Hello There!</h1>'
        }
      end
      let(:do_request) do
        post :create, params: { document: params }, as: :json
      end

      before { do_request }

      it 'must to return all documents' do
        expect(response).to have_http_status(:ok)
        expect(Document.count).to eq(1)
      end
    end
  end
end
