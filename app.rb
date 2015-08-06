require 'sinatra'
require 'pathname'
require 'erb'
require 'redcarpet'

module MdServer
  # routing
  class App < Sinatra::Base
    configure :development do
      require 'dotenv'
      Dotenv.load
    end

    get '/' do
      mds = Pathname.glob('./md/**/*.md')
      @md_files = mds.map do |md|
        filename = md.to_s
        filename[0,5] = ''
        filename
      end
      erb :index
    end

    get '/md/*' do |path|
      md = File.read("./md/#{path}")
      erb :mdtmpl, :locals => { :rendered => markdown(md) }
    end
  end
end
