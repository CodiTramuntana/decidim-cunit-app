# frozen_string_literal: true

Deface::Override.new(virtual_path: +"decidim/proposals/proposals/edit_draft",
                     original: "40480b651aecf8509d5601169db08f0edfa23ed7",
                     name: "add_personal_data_fields_to_edit_draft_form",
                     insert_after: "erb[loud]:contains('edit_form_fields')",
                     text: "
                      <label><%= t('personal_data', scope: 'decidim.proposals.proposals.edit') %></label>
                      <div class='field hashtags__container'>
                        <%= form.text_field :author_name %>
                        <%= form.text_field :author_surname %>
                        <%= form.text_field :author_phone %>
                      </div>
                     ")
