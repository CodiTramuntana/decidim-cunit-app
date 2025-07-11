# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Proposals
    describe CreateProposal do
      let(:form_klass) { ProposalWizardCreateStepForm }
      let(:component) { create(:proposal_component) }
      let(:organization) { component.organization }
      let(:user) { create(:user, :admin, :confirmed, organization:) }
      let(:form) do
        form_klass.from_params(
          form_params
        ).with_context(
          current_user: user,
          current_organization: organization,
          current_participatory_space: component.participatory_space,
          current_component: component
        )
      end

      let(:author) { create(:user, organization:) }

      let(:user_group) do
        create(:user_group, :verified, organization:, users: [author])
      end

      describe "call" do
        let(:form_params) do
          {
            title: "A reasonable proposal title",
            body: "A reasonable proposal body",
            author_name: "Beck",
            author_surname: "Ronald",
            author_phone: "650650650",
            user_group_id: user_group.try(:id)
          }
        end

        let(:command) do
          described_class.new(form, author)
        end

        describe "when the form is not valid" do
          before do
            allow(form).to receive(:invalid?).and_return(true)
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't create a proposal" do
            expect do
              command.call
            end.not_to change(Decidim::Proposals::Proposal, :count)
          end
        end

        describe "when the form is valid" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "creates a new proposal" do
            expect do
              command.call
            end.to change(Decidim::Proposals::Proposal, :count).by(1)
          end

          it "sets the author data" do
            command.call
            proposal = Decidim::Proposals::Proposal.last

            expect(proposal.author_name).to eq form_params[:author_name]
            expect(proposal.author_surname).to eq form_params[:author_surname]
            expect(proposal.author_phone).to eq form_params[:author_phone]
          end
        end
      end
    end
  end
end
