# frozen_string_literal: true

require "rails_helper"
proposals_gem_dir = Gem::Specification.find_by_name("decidim-proposals").gem_dir
files = Dir.glob(File.join(proposals_gem_dir, "spec/shared/*.rb"))
files.each { |f| require(f) }

describe "Admin views proposal details from admin", type: :system do
  include_context "when admin manages proposals"
  include_context "manage proposals"
  include ActionView::Helpers::TextHelper

  let(:participatory_process) { create(:participatory_process, :with_steps, organization: organization, scope: participatory_process_scope) }
  let(:participatory_process_scope) { nil }

  it "has a link to the proposal" do
    go_to_admin_proposal_page(proposal)
    path = "processes/#{participatory_process.slug}/f/#{component.id}/proposals/#{proposal.id}"

    expect(page).to have_selector("a", text: path)
  end

  describe "with personal data" do
    let!(:proposal) { create :proposal, component: current_component, author_name: "Beck", author_surname: "Ronald", author_phone: "650650650" }

    it "has a author name" do
      go_to_admin_proposal_page(proposal)
      expect(page).to have_content("Nom: #{proposal.author_name}")
    end

    it "has a author surname" do
      go_to_admin_proposal_page(proposal)
      expect(page).to have_content("Cognom: #{proposal.author_surname}")
    end

    it "has a author phone" do
      go_to_admin_proposal_page(proposal)
      expect(page).to have_content("Telèfon: #{proposal.author_phone}")
    end
  end
end
