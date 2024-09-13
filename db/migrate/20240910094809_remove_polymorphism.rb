class RemovePolymorphism < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :postable_id
    remove_column :posts, :postable_type
    add_column :posts, :body, :string
  end
end
