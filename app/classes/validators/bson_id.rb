module Validators

  class BsonId < Grape::Validations::Validator
    def validate_param!(attr_name, params)
      unless params[attr_name] =~ /^[0-9a-f]{24}$/i
        throw :error, :status => 400, :message => "#{attr_name}: must be a BSON id"
      end
    end
  end

end