require "rails/generators"
require "yaml"
require "fileutils"

module CodeCare
  class SetupGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    def setup_whenever_cron_monitoring
      return unless File.exists?("config/schedule.rb")

      prepend_to_file("config/schedule.rb") do
        <<-'RUBY'
job_type :bundled_rake_sentinel, "cd :path && bundle exec bin/cron_monitor rake :task"

        RUBY
      end
    end

    def setup_ci_checks
      ci_check_invocation = "bundle exec run_ci_checks"

      # Add brakeman to travis runs
      if File.exist? ".travis.yml"
        travis = YAML.load_file(".travis.yml")
        travis["script"] = [] if travis["script"].nil?

        unless travis["script"].include?(ci_check_invocation)
          travis["script"] << ci_check_invocation
        end

        File.open(".travis.yml", "w") { |file| YAML.dump(travis, file) }
      end
    end

    def setup_simplecov
      prepend_to_file("spec/spec_helper.rb") do
        <<-'RUBY'
require "simplecov"
SimpleCov.start "rails"

          RUBY
      end

      append_to_file(".gitignore") do
        <<-'IGNORE'
coverage
        IGNORE
      end
    end

    def create_bundler_binstubs
      system("bundle exec spring binstub rspec")
    end

    def setup_guard
      return if File.exists?("Guardfile")

      copy_file("Guardfile", "Guardfile")
    end

    def setup_rubocop
      FileUtils.touch(".rubocop.yml")

      prepend_to_file(".rubocop.yml") do
        <<-'YAML'
inherit_gem:
  reinteractive-style:
    - default.yml

        YAML
      end
    end
  end
end
