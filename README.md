# Platform161 API client.

It is made for our API users so it can be used as an example of accessing P161 API.

## Dependencies:

To use the client add it to your Gemfile

```
gem 'p161-api-client', git: 'https://github.com/CD-Technology/p161-api-client-ruby.git'
```

## Usage

### Initialization

```
require 'platform161/client'

API_URL = ENV['P161_API_URL']

credentials = {
  user:          ENV['P161_USER'],
  password:      ENV['P161_PASSWORD'],
  client_id:     ENV['P161_CLIENT_ID'],
  client_secret: ENV['P161_CLIENT_SECRET']
}


p161_api_client =  Platform161::Client.new(API_URL, credentials)
```

### Get the campaigns list

```
p161_api_client.request('get', 'campaigns')
```

###  Get a specific campaign

```
p161_api_client.request('get', 'campaigns/1')
```

### Update a specific campaign

```
params = {
  campaign: {
    name: 'New name'
  }
}
p161_api_client.request('put', 'campaigs/1', params)
```

### Generate an advertiser report

```
params = {
  advertiser_report: {
    measures: [:clicks, :impressions],
    interval: :daily
  }
}

response = client.request( 'post', 'advertiser_reports', params)
```

### Get a specific report

```
response = client.request('get', 'advertiser_reports/12')
```

### Get a specifc report using pagination, retrieve first 10 items in a report

```
response = client.request('get', 'advertiser_reports/12?ps=0&pe=9')
```

### Get the second batch of items

```
response = client.request('get', 'advertiser_reports/12?ps=10&pe=19')
```

### Upload a creative

```
params = {
  creative: {
    name: 'creative name',
    file: open('/path/to/creative/file.jpeg'),
    size_id: 1,
    start_on: '01-02-12',
    end_on: '01-02-12',
    advertiser_id: 1,
    click_url: 'http://test.com'
  }
}

response = client.request('post', 'creatives', params)
```
