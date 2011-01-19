module ActionView
  module Helpers
    class FormBuilder
      def globalize_fields_for(locale, *args, &proc)
        raise ArgumentError, "Missing block" unless block_given?
        @index = @index ? @index + 1 : 1
        object_name = "#{@object_name}[translations_attributes][#{@index}]"
        object = @object.translations.select{|t| t.locale.to_s == locale}.first || @object.translations.find_by_locale(locale.to_s)
        @template.concat @template.hidden_field_tag("#{object_name}[id]", object ? object.id : "")
        @template.concat @template.hidden_field_tag("#{object_name}[locale]", locale)
        @template.fields_for(object_name, object, *args, &proc)
      end
    end
  end
end

module Globalize
  module Model
    module ActiveRecord
      module Translated
        module Callbacks
          def enable_nested_attributes
            accepts_nested_attributes_for :translations
          end
        end
        module InstanceMethods
          def after_save
            init_translations if build_all_translations
          end
          # Builds an empty translation for each available 
          # locale not in use after creation
          def init_translations
            I18n.available_locales.reject{|key| key == :root }.each do |locale|
              translation = self.translations.find_by_locale locale.to_s
              if translation.nil?
                # logger.debug "Building empty translation with locale '#{locale}'"
                translations.build :locale => locale
                save
              end
            end
          end
        end
      end
    end
  end
end
