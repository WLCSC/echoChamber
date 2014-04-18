require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/config_file'

class EchoChamber < Sinatra::Base
    register Sinatra::ConfigFile
    set server: :thin, connections: []
    set :protection, :except => :frame_options

    config_file 'config.yml'

    def authorized?
        @auth ||= Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [settings.username, settings.password]
    end

    def protected!
        unless authorized?
            response['WWW-Authenticate'] = %(Basic realm="Control Interface")
            throw(:halt, [401, "We need your login name (#{settings.username}) & password (#{settings.password}) to get to the control interface.\n"])
        end
    end

    def read_list
        @running_dir = File.dirname(__FILE__)
        @running_dir = Dir.pwd if (@running_dir == '.')
        @@list = {}
        @@filehost = nil
        File.readlines(@running_dir + '/data/list.txt').each do |line|
            l = line.split('|')
            @@list[l[0].chomp] = l[1].chomp if @@filehost
            @@filehost = line.chomp unless @@filehost
        end

        @@list
    end

    configure do
        @running_dir = File.dirname(__FILE__)
        @running_dir = Dir.pwd if (@running_dir == '.')
        @@list = {}
        @@filehost = nil
        File.readlines(@running_dir + '/data/list.txt').each do |line|
            l = line.split('|')
            @@list[l[0].chomp] = l[1].chomp if @@filehost
            @@filehost = line unless @@filehost
        end

        @@current_title = @@list.keys.first
        @@current_url = @@list[@@current_title]
        @@title = "Default"
        @@description = nil
        puts "Hosting files from #{@@filehost}"
        puts "Reading #{@@list.length} files."
        puts "Defaulting to #{@@current_url}"
        puts @@list.inspect
    end

    get '/' do
        @current_title = @@current_title
        @current_url = @@current_url
        @title = @@title
        @description = @@description
        @filehost = @@filehost
        erb :index
    end

    get '/ctrl' do
        protected!
        read_list

        @current_title = @@current_title
        @current_url = @@current_url
        @title = @@title
        @description = @@description
        @strcount = settings.connections.length
        @list = @@list
        @filehost = @@filehost

        erb :ctrl
    end

    get '/stream', :provides => 'text/event-stream' do
        stream :keep_open do |out|
            settings.connections << out
            out.callback {settings.connections.delete(out)}
        end
    end

    post '/post' do
        if params[:title]
            @@title = params[:title]
        end

        if params[:desc]
            @@description = params[:desc]
        end

        if params[:play]
            @@current_title = params[:play]
            @@current_url = @@list[@@current_title]
            settings.connections.each {|out| out << %Q^data: {"play": "#{@@current_url}", "title": "#{@@title}", "desc": "#{@@description}"}\n\n^}
        end

        if params[:ctrl]
            settings.connections.each {|out| out << %Q^data: {"ctrl": "#{params[:ctrl]}"}\n\n^}
        end
        
        if params[:ctrl] && params[:jump]
            settings.connections.each {|out| out << %Q^data: {"ctrl": "#{params[:ctrl]}", "jump": #{params[:jump]}}\n\n^}
        end
        204
    end
end
