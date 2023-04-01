json.extract! document, :id, :description, :document_data, :created_at
json.pdf_url  api_v1_document_generate_link_url(document)
