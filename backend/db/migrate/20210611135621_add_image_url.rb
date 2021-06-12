class AddImageUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :image, :text
  end
end
