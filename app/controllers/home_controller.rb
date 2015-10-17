class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    render layout: false
  end
  def about
  end
  def terms
  end
  def thanks
  end
end
