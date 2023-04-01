FactoryBot.define do
  factory :document do
    pdf_content { Faker::Internet.url(host: 'example.com') }
    description { Faker::Movie.title }
    document_data do
      {
        customer_name: 'Tomás',
        contract_value: 'R$ 1.990,90'
      }
    end
  end
end
