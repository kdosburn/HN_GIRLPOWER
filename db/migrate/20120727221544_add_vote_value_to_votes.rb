class AddVoteValueToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :vote_value, :integer
  end
end

