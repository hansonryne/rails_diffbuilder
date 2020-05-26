module GreppableController
  extend ActiveSupport::Concern

  def run_current_greps
    self.run_all_greps
  end

end
