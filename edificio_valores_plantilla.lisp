;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Valores para el GML de edificio en versiones de AutoCad que no soportan formularios .dcl
;; R14, 2000 y versiones para MAC y Linux. Hacer una copia del original antes de moficarlo.
;; cuidado con los acentos y otros caráct. nacionales, es codificación ANSI, NO ES UTF-8 !! 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SI fuese necesario. Indicar un texto identificadoe del edificio 
(setq referencia_edificio_txt "EDIFICIO")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar si la obra está acabada o no. Comentar descomentar una de las dos líneas 
(setq obra_txt "obra_sin_acabar")
;(setq obra_txt "obra_acabada")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar la fecha de inicio solo si es "obra_acabada"
;(setq fecha_inicio_txt "01-01-2001")
;(setq fecha_inicio_txt "DD-MM-AAAA")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar fecha fin de obras solo si es "obra_acabada"
(setq fecha_fin_txt "")
;(setq fecha_fin_txt "DD-MM-AAAA")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar el índice del huso. 
; descomentar/comentar una de las siguientes lineas
;(setq item_huso "EPSG::32628") ;; por defecto uso28
;(setq item_huso "EPSG::25829") ;; por defecto uso29
(setq item_huso "EPSG::25830") ;; por defecto uso30
;(setq item_huso "EPSG::25831") ;; por defecto uso31
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar la precisión de la cartogafía; dejar como está si usamos de base la Catastral
(setq precision_txt "0,1")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar el uso o destino de la construcción
; descomentar/comentar una de las siguientes lineas
(setq item_uso "") ; por defecto uso destino no se indica
;(setq item_uso "1_residential") ; 1_residential
;(setq item_uso "2_agriculture") ; 2_agriculture
;(setq item_uso "3_industrial") ; 3_industrial
;(setq item_uso "4_commerceAndServices") ; 4_commerceAndServices
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar el número de inmuebles
(setq inmuebles_txt "1")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar el número de viviendas
(setq viviendas_txt "1")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar el número de plantas del edificio
(setq plantas_txt "1")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar la superfici construida en m2
(setq superficie_txt "100")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar lugar y fecha 
(setq lugar_y_fecha_txt "En Anywhere a 1 de enero del 2001")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar la ante firma
;(setq antefirma_txt "")
(setq antefirma_txt "El Técnico")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Indicar el pie de firma
(setq posfirma_txt "Don Juan Español")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FIN DE LAS DEFINICON DE EDIFICIO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(princ)