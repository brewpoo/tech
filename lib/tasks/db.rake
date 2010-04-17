namespace :db do
  desc "Dump the current database to a MySQL file" 
  task :database_dump do
    load 'config/environment.rb'
    abcs = ActiveRecord::Base.configurations
    case abcs[RAILS_ENV]["adapter"]
    when 'mysql'
      ActiveRecord::Base.establish_connection(abcs[RAILS_ENV])
      File.open("db/#{RAILS_ENV}_data.sql", "w+") do |f|
        if abcs[RAILS_ENV]["password"].blank?
          f << `mysqldump -h #{abcs[RAILS_ENV]["host"]} -u #{abcs[RAILS_ENV]["username"]} #{abcs[RAILS_ENV]["database"]}`
        else
          f << `mysqldump -h #{abcs[RAILS_ENV]["host"]} -u #{abcs[RAILS_ENV]["username"]} -p#{abcs[RAILS_ENV]["password"]} #{abcs[RAILS_ENV]["database"]}`
        end
      end
    else
      raise "Task not supported by '#{abcs[RAILS_ENV]['adapter']}'" 
    end
  end

  #desc "Refreshes your local development environment to the current production database" 
  #task :production_data_refresh do
  #  `rake remote:exec ACTION=remote_db_runner --trace`
  #  `rake db:production_data_load --trace`
  #end 

  #desc "Loads the production data downloaded into db/production_data.sql into your local development database" 
  #task :production_data_load do
  #  load 'config/environment.rb'
  #  abcs = ActiveRecord::Base.configurations
  #  case abcs[RAILS_ENV]["adapter"]
  #  when 'mysql'
  #    ActiveRecord::Base.establish_connection(abcs[RAILS_ENV])
  #    if abcs[RAILS_ENV]["password"].blank?
  #      `mysql -h #{abcs[RAILS_ENV]["host"]} -u #{abcs[RAILS_ENV]["username"]} #{abcs[RAILS_ENV]["database"]} < db/production_data.sql`
  #    else
  #      `mysql -h #{abcs[RAILS_ENV]["host"]} -u #{abcs[RAILS_ENV]["username"]} -p#{abcs[RAILS_ENV]["password"]} #{abcs[RAILS_ENV]["database"]} < db/production_data.sql`
   #   end
   # else
   #   raise "Task not supported by '#{abcs[RAILS_ENV]['adapter']}'" 
   # end
  #end


  desc "Load production lookups into development"
  task :load_production_lookups do
    require 'yaml'

    database = YAML::load_file('config/database.yml')

    filename = "dump.#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}.sql"

    puts "Dumping production lookup tables locally"
    `mysqldump -h #{database['production']['host']} -u #{database['production']['username']} --password=#{database['production']['password']} #{database['production']['database']} #{database['lookups'].gsub(',','')} > /tmp/#{filename}`
    puts "Dump completed, importing into development"
    `mysql -u #{database['development']['username']} --password=#{database['development']['password']} #{database['development']['database']} < /tmp/#{filename}; rm -f /tmp/#{filename}`
    puts "Done"
  end

  desc "Load production data into development"
  task :load_production_data do
    require 'yaml'

    database = YAML::load_file('config/database.yml')

    filename = "dump.#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}.sql"

    puts "Dumping production data locally"
    `mysqldump -h #{database['production']['host']} -u #{database['production']['username']} --password=#{database['production']['password']} #{database['production']['database']} > /tmp/#{filename}`
    puts "Dump completed, importing into development"
    `mysql -u #{database['development']['username']} --password=#{database['development']['password']} #{database['development']['database']} < /tmp/#{filename}; rm -f /tmp/#{filename}`
    puts "Updating contact emails"
    `mysql -u #{database['development']['username']} --password=#{database['development']['password']} #{database['development']['database']} < db/post_import.sql`
    puts "Done"
  end

  desc "Load Initial Data"
  task :load_initial_data do
    require 'yaml'

    database = YAML::load_file('config/database.yml')

    puts "Importing initial data into development"
    `mysql -u #{database['development']['username']} --password=#{database['development']['password']} #{database['development']['database']} < db/initial.sql`
    puts "Done"
  end


  desc "Load Sample Data"
  task :load_sample_data do
    require 'yaml'

    base = YAML::load_file('config/database.yml')

    puts "Importing sample data into development"
    `mysql -u #{database['development']['username']} --password=#{database['development']['password']} #{database['development']['database']} < db/sample.sql`
    puts "Done"
  end

  desc "Purge non-system data from development"
  task :purge_development_data do

    require 'yaml'
    database = YAML::load_file('config/database.yml')

    puts "Truncating data"
    `mysql -u #{database['development']['username']} --password=#{database['development']['password']} #{database['development']['database']} < vendor/scripts/truncate_development.sql`
    puts "Done"
  end
  

end
