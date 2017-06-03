require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome email' do
    let(:user) { User.first }
    let(:mail) { UserMailer.welcome_email(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq 'Welcome to Crabalicious Film Reviews'
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ['crabaliciousteam@gmail.com']
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include 'You have successfully signed up to Crabaliciousfilmreviews.com'     
    end
  end
end
