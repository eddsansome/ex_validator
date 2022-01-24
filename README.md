# Custom Validator

A smol example of how to use custom validations in Rails. Taken from [rails](https://guides.rubyonrails.org/active_record_validations.html#performing-custom-validations)

Process

- Create a `validators` folder
- `mkdir app/validators`
- Create a validation file
- `vim banana_validator.rb`
- Create a class with the naming convention of `[Custom]Validator` that inherits from `ActiveModel::EachValidator`
- overwrite the `validate_each` method to validate against the passed in value
- attach any errors directly to the record - this will allow the synergy with the form and validation errors

`app/validators/banana_validator.rb`
``` Ruby
class BananaValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.downcase == "banana"
      record.errors.add attribute, "Don't set the title as banana!" 
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
  validates :title, banana: true
end
```

<img width="826" alt="Screenshot 2022-01-24 at 15 48 19" src="https://user-images.githubusercontent.com/75685296/150816033-551f7e8a-3747-40e9-a4cf-31990973dcda.png">


Notes:

- Notice how the naming convention takes care of the Object -> :symbol conversion
- `BananaValidator` in our validators folder becomes `:banana` in the Post model
