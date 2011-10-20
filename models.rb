#./models.rb
require 'rubygems'
require 'data_mapper'

DataMapper::Logger.new('./log/dm.log', :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/sqlite3.db")

class Project
  include DataMapper::Resource

  property :id,            Serial
  property :title,         String
  property :link_to_image, String
  property :desc,          Text
  property :link_to_web,   String
  property :created_at,    DateTime

end

  #migrate and populate with some data when executed alone

Project.auto_migrate! unless Project.storage_exists?
DataMapper.auto_upgrade!
DataMapper.finalize
