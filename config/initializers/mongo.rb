if ENV['MONGOLAB_URI']
  regex_match = /.*:\/\/(.*):(.*)@(.*):(.*)\//.match(ENV['MONGOLAB_URI'])
  host = regex_match[3]
  port = regex_match[4]
  db_name = regex_match[1]
  pw = regex_match[2]
  MongoMapper.connection = Mongo::Connection.new(host, port)
  MongoMapper.database = db_name
  MongoMapper.database.authenticate(db_name, pw)
else
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
  MongoMapper.database = "#myapp-#{Rails.env}"
end

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end