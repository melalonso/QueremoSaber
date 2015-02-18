# models/about_me_validator.rb:
# Validates editing about me text on user profile pages.
#
# Copyright (c) 2010 UK Citizens Online Democracy. All rights reserved.
# Email: hello@mysociety.org; WWW: http://www.mysociety.org/
require 'forwardable'

class AboutMeValidator
    extend Forwardable
    include ActiveModel::Validations

    def_delegators :@subject, :about_me

    validate :length_of_about_me

    def initialize(subject)
      unless subject.respond_to?(:about_me)
        raise 'subject must respond to :about_me'
      end
      @subject = subject
    end

    private

    def length_of_about_me
        if !about_me.blank? && about_me.size > 500
            errors.add(:about_me, _("Please keep it shorter than 500 characters"))
        end
    end
end
