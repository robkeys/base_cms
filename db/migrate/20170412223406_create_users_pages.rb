class CreateUsersPages < ActiveRecord::Migration[5.0]

  def up
    create_table :users_pages, :id => false do |t|
      t.integer "user_id"
      t.integer "page_id"
    end
    add_index("users_pages", ["user_id", "page_id"])
  end

  def down
    drop_table :users_pages
  end
end
