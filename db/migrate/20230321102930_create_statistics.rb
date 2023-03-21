# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :statistics do
      primary_key :id
      foreign_key :ip_address, :ip_addresses, type: :inet, null: false
      column :start_time, :timestamp, null: false
      column :rtt, :smallint, null: false
      column :failed, :bool, null: false

      index %i[ip_address start_time]
      index :start_time, type: :brin
    end
  end
end
