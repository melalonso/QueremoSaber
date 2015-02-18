require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AboutMeValidator do

  describe :new do

    it 'expects the subject to respond to about_me' do
      expect {
        AboutMeValidator.new(double)
      }.to raise_error 'subject must respond to :about_me'
    end

  end

  describe :valid? do

    it 'is valid if about_me is =< 500' do
      user = double(:about_me => 'a'*500)
      validator = AboutMeValidator.new(user)
      expect(validator).to be_valid
    end

    it 'is valid if about_me is blank' do
      user = double(:about_me => '')
      validator = AboutMeValidator.new(user)
      expect(validator).to be_valid
    end

    it 'is valid if about_me is nil' do
      user = double(:about_me => nil)
      validator = AboutMeValidator.new(user)
      expect(validator).to be_valid
    end

    it 'is invalid if about_me is > 500' do
      user = double(:about_me => 'a'*501)
      validator = AboutMeValidator.new(user)
      expect(validator).to have(1).error_on(:about_me)
    end

  end

  describe :about_me do

    it 'forwards to the subject' do
      user = double(:about_me => 'My description')
      validator = AboutMeValidator.new(user)
      expect(validator.about_me).to eq('My description')
    end

  end

end
