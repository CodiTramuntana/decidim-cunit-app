# frozen_string_literal: true

class Forms::Proposals::ProposalWizardCreateStepFormDecorator
  def self.decorate
    Decidim::Proposals::ProposalWizardCreateStepForm.class_eval do
      attribute :author_name, String
      attribute :author_surname, String
      attribute :author_phone, String
    end
  end
end

Forms::Proposals::ProposalWizardCreateStepFormDecorator.decorate
