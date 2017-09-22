<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
	session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<title>CERTIFICADOS</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="Description"
	content="Innovación en Gestión Empresarial">



<script type="text/javascript" src="Scripts/noticias.js"></script>

<style type="text/css">
sinestilo: {
	
}
</style>


<script language="javascript" type="text/javascript">
	function fMenu() {
		var vError1 = false;
		var vError2 = false;
		if (document.getElementById('usuario').value == "") {
			vError1 = true;

		}
		if (document.getElementById('contrasena').value == "") {
			vError2 = true;
		}
		if (vError1) {
			if (vError2) {
				alert('¡Debe digitar su documento y contraseña de administrador!');
				document.getElementById('usuario').focus();

			} else {
				alert('¡Debe digitar su documento!');
				document.getElementById('usuario').focus();
			}
		} else {
			if (vError2) {
				alert('¡Debe especificar la contraseña!');
				document.getElementById('contrasena').focus();
			} else {
				document.siss.submit();
			}

		}

	}
</script>






<link rel="alternate" type="application/rss+xml"
	title="Isoluciones &raquo; Feed" href="../feed/index.html" />
<link rel="alternate" type="application/rss+xml"
	title="Isoluciones &raquo; RSS de los comentarios"
	href="../comments/feed/index.html" />
<script type="text/javascript">
			window._wpemojiSettings = {"baseUrl":"https:\/\/s.w.org\/images\/core\/emoji\/72x72\/","ext":".png","source":{"concatemoji":"http:\/\/isolucionesltda.com\/wp-includes\/js\/wp-emoji-release.min.js?ver=4.5.4"}};
			!function(a,b,c){function d(a){var c,d,e,f=b.createElement("canvas"),g=f.getContext&&f.getContext("2d"),h=String.fromCharCode;if(!g||!g.fillText)return!1;switch(g.textBaseline="top",g.font="600 32px Arial",a){case"flag":return g.fillText(h(55356,56806,55356,56826),0,0),f.toDataURL().length>3e3;case"diversity":return g.fillText(h(55356,57221),0,0),c=g.getImageData(16,16,1,1).data,d=c[0]+","+c[1]+","+c[2]+","+c[3],g.fillText(h(55356,57221,55356,57343),0,0),c=g.getImageData(16,16,1,1).data,e=c[0]+","+c[1]+","+c[2]+","+c[3],d!==e;case"simple":return g.fillText(h(55357,56835),0,0),0!==g.getImageData(16,16,1,1).data[0];case"unicode8":return g.fillText(h(55356,57135),0,0),0!==g.getImageData(16,16,1,1).data[0]}return!1}function e(a){var c=b.createElement("script");c.src=a,c.type="text/javascript",b.getElementsByTagName("head")[0].appendChild(c)}var f,g,h,i;for(i=Array("simple","flag","unicode8","diversity"),c.supports={everything:!0,everythingExceptFlag:!0},h=0;h<i.length;h++)c.supports[i[h]]=d(i[h]),c.supports.everything=c.supports.everything&&c.supports[i[h]],"flag"!==i[h]&&(c.supports.everythingExceptFlag=c.supports.everythingExceptFlag&&c.supports[i[h]]);c.supports.everythingExceptFlag=c.supports.everythingExceptFlag&&!c.supports.flag,c.DOMReady=!1,c.readyCallback=function(){c.DOMReady=!0},c.supports.everything||(g=function(){c.readyCallback()},b.addEventListener?(b.addEventListener("DOMContentLoaded",g,!1),a.addEventListener("load",g,!1)):(a.attachEvent("onload",g),b.attachEvent("onreadystatechange",function(){"complete"===b.readyState&&c.readyCallback()})),f=c.source||{},f.concatemoji?e(f.concatemoji):f.wpemoji&&f.twemoji&&(e(f.twemoji),e(f.wpemoji)))}(window,document,window._wpemojiSettings);
		</script>
<style type="text/css">
img.wp-smiley,img.emoji {
	display: inline !important;
	border: none !important;
	box-shadow: none !important;
	height: 1em !important;
	width: 1em !important;
	margin: 0 .07em !important;
	vertical-align: -0.1em !important;
	background: none !important;
	padding: 0 !important;
}
</style>
<link rel='stylesheet' id='et-gf-open-sans-css'
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,700'
	type='text/css' media='all' />
<link rel='stylesheet' id='et_monarch-css-css'
	href='wp-content/plugins/monarch/css/stylee7f0.css?ver=1.3.1'
	type='text/css' media='all' />
<link rel='stylesheet' id='divi-fonts-css'
	href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800&amp;subset=latin,latin-ext'
	type='text/css' media='all' />
<link rel='stylesheet' id='et-gf-arimo-css'
	href='http://fonts.googleapis.com/css?family=Arimo:400,400italic,700italic,700&amp;subset=latin,cyrillic-ext,latin-ext,greek-ext,cyrillic,greek,vietnamese'
	type='text/css' media='all' />
<link rel='stylesheet' id='et-gf-lato-css'
	href='http://fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,700italic,900,900italic&amp;subset=latin'
	type='text/css' media='all' />
<link rel='stylesheet' id='divi-style-css'
	href='wp-content/themes/Divi/style3b33.css?ver=2.7.7' type='text/css'
	media='all' />
<link rel='stylesheet' id='et-shortcodes-css-css'
	href='wp-content/themes/Divi/epanel/shortcodes/css/shortcodes3b33.css?ver=2.7.7'
	type='text/css' media='all' />
<link rel='stylesheet' id='et-shortcodes-responsive-css-css'
	href='wp-content/themes/Divi/epanel/shortcodes/css/shortcodes_responsive3b33.css?ver=2.7.7'
	type='text/css' media='all' />
<link rel='stylesheet' id='magnific-popup-css'
	href='wp-content/themes/Divi/includes/builder/styles/magnific_popup3b33.css?ver=2.7.7'
	type='text/css' media='all' />
<script type='text/javascript'
	src='wp-includes/js/jquery/jqueryb8ff.js?ver=1.12.4'></script>
<script type='text/javascript'
	src='wp-includes/js/jquery/jquery-migrate.min330a.js?ver=1.4.1'></script>
<link rel='https://api.w.org/' href='../wp-json/index.html' />
<link rel="EditURI" type="application/rsd+xml" title="RSD"
	href="../xmlrpc0db0.php?rsd" />
<link rel="wlwmanifest" type="application/wlwmanifest+xml"
	href="wp-includes/wlwmanifest.xml" />
<meta name="generator" content="WordPress 4.5.4" />
<link rel='shortlink' href='../index6b92.html?p=465' />
<link rel="alternate" type="application/json+oembed"
	href="../wp-json/oembed/1.0/embed74b0.json?url=http%3A%2F%2Fisolucionesltda.com%2Fconsultoria-empresarial%2F" />
<link rel="alternate" type="text/xml+oembed"
	href="../wp-json/oembed/1.0/embed508b?url=http%3A%2F%2Fisolucionesltda.com%2Fconsultoria-empresarial%2F&amp;format=xml" />
<style type="text/css" id="et-social-custom-css">
</style>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<style id="theme-customizer-css">
@media only screen and ( min-width: 767px ) {
	body,.et_pb_column_1_2 .et_quote_content blockquote cite,.et_pb_column_1_2 .et_link_content a.et_link_main_url,.et_pb_column_1_3 .et_quote_content blockquote cite,.et_pb_column_3_8 .et_quote_content blockquote cite,.et_pb_column_1_4 .et_quote_content blockquote cite,.et_pb_blog_grid .et_quote_content blockquote cite,.et_pb_column_1_3 .et_link_content a.et_link_main_url,.et_pb_column_3_8 .et_link_content a.et_link_main_url,.et_pb_column_1_4 .et_link_content a.et_link_main_url,.et_pb_blog_grid .et_link_content a.et_link_main_url,body .et_pb_bg_layout_light .et_pb_post p,body .et_pb_bg_layout_dark .et_pb_post p
		{
		font-size: 13px;
	}
	.et_pb_slide_content,.et_pb_best_value {
		font-size: 14px;
	}
}

body {
	color: #333333;
}

h1,h2,h3,h4,h5,h6 {
	color: #444444;
}

#top-header,#et-secondary-nav li ul {
	background-color: #919191;
}

.et_header_style_centered .mobile_nav .select_page,.et_header_style_split .mobile_nav .select_page,.et_nav_text_color_light #top-menu>li>a,.et_nav_text_color_dark #top-menu>li>a,#top-menu a,.et_mobile_menu li a,.et_nav_text_color_light .et_mobile_menu li a,.et_nav_text_color_dark .et_mobile_menu li a,#et_search_icon:before,.et_search_form_container input,span.et_close_search_field:after,#et-top-navigation .et-cart-info
	{
	color: #595959;
}

.et_search_form_container input::-moz-placeholder {
	color: #595959;
}

.et_search_form_container input::-webkit-input-placeholder {
	color: #595959;
}

.et_search_form_container input:-ms-input-placeholder {
	color: #595959;
}

.footer-widget,.footer-widget li,.footer-widget li a,#footer-info {
	font-size: 10px;
}

.footer-widget .et_pb_widget div,.footer-widget .et_pb_widget ul,.footer-widget .et_pb_widget ol,.footer-widget .et_pb_widget label
	{
	line-height: 1.5em;
}

#footer-widgets .footer-widget li:before {
	top: 4.5px;
}

#footer-info {
	font-size: 11px;
}

#footer-bottom .et-social-icon a {
	font-size: 26px;
}

#footer-bottom .et-social-icon a {
	color: #59a1ff;
}

body .et_pb_button,.woocommerce a.button.alt,.woocommerce-page a.button.alt,.woocommerce button.button.alt,.woocommerce-page button.button.alt,.woocommerce input.button.alt,.woocommerce-page input.button.alt,.woocommerce #respond input#submit.alt,.woocommerce-page #respond input#submit.alt,.woocommerce #content input.button.alt,.woocommerce-page #content input.button.alt,.woocommerce a.button,.woocommerce-page a.button,.woocommerce button.button,.woocommerce-page button.button,.woocommerce input.button,.woocommerce-page input.button,.woocommerce #respond input#submit,.woocommerce-page #respond input#submit,.woocommerce #content input.button,.woocommerce-page #content input.button
	{
	font-size: 18px;
	border-width: 1px !important;
	border-radius: 0px;
}

body.et_pb_button_helper_class .et_pb_button,.woocommerce.et_pb_button_helper_class a.button.alt,.woocommerce-page.et_pb_button_helper_class a.button.alt,.woocommerce.et_pb_button_helper_class button.button.alt,.woocommerce-page.et_pb_button_helper_class button.button.alt,.woocommerce.et_pb_button_helper_class input.button.alt,.woocommerce-page.et_pb_button_helper_class input.button.alt,.woocommerce.et_pb_button_helper_class #respond input#submit.alt,.woocommerce-page.et_pb_button_helper_class #respond input#submit.alt,.woocommerce.et_pb_button_helper_class #content input.button.alt,.woocommerce-page.et_pb_button_helper_class #content input.button.alt,.woocommerce.et_pb_button_helper_class a.button,.woocommerce-page.et_pb_button_helper_class a.button,.woocommerce.et_pb_button_helper_class button.button,.woocommerce-page.et_pb_button_helper_class button.button,.woocommerce.et_pb_button_helper_class input.button,.woocommerce-page.et_pb_button_helper_class input.button,.woocommerce.et_pb_button_helper_class #respond input#submit,.woocommerce-page.et_pb_button_helper_class #respond input#submit,.woocommerce.et_pb_button_helper_class #content input.button,.woocommerce-page.et_pb_button_helper_class #content input.button
	{
	
}

body .et_pb_button:after,.woocommerce a.button.alt:after,.woocommerce-page a.button.alt:after,.woocommerce button.button.alt:after,.woocommerce-page button.button.alt:after,.woocommerce input.button.alt:after,.woocommerce-page input.button.alt:after,.woocommerce #respond input#submit.alt:after,.woocommerce-page #respond input#submit.alt:after,.woocommerce #content input.button.alt:after,.woocommerce-page #content input.button.alt:after,.woocommerce a.button:after,.woocommerce-page a.button:after,.woocommerce button.button:after,.woocommerce-page button.button:after,.woocommerce input.button:after,.woocommerce-page input.button:after,.woocommerce #respond input#submit:after,.woocommerce-page #respond input#submit:after,.woocommerce #content input.button:after,.woocommerce-page #content input.button:after
	{
	font-size: 28.8px;
}

body .et_pb_button:hover,.woocommerce a.button.alt:hover,.woocommerce-page a.button.alt:hover,.woocommerce button.button.alt:hover,.woocommerce-page button.button.alt:hover,.woocommerce input.button.alt:hover,.woocommerce-page input.button.alt:hover,.woocommerce #respond input#submit.alt:hover,.woocommerce-page #respond input#submit.alt:hover,.woocommerce #content input.button.alt:hover,.woocommerce-page #content input.button.alt:hover,.woocommerce a.button:hover,.woocommerce-page a.button:hover,.woocommerce button.button,.woocommerce-page button.button:hover,.woocommerce input.button:hover,.woocommerce-page input.button:hover,.woocommerce #respond input#submit:hover,.woocommerce-page #respond input#submit:hover,.woocommerce #content input.button:hover,.woocommerce-page #content input.button:hover
	{
	border-radius: 0px;
}

@media only screen and ( min-width: 981px ) {
	.et_pb_section {
		padding: 0% 0;
	}
	.et_pb_section.et_pb_section_first {
		padding-top: inherit;
	}
	.et_pb_fullwidth_section {
		padding: 0;
	}
	.footer-widget h4 {
		font-size: 14px;
	}
	.et_header_style_centered.et_hide_primary_logo #main-header:not (.et-fixed-header
		 ) .logo_container,.et_header_style_centered.et_hide_fixed_logo #main-header.et-fixed-header .logo_container
		{
		height: 11.88px;
	}
	.et-fixed-header#top-header,.et-fixed-header#top-header #et-secondary-nav li ul
		{
		background-color: #919191;
	}
	.et-fixed-header #top-menu a,.et-fixed-header #et_search_icon:before,.et-fixed-header #et_top_search .et-search-form input,.et-fixed-header .et_search_form_container input,.et-fixed-header .et_close_search_field:after,.et-fixed-header #et-top-navigation .et-cart-info
		{
		color: #595959 !important;
	}
	.et-fixed-header .et_search_form_container input::-moz-placeholder {
		color: #595959 !important;
	}
	.et-fixed-header .et_search_form_container input::-webkit-input-placeholder
		{
		color: #595959 !important;
	}
	.et-fixed-header .et_search_form_container input:-ms-input-placeholder {
		color: #595959 !important;
	}
}

@media only screen and ( min-width: 1350px) {
	.et_pb_row {
		padding: 27px 0;
	}
	.et_pb_section {
		padding: 0px 0;
	}
	.single.et_pb_pagebuilder_layout.et_full_width_page .et_post_meta_wrapper
		{
		padding-top: 81px;
	}
	.et_pb_section.et_pb_section_first {
		padding-top: inherit;
	}
	.et_pb_fullwidth_section {
		padding: 0;
	}
}

@media only screen and ( max-width: 980px ) {
}

@media only screen and ( max-width: 767px ) {
}
</style>

<style class="et_heading_font">
h1,h2,h3,h4,h5,h6 {
	font-family: 'Open Sans', Helvetica, Arial, Lucida, sans-serif;
	font-weight: 300;
}
</style>
<style class="et_body_font">
body,input,textarea,select {
	font-family: 'Arimo', Helvetica, Arial, Lucida, sans-serif;
}
</style>
<style class="et_primary_nav_font">
#main-header,#et-top-navigation {
	font-family: 'Lato', Helvetica, Arial, Lucida, sans-serif;
}
</style>
<style class="et_secondary_nav_font">
#top-header .container {
	font-family: 'Open Sans', Helvetica, Arial, Lucida, sans-serif;
}
</style>


<style id="module-customizer-css">
</style>

<link rel="shortcut icon"
	href="wp-content/uploads/2016/02/facivon-1.png" />
<!-- All in one Favicon 4.3 -->
<link rel="shortcut icon" href="wp-content/uploads/2016/02/facivon.png" />
<link rel="icon"
	href="wp-content/uploads/2016/02/Logo-Isoluciones-1.png"
	type="image/gif" />
<link rel="icon"
	href="wp-content/uploads/2016/02/cropped-Logo-Isoluciones-32x32.png"
	sizes="32x32" />
<link rel="icon"
	href="wp-content/uploads/2016/02/cropped-Logo-Isoluciones-192x192.png"
	sizes="192x192" />
<link rel="apple-touch-icon-precomposed"
	href="wp-content/uploads/2016/02/cropped-Logo-Isoluciones-180x180.png" />
<meta name="msapplication-TileImage"
	content="http://isolucionesltda.com/wp-content/uploads/2016/02/cropped-Logo-Isoluciones-270x270.png" />











</head>

<body
	class="page page-id-465 page-template-default et_monarch et_bloom et_pb_button_helper_class et_fixed_nav et_show_nav et_secondary_nav_enabled et_pb_gutter windows et_pb_gutters2 et_primary_nav_dropdown_animation_fade et_secondary_nav_dropdown_animation_fade et_pb_footer_columns3 et_header_style_left et_pb_pagebuilder_layout et_right_sidebar chrome">

	<form id="siss" name="siss" action="home.jsp" method="post">
		<input type="hidden" name="usuario" id="usuario"> <input
			type="hidden" name="contrasena" id="contrasena">
	</form>

	<%
		session.invalidate();
			response.setHeader("Cache-Control", "no-store");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", 0);
	%>


	<div id="page-container">

		<div id="top-header">
			<div class="container clearfix">


				<div id="et-info">
					<span id="et-info-phone">(7) 696 0495</span>

				</div>
				<!-- #et-info -->


				<div id="et-secondary-menu"></div>
				<!-- #et-secondary-menu -->

			</div>
			<!-- .container -->
		</div>
		<!-- #top-header -->


			<header id="main-header" data-height-onload="66">
		<div class="container clearfix et_menu_container">
			<div class="logo_container">
				<span class="logo_helper"></span> <a href="http://www.isolucionesltda.com"> <img
					src="wp-content/uploads/2016/04/logo_isoluciones_min.png"
					alt="Isoluciones" id="logo" style="height: 150px;" />
				</a>
			</div>
			<div id="et-top-navigation" data-height="66" data-fixed-height="40">
				<nav id="top-menu-nav">
				<ul id="top-menu" class="nav">
				
				<li id="menu-item-419" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-419"><a href="http://www.isolucionesltda.com/quienes-somos">QUIÉNES SOMOS</a>
<ul class="sub-menu">
	<li id="menu-item-418" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-418"><a href="http://www.isolucionesltda.com/nuestra-esencia">Nuestra esencia</a></li>
	<li id="menu-item-363" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-363"><a href="http://www.isolucionesltda.com">Directrices estratégicas</a></li>
</ul>
</li>
				
				<li id="menu-item-268" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-268"><a href="#">NUESTROS SERVICIOS</a>
<ul class="sub-menu">
	<li id="menu-item-467" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-467"><a href="http://www.isolucionesltda.com/consultoria-empresarial">Consultoría</a></li>
	<li id="menu-item-473" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-473"><a href="http://www.isolucionesltda.com/consultoria-sistemas-gestion">Consultoria en Sistemas de Gestión</a></li>
	<li id="menu-item-365" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-365"><a href="http://www.isolucionesltda.com">Consultoría Virtual</a></li>
	<li id="menu-item-438" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-438"><a href="http://www.isolucionesltda.com/formacion-empresarial">Formación empresarial</a></li>
	<li id="menu-item-457" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-457"><a href="http://www.isolucionesltda.com/e-learning">E-learning</a></li>
	<li id="menu-item-368" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-368"><a href="http://www.isolucionesltda.com">Auditoria</a></li>
	<li id="menu-item-369" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-369"><a href="http://www.isolucionesltda.com">Gobierno</a></li>
</ul>
</li>


<li id="menu-item-370"
						class="menu-item menu-item-type-custom menu-item-object-custom menu-item-370"><a
						href="index.jsp">CERTIFICADOS EN LÍNEA</a></li>
				
					<li id="menu-item-269"
						class="menu-item menu-item-type-custom menu-item-object-custom current-menu-ancestor current-menu-parent menu-item-269"><a
						href="clientes.jsp">CLIENTES</a></li>
					
					<li id="menu-item-371"
						class="menu-item menu-item-type-custom menu-item-object-custom menu-item-371"><a  
						href="#" onclick="window.open('/i-web/indexadmin.jsp', 'administrador', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=300, height=350'); return false;">LOGIN ADMINISTRADOR</a></li>
				</ul>
				</nav>





				<div id="et_mobile_nav_menu">
					<div class="mobile_nav closed">
						<span class="select_page">Seleccionar página</span> <span
							class="mobile_menu_bar mobile_menu_bar_toggle"></span>
					</div>
				</div>
			</div>
			<!-- #et-top-navigation -->
		</div>
		<!-- .container --> </header>
		<!-- #main-header -->

		<div id="et-main-area">
			<div id="main-content">





				<article id="post-471"
					class="post-471 page type-page status-publish hentry">


				<div class="entry-content">
					<div
						class="et_pb_section et_pb_fullwidth_section  et_pb_section_0 et_section_regular">



						<section
							class="et_pb_fullwidth_header et_pb_module et_pb_bg_layout_dark et_pb_text_align_left  et_pb_fullwidth_header_0">

						<div class="et_pb_fullwidth_header_container left">
							<div class="header-content-container center">
								<div class="header-content">

									<h1>NUESTROS CLIENTES</h1>



								</div>
							</div>

						</div>
						<div class="et_pb_fullwidth_header_overlay"></div>
						<div class="et_pb_fullwidth_header_scroll"></div>
						</section>

					</div>
					<!-- .et_pb_section -->
					<div class="et_pb_section  et_pb_section_1 et_section_regular">



						<div class=" et_pb_row et_pb_row_0">

							<div class="et_pb_column et_pb_column_4_4  et_pb_column_0">

								<div
									class="et_pb_text et_pb_module et_pb_bg_layout_light et_pb_text_align_left  et_pb_text_0">

								</div>
								<!-- .et_pb_text -->
							</div>
							<!-- .et_pb_column -->

						</div>
						<!-- .et_pb_row -->

					</div>
					<!-- .et_pb_section -->
					<div class="et_pb_section  et_pb_section_2 et_section_regular">

						<% 
							String directorio_ruta = application.getRealPath("imagenes")+"/logosFinanciadores/";
							List<Object[]> cursos = bAdministrarPublicaciones.getFinanciadores();
							
							String rutaImagen = "";

							int cuentaColumnas = 0;
							int n=0;
							int sw=0;
							if (cursos!=null && cursos.size() > 0) {
								for(Object[] c: cursos){
								n++;
								if(cuentaColumnas==0){
						%>

						<div class=" et_pb_row et_pb_row_1">

<%
								}
								sw=0;
								List<String> cuales = new ArrayList<String>();
								int numeroLogos = 0;
								if(c[2]!=null && c[2].equals("S")){
									numeroLogos++;
									cuales.add("1");
									
									if(c[5]!=null){
									sw=1;
									bAdministrarPublicaciones.guardarArchivoDisco(directorio_ruta + "logo_financiador_"+c[0]+"-1.jpg", (byte[])c[5]);
									
									}
								}
								
								if(c[3]!=null && c[3].equals("S")){
									numeroLogos++;
									cuales.add("2");
									if(c[6]!=null){
									bAdministrarPublicaciones.guardarArchivoDisco(directorio_ruta + "logo_financiador_"+c[0]+"-2.jpg", (byte[])c[6]);
									}
								}
								
								if(c[4]!=null && c[4].equals("S")){
									numeroLogos++;
									cuales.add("3");
									if(c[7]!=null){
										sw=1;
									bAdministrarPublicaciones.guardarArchivoDisco(directorio_ruta + "logo_financiador_"+c[0]+"-3.jpg", (byte[])c[7]);
									}
								}
								
								int cuenta=0;
								if(numeroLogos>0){
									
									for(String p: cuales){
										cuenta++;
										if(cuenta==1){
											
											if(sw==1){
												rutaImagen = "/i-web/ver_foto_adjunta.jsp?id="+c[0]+"&n="+p;
											}else{
												
												rutaImagen = "imagenes/logosFinanciadores/logo_financiador_"+c[0]+"-"+p+".jpg";
											}
											
											break;
											
											
										}else{
											
											if(sw==1){
												rutaImagen = "/i-web/ver_foto_adjunta.jsp?id="+c[0]+"&n="+p;
											}else{
												
												rutaImagen = "imagenes/logosFinanciadores/logo_financiador_"+c[0]+"-"+p+".jpg";
											}
											break;
											
										}
										
									}
									
									
									
									
								}
								
								
								
								
								
								
								
%>
							<div class="et_pb_column et_pb_column_1_4  et_pb_column_1" style="vertical-align: bottom;">

								<div
									class="et_pb_blurb et_pb_module et_pb_bg_layout_light et_pb_text_align_center  et_pb_blurb_0 ">
									<div class="et_pb_blurb_content"  style="vertical-align: bottom;">
										<div class="et_pb_main_blurb_image">
											
											<div class="et_pb_blurb_container"  style="vertical-align: bottom;">
											<h4>
												<a href="index.jsp"><%=c[1] %></a>
											</h4>
</div>
											<a href="index.jsp">
											
											<%
											if(numeroLogos==0){
											%>
										<img  src="imagenes/sinimagen.jpg" style="width: 200px; height:auto; vertical-align: top;">
												
												<%}else{ %>
												
												<img  src="<%= rutaImagen%>" style="width: 200px; height:auto; vertical-align: top;">
												<%} %>
												</a>
										</div>
										
									</div>
									<!-- .et_pb_blurb_content -->
								</div>
								<!-- .et_pb_blurb -->
							</div>
							
						
							


<%




if(cuentaColumnas>=3){
	cuentaColumnas=0;
}else{
	
	cuentaColumnas++;
}




if(n==cursos.size()){
	cuentaColumnas =0;
}




if(cuentaColumnas==0){
%>
						</div>

<%} 



%>
						<%
							}
								
							}
						%>



					</div>




				</div>
				</article>



			</div>
			<!-- #main-content -->


			<footer id="main-footer">



			<div id="et-footer-nav">
				<div class="container">
					<ul id="menu-cabezote" class="bottom-nav">
						<li
							class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-419"><a
							href="http://www.isolucionesltda.com/quienes-somos">QUIENES SOMOS</a></li>
						
						<li
							class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-420"><a
							href="http://www.isolucionesltda.com/consultoria-empresarial">NUESTROS SERVICIOS</a></li>
							
						
							
						<li  
							class="menu-item menu-item-type-custom menu-item-object-custom current-menu-ancestor current-menu-parent menu-item-has-children menu-item-269"><a
							href="index.jsp">CERTIFICADOS EN LÍNEA</a></li>
						<li
							class="menu-item menu-item-type-custom menu-item-object-custom menu-item-370"><a
							href="clientes.jsp">CLIENTES</a></li>
						<li
							class="menu-item menu-item-type-custom menu-item-object-custom menu-item-371"><a href="#" onclick="window.open('/i-web/indexadmin.jsp', 'administrador', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=300, height=350'); return false;">LOGIN ADMINISTRADOR</a></li>
					</ul>
				</div>
			</div>
			<!-- #et-footer-nav -->


			<div id="footer-bottom">
				<div class="container clearfix">
					<ul class="et-social-icons">

						<li class="et-social-icon et-social-facebook"><a
							href="http://www.facebook.com/Isolucionessas" class="icon"
							target="_blank"> <span>Facebook</span>
						</a></li>
						<li class="et-social-icon et-social-youtube"><a
							href="https://www.youtube.com/channel/UChS1AGiOflOSFs1GaENI2AQ"
							class="icon" target="_blank"> <span>youtube</span>
						</a></li>
						<li class="et-social-icon et-social-google-plus"><a
							href="https://plus.google.com/u/0/b/105940587211498233230/105940587211498233230"
							class="icon" target="_blank"> <span>Google</span>
						</a></li>
						<li class="et-social-icon et-social-rss"><a
							href="http://www.isolucionesltda.com/feed/index.html"
							class="icon" target="_blank"> <span>RSS</span>
						</a></li>

					</ul>
					<p id="footer-info">Software de certificados desarrollado por
						quimerapps.com (dannypipe@gmail.com)</p>
				</div>
				<!-- .container -->
			</div>
			</footer>
			<!-- #main-footer -->
		</div>
		<!-- #et-main-area -->


	</div>
	<!-- #page-container -->

	<style type="text/css" id="et-builder-advanced-style">
.et_pb_fullwidth_header_0.et_pb_fullwidth_header {
	background-color: #0c71c3;
}
</style>
	<script type='text/javascript'
		src='wp-content/themes/Divi/includes/builder/scripts/frontend-builder-global-functions3b33.js?ver=2.7.7'></script>
	<script type='text/javascript'
		src='wp-content/plugins/monarch/js/idle-timer.mine7f0.js?ver=1.3.1'></script>
	<script type='text/javascript'>
/* <![CDATA[ */
var monarchSettings = {"ajaxurl":"http:\/\/isolucionesltda.com\/wp-admin\/admin-ajax.php","pageurl":"http:\/\/isolucionesltda.com\/consultoria-empresarial\/","stats_nonce":"033fc75c6b","share_counts":"99443b39d0","follow_counts":"c858ea5386","total_counts":"b1cec78d61","media_single":"5cfb29252a","media_total":"6d45d331d8","generate_all_window_nonce":"9cd056305f","no_img_message":"No images available for sharing on this page"};
/* ]]> */
</script>
	<script type='text/javascript'
		src='wp-content/plugins/monarch/js/custome7f0.js?ver=1.3.1'></script>
	<script type='text/javascript'
		src='wp-content/themes/Divi/includes/builder/scripts/jquery.mobile.custom.min3b33.js?ver=2.7.7'></script>
	<script type='text/javascript'
		src='wp-content/themes/Divi/js/custom3b33.js?ver=2.7.7'></script>
	<script type='text/javascript'
		src='wp-content/themes/Divi/js/smoothscroll3b33.js?ver=2.7.7'></script>
	<script type='text/javascript'
		src='wp-content/themes/Divi/includes/builder/scripts/jquery.fitvids3b33.js?ver=2.7.7'></script>
	<script type='text/javascript'
		src='wp-content/themes/Divi/includes/builder/scripts/waypoints.min3b33.js?ver=2.7.7'></script>
	<script type='text/javascript'
		src='wp-content/themes/Divi/includes/builder/scripts/jquery.magnific-popup3b33.js?ver=2.7.7'></script>
	<script type='text/javascript'>
/* <![CDATA[ */
var et_pb_custom = {"ajaxurl":"http:\/\/isolucionesltda.com\/wp-admin\/admin-ajax.php","images_uri":"http:\/\/isolucionesltda.com\/wp-content\/themes\/Divi\/images","builder_images_uri":"http:\/\/isolucionesltda.com\/wp-content\/themes\/Divi\/includes\/builder\/images","et_frontend_nonce":"1b9e9cac4b","subscription_failed":"Por favor, revise los campos a continuaci\u00f3n para asegurarse de que la informaci\u00f3n introducida es correcta.","et_ab_log_nonce":"e55b1b0d5f","fill_message":"Por favor, rellene los siguientes campos:","contact_error_message":"Por favor, arregle los siguientes errores:","invalid":"De correo electr\u00f3nico no v\u00e1lida","captcha":"Captcha","prev":"Anterior","previous":"Anterior","next":"Siguiente","wrong_captcha":"Ha introducido un n\u00famero equivocado de captcha.","is_builder_plugin_used":"","is_divi_theme_used":"1","widget_search_selector":".widget_search","is_ab_testing_active":"","page_id":"465","unique_test_id":"","ab_bounce_rate":"5","is_cache_plugin_active":"yes","is_shortcode_tracking":""};
/* ]]> */
</script>
	<script type='text/javascript'
		src='wp-content/themes/Divi/includes/builder/scripts/frontend-builder-scripts3b33.js?ver=2.7.7'></script>
	<script type='text/javascript'
		src='wp-includes/js/wp-embed.min67d0.js?ver=4.5.4'></script>
</body>



</html>
<script>
	function enviar_formulario() {

		mensaje = "";

		if (document.getElementById('nombres').value.replace(/^\s*|\s*$/g, "") == "") {
			mensaje = mensaje + "\n* Debe diligenciar nombre completo.";
		}

		if (document.getElementById('correo').value.replace(/^\s*|\s*$/g, "") == "") {
			mensaje = mensaje + "\n* Debe diligenciar el correo electrónico.";
		}

		if ((document.contact_form.correo.value != "")
				&& (!es_correo(document.contact_form.correo.value))) {
			mensaje = mensaje
					+ "\n* El correo electrónico no tiene una estructura válida.";

		}

		if (document.getElementById('telefono').value.replace(/^\s*|\s*$/g, "") == "") {
			mensaje = mensaje + "\n* Debe diligenciar el teléfono ó celular.";
		}

		if ((document.contact_form.telefono.value != "")
				&& (!es_numero(document.contact_form.telefono.value))) {
			mensaje = mensaje
					+ "\n* El teléfono ó celular contiene caractéres no válidos (Debe ser numérico).";

		}

		if (document.getElementById('txtContenido').value.replace(/^\s*|\s*$/g,
				"") == "") {
			mensaje = mensaje + "\n* Debe diligenciar el correo electrónico.";
		}

		if (mensaje != "") {
			alert("Por favor revise lo siguiente:\n\n " + mensaje);

		} else {

			document.getElementById('bandera').value = "1";
			document.contact_form.submit();
		}

	}

	function limpiar_formulario() {

		document.getElementById('nombres').value = "";
		document.getElementById('correo').value = "";
		document.getElementById('telefono').value = "";
		document.getElementById('txtContenido').value = "";
		alert('Formulario limpiado');
		document.contact_form.nombres.focus();

	}

	function es_correo(direccion) {
		var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if (filter.test(direccion))
			return true;
		else
			return false;
	}

	function es_numero(cadena) {
		var longit = cadena.length;

		for (k = 0; k < longit; k++) {
			var car = cadena.charAt(k);
			if ((car != '1') && (car != '2') && (car != '3') && (car != '4')
					&& (car != '5') && (car != '6') && (car != '7')
					&& (car != '8') && (car != '9') && (car != '0'))
				return false;
		}
		if (longit > 0)
			return true;
		else
			return false;
	}
</script>