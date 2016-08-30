class ReprocessImages < ActiveRecord::Migration[5.0]
  def up
    Medium.find_each do |medium|
      medium.image.reprocess!
    end
  end

  def down
    # nothing to do
  end
end
