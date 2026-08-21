# frozen_string_literal: false

require "hexapdf"
require "tempfile"

# Service to add a signature to a pdf using certificates provided to
# Barcelona by Consorci AOC
#
# There are three values stored in secrets:
#
# * A PEM certificate stored in a string
# * A file path to a file containing a DER encoded PKCS12 string
# * A password for previous file
#
class PdfSignatureBarcelona
  attr_accessor :pdf

  # Public: Initializes the service.
  # pdf - The pdf document to be signed
  def initialize(args = {})
    @pdf = args.fetch(:pdf)
  end

  # Public: PDF signed if certificates can be obtained from secrets, the
  # original pdf otherwise
  def signed_pdf
    return pdf if missing_configuration?

    @signed_pdf ||= begin
      file = Tempfile.new("signed_pdf")
      document = HexaPDF::Document.new(io: StringIO.new(pdf))
      document.sign(
        file.path,
        signature: signature_widget(document),
        certificate:,
        key: private_key.key,
        certificate_chain: [],
        reason: caption,
        location:,
        contact_info: contact,
        signature_size: 10_000
      )
      File.binread(file.path)
    ensure
      file.close
      file.unlink
    end
  end

  private

  def missing_configuration?
    [pdf_certificate, certificate, private_key, signature_certificate_password].any?(&:blank?)
  end

  # The signature lives on a page of its own, appended after the document
  # contents, with the caption rendered as the widget appearance.
  def signature_widget(document, options = {})
    width = options.fetch(:width, 200.0)
    height = options.fetch(:height, 50.0)
    size = options.fetch(:size, 8)

    page = document.pages.add

    form = document.acro_form(create: true)
    form.signature_flag(:append_only)
    field = form.create_signature_field("signature")

    widget = field.create_widget(page, Rect: [height, width, width + height, width + height])
    widget.flag(:print)
    appearance = (widget[:AP] ||= {})[:N] ||= document.add({ Type: :XObject, Subtype: :Form })
    appearance[:BBox] = [0, 0, widget[:Rect].width, widget[:Rect].height]
    appearance.canvas
              .font("Helvetica", size:)
              .text(caption, at: [size, (height / 2) - (size / 2)])

    document.add({ Type: :Sig }).tap { |signature| field.field_value = signature }
  end

  def certificate
    return unless pdf_certificate

    @certificate ||= OpenSSL::X509::Certificate.new pdf_certificate
  end

  def private_key
    return if [signature_certificate_password, signer_private_key, certificate].any?(&:blank?)

    @private_key ||= OpenSSL::PKCS12.create(
      signature_certificate_password,
      "PDF signer",
      OpenSSL::PKey.read(signer_private_key),
      certificate
    )
  end

  def signer_private_key
    Decidim::Env.new("PDF_SIGNER_PRIVATE_KEY").to_s
  end

  def pdf_certificate
    Decidim::Env.new("PDF_SIGNER_CERTIFICATE").to_s
  end

  def signature_certificate_password
    Decidim::Env.new("SIGNATURE_CERTIFICATE_PASSWORD").to_s
  end

  def caption
    @caption ||= "Digitally Signed By: #{signedby}\nContact: #{contact}\nLocation: #{location}\nDate: #{date.iso8601}"
  end

  def signedby
    "Ajuntament de Barcelona"
  end

  def location
    "Barcelona"
  end

  def contact
    "suport@decidim.barcelona"
  end

  def date
    Time.current
  end
end
