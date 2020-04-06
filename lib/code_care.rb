require "code_care/version"

if defined?(Rails)
  require "code_care/code_care_railtie"
  require "pry-rails/railtie"
end
