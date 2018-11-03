module CodeCare
  class CodeCareRailtie < Rails::Railtie
    initializer "require dependencies" do
      require "bullet"
      require "pry-byebug"
      require "pry-rails"
    end
  end
end
