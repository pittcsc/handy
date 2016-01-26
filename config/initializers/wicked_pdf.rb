require 'wicked_pdf'

WickedPdf.config = if Rails.env.production?
  { exe_path: '/app/usr/local/bin/wkhtmltopdf' }
else
  { exe_path: '/usr/local/bin/wkhtmltopdf' }
end
