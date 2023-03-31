
class Api::V1::DocumentsController < ApplicationController
    # before_action :set_user, only: %i[show edit update destroy]

    def list
      @documents = Document.all
      byebug
      render json: { documents: @documents }, status: :ok
    end

    def preview
      pdf = Prawn::Document.new(page_size: 'A4')
      # pdf.text "<h1>Hello There!</h1>"
      customer_name = "Evandro Thalles"
      PrawnHtml.append_html(pdf, "<h1 style='text-align: center'>Just a test {{ customer_name }}</h1>")
      #

      send_data(pdf.render,
        filename: 'hello_world.pdf',
        type: 'application/pdf',
        disposition: 'inline'
      )

    end

    def create
      # @document = Document.new(document_params)

      teste =  document_params[:document_data]
      string_with_placeholders = "Hello {{customer_name}}, your age is {{contract_value}}."

      string_with_values = string_with_placeholders.gsub(/\{\{(\w+)\}\}/) { |match|
        key = $1.to_sym
        teste[key].to_s
      }

      byebug
      render json: { documents: @documents }, status: :ok
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

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:description, :template, :document_data  => [:customer_name, :contract_value ])
    end
end