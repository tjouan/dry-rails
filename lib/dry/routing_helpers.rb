module Dry
  module RoutingHelpers
    def collection_path resource
      send "#{base_path resource, plural: true}_path"
    end

    def record_path record
      send "#{base_path record.class}_path", record
    end

    def new_path resource
      send "new_#{base_path resource}_path"
    end

    def edit_path record
      send "edit_#{base_path record.class}_path", record
    end

    def form_arguments record
      [*current_namespace, record]
    end

  private

    def current_namespace
      (controller_path.split('/') - [controller_name]).map &:to_sym
    end

    def base_path klass, plural: false
      message = plural ? :route_key : :singular_route_key
      [*current_namespace, klass.model_name.send(message)].flatten * '_'
    end
  end
end
