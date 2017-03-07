# https://martinschurig.com/posts/2015/02/pulling-production-database-to-local-machine-rails-task/

####                                                                                                        ####
# REMINDER: config/database.yml needs to have appropriate settings for production and development environments #
####                                                                                                        ####

namespace :db_mysql do
  desc 'Pull production db to development'
  task :pull => [:dump, :restore]

  task :dump do
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    production = Rails.application.config.database_configuration['production']
    puts 'mysqldump on production database...'
    system "ssh user@server.tld 'mysqldump -u #{production['username']} --password=#{production['password']} -h #{production['host']} --add-drop-table --skip-lock-tables --verbose #{production['database']}' > #{dumpfile}"
    puts 'Done!'
  end

  task :restore do
    dev = Rails.application.config.database_configuration['development']
    abort 'Live db is not mysql' unless dev['adapter'] =~ /mysql/
    abort 'Missing live db config' if dev.blank?
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    puts 'importing production database to development database...'
    system "mysql -h #{dev['host']} -u root #{dev['database']} < #{dumpfile}"
    puts 'Done!'
  end
end

namespace :db_postgres do
  desc 'Pull production db to development'
  task :pull => [:dump, :restore]

  task :dump do
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    production = Rails.application.config.database_configuration['production']
    puts 'mysqldump on production database...'
    system "ssh user@server.tld 'mysqldump -u #{production['username']} --password=#{production['password']} -h #{production['host']} --add-drop-table --skip-lock-tables --verbose #{production['database']}' > #{dumpfile}"
    puts 'Done!'
  end

  task :restore do
    dev = Rails.application.config.database_configuration['development']
    abort 'Live db is not mysql' unless dev['adapter'] =~ /mysql/
    abort 'Missing live db config' if dev.blank?
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    puts 'importing production database to development database...'
    system "mysql -h #{dev['host']} -u root #{dev['database']} < #{dumpfile}"
    puts 'Done!'
  end
end