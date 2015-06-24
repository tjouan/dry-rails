class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.timestamps          null: false
      t.string      :title, null: false
      t.text        :body,  null: false
    end
  end
end
