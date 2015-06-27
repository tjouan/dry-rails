module Dry
  class ResourceRoutes
    def initialize routes, path
      @routes = routes
      @path   = path
    end

    def routes
      routes_for_path(@path).each_with_object([]) do |e, m|
        m << e.defaults[:action].to_sym
      end.uniq
    end

  private

    def routes_for_path path
      @routes.select { |e| e.defaults[:controller] == @path }
    end
  end
end
