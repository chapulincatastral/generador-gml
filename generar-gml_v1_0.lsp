; Script LISP generar-gml v1.0
; Autores: Castell Cebolla, Álvaro Álvarez, Pepe Alacreu
; (c) Catrasto 2016

; LIMITACIÓN DE RESPONSABILIDAD: El Catastro no proporciona soporte de este script. El script se proporciona tal cual es sin garantía de ningún tipo. El Catastro además se exime de toda garantía implícita incluyendo, sin limitación, cualquier garantía de comerciabilidad o de idoneidad para un propósito en particular. Usted asume todo el riesgo surgido por el uso o el funcionamiento del script y su documentación. En ningún caso será el Catastro, sus autores, o cualquier otra persona involucrada en la creación, producción o distribución del script responsable por los daños y perjuicios (incluyendo, sin limitación, daños por pérdida de beneficios empresariales, interrupción de negocio, pérdida de información comercial u otra pérdida pecuniaria) derivados del uso o la incapacidad de usar el script y su documentación, incluso si el Catastro ha sido advertido de la posibilidad de tales daños.

; LICENCIA PÚBLICA GENERAL (GNU GPL v3): Copyright (C) 2016 Catastro. Este programa es software libre. Puede redistribuirlo y/o modificarlo bajo los términos de la Licencia Pública General de GNU tal como está publicada por la Free Software Foundation, bien de la versión 3 de dicha Licencia o bien (según su elección) de cualquier versión posterior. Este programa se distribuye con la esperanza de que sea útil, pero SIN NINGUNA GARANTÍA, incluso sin la garantía MERCANTIL implícita o sin garantizar la CONVENIENCIA PARA UN PROPÓSITO PARTICULAR. Véase la Licencia Pública General de GNU para más detalles. Usted debería haber recibido una copia de la Licencia Pública General junto con este programa. Si no ha sido así, consulte <http://www.gnu.org/licenses>.

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
<gml:FeatureCollection xmlns:gml=\"http://www.opengis.net/gml/3.2\" xmlns:gmd=\"http://www.isotc211.org/2005/gmd\" xmlns:ogc=\"http://www.opengis.net/ogc\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:cp=\"urn:x-inspire:specification:gmlas:CadastralParcels:3.0\" xmlns:base=\"urn:x-inspire:specification:gmlas:BaseTypes:3.2\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"urn:x-inspire:specification:gmlas:CadastralParcels:3.0 http://inspire.ec.europa.eu/schemas/cp/3.0/CadastralParcels.xsd\" gml:id=\"ES.LOCAL.CP.1\">
   <gml:featureMember>
      <cp:CadastralParcel gml:id=\"ES.LOCAL.CP.1A\">
<!-- Superficie de la parcela en metros cuadrados. Tiene que coincidir con la calculada con las coordenadas.-->
         <cp:areaValue uom=\"m2\">AREAPARCELA</cp:areaValue>
         <cp:beginLifespanVersion xsi:nil=\"true\" nilReason=\"other:unpopulated\"></cp:beginLifespanVersion>
<!-- Geometria en formato GML       -->
         <cp:geometry>
<!-- srs Name codigo del sistema de referencia en el que se dan las coordenadas, que debe coincidir con el de la cartografia catastral -->
<!-- el sistema de referencia de la cartografía catastral varía según provincia, siendo accesible desde la consulta de cartografía en Sede -->  
           <gml:MultiSurface gml:id=\"MultiSurface_ES.LOCAL.CP.1A\" srsName=\"urn:ogc:def:crs:EPSG::258HUSOPARCELA\"> 
             <gml:surfaceMember>
               <gml:Surface gml:id=\"Surface_ES.LOCAL.CP.1A\" srsName=\"urn:ogc:def:crs:EPSG::258HUSOPARCELA\">
                  <gml:patches>
                    <gml:PolygonPatch>")
(setq plantilla2 "
                      <gml:exterior>
                        <gml:LinearRing>
<!-- Lista de coordenadas separadas por espacios o en lineas diferentes    -->
                          <gml:posList srsDimension=\"2\">COORDENADASPARCELA</gml:posList>
                        </gml:LinearRing>
                      </gml:exterior>")
(setq plantilla3 "
					  <gml:interior>
                        <gml:LinearRing>
<!-- Lista de coordenadas separadas por espacios o en lineas diferentes    -->
                          <gml:posList srsDimension=\"2\">COORDENADASHUECO</gml:posList>
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
             <base:localId>CODIGOPARCELA</base:localId>
             <base:namespace>ES.LOCAL.CP</base:namespace>
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

(defun coordenada_toasc (una_coordenada)
	(strcat (rtos (cadr una_coordenada) 2 2) " " (rtos (caddr una_coordenada) 2 2) " ")
); defun coordenada_toasc
	(setq camino_fichero "C:/")
	(setq nombre_fichero_escritura (getfiled "Guardar fichero como... " camino_fichero "gml" 1))
	(alert "Seleccione los recintos y pulse Intro. Los recintos deben haber sido convertidos antes en polilineas cerradas, incluso si han sido descargadas de la OVC.")
	(setq recinto_parcela (ssget '((0 . "POLYLINE,LWPOLYLINE") (70 . 1))); Sólo permite seleccionar polilíneas cerradas.
		numero_entidades_recinto (sslength recinto_parcela) ; Número de entidades seleccionadas
		numero_entidad 0
	); setq
	(alert (strcat "Entidades seleccionadas=" (itoa numero_entidades_recinto))); Muestra el número de entidades seleccionadas
	(setq mensaje_final "Generados los ficheros: ")
	(repeat numero_entidades_recinto
		(setq
		nombre_entidad (ssname recinto_parcela numero_entidad); Obtener nombre de la entidad
		lista_datos_entidad (entget nombre_entidad); Obtener lista con los datos
		numero_entidad (+ 1 numero_entidad)
		); setq
		(command "_AREA" "_E" nombre_entidad)
		(setq AREA (rtos (getvar "AREA") 2 0))
		(setq COORDENADAS " ")
		(setq posicion_coordenadas 1)
		(repeat (length lista_datos_entidad)
			(if (= (car (nth posicion_coordenadas lista_datos_entidad)) '10)
					(setq COORDENADAS (strcat COORDENADAS
						(coordenada_toasc (nth posicion_coordenadas lista_datos_entidad))
						)
					)
			); if				
		(setq posicion_coordenadas (+ posicion_coordenadas 1))
		); repeat
		(setq nombre_fichero_escritura_sec (strcat (substr nombre_fichero_escritura 1 (- (strlen nombre_fichero_escritura) 4)) "_" (itoa numero_entidad) ".gml"))
		(if (null
			(setq fichero_escritura (open nombre_fichero_escritura_sec "w")))
			(progn
				(alert "ERROR: No se puede escribir en el directorio seleccionado.")
				(exit)
			)
		);if
		(setq xml_gml (vl-string-subst HUSO "HUSOPARCELA" (vl-string-subst HUSO "HUSOPARCELA" (vl-string-subst AREA "AREAPARCELA" (vl-string-subst COORDENADAS "COORDENADASPARCELA" (vl-string-subst (itoa numero_entidad) "CODIGOPARCELA" (strcat plantilla1 plantilla2 plantilla4)))))))
		;(print xml_gml)
		(princ xml_gml fichero_escritura)
		(close fichero_escritura)
		(setq mensaje_final (strcat mensaje_final "\n" nombre_fichero_escritura_sec "\n Area:" AREA))	
	); repeat numero_entidades_recinto
	(alert mensaje_final)
); defun gml