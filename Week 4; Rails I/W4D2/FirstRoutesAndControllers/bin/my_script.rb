require 'addressable/uri'
require 'rest-client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1',
  query_values: { user: { username: "Ash Katchim" } }).to_s

puts RestClient.update(url)