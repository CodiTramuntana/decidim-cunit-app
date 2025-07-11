# frozen_string_literal: true

class Commands::Proposals::CreateProposalDecorator
  def self.decorate
    Decidim::Proposals::CreateProposal.class_eval do
      def create_proposal
        PaperTrail.request(enabled: false) do
          @proposal = Decidim.traceability.perform_action!(
            :create,
            Decidim::Proposals::Proposal,
            @current_user,
            visibility: "public-only"
          ) do
            proposal = Decidim::Proposals::Proposal.new(
              title: {
                I18n.locale => title_with_hashtags
              },
              body: {
                I18n.locale => body_with_hashtags
              },
              author_name: form.author_name,
              author_surname: form.author_surname,
              author_phone: form.author_phone,
              component: form.component
            )
            proposal.add_coauthor(@current_user, user_group:)
            proposal.save!
            proposal
          end
        end
      end
    end
  end
end

Commands::Proposals::CreateProposalDecorator.decorate
