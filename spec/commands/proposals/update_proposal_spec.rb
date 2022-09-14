# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Proposals
    describe UpdateProposal do
      let(:form_klass) { ProposalForm }

      let(:component) { create(:proposal_component, :with_extra_hashtags, suggested_hashtags: suggested_hashtags.join(" ")) }
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

      let(:has_address) { false }
      let(:address) { nil }
      let(:latitude) { 40.1234 }
      let(:longitude) { 2.1234 }
      let(:suggested_hashtags) { [] }
      let(:attachment_params) { nil }
      let(:uploaded_photos) { [] }
      let(:current_photos) { [] }
      let(:current_files) { [] }
      let(:uploaded_files) { [] }
      let(:errors) { double.as_null_object }

      describe "call" do
        let(:title) { "A reasonable proposal title" }
        let(:body) { "A reasonable proposal body" }
        let(:author_name) { "Beck" }
        let(:author_surname) { "Ronald" }
        let(:author_phone) { "650650650" }
        let(:form_params) do
          {
            title: title,
            body: body,
            author_name: author_name,
            author_surname: author_surname,
            author_phone: author_phone,
            address: address,
            has_address: has_address,
            user_group_id: user_group.try(:id),
            suggested_hashtags: suggested_hashtags,
            attachment: attachment_params,
            photos: current_photos,
            add_photos: uploaded_photos,
            documents: current_files,
            add_documents: uploaded_files,
            errors: errors
          }
        end

        let(:command) do
          described_class.new(form, author, proposal)
        end

        describe "when the form is not valid" do
          before do
            expect(form).to receive(:invalid?).and_return(true)
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't update the proposal" do
            expect do
              command.call
            end.not_to change(proposal, :title)
          end
        end

        describe "when the form is valid" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "updates the proposal" do
            command.call
            proposal.reload
            expect(proposal.title).to be_kind_of(Hash)
            expect(proposal.title["ca"]).to eq title
            expect(proposal.body).to be_kind_of(Hash)
            expect(proposal.body["ca"]).to match(/^#{body}/)
          end

          it "sets the author data" do
            command.call
            proposal = Decidim::Proposals::Proposal.last

            expect(proposal.author_name).to match(/^#{author_name}/)
            expect(proposal.author_surname).to match(/^#{author_surname}/)
            expect(proposal.author_phone).to match(/^#{author_phone}/)
          end
        end
      end
    end
  end
end
