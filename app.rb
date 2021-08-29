require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'json'

get '/' do
	if params[:url]
		agent = Mechanize.new
		page = agent.get(params[:url])

		result = {}

		begin
			result[:title] = page.title
		rescue => exception
			result[:title] = nil
		end

		begin
			result[:description] = page.at('meta[name="description"]')[:content]
		rescue => exception
			result[:description] = nil
		end

		begin
			result[:keywords] = page.at('meta[name="keywords"]')[:content]
		rescue => exception
			result[:keywords] = nil
		end

		begin
			result[:ogp_title] = page.at('meta[property="og:title"]')[:content]
		rescue => exception
			result[:ogp_title] = nil
		end

		begin
			result[:ogp_description] = page.at('meta[property="og:description"]')[:content]
		rescue => exception
			result[:ogp_description] = nil
		end

		begin
			result[:ogp_keywords] = page.at('meta[property="og:keywords"]')[:content]
		rescue => exception
			result[:ogp_keywords] = nil
		end

		begin
			result[:ogp_image] = page.at('meta[property="og:image"]')[:content]
		rescue => exception
			result[:ogp_image] = nil
		end

		begin
			result[:ogp_url] = page.at('meta[property="og:url"]')[:content]
		rescue => exception
			result[:ogp_url] = nil
		end

		begin
			result[:ogp_type] = page.at('meta[property="og:type"]')[:content]
		rescue => exception
			result[:ogp_type] = nil
		end

		begin
			result[:ogp_site_name] = page.at('meta[property="og:site_name"]')[:content]
		rescue => exception
			result[:ogp_site_name] = nil
		end

		begin
			result[:ogp_locale] = page.at('meta[property="og:locale"]')[:content]
		rescue => exception
			result[:ogp_locale] = nil
		end

		content_type :json
		result.to_json
	
	else
		erb :index
	end
end