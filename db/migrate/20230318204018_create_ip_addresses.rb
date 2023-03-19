# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :ip_addresses do
      column :value, :inet, null: false, primary_key: true
      column :enabled, :boolean, default: true, null: false
    end
  end
end
