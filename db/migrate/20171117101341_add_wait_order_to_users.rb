class AddWaitOrderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :wait_order, :integer, minimum: 0, default: nil,
      null: true
  end
end
