require 'rubygems'
require 'sinatra'
require 'haml'
require 'net/smtp'
require 'pony'

# Helpers
require './lib/render_partial'

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
  name = params[:name]
  email = params[:email]
  subject = params[:subject]
  email_message = params[:email_message]

  if name.empty? || name.length <= 3 || name !~ /\A([a-zA-Z])/
    @check = "Name: Empty, less than 3 or contain special characters => Incorrect"
  elsif email.empty? || email.length <= 3 || email !~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
    @check = "Your email is incorrect. This must be an email."
  elsif subject.empty? || email_message.empty?
    @check = "Subject and message can not be empty."
  else
    Pony.mail(:to => 'raf@amidev.co.uk', :from => email, :subject => subject, :body => email_message)
    @check = "Your email has been sent. Thank you."
  end

  haml :contact, :layout => :'layouts/page'

end


get '/blog' do
  haml :blog, :layout => :'layouts/page'
end

get '/about' do
  haml :about, :layout => :'layouts/page'
end
