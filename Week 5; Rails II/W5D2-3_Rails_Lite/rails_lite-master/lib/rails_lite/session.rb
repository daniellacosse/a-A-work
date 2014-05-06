require 'json'
require 'webrick'
require 'debugger'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    app_crumbs = req.cookies.select { |crumb| crumb.name == "_rails_lite_app" }

    @session_values = !!app_crumbs.first ? JSON.parse(app_crumbs.first.value) : {}
  end

  def [](key)
    @session_values[key]
  end

  def []=(key, val)
    @session_values[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    app_crumb = WEBrick::Cookie.new("_rails_lite_app", @session_values.to_json)

    res.cookies.concat([app_crumb])
  end
end
