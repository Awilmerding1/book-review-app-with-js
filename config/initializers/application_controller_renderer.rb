# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

ActiveModelSerializers.config.tap do |c|
  c.adapter = :json_api
  c.jsonapi_include_toplevel_object = true
  c.jsonapi_version = "1.0"
end
