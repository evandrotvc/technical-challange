class Document < ApplicationRecord
  validates :pdf_content, :description, :document_data, presence: true
end
