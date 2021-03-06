module FormHelper
end

module ActionView
  module Helpers
    module FormHelper
      def phone_field(object_name, method, options = {})
        options[:value] = format_phone(options[:object][method], mobile=(method.to_s =~ /mobile/))
        options[:size] ||= 15
        InstanceTag.new(object_name, method, self, options.delete(:object)).to_input_field_tag("text", options)
      end
    end
    class FormBuilder
      def phone_field(method, options = {})
        @template.phone_field(@object_name, method, options.merge(object: @object))
      end
      def date_field(method, options = {})
        options[:value] = self.object[method].to_s(:date) rescue ''
        options[:size] ||= 12
        text_field(method, options)
      end
    end
    module FormTagHelper
      def date_field_tag(name, value = nil, options = {})
        value = value.to_s(:date) rescue ''
        options[:size] ||= 12
        text_field_tag(name, value, options)
      end
    end
  end
end
