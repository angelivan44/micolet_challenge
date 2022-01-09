class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :preferences, :type, :gender
  end
end
