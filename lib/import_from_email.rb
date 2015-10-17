require './email/email_easyjet'
require './email/email_ba'

class ImportFromEmail
  def import (text)
    @raw=text
    get_subject
    case @subject
      when ~/easyjet/
        process=EmailEasyjet.new
      when ~/BA e-ticket receipt/
        process=EmailBa.new
    else
        raise "Unknown reserve code"
    end
    process
  end
private
  def get_subject
    my_match=@raw.match(/^Subject: (.)$/)[1]
    raise "No subject" if my_match.nil?
    @subject=my_match
  end


end

