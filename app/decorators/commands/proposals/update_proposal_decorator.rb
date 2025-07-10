# frozen_string_literal: true

class Commands::Proposals::UpdateProposalDecorator
  def self.decorate
    Decidim::Proposals::UpdateProposal.class_eval do
      def attributes
        {
          title: {
            I18n.locale => title_with_hashtags
          },
          body: {
            I18n.locale => body_with_hashtags
          },
          category: form.category,
          scope: form.scope,
          address: form.address,
          latitude: form.latitude,
          longitude: form.longitude,
          author_name: form.author_name,
          author_surname: form.author_surname,
          author_phone: form.author_phone
        }
      end
    end
  end
end

Commands::Proposals::UpdateProposalDecorator.decorate
