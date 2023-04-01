class PdfCreatorService
    def initialize(document)
      @document = document
    end

    def translate_html(document_data, template_html)
      html_treated = template_html.gsub(/\{\{(\w+)\}\}/) { |match|
        key = $1.to_sym
        document_data[key].to_s
      }

      html_treated
    end

    def build_pdf(document_data, template_html)
      html = translate_html(document_data, template_html)

      pdf = Prawn::Document.new(page_size: 'A4')
      PrawnHtml.append_html(pdf, html)

      @document.pdf_content = pdf.render
    end
end