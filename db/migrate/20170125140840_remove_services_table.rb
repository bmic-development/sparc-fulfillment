class RemoveServicesTable < ActiveRecord::Migration
  def change
    drop_table :services
  end
end
