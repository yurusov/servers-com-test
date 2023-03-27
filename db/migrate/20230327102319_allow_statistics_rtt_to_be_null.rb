# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :statistics do
      set_column_allow_null :rtt
    end
  end
end
