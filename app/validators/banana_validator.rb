class BananaValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.downcase == "banana"
      record.errors.add attribute, "Don't be a silly banana!" 
    end
  end
end
