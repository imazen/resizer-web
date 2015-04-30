title: All releases
Renderer: RubyPoweredMarkdown
Icon: download
Layout: page

# All releases

<% releases.each do |p| %>
* [<%= p.heading %>](<%= p.path %>) - <%= p.meta_summary ? p.meta_summary.strip : '' %>
<%- end %>


Why do we skip version numbers? Private builds and beta testing. If you received a build via e-mail in response to a support request, you should upgrade to a newer release as soon as it is made available.
