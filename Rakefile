require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require_relative 'config/application'

desc 'Look for style guide offenses in your code'
task :rubocop do
  sh 'rubocop --format simple || true'
end

task default: [:rubocop, :spec]

desc 'Open an irb session preloaded with the environment'
task :console do
  require 'rubygems'
  require 'pry'

  Pry.start
end

## Active Record related rake tasks
namespace :db do
  desc 'remove duplicate posts'
  task :remove_duplicates do
    posts = Post.all
    puts "Loadings #{posts.count} posts..."
    posts.map do |post|
      repeats = Post.where(name: post.name).order(votes: :desc)
      next unless repeats.length > 1

      repeats.last.destroy
    end
  end

  desc 'create the database'
  task :create do
    puts "Creating #{db_path}..."
    touch db_path
  end

  desc 'drop the database'
  task :drop do
    puts "Deleting #{db_path}..."
    rm_f db_path
  end

  desc 'migrate the database (options: VERSION=x).'
  task :migrate do
    ActiveRecord::Migrator.migrations_paths << \
      File.dirname(__FILE__) + 'db/migrate'
    ActiveRecord::Migration.verbose = true
    version = ENV['VERSION'] ? ENV['VERSION'].to_i : nil
    if defined?(ActiveRecord::MigrationContext)
      ActiveRecord::MigrationContext
        .new(ActiveRecord::Migrator.migrations_paths)
        .migrate(version)
    else
      ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, version)
    end
  end

  desc 'Retrieves the current schema version number'
  task :version do
    puts "Current version: #{ActiveRecord::Migrator.current_version}"
  end

  desc 'populate the database with sample data'
  task :seed do
    require "#{__dir__}/db/seeds.rb"
  end

  desc 'Gives you a timestamp for your migration file name'
  task :timestamp do
    puts DateTime.now.strftime('%Y%m%d%H%M%S')
  end

  private

  def db_path
    ActiveRecord::Base.configurations.configs_for(env_name: "development").first.configuration_hash[:database]
  end
end
