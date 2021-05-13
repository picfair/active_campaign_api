# frozen_string_literal: true
require 'addressable'
require 'rest-client'

RSpec.describe(ActiveCampaignApi::Client) do
  let(:client) do
    ActiveCampaignApi::Client.new(
      api_url: 'http://api.example.com/',
      api_key: 'abcdef',
      verbose: false
    )
  end

  describe('API_PREFIX') do
    it 'has an API prefix' do
      expect(ActiveCampaignApi::Client::API_PREFIX).to eql('/api/3/')
    end
  end

  describe('initializer') do
    context('initialize with api_url, api_key') do

      it 'sets the api_url attribute as an Addressble::URI' do
        expect(client.api_url).to be_a(Addressable::URI)
        expect(client.api_url.to_s).to eql('http://api.example.com/')
      end

      it 'sets the api_key instance variable' do
        expect(client.api_key).to eql('abcdef')
      end

      it 'sets the verbose instance variable' do
        expect(client.verbose).to eql(false)
      end
    end

  end

  describe('#default_headers') do
    it 'sets sensible default headers, including api_key' do
      expected_headers = {
        'accept': 'json',
        'content-type': 'application/json',
        'Api-Token': 'abcdef'
      }
      expect(client.default_headers).to eql(expected_headers)
    end
  end

  describe('#get') do
    it 'uses RestClient to GET a request' do
      response = OpenStruct.new(body: {'some' => 'data'}.to_json)
      expect(RestClient::Request).to receive(:execute).with(
        method: :get,
        url: 'http://api.example.com/api/3/resource',
        headers: client.default_headers,
        payload: nil,
      ).and_return(response)
      expect(client.get('resource')).to eql({'some' => 'data'})
    end

    context('with verbose mode') do
      let(:client) do
        ActiveCampaignApi::Client.new(
          api_url: 'http://api.example.com/',
          api_key: 'abcdef',
          verbose: true
        )
      end

      it 'still uses RestClient to GET a request' do
        response = OpenStruct.new(body: {'some' => 'data'}.to_json)
        expect(RestClient::Request).to receive(:execute).with(
          method: :get,
          url: 'http://api.example.com/api/3/resource',
          headers: client.default_headers,
          payload: nil,
          ).and_return(response)
        expect(client.get('resource')).to eql({'some' => 'data'})
      end

    end
  end

  describe('#post') do
    it 'uses RestClient to POST a request' do
      request_data = {'request-data': 123}
      response = OpenStruct.new(body: {'some' => 'data'}.to_json)
      expect(RestClient::Request).to receive(:execute).with(
        method: :post,
        url: 'http://api.example.com/api/3/resource',
        headers: client.default_headers,
        payload: request_data.to_json,
        ).and_return(response)
      expect(client.post('resource', body: request_data.to_json)).
        to eql({'some' => 'data'})
    end
  end

  describe('#put') do
    it 'uses RestClient to PUT a request' do
      request_data = {'request-data': 123}
      response = OpenStruct.new(body: {'some' => 'data'}.to_json)
      expect(RestClient::Request).to receive(:execute).with(
        method: :put,
        url: 'http://api.example.com/api/3/resource',
        headers: client.default_headers,
        payload: request_data.to_json,
        ).and_return(response)
      expect(client.put('resource', body: request_data.to_json)).
        to eql({'some' => 'data'})
    end
  end

  describe('#delete') do
    it 'uses RestClient to DELETE a request' do
      response = OpenStruct.new(body: {'some' => 'data'}.to_json)
      expect(RestClient::Request).to receive(:execute).with(
        method: :delete,
        url: 'http://api.example.com/api/3/resource',
        headers: client.default_headers,
        payload: nil,
        ).and_return(response)
      expect(client.delete('resource')).to eql({'some' => 'data'})
    end
  end


end
