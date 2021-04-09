require 'tempfile'
# require 'rspec/instafail'

RSpec.configure do |config|
  config.example_status_persistence_file_path = Tempfile.new('.rspec.stats')
  config.run_all_when_everything_filtered = true
  config.backtrace_exclusion_patterns = [
   /spec_helper/
 ]
  config.expose_dsl_globally = true
  config.filter_run_when_matching :focus
  config.fail_fast = true
  config.max_displayed_failure_line_count = 30
  config.warnings = false
  config.bisect_runner = :shell
  # config.formatters << RSpec::Instafail
  # config.formatters << :progress
end
