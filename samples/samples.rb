require_relative '../lib/client'

credentials = {
  user:          ENV['P161_USER'],
  password:      ENV['P161_PASSWORD'],
  client_id:     ENV['P161_CLIENT_ID'],
  client_secret: ENV['P161_CLIENT_SECRET']
}

API_URL = ENV["P161_API_URL"]

client = Platform161::Client.new(API_URL, credentials)
puts "Geting the campaigns list ..."
puts client.request('get', 'campaigns')

params = {
  advertiser_report: {
    measures: [:clicks, :impressions],
    interval: :daily
  }
}
puts "Generating an advertiser report ..."
response = client.request('post','advertiser_reports', params)
puts response
puts "paging"
puts "items from 0 to 9 - page 1"
puts client.request('get', "advertiser_reports/#{response['id']}?ps=0&pe=9")
puts "items from 10 to 19 -  page 2"
puts client.request('get', "advertiser_reports/#{response['id']}?ps=10&pe=19")

params = {
  creative: {
    name: 'creative name',
    file: open('/Users/alinavancea/Downloads/z1vnBsdC6Bdc85vM2K54HQ_low_h264m (1).mp4'),
    size_id: 1,
    start_on: '01-02-12',
    end_on: '01-02-12',
    advertiser_id: 609413,
    click_url: 'http://test.com'
  }
}
puts "Uploading a creative ..."
response = client.request('post', 'creatives', params)
puts response