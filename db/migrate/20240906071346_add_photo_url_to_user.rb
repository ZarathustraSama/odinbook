class AddPhotoUrlToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :photo_url, :text
  end
end
