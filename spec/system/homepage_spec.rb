# frozen_string_literal: true

require "spec_helper"

describe "Homepage", type: :system do
  include Decidim::SanitizeHelper

  let!(:organization) do
    create(
      :organization,
      name: "Decidim Application",
      default_locale: :en,
      available_locales: [:ca, :en, :es]
    )
  end
  let!(:hero) { create :content_block, organization: organization, scope_name: :homepage, manifest_name: :hero, settings: { "welcome_text_ca"=>"Benvinguda a Decidim Application" } }
  let!(:sub_hero) { create :content_block, organization: organization, scope_name: :homepage, manifest_name: :sub_hero }

  before do
    switch_to_host(organization.host)
    visit decidim.root_path(locale: I18n.locale)
  end

  it "loads and shows organization name and main blocks" do
    visit decidim.root_path

    expect(page).to have_content("Decidim Application")
    within "section.hero .hero__container" do
      expect(page).to have_content("Benvinguda a Decidim Application")
    end
  end
end
