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


configatron.devise.secret_key = '10b8641ac06c343b1e80b12744caabd5f1ff8a8a23961ae65e2615fca9eacb70cdf0d0b6ac10a99e3c835501b8ef13cf0f5ce93c0c6eb079bbe7d8ff7b8eff27'