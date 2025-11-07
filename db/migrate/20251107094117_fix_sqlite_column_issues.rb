# frozen_string_literal: true

# use postgresql standards for former sqlite column definition
class FixSqliteColumnIssues < ActiveRecord::Migration[8.1]
  def change
    change_column_null :addresses, :addressable_id, false
    change_column_null :addresses, :addressable_type, false
    change_column :bank_accounts, :accountable_id, :bigint
    change_column :contract_instances, :contract_id, :bigint
    change_column :contracts, :client_id, :bigint
    change_column :expenses, :contract_instance_id, :bigint
    change_column :expenses, :cost_type_id, :bigint
    change_column :expenses, :invoice_id, :bigint
    change_column :invoices, :contract_instance_id, :bigint
    change_column :invoices, :user_id, :bigint
    change_column :payment_adjustments, :client_id, :bigint
    change_column :payment_adjustments, :user_id, :bigint
    change_column :payment_allocations, :income_tax_id, :bigint
    change_column :payment_allocations, :payment_statement_id, :bigint
    change_column :payment_allocations, :reference_id, :bigint
    change_column :payment_statements, :client_id, :bigint
    change_column :payment_statements, :user_id, :bigint
    change_column :projects, :client_id, :bigint
    change_column :time_entries, :invoice_id, :bigint
    change_column :time_entries, :project_id, :bigint
  end
end
