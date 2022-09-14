# frozen_string_literal: true

# Extends the Decidim::Proposals component.

def add_attribute_to_global_settings(component, attr_name, type, default: false)
  component.settings(:global).attribute(attr_name.to_sym, type: type, default: default)
end

component = Decidim.find_component_manifest :proposals
add_attribute_to_global_settings(component, :personal_data, :boolean)
