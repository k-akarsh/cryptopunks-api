class CreateJoinTablePunkAccessory < ActiveRecord::Migration[5.2]
  def change
    create_join_table :punks, :accessories do |t|
      # t.index [:punk_id, :accessory_id]
      # t.index [:accessory_id, :punk_id]
    end
  end
end
