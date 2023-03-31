class Api::V1::DocumentsController < ApplicationController
    # before_action :set_user, only: %i[show edit update destroy]

    def list
      @documents = Document.all
      byebug
      render json: { documents: @documents }, status: :ok
    end

    def generate_pdf
        render pdf: "file",
        layout: "application.pdf.erb",
        template: "pdf/template.html.erb"

        respond_to do |format|
          format.html
          format.pdf do
            render :pdf => 'file_name',
            layout: 'pdf.html.erb',
            :template => 'documents/template.pdf.erb',
            # :show_as_html => params[:debug].present?
          end
        end

        # documentation
        # respond_to do |format|
        #   format.html
        #   format.pdf do
        #     render pdf: "file_name",   # Excluding ".pdf" extension.
        #     template: 'things/show',
        #     locals: {foo: @bar},
        #     layout: 'pdf',

        #   end
        # end
    end

    def create
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html do
            redirect_to user_url(@user), notice: 'User was successfully created.'
          end
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
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

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:description, :document_data, :template)
    end
    # :customer_name, :contract_value
end