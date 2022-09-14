# frozen_string_literal: true

Decidim::Proposals::ProposalWizardCreateStepForm.class_eval do
  attribute :author_name, String
  attribute :author_surname, String
  attribute :author_phone, String
end
