require 'rails_helper'

RSpec.describe PdfCreatorService, type: :service do
    let(:document) do
        Document.new(description: Faker::Movie.title,
            document_data: {customer_name: "Tomás", contract_value: "R$ 1.990,90" } )
    end

    subject(:described_instance) { described_class.new(document) }
    let(:html_user){ "<h1> Hello {{customer_name}}. The contract value is {{contract_value}}</h1>" }
    let(:document_data) do
        {
            customer_name: "Tomás",
            contract_value: "R$ 1.990,90",
        }
    end

    describe '#methods' do
        context 'translate_html' do
            it 'must return html treated' do
                html_treated = described_instance.translate_html(document_data, html_user)

                expect(html_treated).to eq("<h1> Hello Tomás. The contract value is R$ 1.990,90</h1>")
            end
        end

        context 'build_pdf' do
            it 'must build pdf' do
                described_instance.build_pdf(document_data, html_user)
                expect(document.pdf_content).should_not be_nil
            end
        end
    end
end