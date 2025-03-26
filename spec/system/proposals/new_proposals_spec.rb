# frozen_string_literal: true

require "rails_helper"

describe "Proposals" do
  include_context "with a component"
  let(:manifest_name) { "proposals" }
  let!(:user) { create(:user, :confirmed, organization: organization) }
  let!(:component) do
    create(:proposal_component,
           :with_creation_enabled,
           manifest: manifest,
           participatory_space: participatory_process)
  end

  before do
    login_as user, scope: :user
  end

  context "when creating a new proposal" do
    before do
      login_as user, scope: :user
      visit_component
    end

    context "and personal data are enable in component" do
      let!(:draft) { create(:proposal, :draft, component: component, users: [user]) }

      before do
        component.update(settings: { personal_data: true })
        visit_component
      end

      it "show personal data fields" do
        click_link_or_button "New proposal"
        path = "#{main_component_path(component)}proposals/#{draft.id}/edit_draft?component_id=#{component.id}&question_slug=#{component.participatory_space.slug}"
        expect(page).to have_current_path(path)
        expect(page).to have_content("Personal data")
        expect(page).to have_content("Name")
        expect(page).to have_content("Surname")
        expect(page).to have_content("Phone")
      end
    end
  end
end
