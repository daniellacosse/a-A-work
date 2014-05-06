require 'erb'
require 'active_support/inflector'
require 'active_support/core_ext'
require_relative 'params'
require_relative 'session'


class ControllerBase
  attr_reader :params, :req, :res

  # setup the controller
  def initialize(req, res, route_params = {})
    @req, @res, @params = req, res, Params.new(req, route_params)
  end

  # populate the response with content
  # set the responses content type to the given type
  # later raise an error if the developer tries to double render
  def render_content(content, type)
    unless @already_rendered
      self.res.body, self.res.content_type = content, type

      @session.store_session(self.res)
      @already_rendered = true
    else
      raise "Double Render Error!"
    end
  end

  # helper method to alias @already_rendered
  def already_rendered?
    !!@already_rendered
  end

  # set the response status code and header
  def redirect_to(url)
    unless @already_rendered
      self.res.status, self.res["location"] = 302, url

      @session.store_session(self.res)
      @already_rendered = true
    else
      raise "Double Render Error!"
    end
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    controller_name = self.class.to_s.underscore

    f = File.read("views/#{controller_name}/#{template_name}.html.erb")
    erb = ERB.new(f).result(binding)

    render_content(erb, "html")
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)

    render(name) unless already_rendered?
  end

  def get
  end
end
