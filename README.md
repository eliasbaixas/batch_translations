Helper that renders globalize fields
on a per-locale basis, so you can use them separately
in the same form and still saving them all at once
in the same request.

Use it like this:

    <h1>Editing post</h1> 
  
    <% form_for(@post) do |f| %>
    <%= f.error_messages %>
  
    <h2>English (default locale)</h2>
    <p><%= f.text_field :title %></p>
    <p><%= f.text_field :teaser %></p>
    <p><%= f.text_field :body %></p>
    
    <hr/>
    
    <h2>Spanish translation</h2>
    <% f.globalize_fields_for :es do |g| %>
    <p><%= g.text_field :title %></p>
    <p><%= g.text_field :teaser %></p>
    <p><%= g.text_field :body %></p>
    <% end %>
    
    <hr/>
    
    <h2>French translation</h2>
    <% f.globalize_fields_for :fr do |g| %>
    <p><%= g.text_field :title %></p>
    <p><%= g.text_field :teaser %></p>
    <p><%= g.text_field :body %></p>
    <% end %>
    
    <% end %>
