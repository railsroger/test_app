class CreateRedactor2Assets < ActiveRecord::Migration[5.1]
  def self.up
    create_table :redactor2_assets do |t|
      t.attachment :data

      t.integer :assetable_id
      t.string :assetable_type, limit: 30
      t.string :type, limit: 30

      t.integer :width
      t.integer :height

      t.timestamps
    end

    add_index 'redactor2_assets', %w[assetable_type type assetable_id], name: 'idx_redactor2_assetable_type'
    add_index 'redactor2_assets', %w[assetable_type assetable_id], name: 'idx_redactor2_assetable'
  end

  def self.down
    drop_table :redactor2_assets
  end
end
