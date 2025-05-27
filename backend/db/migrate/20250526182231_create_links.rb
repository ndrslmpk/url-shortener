class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.string :original_url
      t.string :short_path

      t.timestamps
    end
    add_index :links, :short_path
  end
end
