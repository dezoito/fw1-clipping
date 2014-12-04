/**
 * Displays forms in modal window
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
 * Handles search, dynamical/y updating results
 *
 */
// function ajaxBusca(){
//   if($("#q").val().length >=0){
//     $.get( "/ajax_search", { q: $("#q").val() },function( data ) {
//       $( "#div_body" ).html( data );
//       // "oculta" menu lateral, mantendo a div
//       $( "#div_menu_direito" ).html( " " );
//     });
//   }
// }

// Jquery sticker on right side menus
$(document).ready(function(){
  $("#divMenu").sticky({topSpacing:60});
});

/**
 * cancel buttons: go back to referer
 */
$(".go-back").click(function(){
  history.back();
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
