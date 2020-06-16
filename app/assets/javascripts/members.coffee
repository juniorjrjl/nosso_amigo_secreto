$(document).on 'turbolinks:load', ->
  $('#member_email, #member_name').keypress (e) ->
    if e.which == 13 && valid_email($( "#member_email" ).val()) && $( "#member_name" ).val() != ""
      $('.new_member').submit()

  $('#member_email, #member_name').bind 'blur', ->
    if valid_email($( "#member_email" ).val()) && $( "#member_name" ).val() != ""
      $('.new_member').submit()

  $('body').on 'click', 'a.remove_member', (e) ->
    $.ajax '/members/'+ e.currentTarget.id,
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          Materialize.toast('Membro removido', 4000, 'green')
          $('#member_' + e.currentTarget.id).remove()
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na remoção de membro', 4000, 'red')
    return false

  $('.new_member').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: $(".new_member").serialize()
        success: (data, text, jqXHR) ->
          insert_member(data['id'], data['name'],  data['email'])
          $('#member_name, #member_email').val("")
          $('#member_name').focus()
          Materialize.toast('Membro adicionado', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na hora de incluir membro', 4000, 'red')
    return false

  $('input[id^="email_"], input[id^="name_"]').keypress (e) ->
    member_id = get_member_id(e.target.id)
    if e.which == 13 && valid_email($( "#email_#{member_id}" ).val()) && $( "#name_#{member_id}" ).val() != ""
      update_member(parseInt(member_id))

  $('input[id^="email_"], input[id^="name_"]').bind 'blur', (e)->
    member_id = get_member_id(e.target.id)
    if valid_email($( "#email_#{member_id}" ).val()) && $( "#name_#{member_id}" ).val() != ""
      update_member(parseInt(member_id))

get_member_id = (input_id) -> input_id.substring(input_id.indexOf('_') + 1)

update_member = (id) ->
  member =  build_update_member_json($( "#name_#{id}").val(), 
    $( "#email_#{id}").val(), 
    parseInt($("#campaign_id_#{id}").val()))
  $.ajax "/members/#{id}",
      type: 'PUT'
      dataType: 'json',
      data: member
      success: (data, text, jqXHR) ->
        Materialize.toast('Membro atualizado', 4000, 'green')
      error: (jqXHR, textStatus, errorThrown) ->
        Materialize.toast('Problema na hora de atualizar membro', 4000, 'red')
  return false

build_update_member_json = (name, email, campaign_id) ->
  member: {
    name: name,
    email: email,
    campaign_id: campaign_id
  }

valid_email = (email) ->
  /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email)

insert_member = (id, name, email) ->
  $('.member_list').append(
    '<div class="member" id="member_' + id + '">' +
      '<div class="row">' +
        '<div class="col s12 m5 input-field">' +
          '<input id="name_' + id + '" type="text" class="validate" value="' + name + '">' +
          '<label for="name" class="active">Nome</label>' +
        '</div>' +
        '<div class="col s12 m5 input-field">' +
          '<input id="email_' + id + '" type="email" class="validate" value="' + email + '">' +
          '<label for="email" class="active" data-error="Formato incorreto">Email</label>' +
        '</div>' +
        '<div class="col s3 offset-s3 m1 input-field">' +
          '<i class="material-icons icon">visibility</i>' +
        '</div>' +
        '<div class="col s3 m1 input-field">' +
          '<a href="#" class="remove_member" id="' + id + '">' +
            '<i class="material-icons icon">delete</i>' +
          '</a>' +
        '</div>' +
      '</div>' +
    '</div>')