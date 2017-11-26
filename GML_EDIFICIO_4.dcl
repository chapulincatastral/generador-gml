GML_EDIFICIO : dialog {
label = "Parámetros de GML e Informe de Edificio";

: column {
///////////////////////////////////////
:boxed_row {
label = "Certificación de final de obra";
    : column {
    : radio_column {
      label = "Estado de las de obras";
      key = "obra"; 	
    
    : radio_button {
      label = "En construcción, sin certi.";
      key = "obra_sin_acabar";
    } 	
    : radio_button {
      label = "Con certificado";
      key = "obra_acabada";
    }	
    }
    }
    : boxed_column {
    label = "Cumplimentar sólo si se tiene el certif. de final de obra";
    :row {
    : edit_box {
      key = "fecha_inicio";
      label = "la fecha de inicio de obras";
      edit_width = 10;
    }}
    :row {
    : edit_box {
      key = "fecha_fin";
      label = "la fecha de final de obra del certificado";
      edit_width = 10;
      //value = "DD-MM-AAAA";
    }}
    }
 }
 /////////////////////////////////////////////////
:boxed_row {
    : boxed_column {
    label = "Identificación del edificio según el protocolo";
    : edit_box {
      key = "referencia_edificio";
      label = "Identificador del edificio";
      edit_width = 10;
      //value = "";
    }
    }
    : boxed_column {
    label = "Sistema de referencia y huso";
    : row {
      : popup_list {
        key = "lista_huso";
        label = "Sist. ref. y huso";
        //value = 2;
        fixed_width_font = false;
        width = 10;
      }
    }
    : row {
    : edit_box {
      key = "precision";
      label = "Precisión de las coordenadas en metros";
      edit_width = 2;
      //value = "10";
    }
    }
    }
}
////////////////////////////////////////////////////////////////
:boxed_row {
label = "Si lo conoce, indique el uso principal al que se destina el edificio (Vivienda, comercios,..)";
    : column {
      : popup_list {
        key = "lista_uso";
        label = "Uso principal";
        fixed_width_font = false;
        width = 7;
        //value = 0;
      }}
      
    : column {
    }
}
////////////////////////////////////////////////////////////////
:boxed_row {
    : boxed_column {
    label = "Inmuebles = viviendas + garajes + locales";
    : row {
    : edit_box {
      key = "inmuebles";
      label = "Número Inmuebles (= v+g+l)";
      edit_width = 3;
      //value = "";
    }}
    : row {
    : edit_box {
      key = "viviendas";
      label = "Número de viviendas";
      edit_width = 3;
      //value = "";
    }}
    }	
    : boxed_column {
    label = "Alturas y superfice computable según normativa";
    : row {
    : edit_box {
      key = "plantas";
      label = "Número de plantas sobre rasante";
      edit_width = 3;
      //value = "";
    }}
    : row {
    : edit_box {
      key = "superficie";
      label = "Superficie construida computable (m² )";
      edit_width = 5;
      //value = "";
    }}
    }	
}
////////////////////////////////////////////////////////////////
:boxed_row {
label = "Firma del Informe";
    : column {
      : row {
        : edit_box {
          key = "lugar_y_fecha";
          label = "Lugar y Fecha";
          edit_width = 40;
          //value = "";
        }
      }
      : row {
        : edit_box {
          key = "antefirma";
          label = "Cargo o título del firmante";
          edit_width = 40;
          //value = "";
        }
      }
      : row {
        : edit_box {
          key = "posfirma";
          label = "Nombre del Firmante";
          edit_width = 40;
          //value = "";
        }
      }
    }
}
////////////////////////////////////////////////////////////////
: boxed_row {
    : button {
      key = "accept";
      label = " Aceptar ";
      is_default = true;
    }
    : button {
      key = "cancel";
      label = " Cancelar ";
      is_default = false;
      is_cancel = true;
    }
    : button {
      key = "help";
      label = " Ayuda ";
      is_default = false;
    }
}
}
}