class CreateUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|#if dont want id, set :id=>false

      t.column "first_name", :string
      t.column "last_name", :string, :limit=>20
      t.column "email", :string,:default=>'', :null=>false
      t.column "password", :string, :limit=>40

      #t.datetime "created_at"
      #t.datetime "updated_at"
      t.timestamps  # same as above 2 lines
    end
  end
  def down
  	drop_table :users
  end
end
