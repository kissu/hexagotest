class PagesController < ApplicationController

  skip_before_action :only_signed_in, only: [:home]

  def home
  end

end
