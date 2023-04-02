class Api::V1::DocumentsController < ApplicationController
  before_action :set_document, only: %i[create generate_link]

  def list
    @documents = Document.all

    render :list, status: :ok
  end

  def generate_link
    send_data(@document.pdf_content,
      filename: 'example.pdf',
      type: 'application/pdf',
      disposition: 'inline')
  end

  def create
    return update_document if @document.present?

    build_pdf

    if @document.save
      render :show, status: :ok
    else
      render json: { error: @document.errors }, status: :unprocessable_entity
    end
  end

  private

  def build_pdf
    @document = Document.new(description: document_params[:description],
      document_data: document_params[:document_data])

    PdfCreatorService.new(@document).build_pdf(document_params[:document_data],
      document_params[:template])
  end

  def update_document
    PdfCreatorService.new(@document).build_pdf(document_params[:document_data],
      document_params[:template])

    if @document.update(description: document_params[:description],
      document_data: document_params[:document_data])
      render :show, status: :ok
    else
      render json: { error: @document.errors }, status: :unprocessable_entity
    end
  end

  def set_document
    @document = Document.find_by(id: params[:document_id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document).permit(:description, :template,
      document_data: %i[customer_name contract_value])
  end
end
