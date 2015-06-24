module Dry
  class Resource
    DEFAULT_OPTIONS = {
      attrs_read:   [],
      attrs_write:  {},
      route_format: '%s'
    }

    ATTR_TYPE_TO_FORM_FIELD = {
      boolean:  :check_box,
      integer:  :number_field,
      string:   :text_field,
      text:     :text_area
    }

    extend Forwardable
    def_delegators :@model, :model_name

    attr_reader :model

    def initialize model, options = {}
      @model    = model
      @options  = DEFAULT_OPTIONS.merge options
    end

    def singular_name
      model_name.singular
    end

    def plural_name
      model_name.plural
    end

    def new?
      has_route_for? :new
    end

    def edit?
      has_route_for? :edit
    end

    def destroy?
      has_route_for? :destroy
    end

    def attrs_read
      @options[:attrs_read]
    end

    def attrs_write
      @options[:attrs_write]
    end

    def each_form_fields
      attrs_write.each do |e|
        yield e, ATTR_TYPE_TO_FORM_FIELD[@model.column_types[e.to_s].type]
      end
    end

  private

    def has_route_for? action
      routes_for_resource(model_name.route_key).any? do |e|
        e.defaults[:action] == action.to_s
      end
    end

    def routes_for_resource resource_key
      @_resource_routes ||= Rails.application.routes.routes.select do |e|
        e.defaults[:controller] == @options[:route_format] % resource_key
      end
    end
  end
end
