class CreatePunks < ActiveRecord::Migration[5.2]
  def change
    create_table :punks do |t|
      t.integer :punk_identifier
      t.string :gender, limit: 1

      t.timestamps
    end
  end
end
