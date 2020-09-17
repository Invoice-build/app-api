module InvoiceAuthorization
  extend ActiveSupport::Concern

  included do
    def authenticated_invoice?(invoice)
      if invoice.password_digest
        return true if password_provided?

        false
      else
        true
      end
    end

    def password_provided?
      return Invoice.find_by(id: decoded_invoice_token[0]['invoice_id']) unless decoded_invoice_token.empty?
    end

    def invoice_session_token(invoice)
      expires = Time.now.to_i + 30.days.to_i
      JWT.encode({ invoice_id: invoice.id, exp: expires }, ENV['JWT_SECRET'], 'HS256')
    end

    def decoded_invoice_token
      if token = request.headers['Invoice-Authorization']
        begin
          JWT.decode(token, ENV['JWT_SECRET'], true, { algorithm: 'HS256' })
        rescue JWT::ExpiredSignature
          []
        rescue JWT::DecodeError
          []
        end
      else
        []
      end
    end
  end
end
