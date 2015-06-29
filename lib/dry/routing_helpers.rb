module Dry
  module RoutingHelpers
    def collection_path resource
      send "#{base_path resource, plural: true}_path"
    end

    def record_path record
      send "#{base_path record.class}_path", *([@parent, record].compact)
    end

    def new_path resource
      send "new_#{base_path resource}_path"
    end

    def edit_path record
      send "edit_#{base_path record.class}_path", *([@parent, record].compact)
    end

    def relation_path record, relation
      send "#{base_path record.class}_#{relation.model_name.route_key}_path",
        record
    end

    def form_arguments record
      [*current_namespace, @parent, record].compact
    end

  private

    def current_namespace
      (controller_path.split('/') - [controller_name]).map &:to_sym
    end

    def base_path klass, plural: false
      path = [*current_namespace].flatten
      path << parent_class.model_name.singular_route_key if parent?
      path << klass.model_name.send(plural ? :route_key : :singular_route_key)
      path * '_'
    end

    def parent?
      !!@parent
    end

    def parent_class
      @parent ? @parent.class : nil
    end
  end
end
