# Custom Validator

A smol example of how to use custom validations in Rails. Taken from [rails](https://guides.rubyonrails.org/active_record_validations.html#performing-custom-validations)

Process

- Create a `validators` folder
- `mkdir app/validators`
- Create a validation file
- `vim f*ck_validator.rb`
- Create a class with the naming convention of `[Custom]Validator` that inherits from `ActiveModel::EachValidator`
- overwrite the `validate_each` method to validate against the passed in value
- attach any errors directly to the record - this will allow the synergy with the form and validation errors

`app/validators/fuck_validator.rb`
``` Ruby
class FuckValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.downcase == "fuck"
      record.errors.add attribute, "Don't set the title as fuck!" 
    end
  end
end
```
`app/views/posts/_form.html.erb`
``` Ruby
<%= form_with(model: post) do |form| %>
  <% if post.errors.any? %>
    <div style="color: red">
      <h2><%= pluralize(post.errors.count, "error") %> prohibited this post from being saved:</h2>
      <ul>
        <% post.errors.each do |error| %>
          <li><%= error.full_message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>
<% # form things here... %>
<% end %>
```
`app/models/post.rb`
```
class Post < ApplicationRecord
  validates :title, fuck: true
end
```

Notes:

- Notice how the naming convention takes care of the Object -> :symbol conversion
- `F*ckValidator` in our validators folder becomes `:f*ck` in the Post model
