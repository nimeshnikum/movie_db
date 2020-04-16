class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
    end
  end
end
