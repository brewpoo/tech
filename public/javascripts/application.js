// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//

function mark_note_destroyed(element) {
  $(element).next('.should_destroy').value = 1;
  $(element).up('.note').hide();
}

function remove_note(element) {
  $(element).up('.note').remove();
}

function mark_destroyed(c,element) {
  $(element).next('.should_destroy').value = 1;
  $(element).up(c).hide();
}

function remove_destroyed(c,element) {
  $(element).up(c).remove();
}

function conditional_enable(c,element) {
  if(element.value) {
    $(element).next(c).enable();
  } else {
    $(element).next(c).disable();
  }
}

function toggle(c,element) {
  if(element.checked==true) {
    $(element).next(c).disabled=false;
  } else {
    $(element).next(c).disabled=true;
  }
}

function update_if_blank(c,element) {
  if($(element).next(c).value == "") {
    $(element).next(c).value=$(element).value;
  }
}

function update_always(c,element) {
  $(c).value=$(element).value;
}

function update_select_options( target, opts_array, clear_select_list ) {

    if( $(target).type.match("select" ) ){ // Confirm the target is a select box

        // Remove existing options from the target and the clear_select_list
        clear_select_list[clear_select_list.length] = target // Include the target in the clear list

        for( k=0;k < clear_select_list.length;k++){
            obj = $(clear_select_list[k]);
            if( obj.type.match("select") ){
                len = obj.childNodes.length;
                for( var i=0;i < len;i++){obj.removeChild(obj.firstChild);}
            }
        }

        // Populate the new options
        for(i=0;i < opts_array.length;i++){
            o = document.createElement( "option" );
            o.appendChild( document.createTextNode( opts_array[i][0] ) );
            o.setAttribute( "value", opts_array[i][1] );
            obj.appendChild(o);
        }
    }
}

function overlay() {
  modal = document.getElementById("overlay");
  modal.style.visibility = (modal.style.visibility == "visible") ? "hidden" : "visible";
}

