require 'active_support/concern'

module Encryption
  extend ActiveSupport::Concern

  def encryption_key
    if Rails.env == 'production'
      raise 'Must set token key!!' unless ENV['TOKEN_KEY']
      ENV['TOKEN_KEY']
    else
      ENV['TOKEN_KEY'] ? ENV['TOKEN_KEY'] : 'test_key'
    end
  end

end