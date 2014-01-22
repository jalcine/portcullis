class AddFeeProcessingToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fee_processing, :integer, default: Event::FEE_PASS_ON, nil: false
  end
end
