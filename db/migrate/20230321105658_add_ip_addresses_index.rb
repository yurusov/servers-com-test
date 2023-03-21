# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :ip_addresses do
      add_index %i[value enabled]
    end
  end
end
