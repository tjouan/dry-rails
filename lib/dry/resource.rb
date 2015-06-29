module Dry
  class Resource
    DEFAULT_OPTIONS = {
      attrs_read:     [],
      attrs_write:    [],
      attrs_options:  {},
      routes:         []
    }

    ATTR_TYPE_TO_FORM_FIELD = {
      boolean:  :check_box,
      decimal:  :number_field,
      integer:  :number_field,
      string:   :text_field,
      text:     :text_area
    }

    ATTR_RELATION_PATTERN = /_id\z/.freeze

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

    def attrs_options
      @options[:attrs_options]
    end

    def each_form_fields
      attrs_write.each do |e|
        if e =~ ATTR_RELATION_PATTERN
          yield e,
            @model.reflections[e.to_s.sub ATTR_RELATION_PATTERN, ''].klass
        else
          yield e, form_field_for(e)
        end
      end
    end

  private

    def has_route_for? action
      @options[:routes].include? action
    end

    def form_field_for attr
      if type = attrs_options[attr]
        type
      else
        ATTR_TYPE_TO_FORM_FIELD[@model.column_types[attr.to_s].type]
      end
    end
  end
end
