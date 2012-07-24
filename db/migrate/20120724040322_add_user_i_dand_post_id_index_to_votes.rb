class AddUserIDandPostIdIndexToVotes < ActiveRecord::Migration
  def change
    add_index :votes, :post_id
    add_index :votes, :user_id
  end
end
