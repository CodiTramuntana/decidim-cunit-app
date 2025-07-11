# frozen_string_literal: true

require "rails_helper"
proposals_gem_dir = Gem::Specification.find_by_name("decidim-proposals").gem_dir
files = Dir.glob(File.join(proposals_gem_dir, "spec/shared/*.rb"))
files.each { |f| require(f) }

describe "Admin views proposal details from admin" do
  include_context "when admin manages proposals"
  include ActionView::Helpers::TextHelper

  let(:participatory_process_scope) { nil }
  let(:participatory_process) { create(:participatory_process, :with_steps, organization:, scope: participatory_process_scope) }
  let!(:other_user) { create(:user, organization: current_component.organization) }
  let!(:proposal) { create(:proposal, component: current_component, users: [other_user]) }

  before do
    go_to_admin_proposal_page(proposal)
  end

  describe "with personal data" do
    let!(:proposal) { create(:proposal, component: current_component, author_name: "Beck", author_surname: "Ronald", author_phone: "650650650") }

    it "has a author name" do
      expect(page).to have_content("#{I18n.t("activemodel.attributes.proposal.author_name")}: #{proposal.author_name}")
    end

    it "has a author surname" do
      expect(page).to have_content("#{I18n.t("activemodel.attributes.proposal.author_surname")}: #{proposal.author_surname}")
    end

    it "has a author phone" do
      expect(page).to have_content("#{I18n.t("activemodel.attributes.proposal.author_phone")}: #{proposal.author_phone}")
    end
  end

  def go_to_admin_proposal_page(proposal)
    within "tr", text: translated(proposal.title) do
      find("a", class: "action-icon--show-proposal").click
    end
  end
end
