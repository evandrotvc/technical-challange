# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document do
  subject(:document) { build(:document) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:document_data) }
    it { is_expected.to validate_presence_of(:pdf_content) }
  end

  describe 'document create' do
    before { document.save }

    it { is_expected.to be_persisted }
  end
end
