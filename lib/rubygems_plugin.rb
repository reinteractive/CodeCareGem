def color(color)
  printf "\033[#{color}m"
  yield
  printf "\033[0m"
end

Gem.pre_install do |installer|
  red = 31
  yellow = 33

  gemfile = File.join(Bundler.root, "Gemfile")
  # Bullet needs an older version for Ruby < 2.3
  if Gem::Dependency.new("tmp", "< 2.3").match?("tmp", RUBY_VERSION) &&
      File.open(gemfile).each_line.none? { |line| line.include?("bullet") }
    color(red) { puts "Bullet must be capped at 5.7.6 on Ruby < 2.3" }
    color(red) { puts "Add this line to your gemfile after code_care:" }
    color(red) { puts "gem 'bullet', '5.7.6'" }
    color(red) { puts "When you upgrade to Ruby >= 2.3 you can remove it" }
    false
  else
    skip_dependencies = %w(bundler rake)
    installer.spec.dependencies.each do |dep|
      next if skip_dependencies.include?(dep.name)

      if File.open(gemfile).each_line.any? { |line| line.include?(dep.name) }
        color(yellow) { puts "NOTICE: Gemfile includes #{dep.name} which is already included in code_care." }
        color(yellow) { puts "You can remove it from the Gemfile unless you need to specify a particular version." }
      end
    end
    true
  end
end
