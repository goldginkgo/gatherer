class AddOrderToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :project_order, :integer
  end
end
