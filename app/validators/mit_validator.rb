# frozen_string_literal: true

class MitValidator < ActiveModel::Validator
  def kerberos_conflict?(username, email)
    return false if username.length > 8
    (email != username + '@mit.edu') && (email != username + '@alum.mit.edu')
  end

  def validate(account)
    return if !account.local? || account.user.confirmed?
    if kerberos_conflict?(account.username, account.user.email)
      account.errors.add(:username, "Because this username has 8 characters or fewer, it can only be registered with the email address #{account.username}@mit.edu.")
    end
  end
end
