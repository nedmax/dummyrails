class AddTextToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :text, :string
  end
end
