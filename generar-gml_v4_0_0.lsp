;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; Script AutoLisP generar-gml.lsp
;;;;;;;;;;;
;;;;;;;;;;; LIMITACION DE RESPONSABILIDAD: No se proporciona soporte de este script. El script se proporciona tal cual es sin responsabilidad ni garant�a de ning�n tipo. Los autores se eximen de toda garantia impl�cita incluyendo, sin limitaci�n, cualquier garant�a de comerciabilidad o de idoneidad para un prop�sito en particular. Usted asume todo el riesgo surgido por el uso o el funcionamiento del script y su documentaci�n. En ning�n caso ser�n sus autores, o cualquier otra persona involucrada en la creaci�n, producci�n o distribuci�n del script responsable por los da�os y perjuicios (incluyendo, sin limitaci�n, da�os por p�rdida de beneficios empresariales, interrupci�n de negocio, p�rdida de informaci�n comercial u otra perdida pecuniaria) derivados del uso o la incapacidad de usar el script y su documentaci�n, incluso si no ha sido advertido de la posibilidad de tales da�os.
;;;;;;;;;;;
;;;;;;;;;;; LICENCIA P�BLICA GENERAL (GNU GPL v3): Copyright (C) 2016 ChapulinCatastral https://github.com/chapulincatastral/ . Este programa es software libre. Puede redistribuirlo y/o modificarlo bajo los t�rminos de la Licencia P�blica General de GNU tal como est� publicada por la Free Software Foundation, bien de la versi�n 3 de dicha Licencia o bien (seg�n su elecci�n) de cualquier versi�n posterior. Este programa se distribuye con la esperanza de que sea �til, pero SIN NINGUNA GARANT�A, incluso sin la garant�a MERCANTIL impl�cita o sin garantizar la CONVENIENCIA PARA UN PROP�SITO PARTICULAR. V�ase la Licencia P�blica General de GNU para m�s detalles. Usted deber�a haber recibido una copia de la Licencia P�blica General junto con este programa. Si no ha sido as�, consulte <http://www.gnu.org/licenses>.
;;;;;;;;;;;
;;;;;;;;;;; version: 1.0.0; fecha: 10.10.2016; Autor: Castell Cebolla, Alvaro Alvarez, Pepe Alacreu; Modificacion: Genera GML de Parcela Catastral
;;;;;;;;;;; version: 2.0.0; fecha: 11.11.2016; Autor: Alvaro; Modificaci�n: soporte para; islas, identificador de parcela y tipo identificador de parcela
;;;;;;;;;;; version: 3.0.0; fecha: 12.12.2016; Autor: Alvaro; Modificaci�n: se a�ade GMLe que genera GML de edificio.
;;;;;;;;;;; version: 3.0.1; fecha: 12.12.2016; Autor: Alvaro, Castell ; Modificaci�n: Se filtran las "entidades arco" en las polil�neas cerradas.
;;;;;;;;;;; version: 3.0.2; fecha: 16.12.2016; Autor: Alvaro; Modificaci�n: Se permiten n�mero de viviendas 0 y se modifican textos y descripci�n del formulario.
;;;;;;;;;;; version: 3.0.3; fecha: 17.12.2016; Autor: Alvaro; Modificaci�n: Cambiamos el gmle para generar una coord. por l�nea y facilitar el "copy paste" de coord. 8-)
;;;;;;;;;;; version: 3.0.4; fecha: 21.12.2016; Autor: Alvaro; Modificaci�n: Comprobar que los identificadores de parcela de GML de Parcela no contienen espacios en blanco
;;;;;;;;;;; version: 4.0.0; fecha: 22.11.2017; Autor: Jose Antonio Garcia <jagarciavi@jagarciavi.es>; Modificaci�n: Actualizaci�n de la plantilla de GML de parcela a la version 4 de INSPIRE (https://gyazo.com/b4ef35b1222b266f309a25879b7fd0f6).
;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Plantillas de fichero GML de Parcela
(setq plantilla1 "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<!--Parcela Catastral para entregar a la D.G. del Catastro.-->
<!--Generado por chapulincatastral https://github.com/chapulincatastral/generador-gml/ -->
<gml:FeatureCollection gml:id=\"ES.SDGC.CP\" xmlns:gml=\"http://www.opengis.net/gml/3.2\" xmlns:gmd=\"http://www.isotc211.org/2005/gmd\" xmlns:ogc=\"http://www.opengis.net/ogc\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:cp=\"http://inspire.ec.europa.eu/schemas/cp/4.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://inspire.ec.europa.eu/schemas/cp/4.0 http://inspire.ec.europa.eu/schemas/cp/4.0/CadastralParcels.xsd\">
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
         <cp:inspireId xmlns:base=\"http://inspire.ec.europa.eu/schemas/base/3.3\">
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

); progn Plantilla GML de Parcela
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Plantillas de fichero .html Informe de Edificio
(setq html_edifi "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">
<html>
<head>
<title>Informe de Coord. Georrefe. de los V&eacute;rtices de la Edificaci&oacute;n</title>
<meta name=\"Description\" content=\"INFORME COORDENADAS GEORREFERENCIADAS DE LOS V&Eacute;RTICES DE LA EDIFICACI�N\">
<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">
<meta name=\"Author\" content=\"ChapulinCatastral\">
<style type=\"text/css\">
  table#01 {
    table-layout: fixed;
    width: 900px;
  }
  th {
    text-align: right;
    width: 80px;
    font-size: 10px;
  }
  .th_n {
    text-align: right;
    width: 25px;
    font-size: 10px;
  }
  td {
    text-align: right;
    width: 80px;
    font-size: 10px;
  }
  .td_n {
    text-align: right;
    width: 25px;
    font-size: 10px;
  }
  h1 {
    font-family: verdana;
    text-align: left;
    font-size: 22px;
  }
  .p_r {
    font-family: verdana;
    font-size: 16px;
  }
  .p_d {
    font-size: 16px;
    text-align: right;
  }
  p {
    font-family: verdana;
    font-size: 12px;
    text-align: left;
  }
  .p_f {
    font-family: verdana;
    font-size: 12px;
    text-align: left;
    text-indent: 200px;
  }
</style>
</head>
<body>
<h1>INFORME DE COORDENADAS GEORREFERENCIADAS DE LOS V&Eacute;RTICES DE LA EDIFICACI&Oacute;N </h1>
<p class=\"p_d\"> Hoja 1/1</p>
<p class=\"p_r\">REFERENCIA DEL EDIFICIO: %REFERENCIA_EDIFICIO%</p>
<p>Sistema de referencia ETRS89, coordenadas U.T.M. huso %HUSO% [%SISTEMA_REFERENCIA%]</p>
<p>Escala m&aacute;xima de representaci&oacute;n de estas coordenadas: 1:%MAX_REPRESENTACION%</p>
<p>Total: %NUM_VERTICES% v&eacute;rtices.</p>
%TABLA%
<p class=\"p_f\">%LUGAR_Y_FECHA%</p>
<p class=\"p_f\">%ANTEFIRMA%</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p class=\"p_f\">%POSFIRMA%</p>
</body>
</html>")
(setq html_edifi_tabla " <table id=\"t01\">
  <tr>
    <th class=\"th_n\">N&ordm;</th>
    <th>X</th>
    <th>Y</th>
    <th class=\"th_n\"> </th>
    <th class=\"th_n\">N&ordm;</th>
    <th>X</th>
    <th>Y</th>
    <th class=\"th_n\"> </th>
    <th class=\"th_n\">N&ordm;</th>
    <th>X</th>
    <th>Y</th>
    <th class=\"th_n\"> </th>
    <th class=\"th_n\">N&ordm;</th>
    <th>X</th>
    <th>Y</th>
%FILA_TABLA%
</table>")
(setq html_edifi_fila_tabla "  <tr>
    <td class=\"td_n\">%NUM_VERTICE_1%</td>
    <td>%COOR_X_1%</td>
    <td>%COOR_Y_1%</td>
    <td class=\"td_n\">%NUM_VERTICE_2%</td>
    <td>%COOR_X_2%</td>
    <td>%COOR_Y_2%</td>
    <td class=\"td_n\">%NUM_VERTICE_3%</td>
    <td>%COOR_X_3%</td>
    <td>%COOR_Y_3%</td>
    <td class=\"td_n\">%NUM_VERTICE_4%</td>
    <td>%COOR_X_4%</td>
    <td>%COOR_Y_4%</td>
  </tr>")
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Funciones Comunes
(if (=(substr(getvar "ACADVER")1 2)"14")
(defun rtoc ( n p / foo d l ); convierte el numero 'n' en string; a�ade una ',' cada tres posiciones enteras y usa 'p' posiciones decimales
    (defun foo ( l n )
        (if (< (strlen l) 2)
            l
            (if (= "." (substr l 2 1))
                (strcat (substr l 1 1) "," (substr l 3))
                (if (zerop (rem n 3))
                    (strcat (substr l 1 1) "." (foo (substr l 2) (1+ n)))
                    (strcat (substr l 1 1) (foo (substr l 2) (1+ n)))
                )
            )
        )
    )
    (setq l (rtos (abs n) 2 p))
    (strcat (if (minusp n) "-" "")
            (foo l (- 3 (rem (fix (/ (log (abs n)) (log 10))) 3)))
    )
    
); defun rtoc
(defun rtoc ( n p / foo d l ); convierte el numero 'n' en string; a�ade una ',' cada tres posiciones enteras y usa 'p' posiciones decimales
    (defun foo ( l n )
        (if (not (cadr l))
            l
            (if (= 46 (cadr l))
                (vl-list* (car l) 44 (cddr l))
                (if (zerop (rem n 3))
                    (vl-list* (car l) 46 (foo (cdr l) (1+ n)))
                    (cons (car l) (foo (cdr l) (1+ n)))
                )
            )
        )
    )
    (setq d (getvar 'dimzin))
    (setvar 'dimzin 0)
    (setq l (vl-string->list (rtos (abs n) 2 p)))
    (setvar 'dimzin d)
    (vl-list->string
        (append (if (minusp n) '(45))
            (foo l (- 3 (rem (fix (/ (log (abs n)) (log 10))) 3)))
        )
    )
); defun rtoc
); if
(defun split (lst len opt / ls l i) ; opt, T= by division or nil=by length
(setq i 1 l '() len (if opt (/ (length lst) len) len))
  (while lst
    (setq l (append  l (list(car lst))))
    (if
    (zerop (rem i len))
 (setq ls (cons l ls) l nil)
    ) 
    (setq i (1+ i) lst (cdr lst))
  ) ;_ end of foreach
  (if l
    (append (reverse ls) (list  l))
    (reverse ls)
  ) ;_ end of if
) ;_ end of defun
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
(defun real_espanyol(cadena / tmp)
  (if (and (> (strlen cadena) 6) (/= (str-pos cadena ".") 0) (= 2 (-(strlen cadena) (str-pos cadena ".")) ))
    (progn
      (setq tmp (vl-string-subst "," "." cadena))
      (if (> (strlen cadena) 9)
        (strcat (substr tmp 1 (- (strlen tmp) 9)) "." (substr tmp (- (strlen tmp) 8) 3) "." (substr tmp (- (strlen tmp) 5)))
        (strcat (substr tmp 1 (- (strlen tmp) 6)) "." (substr tmp (- (strlen tmp) 5)))
      )
    )
    (if (/= (str-pos cadena ".") 0)
      (vl-string-subst "," "." cadena)
      cadena
    )
  )
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
(defun proporcionar_fichero_escritura ( extension / mensaje directorio_correcto nombre_fichero_escritura fichero_prueba_escritura)
    (cond
      ( (= extension "gml")(setq mensaje "Guardar fichero GML Edificio como... ")
      )
      ( (= extension "html")(setq mensaje "Guardar fichero HTML Informe Edificio como ... ") 
      )
      ( (= extension "txt")(setq mensaje "Guardar fichero TXT descripci�n de GML Parcela como ... ") 
      )
      (t (setq mensaje "Guardar fichero  como ... ")
      )
    )
	(setq directorio_correcto "F")
	(while (= directorio_correcto "F")
		(setq nombre_fichero_escritura 
              (getfiled mensaje 
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Funciones Lista ChapulinCatastral
;;;;  Lista Chapulin -> (recinto recinto ...)
;;;;  recinto        -> (NOMBRE_RECINTO  AREA  perimetro islas)
;;;;  perimetro      -> ((coordenadaX coordenadaY) (coordenadaX coordenadaY) ...)
;;;;  islas          -> (isla isla ...)
;;;;  isla           -> (AREA perimetro)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq *nombres_de_parcela_predefinidos* '("1A" "1B" "1C" "1D" "1E" "1F" "1G" "1H" "1J" "1K" "1L" "1M" "1N" "1P" "1R" "1S" "1T" "1T" "1U" "1V" "1X" "1Y" "1Z"))
(setq *lista_variales_Xdefecto* '("lista_huso_ind" "precision_txt" "lugar_y_fecha_txt" "antefirma_txt" "posfirma_txt"))
(setq *lista_valores_Xdefecto* '("2" "0,1" "" "" ""))
(setq *max_filas_tabla_informe_edifio* 40)
(setq *num_columnas_tabla_informe_edifio* 4)

(defun put_valores_Xdefecto()
  (mapcar '(lambda(x) (setenv x  (eval (read x))) ) *lista_variales_Xdefecto*)
)
(defun get_valores_Xdefecto()
  (mapcar '(lambda(x) (if (null (set (read x) (getenv x)))(set (read x) (nth (vl-position x *lista_variales_Xdefecto*) *lista_valores_Xdefecto* )))) *lista_variales_Xdefecto*)
)
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
            (alert (strcat "ERROR\n      Un recinto:\"" "exterior" "\"contiene arcos; Por favor conviertalo en sucesi�n de l�neas rectas"))
            (exit)))
    (setq perimetro_entidad (mapcar 'cdr (vl-remove-if-not '(lambda (x) (= 10 (car x))) lista_datos_entidad)))
    ;;(setq objetos (ssget "_WP" perimetro_entidad))
    (if (setq objetos_interiores (ssget "_WP" perimetro_entidad))
        (progn
            (setq NOMBRE_RECINTO (analiza_entidad_interior_texto objetos_interiores))
            (setq islas (analiza_entidad_interior_recintos objetos_interiores))
        )
    )
    (command "_AREA" "_E" nombre_una_entidad)
    (setq AREA_R (getvar "AREA") )
    (if (null (car NOMBRE_RECINTO))
        (progn
            (setq NOMBRE_RECINTO (list (car *nombres_de_parcela_predefinidos*)))
            (setq *nombres_de_parcela_predefinidos* (cdr *nombres_de_parcela_predefinidos*))
        )
        (if (> (str-count  (car NOMBRE_RECINTO) " ") 0)
            (progn
                (alert (strcat "ERROR: Nombre Parcela \"" (car NOMBRE_RECINTO) "\", contiene espacios en blanco"))
                (exit)
            )
        )
    )    
    (list (car NOMBRE_RECINTO) AREA_R perimetro_entidad islas)
  ;; (caar islas) ; primera superficie; (caadr islas) ; segunda ; (caaddr islas) ; tercera
) ; defun analiza_entidad_seleccionada
(defun get_nombre_parcela (recinto)
    (if (null (car recinto))
        (progn
            (setq *nombres_de_parcela_predefinidos* (cdr *nombres_de_parcela_predefinidos*))
            (car *nombres_de_parcela_predefinidos*)
        )
        (if (not (str-pos (car recinto) " "))
            (car recinto)
            (progn
                (alert (strcat "ERROR: Nombre Parcela \"" (car recinto) "\", contiene espacios en blanco"))
                (exit)
            )
        )
    )
);defun get_nombre_parcela
(defun get_tipo_parcela (recinto)
    (if (and  (car recinto) (es_referencia (car recinto)))
        "SDGC"
        "LOCAL")
);defun get_tipo_parcela  
(defun get_area (recinto)
    (- (cadr recinto) (get_area_islas recinto))
);defun get_area  
(defun get_recinto_exterior_txt (recinto)
    (strcat (apply 'strcat (mapcar 'coordenada_toasc2 (caddr recinto))) 
            (coordenada_toasc2 (car (caddr recinto))))
);defun get_recinto_exterior_txt
(defun get_recinto_interior_txt (recinto)
    (strcat (apply 'strcat (mapcar 'coordenada_toasc2 (cadr recinto))) 
            (coordenada_toasc2 (car (cadr recinto))))
);defun get_recinto_interior_txt  
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
                (alert (strcat "ERROR\n      Un recinto:\"" "interior" "\"contiene arcos; Por favor conviertalo en sucesi�n de l�neas rectas"))
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
(progn ; Funciones GML de Edificio
(defun htmlentities (cadena / tmp1 tmp2)
  (setq entities '("�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�" "�"))
  (setq html_entities '("&aacute;" "&eacute;" "&iacute;" "&oacute;" "&uacute;"
                      "&Aacute;" "&Eacute;" "&Iacute;" "&Oacute;" "&Uacute;" 
                      "&agrave;" "&egrave;" "&igrave;" "&ograve;" "&ugrave;" 
                      "&Agrave;" "&Egrave;" "&Igrave;" "&Ograve;" "&Ugrave;" 
                      "&ntilde;" "&Ntilde;" "&ccedil;" "&Ccedil;" "&ordm;" "&ordf;"
                      "&uuml;"  "&Uuml;"  "&iuml;"  "&Iuml;" ))
  (setq tmp cadena)
  (setq tmp2 "")
  (while (> (strlen tmp) 0)
    (setq tmp2 (strcat tmp2 
                       (if (vl-position (substr tmp 1 1) entities)
                         (nth (vl-position (substr tmp 1 1) entities) html_entities)
                         (substr tmp 1 1)
                       )
                )
    
    )
    (setq tmp (substr tmp 2))
  )
  tmp2
);defun htmlentities
(defun genera_informe_html_edificio (nombre_fichero lista_chapulin / fichero_escritura)
  (if (null (setq fichero_escritura (open nombre_fichero "w")))
    (progn
      (alert (strcat "ERROR; el Informe de esquinas de edificio: \""  
                     nombre_fichero
                     "\"\n   no ha podido ser generado"))
      (exit)
    )
    (progn
      (princ (genera_informe_html_edificio_html lista_chapulin) fichero_escritura)
      (close fichero_escritura)
      (alert (strcat "Informe de esquinas de edificio: \""  
                     nombre_fichero
                     "\"\n   correctamente generado"))
    )
  )
); defun genera_informe_html_edificio
(defun genera_informe_html_edificio_html (lista_chapulin / vertices max_representacion)
  ;;(while (car lista_chapulin) ; empezamos con un solo recinto
  (setq vertices (caddar lista_chapulin))
  (setq max_representacion (rtoc (* (atof (real_ingles precision_txt)) 15000) 0))
  (vl-string-subst referencia_edificio_txt "%REFERENCIA_EDIFICIO%"
    (vl-string-subst (substr item_huso 5 2) "%HUSO%"
      (vl-string-subst item_huso "%SISTEMA_REFERENCIA%"
        (vl-string-subst max_representacion "%MAX_REPRESENTACION%"
          (vl-string-subst (itoa (vl-list-length vertices)) "%NUM_VERTICES%"
            (vl-string-subst (genera_informe_html_edificio_html_tabla vertices) "%TABLA%"
            (htmlentities 
              (vl-string-subst lugar_y_fecha_txt "%LUGAR_Y_FECHA%"
                (vl-string-subst antefirma_txt "%ANTEFIRMA%"
                  (vl-string-subst posfirma_txt "%POSFIRMA%"  html_edifi))))))))))
); defun genera_informe_html_edificio_html
(defun genera_informe_html_edificio_html_tabla ( recinto )
  (vl-string-subst (genera_informe_html_edificio_html_fila_tabla recinto) 
                   "%FILA_TABLA%" 
                   html_edifi_tabla)
); defun genera_informe_html_edificio_html_tabla
(defun genera_informe_html_edificio_html_fila_tabla ( recinto / num_vertice num_vertices html_tabla coordenadas num_vertices)
  (defun coorX_vertice_txt (lista_coordenadas vertice )
    (if (> vertice num_vertices)
      " "
      (rtoc (car  (nth (- vertice 1) lista_coordenadas)) 2 ))
  )
  (defun coorY_vertice_txt (lista_coordenadas vertice )
     (if (> vertice num_vertices)
      " "
      (real_espanyol(rtos (cadr (nth (- vertice 1) lista_coordenadas)) 2 2)))
  )
  (defun vertice_tx (vertice)
     (if (> vertice num_vertices)
      " "
      (itoa vertice))
  )
  (setq num_vertice 1)
  (setq num_vertices (vl-list-length recinto) )
  (setq html_tabla "")
  (if (> num_vertices (* *max_filas_tabla_informe_edifio* *num_columnas_tabla_informe_edifio*)) 
    (progn 
      (alert (strcat "ERROR: demasiados v�rtices en el recinto; n�mero de v�rtices:" 
                     (itoa (vl-list-length coordenadas))
                     ". N�mero m�ximo de v�rtices permitidos: "
                     (itoa (* *max_filas_tabla_informe_edifio* *num_columnas_tabla_informe_edifio*))
              )
      )
      (exit)
    )
  )
 (repeat (min num_vertices *max_filas_tabla_informe_edifio*)
    (setq html_tabla (strcat html_tabla "\n"
      "  <tr>"
      "    <td class=\"td_n\">"(vertice_tx (+ num_vertice (* 0 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td>"(coorX_vertice_txt recinto (+ num_vertice (* 0 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td>"(coorY_vertice_txt recinto (+ num_vertice (* 0 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td class=\"td_n\"> </td>"
      "    <td class=\"td_n\">"(vertice_tx (+ num_vertice (* 1 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td>"(coorX_vertice_txt recinto (+ num_vertice (* 1 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td>"(coorY_vertice_txt recinto (+ num_vertice (* 1 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td class=\"td_n\"> </td>"
      "    <td class=\"td_n\">"(vertice_tx (+ num_vertice (* 2 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td>"(coorX_vertice_txt recinto (+ num_vertice (* 2 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td>"(coorY_vertice_txt recinto (+ num_vertice (* 2 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td class=\"td_n\"> </td>"
      "    <td class=\"td_n\">"(vertice_tx (+ num_vertice (* 3 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td>"(coorX_vertice_txt recinto (+ num_vertice (* 3 *max_filas_tabla_informe_edifio*)))"</td>"
      "    <td>"(coorY_vertice_txt recinto (+ num_vertice (* 3 *max_filas_tabla_informe_edifio*)))"</td>"
      "  </tr>"))
    (setq num_vertice (+ num_vertice 1))
  )
  html_tabla
); defun genera_informe_html_edificio_html_fila_tabla
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun copy_paste_registradores (coordenadas / lon i coor_copy_paste espacios )
    (setq lon (strlen coordenadas))
    (setq coor_copy_paste "")
    (setq i 1)
    (setq espacios 0)
    (while (< i lon)
        (setq coor_copy_paste  (strcat coor_copy_paste
                                    (if (= (substr coordenadas i 1) " ")
                                        (progn
                                            (setq espacios (+ espacios 1))
                                            (if (= (rem espacios 2) 0)
                                                "\n"
                                                " "
                                            )
                                        )
                                        (substr coordenadas i 1)
                                    )
                                )
        )
        (setq i (+ i 1))
    )
    coor_copy_paste
); defun copy_paste_registradores 
(defun genera_gml_edificio_txt (lista_chapulin / PolygonPatches)
  (setq PolygonPatches "")
  (while (car lista_chapulin) 
      (setq PolygonPatches (strcat PolygonPatches
                                    (vl-string-subst (copy_paste_registradores (get_recinto_exterior_txt (car lista_chapulin)))
                                                     "%COORDENADAS%" fichero_gml_PolygonPatch)))
      (setq lista_chapulin (cdr lista_chapulin))
  )
  (strcat 
    (if (= obra_txt "obra_acabada" ) 
      (strcat
          (vl-string-subst "functional" "%OBRA%"  fichero_gml_1)
          (vl-string-subst (fecha_en_ingles fecha_fin_txt) "%FECHA-FIN%" 
                            (vl-string-subst (fecha_en_ingles fecha_inicio_txt) "%FECHA-INICIO%" fichero_gml_2)))
      (vl-string-subst "underConstruction" "%OBRA%" fichero_gml_1))
    (vl-string-subst referencia_edificio_txt "%REFERENCIA-PARCELA%"
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
  (if (= referencia_edificio_txt "")
     (setq texto (strcat texto 
                         "\nERROR.\n El identificador de la parcela no puede estar en blanco\n")))
  (if (=  precision_txt "")
     (setq texto (strcat texto "\nERROR.\n La precisi�n�de las coord. no puede dejarse en blanco\n"))
     (if (not (es_real_positivo precision_txt))
       (setq texto (strcat texto "\nERROR.\n La precisi�n�de las coord.:\"" 
                           precision_txt "\", no es un n�mero real positivo\n"))))
  (if (=  inmuebles_txt "")
     (setq texto (strcat texto "\nERROR.\n El n�mero de inmuebles no puede dejarse en blanco\n"))
     (if (not (es_entero_positivo inmuebles_txt))
       (setq texto (strcat texto "\nERROR.\n El n�mero de inmuebles:\"" 
                           inmuebles_txt "\", no es un n�mero entero positivo\n"))))
  (if (=  viviendas_txt "")
     (setq texto (strcat texto "\nERROR.\n El n�mero de viviendas no puede dejarse en blanco\n"))
     (if (not (or (es_entero_positivo viviendas_txt) (= "0" viviendas_txt)))
       (setq texto (strcat texto "\nERROR.\n El n�mero de viviendas:\"" 
                           viviendas_txt "\", no es un n�mero entero positivo\n"))))
  (if (=  plantas_txt "")
     (setq texto (strcat texto "\nERROR.\n El n�mero de plantas no puede dejarse en blanco\n"))
     (if (not (es_entero_positivo plantas_txt))
       (setq texto (strcat texto "\nERROR.\n El n�mero de plantas:\"" 
                           plantas_txt "\", no es un n�mero entero positivo\n"))))
  (if (=  superficie_txt "")
     (setq texto (strcat texto "\nERROR.\n La superficie no puede dejarse en blanco\n"))
     (if (not (es_entero_positivo superficie_txt))
       (setq texto (strcat texto "\nERROR.\n El valor de la superficie:\"" 
                           superficie_txt "\", no es un n�mero entero positivo\n"))))
   (if (and (es_entero_positivo inmuebles_txt)
            (es_entero_positivo viviendas_txt)
            (> (atoi viviendas_txt) (atoi inmuebles_txt)))
       (setq texto (strcat texto "\nERROR.\n El n�mero de inmuebles no puede ser menor que el de viviendas\n")))   
  texto
)
(defun formulario_es_correcto ()
  (and 
    (or (= obra_txt "obra_sin_acabar")
        (and (= obra_txt "obra_acabada") 
             (es_fecha fecha_inicio_txt)
             (es_fecha fecha_fin_txt)))
    (/= referencia_edificio_txt "")
    (es_real_positivo precision_txt)
    (es_entero_positivo inmuebles_txt)
    (or (es_entero_positivo viviendas_txt) (= "0" viviendas_txt))
    (es_entero_positivo plantas_txt)
    (es_entero_positivo superficie_txt)
    (<= (atoi viviendas_txt) (atoi inmuebles_txt))
  )
); defun formulario_es_correcto
(defun genera_fichero_gml_edificio (nombre_fichero lista_chapulin/fichero_escritura)
  (setq fichero_escritura (open nombre_fichero "w"))
    (princ (genera_gml_edificio_txt lista_chapulin) fichero_escritura)
    (close fichero_escritura)
    (alert (strcat "fichero de GML de edificio: \""  
                 nombre_fichero
                 "\"\n   correctamente generado"))
); defun genera_fichero_gml_edificio
(defun saveVars()
  (setq obra_txt (get_tile "obra"))
  (setq fecha_inicio_txt (get_tile "fecha_inicio"))
  (setq fecha_fin_txt (get_tile "fecha_fin"))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq referencia_edificio_txt (get_tile "referencia_edificio"))
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
  (setq lugar_y_fecha_txt (get_tile "lugar_y_fecha"))
  (setq antefirma_txt (get_tile "antefirma"))
  (setq posfirma_txt (get_tile "posfirma"))
);defun saveVars
(defun C:gmle()
  (setq lista_chapulin nil) 
  (setq cancelado nil)
  (setq formulario_correcto nil)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Solicitamos seleccionar los recintos del edificio
  (alert "Seleccione los per�metros exteriores del edificio.\n\n NOTA: S�lo se permite seleccionar pol�lineas previamente cerradas!!")
  ;; Solo se permite seleccionar polilineas  previamente cerradas
  (setq recinto_parcela (ssget '((0 . "POLYLINE,LWPOLYLINE") (70 . 1))))
  ;; generacion de la lista chapulin a partir de los recintos seleccionados
  (setq  numero_entidades_recinto (sslength recinto_parcela))
  (alert (strcat "N�mero de recintos seleccionados: " (itoa numero_entidades_recinto)))
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
    ;(setq referencia_edificio_txt "")
    (setq referencia_edificio_txt (get_nombre_parcela(car lista_chapulin)))
    (setq lista_huso(list "EPSG::32628" "EPSG::25829" "EPSG::25830" "EPSG::25831"))
    ;(setq lista_huso_ind "2") ;; por defecto uso30
    ;(setq precision_txt "")
    ;
    (setq lista_uso(list "" "1_residential" "2_agriculture" "3_industrial" "4_commerceAndServices"))
    (setq lista_uso_ind "0") ; por defecto uso destino en blanco 
    ;
    (setq inmuebles_txt "")
    (setq viviendas_txt "")
    (setq plantas_txt "")
    (setq superficie_txt "")
    (setq lugar_y_fecha_txt "")
    ;(setq antefirma_txt "")
    ;(setq posfirma_txt "")
    (get_valores_Xdefecto)
  ); progn ; set variales txt a valores por defecto del formulario
  ;; Vamos con el formulario
  (if(not(setq dcl_id (load_dialog "GML_EDIFICIO_4.dcl")))
    (progn ; then => NO se ha encontrado el fichero .dcl con la definion del formulario
      (alert "El fichero con la definici�n del formulario no se ha podido cargar,
      a�ada nombre del directorio donde se encuentra el fichero  GML_EDIFICIO.dcl
      a la lista de directorios: \"Opciones de AutoCad\"->\"Ruta de b�squeda de archivo de soporte\"")
      (exit)
    ); 
    (progn ; else => SI se ha encontrado el fichero .dcl con la definion del formulario
    (while (and (not formulario_correcto) (not cancelado))
      (if (not (new_dialog "GML_EDIFICIO" dcl_id))
        (progn ; then => error en la definicion  del formulario
          (alert "\n\n La definici�n del formulario \"GML_EDIFICIO \" 
                  no se encuentra en el fichero de defini�n \"GML_EDIFICIO_4.dcl\"")
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
          (set_tile "referencia_edificio" referencia_edificio_txt)
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
          (set_tile "lugar_y_fecha" lugar_y_fecha_txt)
          (set_tile "antefirma" antefirma_txt)
          (set_tile "posfirma" posfirma_txt)
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
              (alert "- Se recomienda entrar en la Sede Electr�nica del Catastro para:
        . Averiguar el sistema de referencia y huso de las coordenadas  
        . Descargar las coordenadas georreferenciadas del solar donde
          se ubica el edificio.

- El per�metro del edificio ha de corresponderse o estar dentro de la parcela catastral georreferenciada, que previamente ha sido descargada.

- A la Cartograf�a Catastral se le supone una precisi�n de 0,1 metros.

- El per�metro del edificio se representa mediante una polil�nea cerrada, compuesta por segmentos rectil�neos. No se admiten curvas.

- Si el edificio est� compuesto por varios bloques independientes, tendremos varios per�metros.

- Si hay mas de un per�metro, no puede haber contactos entre ellos, por peque�o que sea."))
          
              (if (= ddiag 2) ; Ha pulsado aceptar
                (progn
                ;(princ "\n \n ...Ha Pulsado aceptar!")
                (if (not (setq formulario_correcto (formulario_es_correcto)))
                  (progn
                    (alert "ATENCI�N:\n\nSe han producido ERRORES\n\n al cumplimentar el formulario")
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
      (progn
        (genera_fichero_gml_edificio (proporcionar_fichero_escritura "gml") lista_chapulin)
        (genera_informe_html_edificio (proporcionar_fichero_escritura "html") lista_chapulin)
        (put_valores_Xdefecto)
      )
      (alert "Generaci�n de fichero GML de edificio cancelada")
    )    
    ); progn else
  );if
  (princ)
); defun C:gmle
); progn ; Funciones GML de Edificio
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn ; Funciones GML de Parcela
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
    (setq COOR_PARCELA (get_recinto_exterior_txt recinto_actual))
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
	    	(vl-string-subst (get_recinto_interior_txt (car islas))
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
  (alert (strcat "Seleccione per�metros exteriores de las parcelas.\n\n NOTA: S�lo se permite seleccionar polil�neas previamente cerradas\n\n Huso de trabajo: "
                 HUSO))
  (setq recinto_parcela (ssget '((0 . "POLYLINE,LWPOLYLINE") (70 . 1))))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq numero_entidades_recinto (sslength recinto_parcela))
  (setq numero_entidad 0)
  (setq lista_chapulin nil)
  (repeat numero_entidades_recinto
    (setq lista_chapulin (cons (analiza_entidad_seleccionada (ssname recinto_parcela numero_entidad)) lista_chapulin)
          numero_entidad (+ 1 numero_entidad)))
  (alert (strcat "N�mero de entidades seleccionadas: " (itoa (vl-list-length lista_chapulin))))
  (setq nombre_fichero_escritura (proporcionar_fichero_escritura "txt"))
  (setq nombre_directorio (vl-filename-directory nombre_fichero_escritura))
  (setq mensaje_final 
    (strcat "Directorio usado: " 
        nombre_directorio
        "\n\n   N�mero Ficheros Generados:"
        (itoa (vl-list-length lista_chapulin))))
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
	   (strcat mensaje_final "\n\n\t "
		   (substr nombre_fichero_escritura_sec  (+ (strlen nombre_directorio) 2))))
    (setq mensaje_final
	   (strcat mensaje_final
		   "\n\t\t Nombre parcela: "
		   (get_nombre_parcela (car lista_chapulin))))
    (setq mensaje_final
	   (strcat mensaje_final
		   "\n\t\t Tipo parcela: "
           (get_tipo_parcela (car lista_chapulin))))
    (setq mensaje_final
	   (strcat mensaje_final 
		   "\n\t\t �rea parcela: "
		   (rtos (get_area (car lista_chapulin)) 2 0)))
    (setq mensaje_final
	   (strcat mensaje_final
		   "\n\t\t Islas en parcela: "
		   (itoa (vl-list-length(get_islas (car lista_chapulin))))))    
    (setq i (+ i 1))
    (setq lista_chapulin (cdr lista_chapulin))
  ); while
  (alert mensaje_final) ; mostramos datos resumen  
  (setq fichero_escritura (open nombre_fichero_escritura "w"))
  (princ mensaje_final fichero_escritura); graba en el fichero .txt los datos resumen
  (close fichero_escritura)
); defun gml
); progn ; Funciones GML de Parcela
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (=(substr(getvar "ACADVER")1 2)"14")
(progn
(defun vl-position (item3 lista3 / i3) 
    (cond
      ( (null lista3) nil
      )
      ( (eq item3 (car lista3)) 0 
      )
      (t (if (setq i3 (vl-position2 item3 (cdr lista3)) ) (+ i3 1) nil)
      )
    )
;(vl-position "a" '("a"))
;(vl-position "a" '("b" "a"))
;(vl-position "a" '("c" "b" "a"))
;(vl-position "a" '("b" "c"))
;(vl-position "a" '())
;(vl-position "a" nil)
); defun vl-position 

(defun vl-position2 (item2 lista2 / i2) 
    (cond
      ( (null lista2) nil
      )
      ( (eq item2 (car lista2)) 0 
      )
      (t (if (setq i2 (vl-position item2 (cdr lista2)) ) (+ i2 1) nil)
      )
    )
); defun vl-position 

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
(defun vl-list-length (lista / contador )
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
(defun vl-filename-directory (path / lugar)
  (defun str_pos (string char / posicion)
    (setq posicion (strlen string) )
	(while (and (/= (substr string posicion 1) char)  (> posicion 1))
	   (setq posicion (- posicion 1)))
	posicion
  )
  (setq lugar (str_pos path "\\"))
  (substr path 1 (- lugar 1))
); defun vl-filename-directory
); progn
); if Funciones Acad14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(princ
    (strcat "\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        "\n:: generar-gml.lsp Version 3 ; \\U+00A9 "
        (menucmd "m=$(edtime,0,yyyy)")
        " ChapulinCatastral https://github.com/chapulincatastral/ ::"
        "\n::     Escriba \"gml30\" para generar GML de Parcela en el huso 30 ::"
        "\n::     Escriba \"gmle\"  para generar GML de Edificio ::\n"
    )
)
(princ)
;;-----------------------------------------------------------------------------------;;
;;                             End of File                                           ;;
;;-----------------------------------------------------------------------------------;;