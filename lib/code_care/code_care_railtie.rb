module CodeCare
  class CodeCareRailtie < Rails::Railtie
    initializer "require dependencies" do
      require "pry-byebug"
      require "pry-rails"
    end
  end
end
