require 'forwardable'

module Dry
  class << self
    def view_path
      File.expand_path('../../app/views', __FILE__)
    end

    def lib_path
      File.expand_path('..', __FILE__)
    end
  end
end
