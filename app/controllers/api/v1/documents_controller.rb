
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
        disposition: 'inline'
      )
    end

    def create
      teste =  document_params[:document_data]
      string_with_placeholders = document_params[:template]

      string_with_values = string_with_placeholders.gsub(/\{\{(\w+)\}\}/) { |match|
        key = $1.to_sym
        teste[key].to_s
      }
 
      pdf = Prawn::Document.new(page_size: 'A4')
      PrawnHtml.append_html(pdf, string_with_values)

      @document = Document.new(
        description: document_params[:description],
        document_data: document_params[:document_data],
        pdf_content: pdf.render
      )

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
      @document = Document.find_by!(id: params[:document_id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:description, :template, :document_data  => [:customer_name, :contract_value ])
    end
end