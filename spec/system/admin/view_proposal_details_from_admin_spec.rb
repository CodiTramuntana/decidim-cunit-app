# frozen_string_literal: true

require "rails_helper"
proposals_gem_dir = Gem::Specification.find_by_name("decidim-proposals").gem_dir
files = Dir.glob(File.join(proposals_gem_dir, "spec/shared/*.rb"))
files.each { |f| require(f) }

describe "Admin views proposal details from admin" do
  include_context "when admin manages proposals"
  include ActionView::Helpers::TextHelper

  let(:participatory_process_scope) { nil }
  let(:participatory_process) { create(:participatory_process, :with_steps, organization: organization, scope: participatory_process_scope) }

  before do
    click_link_or_button proposal.title["en"]
  end

  describe "with personal data" do
    let!(:proposal) { create(:proposal, component: current_component, author_name: "Beck", author_surname: "Ronald", author_phone: "650650650") }

    it "has a author name" do
      expect(page).to have_content("Name: #{proposal.author_name}")
    end

    it "has a author surname" do
      expect(page).to have_content("Surname: #{proposal.author_surname}")
    end

    it "has a author phone" do
      expect(page).to have_content("Phone: #{proposal.author_phone}")
    end
  end
end
