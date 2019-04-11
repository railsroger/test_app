module Spree
  module Admin
    module GeneralSettingsHelper
      def currency_options
        currencies = ::Money::Currency.table.map do |_code, details|
          iso = details[:iso_code]
          [iso, "#{details[:name]} (#{iso})"]
        end
        options_from_collection_for_select(currencies, :first, :last, Spree::Config[:currency])
      end

      def country_options
        countries = Spree::Country.all.map do |details|
          iso = details[:id]
          [iso, details[:name]]
        end
        options_from_collection_for_select(countries, :first, :last, current_store.country_id)
      end
    end
  end
end
