class Task < ApplicationRecord
  belongs_to :list

  def complete
    self.completed_at = Time.current
    save
  end
end
