require_relative '../lib/client'

describe "client" do

  let(:api_url) { "http://test.com" }
  let(:credentials) { {user: 'test', password: 'password', client_id: 'client_id', client_secret: 'client_secret'}}

  it "needs correct credentials" do
    expect{Platform161::Client.new("test", {a: ''})}.to raise_error(ArgumentError)
  end

  it "authenticates when doing first request" do
    client = Platform161::Client.new(api_url, credentials)
    expect(client).to receive(:get_token).and_return("token")
    allow(HTTMultiParty).to receive(:public_send).with('get', "#{api_url}/campaigns", body: {}, headers: {"PFM161-API-AccessToken" => 'token'}).and_return({})
    client.request('get', 'campaigns')
  end

  it "doesn't authenticate second time" do
    client = Platform161::Client.new(api_url, credentials)
    expect(client).to receive(:get_token).and_return("token")
    allow(HTTMultiParty).to receive(:public_send).with('get', "#{api_url}/campaigns", body: {}, headers: {"PFM161-API-AccessToken" => 'token'}).and_return({})
    client.request('get', 'campaigns')

    expect(client).to_not receive(:get_token)
    allow(HTTMultiParty).to receive(:public_send).with('get', "#{api_url}/creatives", body: {}, headers: {"PFM161-API-AccessToken" => 'token'}).and_return({})
    client.request('get', 'creatives')
  end

end
