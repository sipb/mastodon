# frozen_string_literal: true

class MitValidator < ActiveModel::Validator
  def validate(account)
    return if !account.local? || (!account.user.nil? && account.user.confirmed?)
    account.errors.add(:username, 'Because this username has 8 characters or fewer, it can only be registered with the email address %s@mit.edu.' % account.username) if account.username.length <= 8 && !account.user.email.eql?([account.username, '@mit.edu'].join)
  end
end
