; Script LISP generar-gml v1.0
; Autores: Castell Cebolla, Álvaro Álvarez, Pepe Alacreu
; (c) 2016 http://generador-gml.blogspot.com.es/

; LIMITACIÓN DE RESPONSABILIDAD: Los autores no proporciona soporte de este script. El script se proporciona tal cual es sin garantía de ningún tipo. Los autores  además se eximen de toda garantía implícita incluyendo, sin limitación, cualquier garantía de comerciabilidad o de idoneidad para un propósito en particular. Usted asume todo el riesgo surgido por el uso o el funcionamiento del script y su documentación. En ningún caso serán sus autores, o cualquier otra persona involucrada en la creación, producción o distribución del script responsable por los daños y perjuicios (incluyendo, sin limitación, daños por pérdida de beneficios empresariales, interrupción de negocio, pérdida de información comercial u otra pérdida pecuniaria) derivados del uso o la incapacidad de usar el script y su documentación, incluso si no ha sido advertido de la posibilidad de tales daños.

; LICENCIA PÚBLICA GENERAL (GNU GPL v3): Copyright (C) 2016 http://generador-gml.blogspot.com.es/ . Este programa es software libre. Puede redistribuirlo y/o modificarlo bajo los términos de la Licencia Pública General de GNU tal como está publicada por la Free Software Foundation, bien de la versión 3 de dicha Licencia o bien (según su elección) de cualquier versión posterior. Este programa se distribuye con la esperanza de que sea útil, pero SIN NINGUNA GARANTÍA, incluso sin la garantía MERCANTIL implícita o sin garantizar la CONVENIENCIA PARA UN PROPÓSITO PARTICULAR. Véase la Licencia Pública General de GNU para más detalles. Usted debería haber recibido una copia de la Licencia Pública General junto con este programa. Si no ha sido así, consulte <http://www.gnu.org/licenses>.


(DEFUN c:gml28()
(gml 28)
)
(DEFUN c:gml29()
(gml 29)
)
(DEFUN c:gml30()
(gml 30)
)
(DEFUN c:gml31()
(gml 31)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(DEFUN gml(parametro_huso / HUSO plantilla1 plantilla2 plantilla3 plantilla4 camino_fichero nombre_fichero_escritura recinto_parcela mensaje_final nombre_entidad lista_datos_entidad)
(DEFUN gml(parametro_huso)
; Comprobar parámetro huso pasado al programa
    (print parametro_huso)
    (setq parametro_huso_valido "T")
    (if (not parametro_huso) (setq parametro_huso 30)) ; 30 por defecto
    (if (not (or (= parametro_huso 28) (= parametro_huso 29) (= parametro_huso 30) (= parametro_huso 31)))
         (setq parametro_huso_valido nil)
    ) ; if not
    (if (= parametro_huso_valido nil)
        (progn
            (alert "Huso proporcionado incorrecto, debe ser 28, 29, 30 o 31, saliendo...")
            (exit)
        )
    )
    (alert (strcat "Huso seleccionado: " (itoa parametro_huso)))
    (setq HUSO (itoa parametro_huso))

    (setq plantilla1 "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<!--Parcela Catastral para entregar a la D.G. del Catastro.-->
<!--Generado por chapulincatastral https://github.com/chapulincatastral/generador-gml/ -->
<gml:FeatureCollection xmlns:gml=\"http://www.opengis.net/gml/3.2\" xmlns:gmd=\"http://www.isotc211.org/2005/gmd\" xmlns:ogc=\"http://www.opengis.net/ogc\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:cp=\"urn:x-inspire:specification:gmlas:CadastralParcels:3.0\" xmlns:base=\"urn:x-inspire:specification:gmlas:BaseTypes:3.2\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"urn:x-inspire:specification:gmlas:CadastralParcels:3.0 http://inspire.ec.europa.eu/schemas/cp/3.0/CadastralParcels.xsd\" gml:id=\"ES.LOCAL.CP.%CODIGOPARCELA%\">
   <gml:featureMember>
      <cp:CadastralParcel gml:id=\"ES.%TIPO_DE_PARCELA%.CP.%CODIGOPARCELA%\">
<!-- Superficie de la parcela en metros cuadrados. Tiene que coincidir con la calculada con las coordenadas.-->
         <cp:areaValue uom=\"m2\">AREAPARCELA</cp:areaValue>
         <cp:beginLifespanVersion xsi:nil=\"true\" nilReason=\"other:unpopulated\"></cp:beginLifespanVersion>
<!-- Geometria en formato GML       -->
         <cp:geometry>
<!-- srs Name codigo del sistema de referencia en el que se dan las coordenadas, que debe coincidir con el de la cartografia catastral -->
<!-- el sistema de referencia de la cartografía catastral varía según provincia, siendo accesible desde la consulta de cartografía en Sede -->  
           <gml:MultiSurface gml:id=\"MultiSurface_ES.%TIPO_DE_PARCELA%.CP.%CODIGOPARCELA%\" srsName=\"urn:ogc:def:crs:EPSG::258%HUSOPARCELA%\"> 
             <gml:surfaceMember>
               <gml:Surface gml:id=\"Surface_ES.%TIPO_DE_PARCELA%.CP.%CODIGOPARCELA%\" srsName=\"urn:ogc:def:crs:EPSG::258%HUSOPARCELA%\">
                  <gml:patches>
                    <gml:PolygonPatch>")
(setq plantilla2 "
                      <gml:exterior>
                        <gml:LinearRing>
<!-- Lista de coordenadas separadas por espacios o en lineas diferentes    -->
                          <gml:posList srsDimension=\"2\">%COOR_PARCELA%</gml:posList>
                        </gml:LinearRing>
                      </gml:exterior>")
(setq plantilla3 "
                      <gml:interior>
                        <gml:LinearRing>
<!-- Lista de coordenadas separadas por espacios o en lineas diferentes    -->
                          <gml:posList srsDimension=\"2\">%COOR_ISLA%</gml:posList>
                        </gml:LinearRing>
                         </gml:interior>")
(setq plantilla4 "             
                    </gml:PolygonPatch>
                  </gml:patches>
                </gml:Surface>
              </gml:surfaceMember>
            </gml:MultiSurface>
         </cp:geometry>
         <cp:inspireId>
           <base:Identifier>
<!-- Identificativo local de la parcela. Solo puede tener letras y numeros. Se recomienda (pero no es necesario) poner siempre un digito de control, por ejemplo utilizando el algoritmo del NIF.-->
             <base:localId>%CODIGOPARCELA%</base:localId>
             <base:namespace>ES.%TIPO_DE_PARCELA%.CP</base:namespace>
           </base:Identifier>
         </cp:inspireId>
         <cp:label/>
<!--Siempre en blanco, ya que todavia no ha sido dada de alta en las bases de datos catastrales.-->
         <cp:nationalCadastralReference/>
      </cp:CadastralParcel>
   </gml:featureMember>
<!-- Si se desea entregar varias parcelas en un mismo fichero, se pondra un nuevo featureMember para cada parcela -->
</gml:FeatureCollection>
")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFUN proporcionar_fichero_escritura ( / directorio_correcto nombre_fichero_escritura fichero_prueba_escritura)
    ;;(getfiled "Guardar fichero como... " (getvar 'MYDOCUMENTSPREFIX) "txt" 1)
	(setq directorio_correcto "F")
	(while (= directorio_correcto "F")
		(setq nombre_fichero_escritura (getfiled "Guardar fichero como... " (getvar 'MYDOCUMENTSPREFIX) "txt" 1))
		; Comprobar permisos de escritura
		(if (null (setq fichero_prueba_escritura (open nombre_fichero_escritura "w")))
			(progn
				(alert "Error: No se puede escribir en el directorio seleccionado, elige otro.")
				;(exit)
				); then
			(progn
				(setq directorio_correcto "T") 
				(close fichero_prueba_escritura)
				;;(vl-file-delete nombre_fichero_escritura); borramos el fichero de prueba
			); else
		);if
	);while
	nombre_fichero_escritura
); defun proporcionar_fichero_escritura
;
(defun coordenada_toasc (una_coordenada)
    (strcat (rtos (cadr una_coordenada) 2 2) " " (rtos (caddr una_coordenada) 2 2) " ")
); defun coordenada_toasc
(defun coordenada_toasc2 (una_coordenada)
    (strcat (rtos (car una_coordenada) 2 2) " " (rtos (cadr una_coordenada) 2 2) " ")
); defun coordenada_toasc2
;
;; (setq objetos (ssget "_WP" perimetro_entidad))
(defun analiza_entidad_interior_texto (objetos / numero_entidades numero_entidad encontrado nombre_entidad lista_datos_entidad)
    (setq     numero_entidades (sslength objetos))
    (setq     numero_entidad 0 )
    (setq     encontrado -1)
        (while (and (<  numero_entidad numero_entidades) (= encontrado -1))
            (setq nombre_entidad (ssname objetos numero_entidad))
            (setq lista_datos_entidad (entget nombre_entidad))
            (if  (or (= (cdadr  lista_datos_entidad) "TEXT") (= (cdadr  lista_datos_entidad) "MTEXT"))
                (setq encontrado numero_entidad)
                (setq numero_entidad (+ 1 numero_entidad))
            )
        )
    (if (> encontrado -1) (mapcar 'cdr (vl-remove-if-not '(lambda (x) (= 1 (car x))) lista_datos_entidad)))
); defun analiza_entidad_interior_texto
(defun analiza_entidad_interior_recintos (objetos / numero_entidades numero_entidad nombre_entidad lista_datos_entidad recintos_interiores AREA_R)
    (setq     numero_entidades (sslength objetos))
    (setq     numero_entidad 0 )
    (setq recintos_interiores '())
    (repeat numero_entidades
        (setq  nombre_entidad (ssname objetos numero_entidad))
        (setq  lista_datos_entidad (entget nombre_entidad))
        (setq  numero_entidad (+ 1 numero_entidad))
        ;;'((0 . "POLYLINE,LWPOLYLINE") (70 . 1))
        (if (and (or (= (cdadr  lista_datos_entidad) "LWPOLYLINE")
			         (= (cdadr  lista_datos_entidad) "POLYLINE"))
            (= (cdar (vl-remove-if-not '(lambda (x) (= 70 (car x)) ) lista_datos_entidad)) 1))
            (progn
		    (command "_AREA" "_E" nombre_entidad)
            (setq AREA_R (getvar "AREA") )
            (setq recintos_interiores (cons (list AREA_R (mapcar 'cdr (vl-remove-if-not '(lambda (x) (= 10 (car x))) lista_datos_entidad))) recintos_interiores))
            )
        )
    )    
    recintos_interiores
); defun analiza_entidad_interior_recintos
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq recinto_parcela (ssget '((0 . "POLYLINE,LWPOLYLINE") (70 . 1))))
;; (setq nombre_una_entidad (ssname recinto_parcela  0))
(defun analiza_entidad_seleccionada (nombre_una_entidad / lista_datos_entidad perimetro_entidad objetos_interiores NOMBRE_RECINTO AREA_R islas)
    (setq lista_datos_entidad (entget nombre_una_entidad))  
    (setq perimetro_entidad (mapcar 'cdr (vl-remove-if-not '(lambda (x) (= 10 (car x))) lista_datos_entidad)))
    ;;(setq objetos (ssget "_WP" perimetro_entidad))
    (if (setq objetos_interiores (ssget "_WP" perimetro_entidad))
      (progn
      (setq NOMBRE_RECINTO (analiza_entidad_interior_texto objetos_interiores))    
      (setq islas (analiza_entidad_interior_recintos objetos_interiores))))
    (command "_AREA" "_E" nombre_una_entidad)
    (setq AREA_R (getvar "AREA") )
    ;; (setq AREA_EXT (rtos (getvar "AREA") 2 0))
    ;; (vl-list-length islas)
    (list (car NOMBRE_RECINTO) AREA_R perimetro_entidad islas)
  ;; (caar islas) ; primera superficie; (caadr islas) ; segunda ; (caaddr islas) ; tercera
) ; defun analiza_entidad_seleccionada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun generar_xml (recinto_actual huso_actual )
    (setq AREA_TXT (rtos (get_area recinto_actual) 2 0))
    (setq TIPO_PARCELA (get_tipo_parcela recinto_actual))
    (setq NOMBRE_PARCELA (get_nombre_parcela recinto_actual))
    (setq COOR_PARCELA (get_recinto_exterior recinto_actual))
    ;; generamos cabecera y el recinto exterior      
    (setq xml_gml (vl-string-subst huso_actual "%HUSOPARCELA%"
		(vl-string-subst huso_actual "%HUSOPARCELA%"
		  (vl-string-subst AREA_TXT "AREAPARCELA"
		    (vl-string-subst COOR_PARCELA "%COOR_PARCELA%"
		        (vl-string-subst NOMBRE_PARCELA "%CODIGOPARCELA%"
		        (vl-string-subst NOMBRE_PARCELA "%CODIGOPARCELA%"
		        (vl-string-subst NOMBRE_PARCELA "%CODIGOPARCELA%"
		        (vl-string-subst NOMBRE_PARCELA "%CODIGOPARCELA%"
		            (vl-string-subst TIPO_PARCELA "%TIPO_DE_PARCELA%"
		            (vl-string-subst TIPO_PARCELA "%TIPO_DE_PARCELA%"
		            (vl-string-subst TIPO_PARCELA "%TIPO_DE_PARCELA%"
			        (vl-string-subst TIPO_PARCELA "%TIPO_DE_PARCELA%"
			            (strcat plantilla1 plantilla2 ))))))))))))))
    ;; si hay recintos interiores; los añadimos
    (setq islas (get_islas recinto_actual))
    (while (car islas )
      (setq xml_gml
    	 (strcat xml_gml
	    	(vl-string-subst (get_recinto_interior (car islas))
		                 "%COOR_ISLA%"
		                 plantilla3)))
    (setq islas (cdr islas)))
;; cerramos el xml
    (setq xml_gml
	 (strcat xml_gml
		(vl-string-subst NOMBRE_PARCELA "%CODIGOPARCELA%"
		            (vl-string-subst TIPO_PARCELA "%TIPO_DE_PARCELA%"
		                 plantilla4))))
xml_gml
); defun generar_xml
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
(defun es_digito (char)
	  (or (= char "0")
	      (= char "1")
	      (= char "2")
	      (= char "3")
	      (= char "4")
	      (= char "5")
	      (= char "6")
	      (= char "7")
	      (= char "8")
	      (= char "9"))
);defun es_digito
(defun es_referencia (cadena)
  (and (= (strlen cadena) 14)
	   (es_digito (substr cadena 1 1)))
);defun es_referencia
  
(defun get_nombre_parcela (recinto)
    (if (null (car recinto))
        "1A"
        (car recinto))
);defun get_nombre_parcela
(defun get_tipo_parcela (recinto)
    (if (and  (car recinto) (es_referencia (car recinto)))
        "SDGC"
        "LOCAL")
);
  
(defun get_area (recinto)
    (- (cadr recinto) (get_area_islas recinto))
);
  
(defun get_recinto_exterior (recinto)
    (strcat (apply 'strcat (mapcar 'coordenada_toasc2 (caddr recinto))) 
            (coordenada_toasc2 (car (caddr recinto))))
);
(defun get_recinto_interior (recinto)
    (strcat (apply 'strcat (mapcar 'coordenada_toasc2 (cadr recinto))) 
            (coordenada_toasc2 (car (cadr recinto))))
);
  
(defun get_islas (recinto)
    (setq islas (cadddr recinto))
);
(defun get_area_islas (recinto / islas area_islas)
    ;;(setq recinto (cadr lista_chapulin))
    (setq islas (get_islas recinto))
    (setq area_islas 0)
    (while (caar islas)
      (setq area_islas (+ (caar islas) area_islas))
      (setq islas (cdr islas)))
    area_islas
);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; seleccionemos las recintos de la RGGA
;; Sólo permite seleccionar polilíneas cerradas previamente con el comando POLCONT
(setq recinto_parcela (ssget '((0 . "POLYLINE,LWPOLYLINE") (70 . 1))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq     numero_entidades_recinto (sslength recinto_parcela))
(setq     numero_entidad 0 )
(setq lista_chapulin nil)
(repeat numero_entidades_recinto
    (setq lista_chapulin (cons (analiza_entidad_seleccionada (ssname recinto_parcela numero_entidad)) lista_chapulin)
          numero_entidad (+ 1 numero_entidad)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Lista Chapulin -> (recinto recinto ...)
; recinto        -> (NOMBRE_RECINTO  AREA  perimetro islas)
; perimetro      -> ((coordenadaX coordenadaY) (coordenadaX coordenadaY) ...)
; islas          -> (isla isla ...)
; isla           -> (AREA perimetro)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(setq nombres (mapcar 'car lista_chapulin))
;(setq areas (mapcar 'cadr lista_chapulin))
;(setq perimetros (mapcar 'caddr lista_chapulin))
;(setq islas (mapcar 'cadddr  lista_chapulin))
;(mapcar 'coordenada_toasc2 (mapcar 'cadr  perimetros))  
;(mapcar 'coordenada_toasc2 (mapcar 'caddr  perimetros))
;;;;;;;;;;;;;;;;;;;;
;(get_nombre_parcela (car lista_chapulin))
;(get_nombre_parcela (cadr lista_chapulin))
;(get_nombre_parcela (caddr lista_chapulin))
;(get_tipo_parcela (car lista_chapulin))
;(get_tipo_parcela (cadr lista_chapulin))
;(get_tipo_parcela (caddr lista_chapulin))
;(get_area (car lista_chapulin))
;(get_area (cadr lista_chapulin))
;(get_area (caddr lista_chapulin))
;(get_recinto_exterior (car lista_chapulin))
;(get_recinto_exterior (cadr lista_chapulin))
;(get_islas (car lista_chapulin))
;(get_islas (cadr lista_chapulin))
;(get_islas (caddr lista_chapulin))
;(get_area_islas  (car lista_chapulin))
;(get_area_islas  (cadr lista_chapulin))
;(get_area_islas  (caddr lista_chapulin))


  
;; Muestra el número de entidades seleccionadas
(alert (strcat "Entidades seleccionadas=" (itoa (vl-list-length lista_chapulin))))

(setq nombre_fichero_escritura (proporcionar_fichero_escritura))
  
;; generamos los .gml ; uno por recinto

(setq nombre_directorio (vl-filename-directory nombre_fichero_escritura))
(setq mensaje_final 
    (strcat "Directorio usado: " 
        nombre_directorio
        "\n\n   Ficheros generados:"))
(setq i 1)
(while (car lista_chapulin)
    (setq nombre_fichero_escritura_sec 
        (strcat (substr nombre_fichero_escritura 1 (- (strlen nombre_fichero_escritura) 4))
        "_"
        (itoa i) ".gml"))
    (setq fichero_escritura (open nombre_fichero_escritura_sec "w"))
    (princ (generar_xml (car lista_chapulin) HUSO ) fichero_escritura)
    (close fichero_escritura)
    (setq mensaje_final
	   (strcat mensaje_final "\n\t "
		   (substr nombre_fichero_escritura_sec  (+ (strlen nombre_directorio) 2))))
    (setq mensaje_final
	   (strcat mensaje_final
		   "\n\t\t Nombre: "
		   (get_nombre_parcela (car lista_chapulin))))
    (setq mensaje_final
	   (strcat mensaje_final
		   "\n\t\t Tipo: "
           (get_tipo_parcela (car lista_chapulin))))
    (setq mensaje_final
	   (strcat mensaje_final 
		   "\n\t\t Area: "
		   (rtos (get_area (car lista_chapulin)) 2 0)))
    (setq mensaje_final
	   (strcat mensaje_final
		   "\n\t\t Islas: "
		   (itoa (vl-list-length(get_islas (car lista_chapulin))))))    
    (setq i (+ i 1))
    (setq lista_chapulin (cdr lista_chapulin))
); while

(alert mensaje_final)
;; graba en el fichero .txt los datos mostrados por pantalla
(setq fichero_escritura (open nombre_fichero_escritura "w"))
(princ mensaje_final fichero_escritura)
(close fichero_escritura)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
); defun gml
