require 'active_support/concern'

module Encryptable
  extend ActiveSupport::Concern

  def encryption_key
    if Rails.env.production?
      raise 'Must set an encryption key!!' unless ENV['ENCRYPTION_KEY']
      ENV['ENCRYPTION_KEY']
    else
      ENV['ENCRYPTION_KEY'] ? ENV['ENCRYPTION_KEY'] : 'test_key'
    end
  end

end