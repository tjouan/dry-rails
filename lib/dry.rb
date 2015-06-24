require 'forwardable'

module Dry
  # FIXME: proto
  def self.view_path
    File.expand_path('../../app/views', __FILE__)
  end

  # FIXME: proto
  def self.lib_path
    File.expand_path('..', __FILE__)
  end
end
