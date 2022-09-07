# frozen_string_literal: true

Deface::Override.new(virtual_path: +"decidim/proposals/admin/proposals/show",
                     original: "c8428bced74648fb3bef7a646883194e20ad05b1",
                     name: "add_personal_data_fields_to_admin_show",
                     insert_after: ".row.column:nth-child(3)",
                     text: "
                      <div class='row column'>
                        <strong><%= t('.personal_data') %>:</strong><br>
                        <strong><%= t('.author.name') %>: </strong><%= proposal.author_name %><br>
                        <strong><%= t('.author.surname') %>: </strong><%= proposal.author_surname %><br>
                        <strong><%= t('.author.phone') %>: </strong><%= proposal.author_phone %><br>
                        <br>
                      </div>
                     ")
