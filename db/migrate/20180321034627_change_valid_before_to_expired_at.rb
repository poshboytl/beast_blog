class ChangeValidBeforeToExpiredAt < ActiveRecord::Migration[5.1]
  def change
    rename_column :invitations, :valid_before, :expired_at
  end
end
