;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; Script AutoLisP generar-gml.lsp
;;;;;;;;;;;
;;;;;;;;;;; LIMITACION DE RESPONSABILIDAD: No se proporciona soporte de este script. El script se proporciona tal cual es sin responsabilidad ni garantía de ningún tipo. Los autores se eximen de toda garantia implícita incluyendo, sin limitación, cualquier garantía de comerciabilidad o de idoneidad para un propósito en particular. Usted asume todo el riesgo surgido por el uso o el funcionamiento del script y su documentación. En ningún caso serán sus autores, o cualquier otra persona involucrada en la creación, producción o distribución del script responsable por los daños y perjuicios (incluyendo, sin limitación, daños por pérdida de beneficios empresariales, interrupción de negocio, pérdida de información comercial u otra perdida pecuniaria) derivados del uso o la incapacidad de usar el script y su documentación, incluso si no ha sido advertido de la posibilidad de tales daños.
;;;;;;;;;;;
;;;;;;;;;;; LICENCIA PÚBLICA GENERAL (GNU GPL v3): Copyright (C) 2016 ChapulinCatastral https://github.com/chapulincatastral/ . Este programa es software libre. Puede redistribuirlo y/o modificarlo bajo los términos de la Licencia Pública General de GNU tal como está publicada por la Free Software Foundation, bien de la versión 3 de dicha Licencia o bien (según su elección) de cualquier versión posterior. Este programa se distribuye con la esperanza de que sea útil, pero SIN NINGUNA GARANTÍA, incluso sin la garantía MERCANTIL implícita o sin garantizar la CONVENIENCIA PARA UN PROPÓSITO PARTICULAR. Véase la Licencia Pública General de GNU para más detalles. Usted debería haber recibido una copia de la Licencia Pública General junto con este programa. Si no ha sido así, consulte <http://www.gnu.org/licenses>.
;;;;;;;;;;;
;;;;;;;;;;; version: 1.0.0; fecha: 10.2016; Autor: Castell Cebolla, Alvaro Alvarez, Pepe Alacreu; Modificacion: Genera GML de Parcela Catastral
;;;;;;;;;;; version: 2.0.0; fecha: 11.2016; Autor: Alvaro; Modificacion: soporte para; islas, identificador de parcela y tipo identificador de parcela
;;;;;;;;;;; version: 3.0.0; fecha: 12.2016; Autor: Alvaro; Modificacion: se añade GMLe que genera GML de edificio.
;;;;;;;;;;; version: 3.0.1; fecha: 12.2016; Autor: Alvaro, Castell ;  Se filtran las "entidades arco" en las polilíneas cerradas.
;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Plantillas de fichero GML de Edificio
(setq fichero_gml_1 "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>
<!--Instancia de ejemplo de edificio.-->
<gml:FeatureCollection gml:id=\"ES.SDGC.BU\" xmlns:ad=\"urn:x-inspire:specification:gmlas:Addresses:3.0\" xmlns:base=\"urn:x-inspire:specification:gmlas:BaseTypes:3.2\" xmlns:bu-base=\"http://inspire.jrc.ec.europa.eu/schemas/bu-base/3.0\" xmlns:bu-core2d=\"http://inspire.jrc.ec.europa.eu/schemas/bu-core2d/2.0\" xmlns:bu-ext2d=\"http://inspire.jrc.ec.europa.eu/schemas/bu-ext2d/2.0\" xmlns:cp=\"urn:x-inspire:specification:gmlas:CadastralParcels:3.0\" xmlns:el-bas=\"http://inspire.jrc.ec.europa.eu/schemas/el-bas/2.0\" xmlns:el-cov=\"http://inspire.jrc.ec.europa.eu/schemas/el-cov/2.0\" xmlns:el-tin=\"http://inspire.jrc.ec.europa.eu/schemas/el-tin/2.0\" xmlns:el-vec=\"http://inspire.jrc.ec.europa.eu/schemas/el-vec/2.0\" xmlns:gco=\"http://www.isotc211.org/2005/gco\" xmlns:gmd=\"http://www.isotc211.org/2005/gmd\" xmlns:gml=\"http://www.opengis.net/gml/3.2\" xmlns:gmlcov=\"http://www.opengis.net/gmlcov/1.0\" xmlns:gn=\"urn:x-inspire:specification:gmlas:GeographicalNames:3.0\" xmlns:gsr=\"http://www.isotc211.org/2005/gsr\" xmlns:gss=\"http://www.isotc211.org/2005/gss\" xmlns:gts=\"http://www.isotc211.org/2005/gts\" xmlns:swe=\"http://www.opengis.net/swe/2.0\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://inspire.jrc.ec.europa.eu/schemas/bu-ext2d/2.0 http://inspire.ec.europa.eu/draft-schemas/bu-ext2d/2.0/BuildingExtended2D.xsd\">
	<gml:featureMember>
		<bu-ext2d:Building gml:id=\"ES.LOCAL.1\">
			<bu-core2d:beginLifespanVersion xsi:nil=\"true\" nilReason=\"other:unpopulated\"/>
<!--PONER AQUI SI ES FUNCIONAL O EN CONSTRUCCION.-->
			<bu-core2d:conditionOfConstruction>%OBRA%</bu-core2d:conditionOfConstruction>")
(setq fichero_gml_2 "\n			<bu-core2d:dateOfConstruction>        
<!--FECHA DE CONSTRUCCION SI ES FUNCIONAL.-->
				<bu-core2d:DateOfEvent>
					<bu-core2d:beginning>%FECHA-INICIO%T00:00:00</bu-core2d:beginning>
					<bu-core2d:end>%FECHA-FIN%T00:00:00</bu-core2d:end>
				</bu-core2d:DateOfEvent>
			</bu-core2d:dateOfConstruction>")
(setq fichero_gml_3 "\n			<bu-core2d:endLifespanVersion xsi:nil=\"true\" nilReason=\"other:unpopulated\"/>
			<bu-core2d:inspireId>
				<base:Identifier>
<!--IDENTIFICATIVO DE LA FINCA Y EDIFICIO.-->
					<base:localId>%REFERENCIA-PARCELA%</base:localId>
					<base:namespace>ES.LOCAL.BU</base:namespace>
				</base:Identifier>
			</bu-core2d:inspireId>
			<bu-ext2d:geometry>
				<bu-core2d:BuildingGeometry>
					<bu-core2d:geometry>
<!--EL SRSNAME ES EL SISTEMA DE REFERENCIA DE LAS COORDENADAS. DEBE COINCIDIR CON EL DE LA CARTOGRAFIA CATASTRAL DEL MUNICIPIO.-->
						<gml:Surface gml:id=\"surface_ES.LOCAL.1\" srsName=\"urn:ogc:def:crs:%HUSO%\">
							<gml:patches>")
(setq fichero_gml_PolygonPatch "\n							<gml:PolygonPatch>
							<gml:exterior>
								<gml:LinearRing>
<!--LISTA DE COORDENADAS-->
									<gml:posList>
%COORDENADAS% 
									</gml:posList>
								</gml:LinearRing>
							</gml:exterior>
							</gml:PolygonPatch>")
(setq fichero_gml_4 "\n							</gml:patches>
						</gml:Surface>
					</bu-core2d:geometry>
<!--AQUI HAY QUE PONER LA PRECISION REAL DE LAS COORDENADAS-->
					<bu-core2d:horizontalGeometryEstimatedAccuracy uom=\"m\">%PRECISION%</bu-core2d:horizontalGeometryEstimatedAccuracy>
					<bu-core2d:horizontalGeometryReference>footPrint</bu-core2d:horizontalGeometryReference>
					<bu-core2d:referenceGeometry>true</bu-core2d:referenceGeometry>
				</bu-core2d:BuildingGeometry>
			</bu-ext2d:geometry>")
(setq fichero_gml_5 "\n<!-- USO PRINCIPAL, SI ES CONOCIDO-->
			<bu-ext2d:currentUse>%USO%</bu-ext2d:currentUse>")
(setq fichero_gml_6 "\n<!-- NUMERO DE INMUEBLES-->
			<bu-ext2d:numberOfBuildingUnits>%INMUEBLES%</bu-ext2d:numberOfBuildingUnits>
<!-- NUMERO DE VIVIENDAS-->
			<bu-ext2d:numberOfDwellings>%VIVIENDAS%</bu-ext2d:numberOfDwellings>
<!-- NUMERO DE PLANTAS SOBRE RASANTE-->
			<bu-ext2d:numberOfFloorsAboveGround>%PLANTAS%</bu-ext2d:numberOfFloorsAboveGround>
			<bu-ext2d:officialArea>
				<bu-ext2d:OfficialArea>
					<bu-ext2d:officialAreaReference>grossFloorArea</bu-ext2d:officialAreaReference>
<!-- SUPERFICIE CONSTRUIDA TOTAL EN M2-->
					<bu-ext2d:value uom=\"m2\">%SUPERFICIE%</bu-ext2d:value>
				</bu-ext2d:OfficialArea>
			</bu-ext2d:officialArea>
		</bu-ext2d:Building>
	</gml:featureMember>
</gml:FeatureCollection>")
); progn ; Plantilla GML de Edificio
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Plantillas de fichero GML de RGA
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
<!-- el sistema de referencia de la cartografÃ­a catastral varÃ­a segÃºn provincia, siendo accesible desde la consulta de cartografÃ­a en Sede -->  
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

); progn Plantilla GML de RGA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Funciones Comunes
(defun str-pos(str c / i l ls lc)
  (setq i 1)
  (setq ls(strlen str))
  (setq lc(strlen c))
  (setq l(1+(- ls lc)))
  (while(and(<= i l)(/=(substr str i lc)c))
    (setq i(1+ i))
  )
  (if(<= i l)i)
) 
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
(defun str-count(str tok / res)
  (setq res 0)
  (while(>(strlen str)0)
    (if(=(str-pos str tok)1)
      (progn
        (setq res(1+ res))
        (setq str(substr str(1+(strlen tok))))
      )
      (progn
        (setq str(substr str 2))
      )
    )
  )
  res
);defun str-count 
(defun real_ingles (cadena)
  (vl-string-subst "." "," cadena)
)
(defun es_real_positivo (cadena / i )
  (setq i 1)
  (if (= (substr cadena 1 1) "+") (setq cadena (substr cadena 2))) 
  (while (and (<= i  (strlen cadena)) 
              (or (es_digito (substr cadena i 1))
                  (= (substr cadena i 1) ",")
                  (= (substr cadena i 1) ".")))
    (setq i (+ i 1))
   )
   (and (> i (strlen cadena)) 
        (and (< (+ (str-count cadena ",") (str-count cadena ".")) 2))
        (> (atof (vl-string-subst "." "," cadena)) 0.0))
);defun es_real_positivo
(defun es_entero_positivo (cadena / i )
  (setq i 1)
  (if (= (substr cadena 1 1) "+") (setq cadena (substr cadena 2)))
  (while (and (<= i  (strlen cadena)) 
              (es_digito (substr cadena i 1)))
    (setq i (+ i 1))
   )
   (and (> i (strlen cadena)) (> (atoi cadena) 0))
);defun es_entero_positivo
(defun es_fecha (cadena)
   (and (<= (strlen cadena) 10)
        (>= (strlen cadena) 8)
        (=  (str-count cadena "-") 2)
        (setq posicion1 (str-pos  cadena "-"))
        (setq posicion2 (str-pos (substr cadena (+ posicion1 1)) "-" ))
        (setq posicion2 (+ posicion1 posicion2 ))
        (es_entero_positivo (substr cadena 1 (- posicion1 1)))
        (es_entero_positivo (substr cadena (+ posicion1 1) (- posicion2 posicion1 1)))
        (es_entero_positivo (substr cadena (+ posicion2 1)(-  (strlen cadena) posicion2 )))
        (<=  (atoi (substr cadena 1 (- posicion1 1))) 31)
        (<=  (atoi (substr cadena (+ posicion1 1) (- posicion2 posicion1 1))) 12)
        (<=  (atoi (substr cadena (+ posicion2 1)(-  (strlen cadena) posicion2 ))) 2050)
        (>  (atoi (substr cadena (+ posicion2 1)(-  (strlen cadena) posicion2 ))) 1900)
   )
);defun es_fecha
(defun fecha_en_ingles (fecha_txt)  
  (if (= (str-pos fecha_txt "-") 2) (setq fecha_txt (strcat "0" fecha_txt)))
  (if (= (strlen  fecha_txt) 9) (setq fecha_txt (strcat  (substr fecha_txt 1 3) "0" (substr fecha_txt 4))))
  (setq posicion1 (str-pos fecha_txt "-"))
  (setq posicion2 (str-pos (substr fecha_txt (+ posicion1 1)) "-" ))
  (setq posicion2 (+ posicion1 posicion2 ))
  (strcat
        (substr fecha_txt (+ posicion2 1)(-  (strlen fecha_txt) posicion2  ))
        "-"
        (substr fecha_txt (+ posicion1 1) (- posicion2 posicion1 1))
        "-"
        (substr fecha_txt 1 (- posicion1 1)) )
)
(defun coordenada_toasc2 (una_coordenada)
    (strcat (rtos (car una_coordenada) 2 2) " " (rtos (cadr una_coordenada) 2 2) " ")
); defun coordenada_toasc2
(defun proporcionar_fichero_escritura ( extension / directorio_correcto nombre_fichero_escritura fichero_prueba_escritura)
	(setq directorio_correcto "F")
	(while (= directorio_correcto "F")
		(setq nombre_fichero_escritura 
              (getfiled "Guardar fichero edificio como... " 
                        (if (=(substr(getvar "ACADVER")1 2)"14")
                            "C:\\"
                           (getvar 'MYDOCUMENTSPREFIX))
                        extension 1))
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
); progn Funciones Comunes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Funciones Lista ChapulinCatastral
;;;;  Lista Chapulin -> (recinto recinto ...)
;;;;  recinto        -> (NOMBRE_RECINTO  AREA  perimetro islas)
;;;;  perimetro      -> ((coordenadaX coordenadaY) (coordenadaX coordenadaY) ...)
;;;;  islas          -> (isla isla ...)
;;;;  isla           -> (AREA perimetro)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun tiene_arcos (polilyne / i lon )
 (setq arcos (mapcar 'cdr (vl-remove-if-not '(lambda (x) (= 42 (car x))) polilyne)))
 (setq lon (length arcos))
 (setq i 0)
   (while (and (car arcos) (=(car arcos) 0.0))(setq arcos (cdr arcos))(setq i (+ i  1)))
 (< i lon )
); defun tiene_arcos
(defun analiza_entidad_seleccionada (nombre_una_entidad / lista_datos_entidad perimetro_entidad objetos_interiores NOMBRE_RECINTO AREA_R islas)
    (setq lista_datos_entidad (entget nombre_una_entidad))
    (if (tiene_arcos  lista_datos_entidad)
        (progn 
            (alert (strcat "ERROR\n      Un recinto:\"" "exterior" "\"contiene arcos; Por favor conviertalo en sucesión de líneas rectas"))
            (exit)))
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
(defun get_recinto_exterior (recinto)
    (strcat (apply 'strcat (mapcar 'coordenada_toasc2 (caddr recinto))) 
            (coordenada_toasc2 (car (caddr recinto))))
); defun get_recinto_exterior
(defun get_nombre_parcela (recinto)
    (if (null (car recinto))
        "1A"
        (car recinto))
);defun get_nombre_parcela
(defun get_tipo_parcela (recinto)
    (if (and  (car recinto) (es_referencia (car recinto)))
        "SDGC"
        "LOCAL")
);defun get_tipo_parcela  
(defun get_area (recinto)
    (- (cadr recinto) (get_area_islas recinto))
);defun get_area  
(defun get_recinto_exterior (recinto)
    (strcat (apply 'strcat (mapcar 'coordenada_toasc2 (caddr recinto))) 
            (coordenada_toasc2 (car (caddr recinto))))
);defun get_recinto_exterior
(defun get_recinto_interior (recinto)
    (strcat (apply 'strcat (mapcar 'coordenada_toasc2 (cadr recinto))) 
            (coordenada_toasc2 (car (cadr recinto))))
);defun get_recinto_interior  
(defun get_islas (recinto)
    (setq islas (cadddr recinto))
);defun get_islas
(defun get_area_islas (recinto / islas area_islas)
    ;;(setq recinto (cadr lista_chapulin))
    (setq islas (get_islas recinto))
    (setq area_islas 0)
    (while (caar islas)
      (setq area_islas (+ (caar islas) area_islas))
      (setq islas (cdr islas)))
    area_islas
);defun get_area_islas
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
            (if (tiene_arcos  lista_datos_entidad)
            (progn ; then
                (alert (strcat "ERROR\n      Un recinto:\"" "interior" "\"contiene arcos; Por favor conviertalo en sucesión de líneas rectas"))
                (exit))
            (progn
		        (command "_AREA" "_E" nombre_entidad)
                (setq AREA_R (getvar "AREA") )
                (setq recintos_interiores (cons (list AREA_R (mapcar 'cdr (vl-remove-if-not '(lambda (x) (= 10 (car x))) lista_datos_entidad))) recintos_interiores))
            ))
        )
    )    
    recintos_interiores
); defun analiza_entidad_interior_recintos
); progn ; Funciones Lista ChapulinCatastral
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Funciones para generar el GML de Edificio
(defun genera_gml_edificio_txt (lista_chapulin)
  (setq PolygonPatches "")
  (while (car lista_chapulin) 
      (setq PolygonPatches (strcat PolygonPatches
                                    (vl-string-subst (get_recinto_exterior (car lista_chapulin))
                                                     "%COORDENADAS%" fichero_gml_PolygonPatch)))
      (setq lista_chapulin (cdr lista_chapulin)))
  (strcat 
    (if (= obra_txt "obra_acabada" ) 
      (strcat
          (vl-string-subst "functional" "%OBRA%"  fichero_gml_1)
          (vl-string-subst (fecha_en_ingles fecha_fin_txt) "%FECHA-FIN%" 
                            (vl-string-subst (fecha_en_ingles fecha_inicio_txt) "%FECHA-INICIO%" fichero_gml_2)))
      (vl-string-subst "underConstruction" "%OBRA%" fichero_gml_1))
    (vl-string-subst referencia_catastral_txt "%REFERENCIA-PARCELA%"
          (vl-string-subst item_huso "%HUSO%" fichero_gml_3))
    PolygonPatches
    (vl-string-subst (real_ingles precision_txt) "%PRECISION%" fichero_gml_4)
    (if (/= item_uso "") (vl-string-subst item_uso "%USO%" fichero_gml_5) "")
    (vl-string-subst inmuebles_txt "%INMUEBLES%"
      (vl-string-subst viviendas_txt "%VIVIENDAS%"
        (vl-string-subst plantas_txt "%PLANTAS%" 
          (vl-string-subst superficie_txt "%SUPERFICIE%" fichero_gml_6)))))
);defun genera_gml_txt
(defun msg_error ()
  (setq texto "")
  (if (and (= obra_txt "obra_acabada")  (not (es_fecha fecha_inicio_txt))) 
    (setq texto (strcat texto "\nERROR.\n El formato de fecha inicio obras:\"" fecha_inicio_txt "\" no es correcto\n"))
    )
  (if (and (= obra_txt "obra_acabada")  (not (es_fecha fecha_fin_txt))) 
    (setq texto (strcat texto "\nERROR.\n El formato de fecha fin obras:\"" fecha_fin_txt "\" no es correcto\n"))
    )
  (if (= referencia_catastral_txt "")
     (setq texto (strcat texto 
                         "\nERROR.\n El identificador de la parcela no puede estar en blanco\n")))
  (if (=  precision_txt "")
     (setq texto (strcat texto "\nERROR.\n La precisión de las coord. no puede dejarse en blanco\n"))
     (if (not (es_real_positivo precision_txt))
       (setq texto (strcat texto "\nERROR.\n La precisión de las coord.:\"" 
                           precision_txt "\", no es un número real positivo\n"))))
  (if (=  inmuebles_txt "")
     (setq texto (strcat texto "\nERROR.\n El número de inmuebles no puede dejarse en blanco\n"))
     (if (not (es_entero_positivo inmuebles_txt))
       (setq texto (strcat texto "\nERROR.\n El número de inmuebles:\"" 
                           inmuebles_txt "\", no es un número entero positivo\n"))))
  (if (=  viviendas_txt "")
     (setq texto (strcat texto "\nERROR.\n El número de viviendas no puede dejarse en blanco\n"))
     (if (not (es_entero_positivo viviendas_txt))
       (setq texto (strcat texto "\nERROR.\n El número de viviendas:\"" 
                           viviendas_txt "\", no es un número entero positivo\n"))))
  (if (=  plantas_txt "")
     (setq texto (strcat texto "\nERROR.\n El número de plantas no puede dejarse en blanco\n"))
     (if (not (es_entero_positivo plantas_txt))
       (setq texto (strcat texto "\nERROR.\n El número de plantas:\"" 
                           plantas_txt "\", no es un número entero positivo\n"))))
  (if (=  superficie_txt "")
     (setq texto (strcat texto "\nERROR.\n La superficie no puede dejarse en blanco\n"))
     (if (not (es_entero_positivo superficie_txt))
       (setq texto (strcat texto "\nERROR.\n El valor de la superficie:\"" 
                           superficie_txt "\", no es un número entero positivo\n"))))
   (if (and (es_entero_positivo inmuebles_txt)
            (es_entero_positivo viviendas_txt)
            (> (atoi viviendas_txt) (atoi inmuebles_txt)))
       (setq texto (strcat texto "\nERROR.\n El número de inmuebles no puede ser menor que el de viviendas\n")))   
  texto
)
(defun formulario_es_correcto ()
  (and 
    (or (= obra_txt "obra_sin_acabar")
        (and (= obra_txt "obra_acabada") 
             (es_fecha fecha_inicio_txt)
             (es_fecha fecha_fin_txt)))
    (/= referencia_catastral_txt "")
    (es_real_positivo precision_txt)
    (es_entero_positivo inmuebles_txt)
    (es_entero_positivo viviendas_txt)
    (es_entero_positivo plantas_txt)
    (es_entero_positivo superficie_txt)
    (<= (atoi viviendas_txt) (atoi inmuebles_txt))
  )
); defun formulario_es_correcto
(defun genera_fichero_gml_edificio (nombre_fichero lista_chapulin)
(setq fichero_escritura (open nombre_fichero "w"))
    (princ (genera_gml_edificio_txt lista_chapulin) fichero_escritura)
    (close fichero_escritura)
 (alert (strcat "fichero de GML de edificio: \""  
                 nombre_fichero
                 "\"\n   correctamente generado"))
)
(defun saveVars()
  (setq obra_txt (get_tile "obra"))
  (setq fecha_inicio_txt (get_tile "fecha_inicio"))
  (setq fecha_fin_txt (get_tile "fecha_fin"))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq referencia_catastral_txt (get_tile "referencia_catastral"))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq lista_huso_ind (get_tile "lista_huso"))
  (if(= lista_huso_ind "")
    (setq item_huso nil)
    (setq item_huso (nth (atoi lista_huso_ind) lista_huso))
  )
  (setq precision_txt (get_tile "precision"))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq lista_uso_ind (get_tile "lista_uso"))
  (if(= lista_uso_ind "")
    (setq item_uso nil)
    (setq item_uso (nth (atoi lista_uso_ind) lista_uso))
  )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  (setq inmuebles_txt  (get_tile "inmuebles"))
  (setq viviendas_txt  (get_tile "viviendas"))
  (setq plantas_txt    (get_tile "plantas"))
  (setq superficie_txt (get_tile "superficie"))
);defun saveVars
(defun C:gmle()
  (setq lista_chapulin nil) 
  (setq cancelado nil)
  (setq formulario_correcto nil)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Solicitamos seleccionar los recintos del edificio
  (alert "Seleccione los perímetros exteriores del edificio.\n\n NOTA: Sólo se permite seleccionar polílineas previamente cerradas!!")
  ;; Solo se permite seleccionar polilineas  previamente cerradas
  (setq recinto_parcela (ssget '((0 . "POLYLINE,LWPOLYLINE") (70 . 1))))
  ;; generacion de la lista chapulin a partir de los recintos seleccionados
  (setq  numero_entidades_recinto (sslength recinto_parcela))
  (alert (strcat "Número de recintos seleccionados: " (itoa numero_entidades_recinto)))
  (setq  numero_entidad 0 )
  (repeat numero_entidades_recinto
    (setq lista_chapulin (cons (analiza_entidad_seleccionada (ssname recinto_parcela numero_entidad)) lista_chapulin)
          numero_entidad (+ 1 numero_entidad)))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (progn ; poner las variales txt a los valores por defecto del formulario
    (setq obra_txt "obra_sin_acabar")
    (setq fecha_inicio_txt "DD-MM-AAAA")
    (setq fecha_fin_txt "")
    ;
    (setq referencia_catastral_txt "")
    (setq lista_huso(list "EPSG::32628" "EPSG::25829" "EPSG::25830" "EPSG::25831"))
    (setq lista_huso_ind "2") ;; por defecto uso30
    (setq precision_txt "")
    ;
    (setq lista_uso(list "" "1_residential" "2_agriculture" "3_industrial" "4_commerceAndServices"))
    (setq lista_uso_ind "0") ; por defecto uso destino en blanco 
    ;
    (setq inmuebles_txt "")
    (setq viviendas_txt "")
    (setq plantas_txt "")
    (setq superficie_txt "")
  ); progn ; set variales txt a valores por defecto del formulario
  ;; Vamos con el formulario
  (if(not(setq dcl_id (load_dialog "GML_EDIFICIO.dcl")))
    (progn ; then => NO se ha encontrado el fichero .dcl con la definion del formulario
    (alert "El fichero con la definición del formulario no se ha podido cargar,
      añada nombre del directorio donde se encuentra el fichero  GML_EDIFICIO.dcl
      a la lista de directorios: \"Opciones de AutoCad\"->\"Ruta de búsqueda de archivo de soporte\"")
    (exit)
  ); 
    (progn ; else => SI se ha encontrado el fichero .dcl con la definion del formulario
    (while (and (not formulario_correcto) (not cancelado))
      (if (not (new_dialog "GML_EDIFICIO" dcl_id))
        (progn ; then => error en la definicion  del formulario
          (alert "\n\n La definición del formulario \"GML_EDIFICIO \" 
                  no se encuentra en el fichero de definión \"GML_EDIFICIO.dcl\"")
          (exit)
        )
        (progn ; else => definicion del formulario correcta
          (progn ; Rellenamos los campos del formulario con los valores recuperados
                 ; si es la primera vez del while, los valores son "los valores por defecto"
          (action_tile "cancel" "(done_dialog 1)")
          (action_tile "help" "(saveVars)(done_dialog 3)")
          (action_tile "accept" "(saveVars)(done_dialog 2)")
          ;; Valores por defecto del cuadro de dialogo
          (set_tile "obra" obra_txt)
          (set_tile "fecha_inicio" fecha_inicio_txt)
          (set_tile "fecha_fin" fecha_fin_txt)
          ;
          (set_tile "referencia_catastral" referencia_catastral_txt)
          (start_list "lista_huso" 3)
          (mapcar 'add_list lista_huso)
          (end_list)
          (set_tile "lista_huso" lista_huso_ind)
          (set_tile "precision" precision_txt)
          ;
          (start_list "lista_uso" 3)
          (mapcar 'add_list lista_uso)
          (end_list) 
          (set_tile "lista_uso" lista_uso_ind) 
          ;
          (set_tile "inmuebles" inmuebles_txt)
          (set_tile "viviendas" viviendas_txt)
          (set_tile "plantas" plantas_txt)
          (set_tile "superficie" superficie_txt)
          ); Rellenamos los campos del formulario con los valores recuperados
          ; lanzamos el formulario y espamos por una accion          
          (setq ddiag(start_dialog))
          (if (= ddiag 1) ; Ha pulsado cancelar.
            (progn 
            ;(princ "\n \n ...Ha pulsado cancelar. \n ")
            (setq cancelado 'T))
          
            (if (= ddiag 3) ; Ha pulsado ayuda.
              (progn ; then
              ;(princ "\n \n ...Ha pulsado ayuda. \n ")
              (alert "- Se recomienda entrar en la Sede Electrónica del Catastro para:
        . Averiguar el sistema de referencia y huso de las coordenadas  
        . Descargar las coordenadas georreferenciadas del solar donde
          se ubica el edificio.

- El perímetro del edificio ha de corresponderse o estar dentro de la parcela catastral georreferenciada, que previamente ha sido descargada.

- A la Cartografía Catastral se le supone una precisión de 0,1 metros.

- El perímetro del edificio se representa mediante una polilínea cerrada, compuesta por segmentos rectilíneos. No se admiten curvas.

- Si el edificio está compuesto por varios bloques independientes, tendremos varios perímetros.

- Si hay mas de un perímetro, no puede haber contactos entre ellos, por pequeño que sea."))

            
              (if (= ddiag 2) ; Ha pulsado aceptar
                (progn
                ;(princ "\n \n ...Ha Pulsado aceptar!")
                (if (not (setq formulario_correcto (formulario_es_correcto)))
                  (progn
                    (alert "ATENCIÓN:\n\nSe han producido ERRORES\n\n al cumplimentar el formulario")
                    (alert (msg_error))))
               )
                ;...no es ni uno ni dos ni tres => Ha pulsado aspa -> cerrar ventana. \n ")
                (setq cancelado 'T)
              ) ; else if
            ) ; else if 
          ) ; if  Ha pulsado cancelar.
        ); else => definicion del formulario correcta
      ) ; if not (new_dialog)
    ); while (not formulario_correcto) Y (not cancelado)
  (unload_dialog dcl_id)
  (if (not cancelado)
    (genera_fichero_gml_edificio (proporcionar_fichero_escritura "gml") lista_chapulin)
    (alert "Generación de fichero GML de edificio cancelada"))    
  ); progn else
  );if
  (princ)
); defun C:gmle
); progn ; Funciones GML de Edificio
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Funciones para generar el GML de RGA
(defun C:gml28()
(gml 28)
(princ)
)
(defun C:gml29()
(gml 29)
(princ)
)
(defun C:gml30()
(gml 30)
(princ)
)
(defun C:gml31()
(gml 31)
(princ)
)
(defun gml(parametro_huso)
  ;;(defun gml(parametro_huso / HUSO plantilla1 plantilla2 plantilla3 plantilla4 camino_fichero nombre_fichero_escritura recinto_parcela mensaje_final nombre_entidad lista_datos_entidad)
  (defun generar_xml (recinto_actual huso_actual)
    (setq AREA_TXT (rtos (get_area recinto_actual) 2 0))
    (setq TIPO_PARCELA (get_tipo_parcela recinto_actual))
    (setq NOMBRE_PARCELA (get_nombre_parcela recinto_actual))
    (setq COOR_PARCELA (get_recinto_exterior recinto_actual))
    ;; generamos cabecera y el recinto exterior      
    (setq xml_gml (vl-string-subst "EPSG::32628" "EPSG::25828"
      (vl-string-subst "EPSG::32628" "EPSG::25828"
       (vl-string-subst huso_actual "%HUSOPARCELA%"
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
			            (strcat plantilla1 plantilla2 ))))))))))))))))
    ;; si hay recintos interiores; los anyadimos
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
  ;Comprobar si el huso es valido
  (if (not (or (= parametro_huso 28) (= parametro_huso 29) (= parametro_huso 30) (= parametro_huso 31)))
    (progn
      (alert "Huso proporcionado incorrecto, debe ser 28, 29, 30 o 31, saliendo...")
      (exit)
    )
  ); if not huso valido
  (setq HUSO (itoa parametro_huso))
  ;; seleccionemos los recintos exteriores de las parcelas
  (alert (strcat "Seleccione perímetros exteriores de las parcelas.\n\n NOTA: Sólo se permite seleccionar polilíneas previamente cerradas\n\n Huso de trabajo: "
                 HUSO))
  (setq recinto_parcela (ssget '((0 . "POLYLINE,LWPOLYLINE") (70 . 1))))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq numero_entidades_recinto (sslength recinto_parcela))
  (setq numero_entidad 0)
  (setq lista_chapulin nil)
  (repeat numero_entidades_recinto
    (setq lista_chapulin (cons (analiza_entidad_seleccionada (ssname recinto_parcela numero_entidad)) lista_chapulin)
          numero_entidad (+ 1 numero_entidad)))
  (alert (strcat "Número de entidades seleccionadas: " (itoa (vl-list-length lista_chapulin))))
  (setq nombre_fichero_escritura (proporcionar_fichero_escritura "txt"))
  (setq nombre_directorio (vl-filename-directory nombre_fichero_escritura))
  (setq mensaje_final 
    (strcat "Directorio usado: " 
        nombre_directorio
        "\n\n   Ficheros generados:"))
  (setq i 1)
  (while (car lista_chapulin); generamos los .gml ; uno por recinto
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
  (alert mensaje_final) ; mostramos datos resumen  
  (setq fichero_escritura (open nombre_fichero_escritura "w"))
  (princ mensaje_final fichero_escritura); graba en el fichero .txt los datos resumen
  (close fichero_escritura)
); defun gml
); progn ; Funciones GML de RGA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (=(substr(getvar "ACADVER")1 2)"14")
(progn
(defun vl-string-subst (nuevo_texto susti_texto texto)
  (setq plc 1 
          slen (strlen susti_texto))
  (while (>= (strlen texto) (+ (- plc 1) slen) )
    (setq fp    (substr texto 1 (- plc 1))
          chkpt (substr texto plc slen)
          lp    (substr texto (+ plc slen)  ) 
    );setq
    (if (= chkpt susti_texto)(progn
        (setq texto (strcat fp nuevo_texto lp)
              plc  (- (+ plc (strlen nuevo_texto)) 1)))
    ); if 
    (setq plc (+ plc 1))
  );while
  texto
);defun vl-string-subst
(defun  vl-list-length (lista / contador )
  (setq contador 0)
  (while (car lista) (setq lista (cdr lista)) (setq contador (+ contador 1)))
  contador
);defun vl-list-length
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; (vl-remove-if-not '(lambda (x) (= 1 x)) '(1 2 3 4 1 2 3))
(defun vl-remove-if-not (funcion lista_in / lista_out)
  (while (car lista_in) 
      (if (apply funcion (list (car lista_in))) (setq lista_out (cons  (car lista_in) lista_out)))
	  (setq lista_in (cdr lista_in))
  )
  lista_out
);defun vl-remove-if-not
; (vl-filename-directory "C:\\directorio\\subdirectgorio\\fichero.txt")
; (setq path "C:\\directorio\\subdirectgorio\\fichero.txt")
; (setq string "C:\\directorio\\subdirectgorio\\fichero.txt")
; (setg char "\\")
(defun vl-filename-directory (path)
  (defun str_pos (string char)
    (setq posicion (strlen string) )
	(while (and (/= (substr string posicion 1) char)  (> posicion 1))
	   (setq posicion (- posicion 1)))
	posicion
  )
   (setq lugar (str_pos path "\\"))
   (substr path 1 lugar)
); defun vl-filename-directory
); progn
); if Funciones Acad14
(princ
    (strcat
        "\n:: generar-gml.lsp | Version 3.0.0 | \\U+00A9 "
        (menucmd "m=$(edtime,0,yyyy)")
        " ChapulinCatastral https://github.com/chapulincatastral/ ::"
        "\n:: Escriba \"gml30\" para generar GML de RGA en el huso 30 ::"
        "\n:: Escriba \"gmle\"  para generar GML de Edificio ::"
    )
)
(princ)
;;-----------------------------------------------------------------------------------;;
;;                             End of File                                           ;;
;;-----------------------------------------------------------------------------------;;