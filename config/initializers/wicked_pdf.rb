require 'wicked_pdf'

unless Rails.env.production?
  WickedPdf.config = { exe_path: '/usr/local/bin/wkhtmltopdf' }
end
