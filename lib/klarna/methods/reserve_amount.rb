require 'klarna/digest'

module Klarna
  module Methods
    module ReserveAmount
      def self.xmlrpc_name
        'reserve_amount'
      end

      def self.xmlrpc_params(store_id, store_secret, api_version, client_name, params)
        [
          params[:pno],
          params.fetch(:gender, ''),
          params[:amount],
          params.fetch(:reference, ''),
          params.fetch(:reference_code, ''),
          params.fetch(:order_id_1, ''),
          params.fetch(:order_id_2, ''),
          params[:delivery_address],
          params[:billing_address],
          params.fetch(:client_ip, ''),
          params[:flags],
          params[:currency],
          params[:country],
          params[:language],
          store_id,
          digest(store_id, params[:pno], params[:amount], store_secret),
          params[:pno_encoding],
          params[:pclass],
          params[:goods_list],
          params.fetch(:comment, ''),
          params.fetch(:shipment_info, []),
          params.fetch(:travel_info, []),
          params.fetch(:income_expense, []),
          params.fetch(:bank_info, []),
          params.fetch(:session_id, {}),
          params.fetch(:extra_info, [])
        ]
      end

      private

      def self.digest(store_id, pno, amount, store_secret)
        array = [store_id, pno, amount, store_secret]

        Klarna::Digest.for(array)
      end
    end
  end
end
