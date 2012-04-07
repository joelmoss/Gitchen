$('.modal').modal 'hide'
id = <%= @repo.id %>
$("#repo-#{id}").addClass 'unwatched'