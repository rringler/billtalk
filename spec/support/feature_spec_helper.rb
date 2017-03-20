module FeatureSpecHelper
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop do
        # `jQuery.active` does not seem to work with axios requests
        break if page.evaluate_script('jQuery.active').zero?
      end
    end
  end
end
