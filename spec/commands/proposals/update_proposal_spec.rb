# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Proposals
    describe UpdateProposal do
      let(:form_klass) { ProposalForm }

      let(:component) { create(:proposal_component, :with_extra_hashtags, suggested_hashtags: []) }
      let(:organization) { component.organization }
      let(:form) do
        form_klass.from_params(
          form_params
        ).with_context(
          current_organization: organization,
          current_participatory_space: component.participatory_space,
          current_component: component
        )
      end

      let!(:proposal) { create :proposal, component: component, users: [author] }
      let(:author) { create(:user, organization: organization) }

      let(:user_group) do
        create(:user_group, :verified, organization: organization, users: [author])
      end

      let(:latitude) { 40.1234 }
      let(:longitude) { 2.1234 }
      let(:errors) { double.as_null_object }

      describe "call" do
        let(:title) { "A reasonable proposal title" }
        let(:body) { "A reasonable proposal body" }
        let(:author_name) { "Beck" }
        let(:author_surname) { "Ronald" }
        let(:form_params) do
          {
            title: title,
            body: body,
            author_name: author_name,
            author_surname: author_surname,
            author_phone: "650650650",
            address: nil,
            has_address: false,
            user_group_id: user_group.try(:id),
            suggested_hashtags: [],
            attachment: nil,
            photos: [],
            add_photos: [],
            documents: [],
            add_documents: [],
            errors: errors
          }
        end

        subject { described_class.new(form, author, proposal).call }

        describe "when the form is not valid" do
          before do
            allow(form).to receive(:invalid?).and_return(true)
          end

          it "broadcasts invalid" do
            expect { subject }.to broadcast(:invalid)
          end

          it "doesn't update the proposal" do
            expect do
              subject
            end.not_to change(proposal, :title)
          end
        end

        describe "when the form is valid" do
          it "broadcasts ok" do
            expect { subject }.to broadcast(:ok)
          end

          it "updates the proposal" do
            subject
            proposal.reload
            expect(proposal.title).to be_kind_of(Hash)
            expect(proposal.title["en"]).to eq title
            expect(proposal.body).to be_kind_of(Hash)
            expect(proposal.body["en"]).to match(/^#{body}/)
          end

          it "sets the author data" do
            subject
            proposal = Decidim::Proposals::Proposal.last

            expect(proposal.author_name).to match(/^#{author_name}/)
            expect(proposal.author_surname).to match(/^#{author_surname}/)
            expect(proposal.author_phone).to match("650650650")
          end
        end
      end
    end
  end
end
