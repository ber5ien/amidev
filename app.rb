require 'rubygems'
require 'sinatra'
require 'haml'
require 'net/smtp'

# Helpers
require './lib/render_partial'

#send email
def send_email(to,opts={})
  opts[:server]      ||= 'localhost'
  opts[:from]        ||= 'email@example.com'
  opts[:subject]     ||= "You need to see this"
  opts[:body]        ||= "Important stuff!"

  msg = <<END_OF_MESSAGE
From: #{opts[:from_alias]} <#{opts[:from]}>
To: <#{to}>
Subject: #{opts[:subject]}

#{opts[:body]}
END_OF_MESSAGE

  Net::SMTP.start(opts[:server]) do |smtp|
    smtp.send_message msg, opts[:from], to
  end
end


# Set Sinatra variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :public, 'public'
set :haml, {:format => :html5} # default Haml format is :xhtml

# Application routes
get '/' do
  haml :index, :layout => :'layouts/application'
end

get '/portfolio' do
  haml :portfolio, :layout => :'layouts/page'
end

get '/contact' do
  haml :contact, :layout => :'layouts/page'
end

post '/contact' do
  @name = params[:name]
  @email = params[:email]
  @subject = params[:subject]
  @email_message = params[:email_message]
  send_email "raf@amidev.co.uk", :from => @email, :subject => @subject, :body => @email_message

  haml :contact, :layout => :'layouts/page'

end


get '/blog' do
  haml :blog, :layout => :'layouts/page'
end

get '/about' do
  haml :about, :layout => :'layouts/page'
end
