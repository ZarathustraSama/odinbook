class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :postable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
