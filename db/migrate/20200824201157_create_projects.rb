class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :key, null: false
      t.references :owner, polymorphic: true
      t.string :uuid, blank: false, unique: true
      t.timestamps
    end

    add_index :projects, :uuid
    add_index :projects, :key
  end
end