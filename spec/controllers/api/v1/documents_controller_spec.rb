require 'rails_helper'

RSpec.describe Api::V1::DocumentsController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  describe 'GET /list' do
    context 'with valid parameters' do
      let!(:document) { create(:document) }
      let!(:document2) { create(:document) }
      let!(:document3) { create(:document) }

      let(:do_request) do
        get :list, as: :json
      end

      before { do_request }

      it 'must to return all documents' do
        expect(response).to have_http_status(:ok)
        expect(json['documents']).should_not be_nil
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:params) do
        {
          description: 'teste',
          document_data: {
            customer_name: 'Tomás',
            contract_value: 'R$ 1.990,90'
          },
          template: '<h1>Hello {{customer_name}} There! The value {{contract_value}}</h1>'
        }
      end
      let(:do_request) do
        post :create, params: { document: params }, as: :json
      end

      it 'must to created document' do
        expect { do_request }.to change(Document, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
