module Dry
  module RoutingHelpers
    def collection_path resource
      send "#{resource.model_name.route_key}_path"
    end

    def record_path record
      send "#{record.class.model_name.singular_route_key}_path", record
    end

    def new_path resource
      send "new_#{resource.model_name.singular_route_key}_path"
    end

    def edit_path record
      send "edit_#{record.class.model_name.singular_route_key}_path", record
    end
  end
end
