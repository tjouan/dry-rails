require 'action_view/template/resolver.rb'

module Dry
  class TemplateResolver < ::ActionView::FileSystemResolver
    DRY_PATTERN = DEFAULT_PATTERN.sub /:prefix\//, ''

    def initialize
      super Dry.view_path, DRY_PATTERN
    end
  end
end
