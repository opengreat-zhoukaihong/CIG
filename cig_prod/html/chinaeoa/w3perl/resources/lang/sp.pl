#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                    Language Script                             #####
####                     (http server)                              #####
####                                                                #####
####    domisse@w3perl.com                   version 15/08/2000     #####
####                                                                #####
#########################################################################

# Look for YYY string for new or updated strings

%LangSP = (
"Only_files", "YYYOnly files",
"Filetype", "YYYFiletype",
"28800_modem", "modem 28800",
"A_description" , "Una descripcion",
"About_months" , "Tabla de meses", 
"About_weeks" , "Tabla de semanas", 
"Absolute_links", "Links absolutos",
"Acces_not_taken_into_account", "Accesos no considerados",
"Accesses" , "Accesos", 
"All_html_pages_requests", "Todas las peticiones de paginas",
"All_images_requests", "Todas las peticiones a imagenes",
"All_requests" , "Todas las peticiones",
"All_sites" , "Todos los ",
"At", "En",
"Average_CPU", "Promedio CPU",
"Average", "Media",
"Average_is_black", "La media esta en negro",
"Average_on_hours_and_days", "Media de horas y dias",
"Average_pages_by_session", "Media de paginas leidas por sesion",
"Average_session_time", "Tiempo medio de una sesion",
"Average_reading_time_per_page", "Tiempo medio por lectura de pagina",
"Back", "Atras",
"Background", "Fondo",
"Bad_links", "Links erroneos",
"Blue_line_is_average", "La linea azul es la media",
"Browser" , "Navegador",
"Browsers" , "Navegadores",
"Browsers_used" , "Navegadores utilizados",
"CPU", "Tiempo CPU",
"Cgi-bin", "Cgi-bin",
"Conn_Mach" , "maquinas conectadas", 
"Connection_time", "Tiempo de conexion",
"Correct_size_taken_from_image", "Tamano correcto cogido de la imagen",
"Countries", "Paises", 
"Data", "Datos",
"Data_traffic_by_weeks" , "Trafico de datos por semanas",
"Data_unit_octet" , "bytes",
"Data_unit_Kb" , "Kilobytes",
"Data_unit_Mb" , "Megabytes",
"Date" , "Fecha",
"Days", "Dias", 
"Decrease_over_the_previous_day","Decrimento del dia anterior",
"Directories" , "Directorios",
"Directories_graphs" , "Graficos de directorios",
"Docs" , "Documentos",
"Documents" , "Documentos",
"DomReq" , "Peticiones de dominio", 
"Domain", "Dominio",
"Domain_Hosts" , "Hosts de Dominios",
"Download", "YYYDownload",
"Downloading_time", "Tiempo de bajada",
"Error", "Error",
"Errors" , "Errores",
"Evolution_of", "Evolucion de",
"File", "Fichero",
"For_people" , "Para la gente que ho puede ver graficos",
"Forbidden", "Prohibido",
"Found_in", "Encontrado en",
"Frames", "Frames",
"Frames_excluding", "Frames excluyendo",
"Global_access", "Accesos Globales",
"Graphic" , "Grafico",
"Graphs_for" , "Graficos para",
"Graphs_for_dir" , "Graficos para el directorio",
"HTMLPage_Acc" , "de paginas html accedidas", 
"HTML_accesses", "Accesos HTML",
"HTML_files", "Ficheros HTML",
"HTML_pages", "Paginas HTML",
"HTML_pages_only", "Paginas HTML solo",
"Histogram_about_average_request", "Histograma de la media de peticiones",
"Histogram_sessions", "Histograma de sesiones",
"Hits", "Accesos",
"Hosts", "Hosts",
"Hosts_excluding", "Hosts excluidos",
"Hosts_from" , "Hosts de",
"Hour" , "Hora", 
"Hours" , "Horas", 
"Image", "Imagen",
"Images", "Imagenes", 
"Images_histogram", "Histograma de imagenes",
"Images_never_used", "Imagenes nunca utilizadas",
"Increase_over_the_previous_day", "Incremento sobre el dia anterior",
"Index", "Indice",
"Index_pages", "Paginas Indice",
"Inside" , "Dentro",
"Kb" , "Kb", 
"Kbytes" , "Kilobytes", 
"Keywords", "Palabra Clave",
"Language" , "Espa�ol",
"Last_occurence" , "Ultima ocurrencia",
"Last_try", "Ultimo intento",
"Legend_in_bracket", "Leyenda en parentesis",
"Level", "Nivel",
"Lines_processed", "Lineas Procesadas",
"Link", "Link",
"Links", "Links",
"Links_histogram", "Histograma de links",
"ListOf" , "Lista de",
"ListOfSites" , "Lista de sites",
"List_of", "Lista de",
"List_of_unresolved_hosts", "sin resolver",
"Login", "Login", 
"Longest_external_session", "Sesion externa mas larga",
"Longest_local_session", "Sesion local mas larga",
"Longest_session", "Sesion mas larga",
"Mach_Dom" , " maquinas del dominio", 
"Mb" , "Mb",
"Mbytes" , "Megabytes",
"Mhosts" , "hosts",
"Misc", "Misc",
"Method", "Metodo",
"MonthByMonth" , "mes a mes", 
"Month_of" , "Mes del",
"Month", "Mes",
"Months" , "Meses", 
"More_Precise" , "mas preciso",
"MostSuccesf" , "el mas accedido",
"Multiple_sessions", "Sesiones multiples",
"New_country", "Nuevos Paises",
"New_HTML_files", "Fichero HTML nuevos",
"New_Hosts" , "Nuevos hosts",
"New_Mach" , "maquinas nuevas", 
"Newest_pages", "Paginas mas nuevas",
"Newest_pages_histogram", "Histograma de paginas mas nuevas",
"News" , "Noticias",
"NoReq" , "de peticiones",
"No_HTML_Acc" , "numero de paginas html accedidas", 
"No_Ttl_Req_Mnth" , "numero total de peticiones por mes",
"No_Ttl_Req_Week" , "numero total de peticiones por semana",
"No_login", "Accesos sin Login",
"No_modification", "sin modificacion",
"No_request", "Ninguna peticion ha sido hecha",
"No_robot_session", "No hay sesiones de robots",
"No_title", "Sin titulo",
"Not_found", "No encontrado",
"Number" , "Numero",
"Number_of" , "numero de", 
"Number_of_HTML_files", "Numero de ficheros HTML",
"Number_of_different_resolved_countries" , "YYYNumero de paises diferentes",
"Number_of_different_pages_used" , "Numero de paginas diferentes leidas",
"Number_of_different_sites" , "Numero de sites diferentes",
"Number_of_pages_read", "Numero de paginas leidas",
"Number_of_req_by_weeks" , "Numero de ocurrencias por semanas",
"Number_of_requests", "Numero de peticiones",
"Number_of_visits", "Numero de visitas",
"OS" , "Sistema Operativo",
"OS_used1" , "Los",
"OS_used2" , "sistemas operativos usados",
"Occurence" , "Ocurrencia",
"On", "Sobre", 
"Only_HTML_files_itself", "Solo el peso de HTMl",
"Only_directories", "Solo directorios",
"Only_first", "Solo el primero",
"Only_hosts", "Solo hosts",
"Only_pages", "Solo paginas",
"Only_scripts", "Solo scripts",
"Only_time_session_upper", "Solo sessiones con tiempo mayor de",
"Others" , "Otros",
"Outside" , "De fuera",
"Page", "Pagina",
"Page_read", "Paginas leidas",
"Page_reading_time_histogram", "Histograma de lectura de paginas HTML",
"Pages", "Paginas",
"Pages_excluding", "Paginas excluidas", 
"Pages_never_used", "Paginas nunca accedidas", 
"Percentage" , "Porcentaje", 
"Proxy", "Proxy",
"Reading_time", "Tiempo de lectura",
"Reading_time_sessions", "Sesiones con tiempo de lectura",
"Redirect", "Redireccion",
"References_for" , "Referencias sobre",
"Referer" , "Referer",
"Referer_about" , "Referer sobre",
"Referer_on" , "Referer de",
"Referer_pages2" , "Paginas Referer",
"Request" , "Peticion", 
"Requests" , "Peticiones", 
"Robots_excluding", "Robots excluyendo",
"Robot_name", "Nombre Robot",
"Robot_session_exclude", "Sesiones de Robot han sido excluidas",
"Same_over_the_previous_day", "Mismo sobre el dia anterior",
"Same_title", "El mismo titulo",
"Scripts", "Scripts",
"Search_engine", "Buscador",
"Send_me_an", "Mandeme una",
"Server_pages2" , "Paginas de servidor",
"Server_tree", "arbol del servidor",
"Session", "Sesion",
"Session_cut1", "Si una sesion es mas larga de un dia, sera contada en el primer dia",
"Session_cut2", "Puede haber habido inexactitud si alguna sesion todavia esta corriendo hoy",
"Session_time", "Tiempo de sesion",
"Session_title", "Tiempo de sesiones",
"Sessions" , "Sesiones",
"Sessions_from", "Sesiones de",
"Sorted_countries_list", "Lista ordenada por paises",
"Sorted_virtual_server_list", "Lista de servidor virtuales ordenadas",
"Speed", "Velocidad",
"Stats_about_CPU", "Estadisticas sobre tiempo CPU",
"Stats" , "Estadisticas", 
"Stats_aboutMnth" , "Estadisticas de",
"Stats_about_HTML_files", "Estadisticas de ficheros HTML",
"Stats_about_HTML_files_weight", "Estadisticas del peso de los ficheros HTML",
"Stats_about_alt", "Estadisticas sobre ALT",
"Stats_about_errors" , "Estadisticas de errores", 
"Stats_about_host" , "Estadisticas de hosts", 
"Stats_about_hosts", "Estadisticas sobre hosts",
"Stats_about_images", "Estadisticas sobre imagenes",
"Stats_about_internal_links", "Estadisticas sobre los enlaces internos",
"Stats_about_login", "Estadisticas de login",
"Stats_about_months" , "Estadisticas de meses", 
"Stats_about_robots_sessions", "Estadisticas de sesiones de Robots",
"Stats_about_session_length", "Estadisticas de duracion de sesion",
"Stats_about_sessions", "Estadisticas sobre sesiones",
"Stats_about_visits", "Estadisticas sobre visitas",
"Stats_about_virtual_servers", "Estadisticas sobre servidores virtuales",
"Stats_about_weeks" , "Estadisticas de semanas", 
"Stats_about_width", "Estadisticas de tamano",
"Stats_aboutlastdays1" , "Estadisticas sobre los ultimos",
"Stats_aboutlastdays2" , "dias",
"String", "Cadena",
"Successful_pages" , "Paginas accedidas",
"Summary", "Sumario",
"Symbolic_links", "Links simbolicos",
"Tab_about_lastdays1" , "Tabla de datos de los ultimos",
"Tab_about_lastdays2" , "dias",
"Table" , "Tabla", 
"Text" , "Texto",
"Textual_version" , "Version de texto",
"The_Top", "El mayor",
"Time", "Tiempo",
"Total", "Total",
"Total_HTML_access", "Numero total de accesos HTML",
"Total_data_sent" , "Totales de datos enviados",
"Total_number_of_directories", "Numero total de directorios",
"Total_number_of_html_files", "Numero total de ficheros HTML",
"Total_number_of_images", "Numero total de imagenes",
"Total_number_of_images_in_files", "Numero total de imagenes en paginas HTML",
"Total_number_of_links", "Numero total de links",
"Total_number_of_requests" , "Numero total de peticiones",
"Total_number_of_scripts", "Numero total de scripts",
"Total_number_of_robot_session", "Numero total de sesiones de robot",
"Total_number_sessions", "Numero total de sesiones",
"Total_traffic" , "Trafico total",
"Traffic" , "Trafico", 
"Traffic_about" , "Trafico de",
"Traffic_statistics" , "Estadisticas de trafico",
"Tree", "Arbol",
"Useless_pages", "Paginas sin uso",
"Users" , "Usuarios",
"Virtual_servers", "Servidores Virtuales",
"You_should_add", "Debe anadir",
"Web_size", "tamano de Web",
"Week", "Semana", 
"Weeks" , "Semanas", 
"Weight_HTML_files_histogram", "Histograma del peso de HTML",
"Weight_of_HTML_files", "peso de paginas HTML",
"With" , "con", 
"about" , "sobre", 
"about_hours_and_days", "sobre horas y dias",
"absolute_links", "links absolutos",
"added_pages", "Si quiere anadir alguna de sus paginas aqui",
"all_sites", "todos los sites",
"among" , "sobre", 
"and", "y",
"are_printed", "impresos",
"average_HTML_accesses", "Media de accesos de paginas HTMl",
"bad_links", "links erroneos",
"by", "por",
"by_day", "por dia",
"by_hour", "por hora",
"bytes" , "bytes", 
"chronological_order", "orden cronologico",
"coming_from", "viniendo de",
"computed_with", "computado con ",
"connecting_to", "accediendo a",
"connecting_to_the_server", "conectando al servidor",
"countries", "paises",
"daily" , "diario",
"data_sent_for_dir" , "datos enviados para el directorio",
"day" , "dia", 
"days", "dias",
"description", "descripcion",
"different_images", "imagenes diferentes",
"different_references_found", "Distintas referencias encontradas", 
"directories" , "directorios",
"directory" , "directorio",
"domain", "dominio",
"engine_keywords_used", "palabras clave utilizadas",
"exceeding", "pasando",
"excluding", "excluyendo",
"external" , "exterior",
"files_stored_locally_CD-ROM", "en estos links si estan guardados en el disco local o CD-ROM",
"for_today" , "para hoy",
"from", "de",
"from_dom" , "del dominio", 
"from domain", "del dominio",
"from_outside", "de fuera",
"global", "global",
"hTML_pages", "paginas HTML",
"have", "tiene",
"hour" , "hora", 
"hours" , "horas", 
"host", "host",
"hosts", "hosts",
"images", "imagenes",
"images_found_on_server", "imagenes encontradas en este servidor",  
"in", "en",
"in_this_directory", "en este directorio",
"in_whole_directory", "en todo el directirio",
"internal", "interno",
"last_read_on", "leido por ultima vez el", 
"less_than", "menos de",
"links", "links", 
"local", "local",
"maximum", "maximo",
"minimum", "minimo",
"minutes", "minutos",
"minute", "minuto",
"modified_less_than", "modificado menos de",
"monthly", "meses",
"more_than" , "mas de",
"most_common_errors" , "errores mas comunes",
"most_graphic_pages", "paginas con mas graficos",
"most_linky_pages", "paginas con los mas ",
"most_successful_hosts" , "hosts mas vistos",
"most_succf_browsers_vtime1" , "El",
"most_succf_browsers_vtime2" , "Navegadores mas usados en tiempo",
"most_succf_browsers1" , "El",
"most_succf_browsers2" , "navegadores mas usados",
"most_weighty_pages", "paginas mas grandes",
"no_reference_found", "referencia no encontrada",
"not_defined", "no definido",
"not_included", "no esta incluido",
"of_different_hosts" , "de hosts diferentes",
"of_months" , "de meses", 
"on", "sobre",
"only_reading_time_below", "solo tiempo de lectura menor de",
"only_session_more_than", "solo sesiones con mas de",
"optdirsize1" , "(paginas HTML externas y de dominios)",
"optdirsize2" , "(paginas externas HTML)",
"optdirsize3" , "(paginas HTML de dominios)",
"optdirsize4" , "(todas las peticiones externas y de dominios)",
"optdirsize5" , "(todas las peticiones externas)",
"optdirsize6" , "(todas las peticiones de dominios)",
"pages_found_on_server", "paginas encontradas en el servidor", 
"page", "pagina",
"pages" , "paginas", 
"percentage" , "porcentaje",
"read_by", "leido por",
"referer_pages1" , "paginas referer",
"request" , "peticion", 
"requests" , "peticiones", 
"resolved_countries", "paises resueltos",
"scripts", "scripts",
"search_engine", "busqueda de maquina",
"seconds", "segundos",
"server_pages1" , "paginas de servidor",
"session", "sesiones",
"sessions", "sesiones",
"since", "desde",
"sites", "sites",
"symbolic_links", "link simbolicos",
"table_of_data" , "tabla de datos",
"text_only", "solo texto",
"the" , "el", 
"there_are", "hay",
"there_is" , "hay una",
"times" , "veces",
"to", "a",
"today", "hoy",
"top" , "maximo",
"top_external_sites" , "sites externas",
"top_local_sites" , "sites locales",
"total" , "total",
"total_data_sent_for" , "datos totales enviados para",
"total_for" , "para",
"traffic_in" , "trafico en",
"unknown", "desconocido",
"unresolved", "sin resolver",
"used", "usado en el servidor",
"used2", "usado en el servidor",
"visitors", "visitantes",
"weekly", "semanal",
"weight", "peso",
"weighting", "pesando",
"will_be_printed", "sera impreso",
"with_at_least", "con al menos",
"with_less_than", "con menos de",
"with_most_accesses", "con mas accesos",
"with_the_same_title", "con el mismo titulo",
"without", "sin",
"without_title", "sin titulo",
"wrong", "mal",
"Ascension", "YYYAscension",
"Andorra", "Andorra",
"United-Arab-Emirates", "United-Arab-Emirates", 
"Afghanistan", "Afghanistan",
"Anguilla", "Anguilla",
"Albania", "Albania",
"Antigua-and-Barbuda", "Antigua y Barbuda",
"Armenia", "Armenia",
"Arpa", "Arpanet",
"Argentina", "Argentina",
"Angola", "Angola",
"Antartica", "Antartica",
"Austria", "Austria",
"Australia", "Australia",
"Aruba", "Aruba",
"Azerbaijan", "Azerbaijan",
"Bosnia-Herzegovina", "Bosnia Herzegovina",
"Bangladesh", "Bangladesh",
"Barbados", "Barbados",
"Belgium", "Belgica",
"Burkina-Faso", "Burkina Faso",
"Bulgaria", "Bulgaria",
"Bahrain", "Bahrain",
"Bermuda", "Bermuda",
"Brunei-Darussalam", "Brunei Darussalam",
"Burundi", "Burundi",
"Benin", "Benin",
"Bolivia", "Bolivia",
"Brazil", "Brazil",
"Bahamas", "Bahamas",
"Botswana", "Botswana",
"Belarus", "Belarus",
"Belize", "Belize",
"Buthan", "YYYButhan",
"British-Indian-Ocean-Territory", "YYYBritish Indian Ocean Territory",
"Canada", "Canada",
"Central-African-Rep", "Rep Centro-Africana",
"Congo", "Congo",
"Switzerland", "Suiza",
"Ivory-Coast", "Costa de Marfil",
"Chile", "Chile",
"Cameroon", "Cameron",
"China", "China",
"Colombia", "Colombia",
"Cook-Islands", "Cook Islands",
"US-Commercial", "US Comercial",
"Costa-Rica", "Costa Rica",
"Cuba", "Cuba",
"Cyprus", "Chipre",
"Czech-Republic", "Republica Checa",
"Germany", "Alemania",
"Djibouti", "Djibouti",
"Denmark", "Dinamarca",
"Dominica", "Dominica",
"Dominican-Republic", "Republica Dominicana",
"Algeria", "Algeria",
"Ecuador", "Ecuador",
"US-Educational", "US Educacion",
"Estonia", "Estonia",
"Egypt", "Egipto",
"Spain", "Espana",
"Ethiopia", "Etiopia",
"Finland", "Finlandia",
"Fidji", "Fidji",
"Faroe-Islands", "Islas Faroe",
"France", "Francia",
"Gabon", "Gabon",
"Great-Britain", "Reino Unido",
"French-Guiana", "Guayana Francesa",
"Georgia", "Georgia",
"Ghana", "Ghana",
"Gibraltar", "Gilbraltar",
"US-Government", "US Gobierno",
"Guadeloupe", "Guadeloupe",
"Greece", "Grecia",
"Greenland", "Greolandia",
"Guinea", "Guinea",
"Guyana", "Guyana",
"Guatemala", "Guatemala",
"Guam", "Guam",
"Guinea-Bissau", "Guinea Bissau",
"Hong-Kong", "Hong-Kong", 
"Honduras", "Honduras",
"Croatia", "Croacia",
"Hungary", "Hungria",
"Indonesia", "Indonesia",
"Ireland", "Irlanda",
"Israel", "Israel",
"India", "India",
"International", "Internacional",
"Iceland", "Islandia",
"Iran", "Iran",
"Italy", "Italia",
"Jamaica", "Jamaica",
"Japan", "Japon",
"Jordan", "Jordania",
"Cambodia", "Camboya",
"Comoros", "YYYComoros",
"South-Korea", "Corea del Sur",
"Kenya", "Kenia",
"Kuwait", "Kuwait",
"Kazachstan", "Kazachstan",
"Kyrgyzstan", "Kyrgyzstan",
"Cayman-Islands", "Islas Cayman",
"Christmas-Island", "Islas Christmas",
"Lebanon", "Lebano",
"Saint-Tome-and-Principe", "YYYSaint Tome and Principe",
"Sainte-Lucia", "Sainte Lucia",
"Lesotho", "Lesotho",
"Liechtenstein", "Liechtenstein",
"Lithuania", "Lithuania",
"Latvia", "Latvia",
"Luxembourg", "Luxemburgo",
"Sri-Lanka", "Sri Lanka",
"US-Military", "US Militar",
"Madagascar", "Madagascar",
"Macau", "Macau",
"Macedonia", "Macedonia",
"Mexico", "Mexico",
"Malaysia", "Malaysia",
"Morocco", "Maruecos",
"Moldova", "Moldovia",
"Micronesia", "Micronesia",
"Monaco", "Monaco",
"Maldives", "Maldives",
"Martinique", "YYYMartinique (French)",
"Malta", "Malta",
"Mauritius", "Mauritus",
"Mauritania", "Mauritania",
"Mozambique", "Mozambique",
"Namibia", "Namibia",
"NATO", "NATO",
"New-Caledonia", "New Caledonia", 
"Network", "Network",
"Nicaragua", "Nicaragua",
"Niger", "Niger",
"Nigeria", "Nigeria",
"Netherlands", "Holanda",
"Norway", "Noruega",
"Nepal", "Nepal",
"New-Zealand", "Nueva Zelanda",
"Niue", "Niue",
"Non-Profit", "Organizaciones",
"Oman", "Oman",
"Papua-New-Guinea", "Papua - New Guinea",
"Panama", "Panama",
"Puerto-Rico", "Puerto Rico",
"French-Polynesia", "Polynesia Francesa",
"Pakistan", "Pakistan",
"Paraguay", "Paraguay",
"Peru", "Peru",
"Philippines", "Filipinas",
"Poland", "Polonia",
"Portugal", "Portugal",
"Qatar", "Qatar",
"Romania", "Rumania",
"Russian-Federation", "Federation Rusa",
"Saudi-Arabia", "Arabia Saudita",
"San-Marino", "San Marino",
"Senegal", "Senegal",
"Sierra-Leone", "Sierra Leone",
"Sweden", "Suecia",
"Singapore", "Singapore",
"Slovenia", "Slovenia",
"Slovakia", "Slovakia",
"Swaziland", "Swaziland",
"Soviet-Union", "Union Sovietica",
"El-Savaldor", "El Salvador",
"Chad", "Chad",
"Tanzania", "Tanzania",
"Togo", "Togo",
"Thailand", "Tailandia",
"Tonga", "Tonga",
"Turkey", "Turkia",
"Taiwan", "Taiwan",
"Trinidad-and-Tobago", "Trinidad y Tobago",
"Turkmenistan", "Turkmenistan",
"Tunisia", "Tunez",
"Ukraine", "Ukrania",
"Uganda", "Uganda",
"United-Kingdom", "Reino Unido",
"United-States", "Estados Unidos",
"Uruguay", "Uruguay",
"Uzbekistan", "Uzbekistan",
"Vatican", "Vaticano",
"Venezuela", "Venezuela",
"Vietnam", "Vietnam",
"Virgin-Islands-USA", "Islas Virgenes (EEUU)",
"Virgin-Islands-UK", "Islas Virgenes (British)",
"South-Africa", "Sudafrica",
"Yemen", "Yemen",
"Yugoslavia", "Yugoslavia",
"Zambia", "Zambia",
"Zimbabwe", "Zimbabwe",
"Norfolk-Island", "Norfolk Island",
"Netherlands-Antilles", "Netherlands Antilles",
"American-Samoa", "American Samoa",
"Mongolia", "Mongolia",
"Iraq", "Iraq",
"Vanuatu", "Vanuatu",
"Mali", "Mali",
"Rwanda", "Rwanda",
"Heard-and-McDonald-Islands", "Heard and McDonald Islands",
"Solomon-Islands", "Solomon Islands",
"Cocos-Islands", "Cocos Islands",
"Samoa", "Samoa",
"Mayotte", "Mayotte",
"Turks-and-Caicos-Islands","Turks and Caicos Islands",
"Saint-Pierre-et-Miquelon","Saint Pierre and Miquelon",
"Sierra-Leone", "Sierra Leone",
"Unknown", "Desconocido"
 );