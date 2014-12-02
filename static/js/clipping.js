/**
 * janela Modal para Ocorrências
 */
function ajaxClippingForm(url, clipping_id){
  // if no id was passed, set it to zero
  clipping_id = typeof clipping_id !== 'undefined' ? clipping_id : 0;

  // load form view
  $.get( url + '&clipping_id=' + clipping_id, function( data ) {
    $( ".modal-body" ).html( data );
    $( ".modal-title" ).html( "Add or Edit an Article" );
    $('#myModal').modal({show:true});
  });
}

/**
 * Faz a busca por modelos ou exemplares a medida que o usuario digita
 * carrega resultados dinamicamente
 */
function ajaxBusca(){
  if($("#q").val().length >=0){
    $.get( "/ajax_search", { q: $("#q").val() },function( data ) {
      $( "#div_body" ).html( data );
      // "oculta" menu lateral, mantendo a div
      $( "#div_menu_direito" ).html( " " );
    });
  }
}

// Jquery sticker para menu direito
$(document).ready(function(){
  $("#divMenu").sticky({topSpacing:60});
});

// if we have date inputs, make them a datepicker
$(document).ready(function(){
  $(".datepicker").datepicker({ dateFormat: 'dd/mm/yy' });
});

/**
 * cancel buttons that go back to referer
 *
 */
$(".go-back").click(function(){
  history.back();
});

/**
 * verifica a existência de campos para marca e modelo
 * e, se existirem, faz autocomplete
 */
if ($('#id_mod_marca').length > 0) {
  $(function() {
      $( "#id_mod_marca" ).autocomplete({
        source: "/ajax_search_field/mod_marca",
        minLength: 2,
        focus: function( event, ui ) {
          $( "#id_mod_marca" ).val( ui.item.label );
          return false;
        },
        select: function( event, ui ) {
          $( "#id_mod_marca" ).val( ui.item.label );
          return false;
        }
      })
      .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
        return $( "<li>" )
          .append( "<a><b>" + item.label + "</b></a>")
          .appendTo( ul );
      };
  });
}


// autocomplete de modelos
if ($('#id_mod_marca').length > 0) {
  $(function() {
      $( "#id_mod_modelo" ).autocomplete({
        source: "/ajax_search_field/mod_modelo",
        minLength: 2,
        focus: function( event, ui ) {
          $( "#id_mod_modelo" ).val( ui.item.label );
          return false;
        },
        select: function( event, ui ) {
          $( "#id_mod_modelo" ).val( ui.item.label );
          return false;
        }
      })
      .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
        return $( "<li>" )
          .append( "<a><b>" + item.label + "</b></a>")
          .appendTo( ul );
      };
  });
}

/**
 * Aplica Style de switch on/off nos checkboxes de exemplares
 * http://www.bootstrap-switch.org/
 */
$(document).ready(function(){
  $.fn.bootstrapSwitch.defaults.onText = 'SIM';
  $.fn.bootstrapSwitch.defaults.offText = 'NÃO';
  $.fn.bootstrapSwitch.defaults.onColor = 'danger';
  $("[name='ex_status_emprestado']").bootstrapSwitch();
  $("[name='ex_status_baixado']").bootstrapSwitch();
});

/**
 *  Sweet Alert
 *  Gera confirms estilizados na exclusão de modelos
 *  e exemplares
 */
 $( ".action-needs-confirm" ).click(function(){
  swal({
    title: "Are you sure?",
    text: "This action cannot be undone!",
    type: "warning",
    showCancelButton: true,
    cancelButtonText: "Cancel" ,
    confirmButtonColor: "#DD6B55",
    confirmButtonText: "Confirm" },
  function(){
    document.getElementById("form-delete").submit();
  });
});
