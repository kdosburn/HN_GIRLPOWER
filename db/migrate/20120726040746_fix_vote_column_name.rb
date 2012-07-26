class FixVoteColumnName < ActiveRecord::Migration
  def change
    rename_column :votes, :post_id, :votable_id
    add_column :votes, :votable_type, :string
  end

end
