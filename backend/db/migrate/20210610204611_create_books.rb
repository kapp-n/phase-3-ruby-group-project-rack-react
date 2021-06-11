class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.text :summary
      t.integer :pages
      t.integer :shelf_id
    end
  end
end
