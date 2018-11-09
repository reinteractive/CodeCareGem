# CodeCare

Common dependencies and helpers for use in CodeCare client applications

## Installation

Add this line to your application's Gemfile under `group :development, :test do`
```ruby
gem "code_care", git: "git@github.com:reinteractive/CodeCareGem.git", branch: "master"
```

And then execute:

    $ bundle install
    # If using vendored gems then also run:
    $ bundle pack --all

## Usage

run `bundle exec rails g code_care:setup` at the root of the application

## What it gives you

## Dependencies

Here is a list of gems that are included as dependencies. If they are already present in your Gemfile you can remove them when adding `code_care`.

* [bullet](https://github.com/flyerhzm/bullet)
* [guard-rspec](https://github.com/guard/guard-rspec)
* [pry-rails](https://github.com/rweng/pry-rails)
* [reinteractive-style](https://github.com/reinteractive/reinteractive-style)
* [simplecov](https://github.com/colszowka/simplecov)
* [spring-commands-rspec](https://github.com/jonleighton/spring-commands-rspec)

*Note: Dependencies all have a `>= 0` version, if you need to specify a specific version you can do this in your app's `Gemfile`*

## Utilities/Automatic Setup

### Cron Monitor

A new `bin/cron_monitor` script is provided that will email the output of failed cron jobs, generally rake tasks. For example:

`bundle exec bin/cron_monitor rake task`

Cron monitor requires the following environment variables to be set:

* `CRON_MONITOR_EMAIL_TO`
* `CRON_MONITOR_EMAIL_FROM`
* `SMTP_HOST`
* `SMTP_PORT`
* `SMTP_USERNAME`
* `SMTP_PASSWORD`

#### If you use the Whenever Gem

If a `config/schedule.rb` file exists, a new `bundled_rake_sentinel` job type is added which can be used to run rake tasks via `cron_monitor`

*Note: `whenever` is not included as a dependency and is not required for the `codecare` gem*

### Travis

If a `.travis.yml` file exists, it will be updated to run `brakeman` and `bundle-audit` on each run.

Warnings will not be counted as a build failure unless they are run as a cron (i.e. scheduled) run.

### SimpleCov

Basic setup for SimpleCov will be added to `spec_helper.rb`.
`coverage` will also be added to the `.gitignore`

### Guard

If a `Guardfile` does not exist then one will be created by running `bundle exec guard init rspec`.

This creates a default using the `guard-rspec` gem.

