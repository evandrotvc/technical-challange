class Api::V1::DocumentsController < ApplicationController
  before_action :set_document, only: %i[update generate_link]

  def list
    @documents = Document.all

    render :list, status: :ok
  end

  def generate_link
    send_data(@document.pdf_content,
      filename: 'hello_world.pdf',
      type: 'application/pdf',
      disposition: 'inline')
  end

  def create
    @document = Document.new(description: document_params[:description],
      document_data: document_params[:document_data])

    PdfCreatorService.new(@document).build_pdf(document_params[:document_data],
      document_params[:template])

    if @document.save
      render :show, status: :ok
    else
      render json: { error: @document.errors }, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html do
          redirect_to user_url(@user), notice: 'User was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_document
    @document = Document.find(params[:document_id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document).permit(:description, :template,
      document_data: %i[customer_name contract_value])
  end
end
