class CodeRedMailer < ActionMailer::Base
  def user_rule_change(user, sent_at = Time.now)
    @subject    = 'CodeRed: Ihr Nutzerstatus hat sich geändert'
    @body       = { :user => user , :namen => codered = ["","Admistrator", "Mentor", "Betreuer", "Kontakt", "Deaktiviert"] }
    @recipients = user.user_email
    @headers["Organization"] = "Staatliche Technikerschule Weilburg"
    @headers["List-Id"] = "Das CodeRed Ticketsystem <codered@stsweilburg.de>"  # Mail wird als Mailing-List "getarnt"
    @headers["List-Help"] = "<mailto:info@stsweilburg.de>"                     # dann kann der MailClient das schöner einsortieren
    @from       = 'codered@stsweilburg.de'
    @sent_on    = sent_at
  end
  def user_new(user , newuser , sent_at = Time.now)
    @subject    = 'CodeRed: Es wurde ein neuer Nutzer angelegt' 
    @body       = { :user => user , :newuser => newuser }
    @recipients = user.user_email
    @headers["Organization"] = "Staatliche Technikerschule Weilburg"
    @headers["List-Id"] = "Das CodeRed Ticketsystem <codered@stsweilburg.de>"  # Mail wird als Mailing-List "getarnt"
    @headers["List-Help"] = "<mailto:info@stsweilburg.de>"                     # dann kann der MailClient das schöner einsortieren
    @from       = 'codered@stsweilburg.de'
    @sent_on    = sent_at
  end
  def ticket_new(ticket , user , client , sent_at = Time.now)
    @subject    = 'CodeRed: Es ein neues Ticket angelegt' 
    wichtigkeiten = [["Dringend"],["Normal"],["Wenn Zeit"]]
    @body       = { :ticket => ticket , :user => user , :client => client, :wichtigkeit => wichtigkeiten[ticket.ticket_wichtigkeit] }
    @recipients = user.user_email
    @headers["Organization"] = "Staatliche Technikerschule Weilburg"
    @headers["List-Id"] = "Das CodeRed Ticketsystem <codered@stsweilburg.de>"  # Mail wird als Mailing-List "getarnt"
    @headers["List-Help"] = "<mailto:info@stsweilburg.de>"                     # dann kann der MailClient das schöner einsortieren
    @from       = 'codered@stsweilburg.de'
    @sent_on    = sent_at
  end
  def ticket_zuweisen(ticket , user , client , sent_at = Time.now)
    @subject    = 'CodeRed: Es wurde Ihnen ein Ticket zugeweisen' 
    wichtigkeiten = [["Dringend"],["Normal"],["Wenn Zeit"]]
    @body       = { :ticket => ticket , :user => user , :client => client, :wichtigkeit => wichtigkeiten }
    @recipients = user.user_email
    @headers["Organization"] = "Staatliche Technikerschule Weilburg"
    @headers["List-Id"] = "Das CodeRed Ticketsystem <codered@stsweilburg.de>"  # Mail wird als Mailing-List "getarnt"
    @headers["List-Help"] = "<mailto:info@stsweilburg.de>"                     # dann kann der MailClient das schöner einsortieren
    @from       = 'codered@stsweilburg.de'
    @sent_on    = sent_at
  end
end
