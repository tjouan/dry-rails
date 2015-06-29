module Dry
  module Controller
    extend ActiveSupport::Concern
    include RoutingHelpers

    included do
      class_attribute :_dry_scope, instance_accessor: false

      class_attribute :_dry_attrs, instance_accessor: false
      self._dry_attrs = { read: [], write: [], options: {} }

      class_attribute :_dry_nested_relations, instance_accessor: false
      self._dry_nested_relations = []

      append_view_path TemplateResolver.new

      helper RoutingHelpers

      before_filter :set_resource
      before_filter :set_collection,  only: :index
      before_filter :set_record,      only: %i[show edit update destroy]
    end

    module ClassMethods
      def dry_scope &block
        self._dry_scope = block
      end

      def dry_attrs_read *attrs
        self._dry_attrs[:read] = attrs
      end

      def dry_attrs_write *attrs
        self._dry_attrs[:write] = attrs
      end

      def dry_attrs_options **options
        self._dry_attrs[:options] = options
      end

      def dry_nest *relations
        self._dry_nested_relations.push *relations
      end
    end

    def index
    end

    def new
      @record = resource_scope.new
    end

    def edit
    end

    def create
      @record = resource_scope.new record_params
      if @record.save
        redirect_to collection_path(@resource),
          notice: "#{model_name.singular.capitalize} was successfully created."
      else
        render :new
      end
    end

    def update
      if @record.update record_params
        redirect_to collection_path(@resource),
          notice: "#{model_name.singular.capitalize} was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @record.destroy
      redirect_to collection_path(@resource),
        notice: "#{model_name.singular.capitalize} was successfully destroyed."
    end

  private

    def resource
      @resource ||= Resource.new(controller_name.classify.constantize,
        attrs_read:     self.class._dry_attrs[:read],
        attrs_write:    self.class._dry_attrs[:write],
        attrs_options:  self.class._dry_attrs[:options],
        relations:      self.class._dry_nested_relations,
        routes:         resource_routes
      )
    end

    def resource_routes
      ResourceRoutes.new(Rails.application.routes.routes, controller_path)
        .routes
    end

    def resource_scope
      if b = self.class._dry_scope
        instance_exec &b
      else
        resource.model
      end
    end

    def model_name
      resource.model_name
    end

    def collection
      resource_scope.order 'created_at ASC'
    end

    def set_resource
      resource
    end

    def set_collection
      @collection = collection
    end

    def set_record
      @record = resource_scope.find params[:id]
    end

    def record_params
      params.require(model_name.param_key.to_sym)
        .permit *self.class._dry_attrs[:write]
    end
  end
end
