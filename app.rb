#! /usr/bin/env ruby

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require 'sinatra'
require 'analyser'

get '/' do
    url = params['url']
    
    if (url && url != '')
      begin
        @url = url
        html = RestClient.get(url).body
        links = Analyser.analyse html
        @absolute_links = links[:absolute]
        @relative_links = links[:relative]
        @total_link_count = @absolute_links.length + @relative_links.count
      rescue Exception => e
        @exception = e
      end
    end

    erb(:index)
end