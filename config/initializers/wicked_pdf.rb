require 'wicked_pdf'

WickedPdf.config = if Rails.env.production?
  { exe_path: '/u/apps/handy/shared/bin/wkhtmltopdf' }
else
  { exe_path: '/usr/local/bin/wkhtmltopdf' }
end
