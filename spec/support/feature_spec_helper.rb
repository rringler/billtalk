module FeatureSpecHelper
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop do
        # `jQuery.active` does not seem to work with axios requests
        break if page.evaluate_script('jQuery.active').zero?
      end
    end
  end

  def pause_test
    $stderr.write 'Press enter to continue'
    $stdin.gets
  end
end

RSpec.configure do |rspec|
  rspec.include FeatureSpecHelper, type: :feature
end
