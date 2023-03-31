class Document < ApplicationRecord
    validates :pdf_url, :description, :document_data, presence: true
end