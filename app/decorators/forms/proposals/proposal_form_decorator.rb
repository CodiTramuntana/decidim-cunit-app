# frozen_string_literal: true

class Forms::Proposals::ProposalFormDecorator
end

Decidim::Proposals::ProposalForm.class_eval do
  attribute :author_name, String
  attribute :author_surname, String
  attribute :author_phone, String

  validates :author_name,
            :author_surname,
            :author_phone, presence: true
end
