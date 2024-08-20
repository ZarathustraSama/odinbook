class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.text :content

      t.timestamps
    end
  end
end
