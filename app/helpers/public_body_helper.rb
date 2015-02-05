module PublicBodyHelper

  # Public: The reasons a request can't be made to a PublicBody
  # The returned reasons are ordered by priority. For example, if the body no
  # longer exists there is no reason to ask for its contact details if we don't
  # have an email for it.
  #
  # public_body - Instance of a PublicBody
  #
  # Returns an Array
  def public_body_not_requestable_reasons(public_body)
    reasons = []

    if public_body.defunct?
      reasons.push _('This authority no longer exists, so you cannot make a request to it.')
    end

    if public_body.not_apply?
      reasons.push _('Freedom of Information law does not apply to this authority, so you cannot make a request to it.')
    end

    unless public_body.has_request_email?
      msg = _(%Q(Unfortunately, we do not have a working
                 <a href="{{contact_url}}">contact address</a> for
                 {{body_name}}.).squish,
              :body_name => public_body.name,
              :contact_url => view_public_body_email_path(public_body.url_name))
      reasons.push(msg)
    end

    reasons.compact
  end

end
