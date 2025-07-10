# frozen_string_literal: true

module Lib::Proposals::ProposalSerializerDecorator
end

Decidim::Proposals::ProposalSerializer.class_eval do
  alias_method :original_serialize, :serialize

  def serialize
    original_serialize.merge({
                               author_name: proposal.author_name,
                               author_surname: proposal.author_surname,
                               author_phone: proposal.author_phone
                             })
  end
end
