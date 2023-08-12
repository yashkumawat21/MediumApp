# config/initializers/sidekiq.rb
require 'sidekiq/cron'

# Load the schedule.yml file
schedule_file = Rails.root.join('config', 'schedule.yml')
schedule_hash = YAML.load_file(schedule_file)

Sidekiq::Cron::Job.load_from_hash(schedule_hash)
