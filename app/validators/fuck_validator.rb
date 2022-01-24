class FuckValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.downcase == "fuck"
      record.errors.add attribute, "Don't set the title as fuck!" 
    end
  end
end
