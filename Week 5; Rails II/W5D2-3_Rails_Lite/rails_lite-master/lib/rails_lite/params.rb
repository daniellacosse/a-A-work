require 'uri'
require 'debugger'

class Params
  # use your initialize to merge params from
  # 1. query string
  # 2. post body
  # 3. route params
  def initialize(req, route_params = {})
    # debugger
    @req, @params = req, {}
    @permitted_params ||= {}

    if @req.query_string
      puts ""
      puts "Query:"

      puts "@req.query_string: #{@req.query_string}"
      puts "URI: #{URI.decode_www_form(@req.query_string)}"

      query_params = parse_www_encoded_form(@req.query_string)

      puts "query_params: #{query_params}"

      @params.merge!(query_params)

    end

    if @req.body
      puts ""
      puts "Body:"

      puts "@req.body: #{@req.body}"
      puts "URI: #{URI.decode_www_form(@req.body)}"

      body_params = parse_www_encoded_form(@req.body)

      puts "query_params: #{body_params}"

      @params.merge!(body_params)
    end

    @params.merge!(route_params)

    puts "@params: #{@params}"
    puts "---"
  end

  def [](key)
    @params[key]
  end

  def permit(*keys)

    @permitted_params.merge!( @params.select { |k, v| keys.include?(k) } )
  end

  def require(key)
    raise AttributeNotFoundError unless @params.include?(key)
    @params[key]
  end

  def permitted?(key)
    @permitted_params.include?(key)
  end

  def to_s
    @params.to_json
  end

  class AttributeNotFoundError < ArgumentError; end;

  private
  # this should return deeply nested hash
  # argument format
  # user[address][street]=main&user[address][zip]=89436
  # should return
  # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
  def parse_www_encoded_form(www_encoded_form)

    parsed_form = {}

    uri_result = URI.decode_www_form(www_encoded_form)

    uri_result.each do |k_v_pair|

      n_hash = grow_nested_hash *[
        parse_key( k_v_pair.first ), k_v_pair.last
      ]

      parsed_form.deep_merge!(n_hash)
    end

    parsed_form
  end

  # this should return an array
  # user[address][street] should return ['user', 'address', 'street']
  def parse_key(key)
    key.split(/\[|\]\[|\]/)
  end

  def grow_nested_hash(keys, value)
    return value if keys.empty?

   { keys.first => grow_nested_hash(keys[1..-1], value) }
  end
end

class Hash

  def deep_merge!(hash)
    self.merge!(hash) do |key, s_val, o_val|
      s_val.deep_merge!(o_val) if s_val.is_a?(Hash) && o_val.is_a?(Hash)
    end
  end

end