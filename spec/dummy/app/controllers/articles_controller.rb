class ArticlesController < ApplicationController
  include Dry::Controller

  dry_attrs_read  :title
  dry_attrs_write :title, :body
end
