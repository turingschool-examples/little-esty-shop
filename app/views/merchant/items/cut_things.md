<header>
  <div class = "merchantItemHeader">
    <h1> Little Esty Shop </h1><br/>
  </div>
  <div class = "app_logo">
     <%= image_tag @app_logo.url, size: "220x220" %>
  </div>
  <div class = "app_logo_likes">
     <p><%= @app_logo.likes%> people liked this logo.</p>
  </div>
</header>