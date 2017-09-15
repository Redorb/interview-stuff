class AppController < ApplicationController
  layout 'app'

  def index
    @app_props = { name: 'sup' }
  end
end
