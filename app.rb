require 'rubygems'
require 'sinatra'
require 'haml'
require 'net/smtp'
require 'pony'
#require 'data_mapper'

# Helpers
require './lib/render_partial'

#Models
#require './models'

# Set Sinatra variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :public, 'public'
set :haml, {:format => :html5} # default Haml format is :xhtml
master_email = "raf@amidev.co.uk"
@active_page = 0

# Application routes
get '/' do
  @active_page = "Home"
  haml :index, :layout => :'layouts/application'
end

get '/portfolio' do
  @active_page = "Portfolio"
  @projects = Project.all(:order => [:created_at.desc])
  haml :portfolio, :layout => :'layouts/no_footer'
end

get '/contact' do
  @active_page = "Contact"
  haml :contact, :layout => :'layouts/page'
end

post '/contact' do
  @active_page = "Contact"
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
    Pony.mail(:to => master_email, :from => email, :subject => subject, :body => email_message)
    @check = "Your email has been sent. Thank you."
  end

  haml :contact, :layout => :'layouts/page'

end

get '/blog' do
  @active_page = "Blog"
  haml :blog, :layout => :'layouts/no_footer'
end

get '/about' do
  @active_page = "About"
  haml :about, :layout => :'layouts/page'
end
