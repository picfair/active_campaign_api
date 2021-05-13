# frozen_string_literal: true

require 'addressable'
require 'json'

module ActiveCampaignApi
  # Main ActiveCampaign API Client class
  class Client
    API_PREFIX = '/api/3/'

    attr_accessor(:api_url, :api_key, :verbose)

    # Ininitialize the client
    # You must pass in an api_url and api_key
    # These are available from your ActiveCampaign account
    # For the sandbox accounts these are sent to your Email address by ActiveCampaign
    def initialize(api_url:, api_key:, verbose: false)
      self.api_url = api_url.is_a?(Addressable::URI) ? api_url : Addressable::URI.parse(api_url)
      self.api_key = api_key
      self.verbose = verbose
    end

    # Default headers we send to active campaign
    # - Accept/content type json
    # - Api-Token for authentication
    def default_headers
      @default_headers ||= {
        'accept': 'json',
        'content-type': 'application/json',
        'Api-Token': api_key
      }
    end

    # Send a GET request
    def get(resource_path, headers: {}, prefix: API_PREFIX)
      request(method: :get, resource_path: resource_path, headers: headers, prefix: prefix)
    end

    # Send a POST request
    def post(resource_path, body:, headers: {}, prefix: API_PREFIX)
      request(method: :post, resource_path: resource_path, headers: headers, body: body, prefix: prefix)
    end

    # Send a PUT request
    def put(resource_path, body:, headers: {}, prefix: API_PREFIX)
      request(method: :put, resource_path: resource_path, headers: headers, body: body, prefix: prefix)
    end

    # Send a DELETE request
    def delete(resource_path, headers: {}, prefix: API_PREFIX)
      request(method: :delete, resource_path: resource_path, headers: headers, prefix: prefix)
    end

    # Send any type of HTTP request
    def request(method:, resource_path:, headers: {}, body: nil, prefix: API_PREFIX)
      body_json = body.is_a?(String) || body.nil? ? body : body.to_json
      url = ((api_url + prefix) + resource_path).to_s
      request_headers = default_headers.merge(headers)

      if verbose
        puts("Executing #{method} request to #{url}")
        request_headers.each_pair do |k, v|
          puts("- Header: #{k}: #{v}")
        end
        puts("- body: #{body_json.class}: #{body_json}")
      end

      response = RestClient::Request.execute(
        method: method,
        url: url,
        headers: request_headers,
        payload: body_json
      )

      JSON.parse(response.body)
    end
  end
end
