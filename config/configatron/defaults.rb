# Email
configatron.emails.from = 'goodmorning@scrumlogs.com'

configatron.emails.mandrill.domain = 'scrumlogs.com'
configatron.emails.mandrill.user = ENV['MANDRILL_USER']
configatron.emails.mandrill.pass = ENV['MANDRILL_PASS']


# Integrations
configatron.github.client_id = '12345'
configatron.github.secret = ENV['GITHUB_SECRET']

configatron.gcal.client_id = '12345'
configatron.gcal.secret = ENV['GOOGLE_SECRET']