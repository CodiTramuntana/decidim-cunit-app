# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Proposals
    describe ProposalSerializer do
      subject do
        described_class.new(proposal)
      end

      let!(:proposal) { create(:proposal, :accepted) }

      describe "#serialize" do
        let(:serialized) { subject.serialize }

        it "serializes the author name" do
          expect(serialized).to include(author_name: proposal.author_name)
        end

        it "serializes the author surname" do
          expect(serialized).to include(author_surname: proposal.author_surname)
        end

        it "serializes the author phone" do
          expect(serialized).to include(author_phone: proposal.author_phone)
        end
      end
    end
  end
end
