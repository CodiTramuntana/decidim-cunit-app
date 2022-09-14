# frozen_string_literal: true

class AddPersonalDataFieldsToProposals < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_proposals_proposals, :author_name, :string
    add_column :decidim_proposals_proposals, :author_surname, :string
    add_column :decidim_proposals_proposals, :author_phone, :string
  end
end
