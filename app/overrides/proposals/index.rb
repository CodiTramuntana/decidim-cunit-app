# frozen_string_literal: true

Deface::Override.new(virtual_path: +"decidim/proposals/proposals/index",
                     name: "remove_proposals_map",
                     remove: "erb[loud]:contains('dynamic_map_for')",
                     closing_selector: "erb[silent]:contains('end')",
                     original: "a7b9d1be5921cea3a66a7ec2b2f3c37369926dc4")
