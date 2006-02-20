class CodeRedMailer < ActionMailer::Base

  def user_rule_change(user, sent_at = Time.now)
    @subject    = 'CodeRed: Ihr Nutzerstatus hat sich geändert'
    @body       = { :user => user }
    @recipients = user.user_email
    @from       = 'codered@farbspielchen.de'
    @sent_on    = sent_at
    @headers    = {}
  end
end
