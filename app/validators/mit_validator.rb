# frozen_string_literal: true

class MitValidator < ActiveModel::Validator
  ALUMNI_NAMESPACE = '_alumni'

  def alum_email(username)
    username.rpartition(ALUMNI_NAMESPACE).first + '@alum.mit.edu'
  end

  def kerberos_conflict?(username, email)
    username.length <= 8 && email != username + '@mit.edu'
  end

  def alum_conflict?(username, email)
    username.length > 8 &&
      username.end_with?(ALUMNI_NAMESPACE) &&
      email != alum_email(username)
  end

  def validate(account)
    return if !account.local? || account.user.confirmed?
    if kerberos_conflict?(account.username, account.user.email)
      errmsg = "Because this username has 8 characters or fewer, it can only be registered with the email address #{account.username}@mit.edu."
      if account.user.email == account.username + '@alum.mit.edu'
        errmsg << " As an alternative, you may use #{account.username}#{ALUMNI_NAMESPACE}."
      end
      account.errors.add(:username, errmsg)
    elsif alum_conflict?(account.username, account.user.email)
      account.errors.add(:username, "Because this username ends with #{ALUMNI_NAMESPACE}, it can only be registered with the email address #{alum_email(username)}")
    end
  end
end
