# frozen_string_literal: false

require "origami"
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
                      StringIO.open(pdf) do |stream|
                        parsed_pdf = Origami::PDF.read(stream)
                        parsed_pdf.append_page do |page|
                          page.add_annotation(signature_annotation)
                          parsed_pdf.sign(
                            certificate,
                            private_key.key,
                            method: "adbe.pkcs7.detached",
                            annotation: signature_annotation,
                            location: location,
                            contact: contact,
                            issuer: issuer
                          )
                        end
                        extract_signed_pdf(parsed_pdf)
                      end
                    end
  end

  private

  def missing_configuration?
    [pdf_certificate, certificate, private_key, signature_certificate_password].any?(&:blank?)
  end

  def extract_signed_pdf(parsed_pdf)
    file = Tempfile.new("signed_pdf")
    begin
      parsed_pdf.save(file.path)
      File.binread(file.path)
    ensure
      file.close
      file.unlink
    end
  end

  def text_annotation(options = {})
    width = options.fetch(:width, 200.0)
    height = options.fetch(:height, 50.0)
    size = options.fetch(:size, 8)

    Origami::Annotation::AppearanceStream.new.tap do |annotation|
      annotation.Type = Origami::Name.new("XObject")
      annotation.Resources = Origami::Resources.new
      annotation.Resources.ProcSet = [Origami::Name.new("Text")]
      annotation.set_indirect(true)
      annotation.Matrix = [1, 0, 0, 1, 0, 0]
      annotation.BBox = [0, 0, width, height]
      annotation.write(caption, x: size, y: (height / 2) - (size / 2), size: size)
    end
  end

  def signature_annotation(options = {})
    @signature_annotation ||= begin
                                width = options.fetch(:width, 200.0)
                                height = options.fetch(:height, 50.0)

                                Origami::Annotation::Widget::Signature.new.tap do |annotation|
                                  annotation.set_indirect(true)
                                  annotation.Rect = Origami::Rectangle[llx: height, lly: width + height, urx: width + height, ury: width]
                                  annotation.set_normal_appearance(text_annotation(width: width, height: height))
                                end
                              end
  end

  def certificate
    return unless pdf_certificate
    @certificate ||= OpenSSL::X509::Certificate.new pdf_certificate
  end

  def private_key
    return [signature_certificate_password, signer_private_key, certificate].any?(&:blank?)

    @private_key ||= OpenSSL::PKCS12.create(
                        signature_certificate_password,
                        'PDF signer',
                        OpenSSL::PKey.read(signer_private_key),
                        certificate
                      )
  end

  def signer_private_key
    Rails.application.secrets.pdf_signer_private_key
  end

  def pdf_certificate
    Rails.application.secrets.pdf_signer_certificate
  end

  def signature_certificate_password
    Rails.application.secrets.signature_certificate_password
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

  def issuer
    "Decidim"
  end

  def date
    Time.current
  end
end
