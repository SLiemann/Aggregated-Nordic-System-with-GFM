![NordicLTVS](https://github.com/SLiemann/Aggregated-Nordic-System-with-GFM/assets/78535748/6819de0c-ba4a-4996-bd42-e1f36f0a1472)# Aggregated Nordic System (ANS) with Grid-Forming Converters

This repository contains the Simulink and PowerDynamics.jl models which are used in the paper:

S. Liemann, C. Rehtanz, "Voltage Stability Analysis of Grid-Forming Converters with Current Limitation", handed in for the PSCC 2024.

The models and code provided here can be used, shared and modified, but without any warranty.
In case you want to use these models for research, please have a look at the citation section below. 
The converter models where mainly taken from: https://github.com/ATayebi/GridFormingConverters

For further information or if you encounter some problems do not hesitate to contact us: sebastian.liemann (at) tu-dortmund.de

## Models

In the above paper an aggregated version of the Nordic Test System (see https://ieeexplore.ieee.org/document/9018172 for the original implementation) is derived for voltage stability analyses.
The idea is to have a grid model that captures the main voltage dynamics and stability properties, but is much more computionally efficient, e.g. for the acceleration of large-sampling studies. 
Since the analysis in the paper is divided into short-term/long-term voltage stability as well as EMT/phasor, this is also reflected by the provided files.

![<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<!-- Generiert durch Microsoft Visio, SVG Export NordicLTVS.svg Page-1 -->
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ev="http://www.w3.org/2001/xml-events"
		xmlns:v="http://schemas.microsoft.com/visio/2003/SVGExtensions/" width="3.79236in" height="2.8519in"
		viewBox="0 0 273.05 205.337" xml:space="preserve" color-interpolation-filters="sRGB" class="st40">
	<v:documentProperties v:langID="1031" v:metric="true" v:viewMarkup="false">
		<v:userDefs>
			<v:ud v:nameU="msvNoAutoConnect" v:val="VT0(0):26"/>
		</v:userDefs>
	</v:documentProperties>

	<style type="text/css">
	<![CDATA[
		.st1 {fill:#ffd965;fill-opacity:0.3;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.75}
		.st2 {fill:#ea700d;fill-opacity:0.3;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.75}
		.st3 {fill:#92d050;fill-opacity:0.3;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.75}
		.st4 {fill:#ffd965;fill-opacity:0.29;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.75}
		.st5 {stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st6 {stroke:#ff0000;stroke-dasharray:2.25,2.25;stroke-width:0.75}
		.st7 {stroke:#ff0000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.75}
		.st8 {fill:none;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st9 {fill:#000000;font-family:Times New Roman;font-size:0.666664em}
		.st10 {font-size:1em}
		.st11 {stroke:#ff0000;stroke-linecap:butt;stroke-width:0.75}
		.st12 {fill:none;stroke:#a5a5a5;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st13 {fill:#a5a5a5;font-family:CMU Serif;font-size:1.00001em}
		.st14 {stroke:#a5a5a5;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st15 {marker-end:url(#mrkr5-70);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st16 {fill:#000000;fill-opacity:1;stroke:#000000;stroke-opacity:1;stroke-width:0.25773195876289}
		.st17 {stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:1}
		.st18 {fill:none;stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st19 {fill:#000000;font-family:Times New Roman;font-size:0.666664em;font-weight:bold}
		.st20 {marker-end:url(#mrkr5-152);marker-start:url(#mrkr5-150);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st21 {fill:none;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.75}
		.st22 {fill:none;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.25}
		.st23 {fill:#000000;font-family:CMU Serif;font-size:0.666664em;font-style:italic}
		.st24 {baseline-shift:-25.0112%;font-size:0.500223em;font-style:normal}
		.st25 {fill:#92d050;stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st26 {fill:#000000;font-family:Times New Roman;font-size:0.499992em}
		.st27 {fill:#ffd965;stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st28 {fill:#ea700d;stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st29 {stroke:#000000;stroke-dasharray:3.5,2.5;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st30 {fill:#000000;stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.75}
		.st31 {marker-start:url(#mrkr5-150);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.5}
		.st32 {fill:#000000;font-family:Times New Roman;font-size:0.666664em;font-style:italic}
		.st33 {baseline-shift:-25.0112%;font-family:CMU Serif;font-size:0.500223em;font-style:normal}
		.st34 {font-size:1em;text-decoration:underline}
		.st35 {stroke:#000000;stroke-dasharray:5.25,3.75;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.75}
		.st36 {marker-end:url(#mrkr5-681);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.75}
		.st37 {fill:#000000;fill-opacity:1;stroke:#000000;stroke-opacity:1;stroke-width:0.34246575342466}
		.st38 {marker-end:url(#mrkr5-687);stroke:#ff0000;stroke-linecap:round;stroke-linejoin:round;stroke-width:0.75}
		.st39 {fill:#ff0000;fill-opacity:1;stroke:#ff0000;stroke-opacity:1;stroke-width:0.34246575342466}
		.st40 {fill:none;fill-rule:evenodd;font-size:12px;overflow:visible;stroke-linecap:square;stroke-miterlimit:3}
	]]>
	</style>

	<defs id="Markers">
		<g id="lend5">
			<path d="M 2 1 L 0 0 L 1.98117 -0.993387 C 1.67173 -0.364515 1.67301 0.372641 1.98465 1.00043 " style="stroke:none"/>
		</g>
		<marker id="mrkr5-70" class="st16" v:arrowType="5" v:arrowSize="0" v:setback="6.79" refX="-6.79" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend5" transform="scale(-3.88,-3.88) "/>
		</marker>
		<marker id="mrkr5-150" class="st16" v:arrowType="5" v:arrowSize="0" v:setback="6.07" refX="6.07" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend5" transform="scale(3.88) "/>
		</marker>
		<marker id="mrkr5-152" class="st16" v:arrowType="5" v:arrowSize="0" v:setback="6.07" refX="-6.07" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend5" transform="scale(-3.88,-3.88) "/>
		</marker>
		<marker id="mrkr5-681" class="st37" v:arrowType="5" v:arrowSize="0" v:setback="4.63" refX="-4.63" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend5" transform="scale(-2.92,-2.92) "/>
		</marker>
		<marker id="mrkr5-687" class="st39" v:arrowType="5" v:arrowSize="0" v:setback="5.11" refX="-5.11" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend5" transform="scale(-2.92,-2.92) "/>
		</marker>
	</defs>
	<g v:mID="0" v:index="1" v:groupContext="foregroundPage">
		<title>Zeichenblatt-1</title>
		<v:pageProperties v:drawingScale="0.0393701" v:pageScale="0.0393701" v:drawingUnits="24" v:shadowOffsetX="8.50394"
				v:shadowOffsetY="-8.50394"/>
		<v:layer v:name="Verbinder" v:index="0"/>
		<g id="shape829-1" v:mID="829" v:groupContext="shape" transform="translate(149.669,-25.2283)">
			<title>Tabelle.829</title>
			<rect x="0" y="176.423" width="80.7874" height="28.9134" class="st1"/>
		</g>
		<g id="shape825-3" v:mID="825" v:groupContext="shape" transform="translate(208.63,-2.83465)">
			<title>Tabelle.825</title>
			<rect x="0" y="182.943" width="62.5323" height="22.3937" class="st2"/>
		</g>
		<g id="shape368-5" v:mID="368" v:groupContext="shape" transform="translate(224.313,-156.092)">
			<title>Tabelle.368</title>
			<rect x="0" y="157.715" width="33.7323" height="47.622" class="st3"/>
		</g>
		<g id="shape369-7" v:mID="369" v:groupContext="shape" transform="translate(230.457,-25.2283)">
			<title>Tabelle.369</title>
			<rect x="0" y="176.423" width="40.6982" height="28.9134" class="st2"/>
		</g>
		<g id="shape373-9" v:mID="373" v:groupContext="shape" transform="translate(149.669,-54.1417)">
			<title>Tabelle.373</title>
			<rect x="0" y="165.465" width="65.0058" height="39.8715" class="st1"/>
		</g>
		<g id="shape372-11" v:mID="372" v:groupContext="shape" transform="translate(214.675,-54.3685)">
			<title>Tabelle.372</title>
			<rect x="0" y="165.595" width="56.4798" height="39.7417" class="st4"/>
		</g>
		<g id="shape295-13" v:mID="295" v:groupContext="shape" transform="translate(35.8422,31.2895) rotate(-90)">
			<title>Tabelle.295</title>
			<path d="M0 205.34 L14.79 205.34" class="st5"/>
		</g>
		<g id="shape296-16" v:mID="296" v:groupContext="shape" transform="translate(456.394,49.0855) rotate(90)">
			<title>Tabelle.296</title>
			<path d="M0 205.34 L62.05 205.34" class="st6"/>
		</g>
		<g id="shape297-19" v:mID="297" v:groupContext="shape" transform="translate(436.613,49.0855) rotate(90)">
			<title>Tabelle.297</title>
			<path d="M0 205.34 L62.05 205.34" class="st7"/>
		</g>
		<g id="shape302-22" v:mID="302" v:groupContext="shape" transform="translate(185.102,-190.734)">
			<title>Tabelle.302</title>
			<desc>stiff grid</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="21.7312" cy="200.481" width="43.47" height="9.71243"/>
			<rect x="0" y="195.624" width="43.4625" height="9.71243" class="st8"/>
			<text x="7.84" y="202.88" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>stiff grid</text>		</g>
		<g id="shape320-25" v:mID="320" v:groupContext="shape" transform="translate(160.85,-130.926)">
			<title>Tabelle.320</title>
			<desc>aggregation of other four lines</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="32.7559" cy="196.092" width="65.52" height="18.4902"/>
			<rect x="0" y="186.847" width="65.5118" height="18.4902" class="st8"/>
			<text x="9.54" y="193.69" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>aggregation of <tspan
						x="8.32" dy="1.2em" class="st10">other four lines</tspan></text>		</g>
		<g id="group321-29" transform="translate(102.422,-44.0957) rotate(-45)" v:mID="321" v:groupContext="group">
			<title>Tabelle.321</title>
			<g id="shape322-30" v:mID="322" v:groupContext="shape" transform="translate(200.381,156.86) rotate(77)">
				<title>Tabelle.322</title>
				<path d="M2.14 190.36 L0 198.92 L2.85 196.07 L0.71 205.34" class="st11"/>
			</g>
			<g id="shape323-33" v:mID="323" v:groupContext="shape">
				<title>Tabelle.323</title>
				<path d="M3.57 205.34 L0 203.73 L3.57 202.31" class="st11"/>
			</g>
		</g>
		<g id="shape324-36" v:mID="324" v:groupContext="shape" transform="translate(174.407,342.172) rotate(180)">
			<title>Tabelle.324</title>
			<ellipse cx="4.95509" cy="200.382" rx="4.95509" ry="4.95509" class="st12"/>
		</g>
		<g id="shape325-38" v:mID="325" v:groupContext="shape" transform="translate(162.94,-60.8292)">
			<title>Tabelle.325</title>
			<desc>~</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197" v:verticalAlign="0"/>
			<v:textRect cx="6.51217" cy="202.62" width="13.03" height="5.43434"/>
			<rect x="0" y="199.902" width="13.0243" height="5.43434" class="st8"/>
			<text x="2.85" y="210.7" class="st13" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>~</text>		</g>
		<g id="shape326-41" v:mID="326" v:groupContext="shape" transform="translate(253.622,387.996) rotate(180)">
			<title>Tabelle.326</title>
			<path d="M0 205.34 L5.44 205.34" class="st5"/>
		</g>
		<g id="shape327-44" v:mID="327" v:groupContext="shape" transform="translate(194.63,-169.718)">
			<title>Tabelle.327</title>
			<desc>400 kV</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="12.2441" cy="202.361" width="24.49" height="5.95139"/>
			<rect x="0" y="199.385" width="24.4883" height="5.95139" class="st8"/>
			<text x="0.36" y="204.76" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>400 kV</text>		</g>
		<g id="group334-47" transform="translate(174.611,-58.8947)" v:mID="334" v:groupContext="group">
			<title>Tabelle.334</title>
			<g id="group335-48" transform="translate(213.17,195.624) rotate(90)" v:mID="335" v:groupContext="group">
				<title>Tabelle.335</title>
				<g id="shape336-49" v:mID="336" v:groupContext="shape" transform="translate(0,-4.85622)">
					<title>Tabelle.336</title>
					<ellipse cx="4.85622" cy="200.481" rx="4.85622" ry="4.85622" class="st12"/>
				</g>
				<g id="shape337-51" v:mID="337" v:groupContext="shape">
					<title>Tabelle.337</title>
					<ellipse cx="4.85622" cy="200.481" rx="4.85622" ry="4.85622" class="st12"/>
				</g>
			</g>
			<g id="shape338-53" v:mID="338" v:groupContext="shape" transform="translate(22.402,-4.85622)">
				<title>Tabelle.338</title>
				<path d="M0 205.34 L8.79 205.34" class="st14"/>
			</g>
			<g id="shape339-56" v:mID="339" v:groupContext="shape" transform="translate(0.0904552,-4.82274) rotate(0.02524)">
				<title>Tabelle.339</title>
				<path d="M0 205.34 L7.83 205.34" class="st14"/>
			</g>
			<g id="shape340-59" v:mID="340" v:groupContext="shape" transform="translate(209.389,198.629) rotate(90)">
				<title>Tabelle.340</title>
				<path d="M0 205.34 L3.78 205.34" class="st14"/>
			</g>
		</g>
		<g id="shape342-62" v:mID="342" v:groupContext="shape" transform="translate(241.483,-55.9059)">
			<title>Tabelle.342</title>
			<desc>130 kV</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="14.836" cy="202.361" width="29.68" height="5.95139"/>
			<rect x="0" y="199.385" width="29.6721" height="5.95139" class="st8"/>
			<text x="2.95" y="204.76" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>130 kV</text>		</g>
		<g id="shape345-65" v:mID="345" v:groupContext="shape" transform="translate(131.254,3.40088) rotate(-33.6193)">
			<title>Tabelle.345</title>
			<path d="M0 205.34 L14.95 205.34" class="st15"/>
		</g>
		<g id="group354-71" transform="translate(246.102,-70.1067)" v:mID="354" v:groupContext="group">
			<title>Tabelle.354</title>
			<g id="shape355-72" v:mID="355" v:groupContext="shape" transform="translate(210.292,181.431) rotate(90)">
				<title>Tabelle.355</title>
				<path d="M0 205.34 L9.91 205.34" class="st5"/>
			</g>
			<g id="shape356-75" v:mID="356" v:groupContext="shape" transform="translate(9.91019,396.678) rotate(180)">
				<title>Tabelle.356</title>
				<path d="M0 205.34 L9.91 205.34" class="st5"/>
			</g>
			<g id="shape357-78" v:mID="357" v:groupContext="shape" transform="translate(9.91019,400.565) rotate(180)">
				<title>Tabelle.357</title>
				<path d="M0 205.34 L9.91 205.34" class="st5"/>
			</g>
			<g id="shape358-81" v:mID="358" v:groupContext="shape" transform="translate(210.292,195.229) rotate(90)">
				<title>Tabelle.358</title>
				<path d="M0 205.34 L9.91 205.34" class="st5"/>
			</g>
			<g id="shape359-84" v:mID="359" v:groupContext="shape" transform="translate(2.4884,-5.68434E-014)">
				<title>Tabelle.359</title>
				<path d="M0 205.34 L4.93 205.34" class="st5"/>
			</g>
		</g>
		<g id="shape294-87" v:mID="294" v:groupContext="shape" transform="translate(257.776,254.422) rotate(180)">
			<title>Tabelle.294</title>
			<path d="M0 205.34 L32.97 205.34" class="st17"/>
		</g>
		<g id="shape365-90" v:mID="365" v:groupContext="shape" transform="translate(259.255,-36.11)">
			<title>Tabelle.365</title>
			<desc>T3</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="5.95005" cy="202.361" width="11.91" height="5.95139"/>
			<rect x="0" y="199.385" width="11.9001" height="5.95139" class="st8"/>
			<text x="1.51" y="204.76" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>T3</text>		</g>
		<g id="shape366-93" v:mID="366" v:groupContext="shape" transform="translate(255.495,-79.084)">
			<title>Tabelle.366</title>
			<desc>C1</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.98943" cy="202.361" width="13.98" height="5.95139"/>
			<rect x="0" y="199.385" width="13.9789" height="5.95139" class="st8"/>
			<text x="2.32" y="204.76" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>C1</text>		</g>
		<g id="shape367-96" v:mID="367" v:groupContext="shape" transform="translate(217.701,-39.544)">
			<title>Tabelle.367</title>
			<desc>C2</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.98943" cy="202.361" width="13.98" height="5.95139"/>
			<rect x="0" y="199.385" width="13.9789" height="5.95139" class="st8"/>
			<text x="2.32" y="204.76" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>C2</text>		</g>
		<g id="shape375-99" v:mID="375" v:groupContext="shape" transform="translate(257.478,316.377) rotate(180)">
			<title>Tabelle.375</title>
			<path d="M0 205.34 L32.97 205.34" class="st17"/>
		</g>
		<g id="shape376-102" v:mID="376" v:groupContext="shape" transform="translate(411.128,151.091) rotate(90)">
			<title>Tabelle.376</title>
			<path d="M0 205.34 L7.85 205.34" class="st5"/>
		</g>
		<g id="group425-105" transform="translate(162.422,-41.0054)" v:mID="425" v:groupContext="group">
			<title>Tabelle.425</title>
			<g id="shape426-106" v:mID="426" v:groupContext="shape" transform="translate(206.383,194.376) rotate(90)">
				<title>Tabelle.426</title>
				<rect x="0" y="194.376" width="10.9606" height="10.9606" class="st18"/>
			</g>
			<g id="shape427-108" v:mID="427" v:groupContext="shape" transform="translate(157.202,339.571) rotate(135)">
				<title>Tabelle.427</title>
				<path d="M0 205.34 L15.5 205.34" class="st5"/>
			</g>
			<g id="shape428-111" v:mID="428" v:groupContext="shape" transform="translate(5.86576,403.278) rotate(180)">
				<title>Tabelle.428</title>
				<path d="M0 205.34 L3.12 205.34" class="st5"/>
			</g>
			<g id="shape429-114" v:mID="429" v:groupContext="shape" transform="translate(5.86576,401.941) rotate(180)">
				<title>Tabelle.429</title>
				<path d="M0 205.34 L3.12 205.34" class="st5"/>
			</g>
			<g id="shape430-117" v:mID="430" v:groupContext="shape" transform="translate(0,-0.736197)">
				<title>Tabelle.430</title>
				<desc>~</desc>
				<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
				<v:textRect cx="8.50394" cy="203.108" width="17.01" height="4.45684"/>
				<rect x="0" y="200.88" width="17.0079" height="4.45684" class="st8"/>
				<text x="6.42" y="205.51" class="st19" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>~</text>			</g>
		</g>
		<g id="group453-120" transform="translate(174.611,-41.535)" v:mID="453" v:groupContext="group">
			<title>Tabelle.453</title>
			<g id="group454-121" transform="translate(213.17,195.624) rotate(90)" v:mID="454" v:groupContext="group">
				<title>Tabelle.454</title>
				<g id="shape455-122" v:mID="455" v:groupContext="shape" transform="translate(0,-4.85622)">
					<title>Tabelle.455</title>
					<ellipse cx="4.85622" cy="200.481" rx="4.85622" ry="4.85622" class="st18"/>
				</g>
				<g id="shape456-124" v:mID="456" v:groupContext="shape">
					<title>Tabelle.456</title>
					<ellipse cx="4.85622" cy="200.481" rx="4.85622" ry="4.85622" class="st18"/>
				</g>
			</g>
			<g id="shape457-126" v:mID="457" v:groupContext="shape" transform="translate(22.402,-4.85622)">
				<title>Tabelle.457</title>
				<path d="M0 205.34 L8.79 205.34" class="st5"/>
			</g>
			<g id="shape458-129" v:mID="458" v:groupContext="shape" transform="translate(0.0904552,-4.82274) rotate(0.02524)">
				<title>Tabelle.458</title>
				<path d="M0 205.34 L7.83 205.34" class="st5"/>
			</g>
			<g id="shape459-132" v:mID="459" v:groupContext="shape" transform="translate(209.389,198.629) rotate(90)">
				<title>Tabelle.459</title>
				<path d="M0 205.34 L3.78 205.34" class="st5"/>
			</g>
		</g>
		<g id="shape460-135" v:mID="460" v:groupContext="shape" transform="translate(411.128,141.819) rotate(90)">
			<title>Tabelle.460</title>
			<path d="M0 205.34 L9.27 205.34" class="st14"/>
		</g>
		<g id="shape333-138" v:mID="333" v:groupContext="shape" transform="translate(271.155,356.428) rotate(180)">
			<title>Tabelle.333</title>
			<path d="M0 205.34 L73.77 205.34" class="st17"/>
		</g>
		<g id="shape402-141" v:mID="402" v:groupContext="shape" transform="translate(179.058,-31.3899)">
			<title>Tabelle.402</title>
			<desc>T2</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="11.1506" cy="200.481" width="22.31" height="9.71243"/>
			<rect x="0" y="195.624" width="22.3012" height="9.71243" class="st8"/>
			<text x="6.71" y="202.88" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>T2</text>		</g>
		<g id="shape463-144" v:mID="463" v:groupContext="shape" transform="translate(-43.7656,155.261) rotate(-90)">
			<title>Tabelle.463</title>
			<path d="M2.14 203.19 L2.4 202.93 A14.3616 9.97895 97.4 0 1 11.92 202.79 L12.16 203.06" class="st20"/>
		</g>
		<g id="shape775-153" v:mID="775" v:groupContext="shape" transform="translate(246.99,-157.497)">
			<title>Tabelle.775</title>
			<rect v:rectContext="foreign" x="0" y="194.347" width="11.0551" height="10.9893" class="st21"/>
			<switch>
				<foreignObject x="-221.779" y="194.347" width="453.6" height="19.4173"
						requiredExtensions="http://schemas.microsoft.com/visio/2003/SVGExtensions/">
					<v:foreignData v:orgSize="5940" clip="rect(0 220.766 8.42801 221.779)" v:data="data:metafile;base64,eNrtWE1I
								VFEU/u7zOT8aMUk/EiGTWpkVmbgqyGfSD6EgWuAiiESloYIICVqUg0xIrSRaiEiJRCuLoAhcBLNo088ighZRC3Mn0c5FgTSd
								++be9+bd3pt52nP8oTOcuef+vHvPvd/7LucdBuAyqRGGKVNUXoQtQ0eBJxoQP95+AmBo2gbcoPYNcMpoBfBgO/CW7Dhz9sW2
								lAB9OmgC7Of9pDTdPmYw7OD9pFos/YWP7dayyseeI+0QY6sN3Vqzyohadi3NIe0GQzPn0s1asnknbUr26Ybt81bhfyVpmVhf
								SlTUX28EJqnsJL3K+M6BV5lMJndfI8yau6IVF3AFPbiGBFlxtNP/gOMkl0lqfrO2iTuPFgaB6R8DzxfaPlunn3x58NNczlBZ
								v3V7xBzf0fA1OaTZ/QpsqFbqLVXZHc8OZp/PhDCTqcUxDh9vfygmkGeRTrU85uMOnbprjpcy8cLpF5fe64jwcpfAhuWxJSbm
								oj/dMYkaiAWCydO/fS0k/NwkJiSN1dYb1otNEQ1zKL4s5SxUTDTFljiUuHBjXnCGuKG10mpnac0u9Jnr9xdr0zU2DtPvFG6M
								K9wYd3IDJ/Nzo06pHwnNm2+kxQ0N377PsU4dmsKN7Fl4cmOsMDdKimxLnHUXvkmciW8IAueR+4vnW10u3xga63L4xmIrxbfF
								n4WKs67YEodSD77hP9+WhW+lPmzmw/a6P0NUflzlscWvN04808q5yfpKxxYzo4XxDOWxJSZhl7su6Njiw70gYoty665by7FF
								WLElDhEXbqy2uy6RdnKjYdKJq6yv9F3XMVGYGxEfdsiHHQnQlu9C1IWT8zYnA4k/jLF/jD/A4w+bk2s5/oh62H5ixTIP3q6m
								b4L1xNuyItsS53IPTgb5TfAsHcQ3wfrgZLmHvZT408+zFS7tfr4b/dztft61fGtVwsrpaWfojyvPY/K2BJU9wu/z74eNZmPY
								4H2nRVsbZJ4wKzLfx/ONXaS7fe7FzYd+WucAlTdFLjXXB97X7cOHS2JuP2el+tAtfOCSovKwiw/14h3I58Me+lHV1KXikRJ4
								TLngkfKJR5x0rzK/XJeGJXNtnjduEvzneeN6uoNqxbM8J8z/smrb/BmZh+bPaIadK+Z73yzsmLD/AIch8ng="/>
				</foreignObject>
				<!-- Unsupported Record: EmfPlusRecordTypeSetPixelOffsetMode  -->
				<svg viewBox="0 0 3770.8 162.07" clip="rect(0 220.766 8.42801 221.779)" height="19.4173" overflow="hidden"
						preserveAspectRatio="none" width="453.6" x="-221.779" y="194.347">
					<!-- GetDC -->
					<g stroke="#000000" stroke-miterlimit="10" fill="none">
						<g font-family="&#39;CMU Serif&#39;" font-style="italic" font-weight="500" font-size="67">
							<clipPath id="mfid1">
								<rect x="0" y="0" width="3780" height="162"/>
							</clipPath>
							<g clip-path="url(#mfid1)">
								<text stroke="none" fill="#000000" x="0,38" y="0" transform="translate(1856,74)"
										xml:space="preserve">S</text>
							</g>
						</g>
						<g font-family="&#39;CMU Serif&#39;" font-style="normal" font-weight="500" font-size="46">
							<clipPath id="mfid2">
								<rect x="0" y="0" width="3780" height="162"/>
							</clipPath>
							<g clip-path="url(#mfid2)">
								<text stroke="none" fill="#000000" x="0,24" y="0" transform="translate(1894,88)"
										xml:space="preserve">k</text>
							</g>
						</g>
						<g font-family="&#39;CMU Serif&#39;" font-style="italic" font-weight="500" font-size="46">
							<clipPath id="mfid3">
								<rect x="0" y="0" width="3780" height="162"/>
							</clipPath>
							<g clip-path="url(#mfid3)">
								<text stroke="none" fill="#000000" x="0,14,28" y="0" transform="translate(1894,42)"
										xml:space="preserve">&#39;&#39;</text>
							</g>
						</g>
						<g font-family="&#39;CMU Serif&#39;" font-style="italic" font-weight="500" font-size="67">
							<clipPath id="mfid4">
								<rect x="0" y="0" width="3780" height="162"/>
							</clipPath>
							<g clip-path="url(#mfid4)">
								<text stroke="none" fill="#000000" x="0,41" y="0" transform="translate(1924,74)"
										xml:space="preserve"> </text>
							</g>
						</g>
					</g>
					<!-- Released DC -->
				</svg>
			</switch>
			<rect v:rectContext="foreign" x="0" y="194.347" width="11.0551" height="10.9893" class="st21"/>
		</g>
		<g id="shape788-156" v:mID="788" v:groupContext="shape" transform="translate(212.887,-154.921)">
			<title>Tabelle.788</title>
			<desc>v1</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="5.95005" cy="202.01" width="11.91" height="6.65368"/>
			<rect x="0" y="198.683" width="11.9001" height="6.65368" class="st22"/>
			<text x="3.12" y="204.41" class="st23" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>v<tspan dy="-0.289em"
						class="st24" v:baseFontSize="6">1</tspan></text>		</g>
		<g id="shape789-160" v:mID="789" v:groupContext="shape" transform="translate(212.887,-95.2071)">
			<title>Tabelle.789</title>
			<desc>v2</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="5.95005" cy="202.01" width="11.91" height="6.65368"/>
			<rect x="0" y="198.683" width="11.9001" height="6.65368" class="st22"/>
			<text x="3.12" y="204.41" class="st23" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>v<tspan dy="-0.289em"
						class="st24" v:baseFontSize="6">2</tspan></text>		</g>
		<g id="shape790-164" v:mID="790" v:groupContext="shape" transform="translate(212.887,-55.5547)">
			<title>Tabelle.790</title>
			<desc>v3</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="5.95005" cy="202.01" width="11.91" height="6.65368"/>
			<rect x="0" y="198.683" width="11.9001" height="6.65368" class="st22"/>
			<text x="3.13" y="204.41" class="st23" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>v<tspan dy="-0.289em"
						class="st24" v:baseFontSize="6">3</tspan></text>		</g>
		<g id="shape791-168" v:mID="791" v:groupContext="shape" transform="translate(237.543,-21.2598)">
			<title>Tabelle.791</title>
			<desc>vL</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="5.95005" cy="202.01" width="11.91" height="6.65368"/>
			<rect x="0" y="198.683" width="11.9001" height="6.65368" class="st22"/>
			<text x="2.86" y="204.41" class="st23" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>v<tspan dy="-0.289em"
						class="st24" v:baseFontSize="6">L</tspan></text>		</g>
		<g id="shape792-172" v:mID="792" v:groupContext="shape" transform="translate(209.573,-70.05)">
			<title>Tabelle.792</title>
			<desc>T1</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="11.1506" cy="200.481" width="22.31" height="9.71243"/>
			<rect x="0" y="195.624" width="22.3012" height="9.71243" class="st8"/>
			<text x="6.71" y="202.88" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>T1</text>		</g>
		<g id="shape797-175" v:mID="797" v:groupContext="shape" transform="translate(149.669,-73.1339)">
			<title>Tabelle.797</title>
			<desc>sum of generation as SG or converter</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="31.2661" cy="196.124" width="62.54" height="18.4252"/>
			<rect x="0" y="186.912" width="62.5323" height="18.4252" class="st22"/>
			<text x="2.38" y="193.72" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>sum of generation <tspan
						x="1.39" dy="1.2em" class="st10">as SG or converter</tspan></text>		</g>
		<g id="shape199-179" v:mID="199" v:groupContext="shape" transform="translate(196.404,269.31) rotate(133.315)">
			<title>Tabelle.199</title>
			<path d="M0 205.34 L16.01 205.34" class="st5"/>
		</g>
		<g id="shape201-182" v:mID="201" v:groupContext="shape" transform="translate(232.588,172.275) rotate(90)">
			<title>Tabelle.201</title>
			<path d="M0 205.34 L12.27 205.34" class="st5"/>
		</g>
		<g id="shape202-185" v:mID="202" v:groupContext="shape" transform="translate(236.677,172.275) rotate(90)">
			<title>Tabelle.202</title>
			<path d="M0 205.34 L12.27 205.34" class="st5"/>
		</g>
		<g id="shape204-188" v:mID="204" v:groupContext="shape" transform="translate(274.421,176.624) rotate(90)">
			<title>Tabelle.204</title>
			<path d="M0 205.34 L14.09 205.34" class="st5"/>
		</g>
		<g id="shape205-191" v:mID="205" v:groupContext="shape" transform="translate(280.146,176.624) rotate(90)">
			<title>Tabelle.205</title>
			<path d="M0 205.34 L14.09 205.34" class="st5"/>
		</g>
		<g id="shape158-194" v:mID="158" v:groupContext="shape" transform="translate(3.15195,-169.482)">
			<title>Tabelle.158</title>
			<desc>4072</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st25"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4072</text>		</g>
		<g id="shape159-197" v:mID="159" v:groupContext="shape" transform="translate(7.74732,-186.421)">
			<title>Tabelle.159</title>
			<desc>4071</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st25"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4071</text>		</g>
		<g id="shape160-200" v:mID="160" v:groupContext="shape" transform="translate(28.193,-170.065)">
			<title>Tabelle.160</title>
			<desc>4012</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st25"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4012</text>		</g>
		<g id="shape161-203" v:mID="161" v:groupContext="shape" transform="translate(48.6387,-186.421)">
			<title>Tabelle.161</title>
			<desc>4011</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st25"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4011</text>		</g>
		<g id="shape162-206" v:mID="162" v:groupContext="shape" transform="translate(56.8169,-157.797)">
			<title>Tabelle.162</title>
			<desc>4022</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st25"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4022</text>		</g>
		<g id="shape168-209" v:mID="168" v:groupContext="shape" transform="translate(93.6191,-72.8016)">
			<title>Tabelle.168</title>
			<desc>4043</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4043</text>		</g>
		<g id="shape170-212" v:mID="170" v:groupContext="shape" transform="translate(120.199,-80.9798)">
			<title>Tabelle.170</title>
			<desc>4046</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4046</text>		</g>
		<g id="shape171-215" v:mID="171" v:groupContext="shape" transform="translate(120.199,-61.5091)">
			<title>Tabelle.171</title>
			<desc>4047</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4047</text>		</g>
		<g id="shape172-218" v:mID="172" v:groupContext="shape" transform="translate(63.2427,-28.7125)">
			<title>Tabelle.172</title>
			<desc>4045</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4045</text>		</g>
		<g id="shape173-221" v:mID="173" v:groupContext="shape" transform="translate(64.3136,-7.08661)">
			<title>Tabelle.173</title>
			<desc>4051</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4051</text>		</g>
		<g id="shape174-224" v:mID="174" v:groupContext="shape" transform="translate(24.0712,-57.144)">
			<title>Tabelle.174</title>
			<desc>4061</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4061</text>		</g>
		<g id="shape175-227" v:mID="175" v:groupContext="shape" transform="translate(18.5053,-32.6092)">
			<title>Tabelle.175</title>
			<desc>4062</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4062</text>		</g>
		<g id="shape176-230" v:mID="176" v:groupContext="shape" transform="translate(21.1176,-12.6162)">
			<title>Tabelle.176</title>
			<desc>4063</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4063</text>		</g>
		<g id="shape177-233" v:mID="177" v:groupContext="shape" transform="translate(203.737,95.1909) rotate(111.806)">
			<title>Tabelle.177</title>
			<path d="M0 205.34 L9.44 205.34" class="st5"/>
		</g>
		<g id="shape178-236" v:mID="178" v:groupContext="shape" transform="translate(184.165,-108.059) rotate(52.0418)">
			<title>Tabelle.178</title>
			<path d="M0 205.34 L12.28 205.34" class="st5"/>
		</g>
		<g id="shape179-239" v:mID="179" v:groupContext="shape" transform="translate(27.8864,-193.02) rotate(1.30766)">
			<title>Tabelle.179</title>
			<path d="M0 205.34 L25.95 205.34" class="st5"/>
		</g>
		<g id="shape180-242" v:mID="180" v:groupContext="shape" transform="translate(166.856,186.487) rotate(145.265)">
			<title>Tabelle.180</title>
			<path d="M0 205.34 L16.41 205.34" class="st5"/>
		</g>
		<g id="shape181-245" v:mID="181" v:groupContext="shape" transform="translate(132.1,-149.577) rotate(26.0147)">
			<title>Tabelle.181</title>
			<path d="M0 205.34 L16.64 205.34" class="st5"/>
		</g>
		<g id="shape182-248" v:mID="182" v:groupContext="shape" transform="translate(254.838,-43.666) rotate(72.2553)">
			<title>Tabelle.182</title>
			<path d="M0 205.34 L21.47 205.34" class="st5"/>
		</g>
		<g id="shape183-251" v:mID="183" v:groupContext="shape" transform="translate(128.022,-180.783) rotate(17.8765)">
			<title>Tabelle.183</title>
			<path d="M0 205.34 L47.59 205.34" class="st5"/>
		</g>
		<g id="shape184-254" v:mID="184" v:groupContext="shape" transform="translate(263.544,91.4195) rotate(102.339)">
			<title>Tabelle.184</title>
			<path d="M0 205.34 L19.14 205.34" class="st5"/>
		</g>
		<g id="shape185-257" v:mID="185" v:groupContext="shape" transform="translate(267.633,91.4195) rotate(102.339)">
			<title>Tabelle.185</title>
			<path d="M0 205.34 L19.14 205.34" class="st5"/>
		</g>
		<g id="shape186-260" v:mID="186" v:groupContext="shape" transform="translate(69.1458,-135.109) rotate(0.0174607)">
			<title>Tabelle.186</title>
			<path d="M0 205.34 L16.36 205.34" class="st5"/>
		</g>
		<g id="shape188-263" v:mID="188" v:groupContext="shape" transform="translate(296.887,51.7798) rotate(83.6723)">
			<title>Tabelle.188</title>
			<path d="M0 205.34 L29.68 205.34" class="st7"/>
		</g>
		<g id="shape189-266" v:mID="189" v:groupContext="shape" transform="translate(317.318,89.8549) rotate(104.993)">
			<title>Tabelle.189</title>
			<path d="M0 205.34 L69.55 205.34" class="st7"/>
		</g>
		<g id="shape190-269" v:mID="190" v:groupContext="shape" transform="translate(296.112,59.1819) rotate(75.0686)">
			<title>Tabelle.190</title>
			<path d="M0 205.34 L12.7 205.34" class="st5"/>
		</g>
		<g id="shape191-272" v:mID="191" v:groupContext="shape" transform="translate(10.2836,-52.6276) rotate(-28.9644)">
			<title>Tabelle.191</title>
			<path d="M0 205.34 L12.09 205.34" class="st5"/>
		</g>
		<g id="shape192-275" v:mID="192" v:groupContext="shape" transform="translate(333.636,123.029) rotate(89.6295)">
			<title>Tabelle.192</title>
			<path d="M0 205.34 L11.29 205.34" class="st5"/>
		</g>
		<g id="shape193-278" v:mID="193" v:groupContext="shape" transform="translate(21.1292,319.041) rotate(-151.142)">
			<title>Tabelle.193</title>
			<path d="M0 205.34 L14.52 205.34" class="st5"/>
		</g>
		<g id="shape194-281" v:mID="194" v:groupContext="shape" transform="translate(-17.3383,-42.6005) rotate(-29.9637)">
			<title>Tabelle.194</title>
			<path d="M0 205.34 L10.16 205.34" class="st5"/>
		</g>
		<g id="shape195-284" v:mID="195" v:groupContext="shape" transform="translate(278.827,195.573) rotate(114.172)">
			<title>Tabelle.195</title>
			<path d="M0 205.34 L23.13 205.34" class="st5"/>
		</g>
		<g id="shape196-287" v:mID="196" v:groupContext="shape" transform="translate(289.14,109.872) rotate(100.184)">
			<title>Tabelle.196</title>
			<path d="M0 205.34 L59.91 205.34" class="st6"/>
		</g>
		<g id="shape197-290" v:mID="197" v:groupContext="shape" transform="translate(259.468,114.304) rotate(101.203)">
			<title>Tabelle.197</title>
			<path d="M0 205.34 L46.75 205.34" class="st7"/>
		</g>
		<g id="shape198-293" v:mID="198" v:groupContext="shape" transform="translate(263.22,113.94) rotate(101.099)">
			<title>Tabelle.198</title>
			<path d="M0 205.34 L46.73 205.34" class="st7"/>
		</g>
		<g id="shape200-296" v:mID="200" v:groupContext="shape" transform="translate(218.521,240.022) rotate(116.565)">
			<title>Tabelle.200</title>
			<path d="M0 205.34 L18.29 205.34" class="st5"/>
		</g>
		<g id="shape203-299" v:mID="203" v:groupContext="shape" transform="translate(72.6126,-33.3267) rotate(10.5946)">
			<title>Tabelle.203</title>
			<path d="M0 205.34 L29.1 205.34" class="st5"/>
		</g>
		<g id="shape206-302" v:mID="206" v:groupContext="shape" transform="translate(277.482,170.666) rotate(98.3878)">
			<title>Tabelle.206</title>
			<path d="M0 205.34 L28.03 205.34" class="st5"/>
		</g>
		<g id="shape207-305" v:mID="207" v:groupContext="shape" transform="translate(282.959,170.666) rotate(98.3878)">
			<title>Tabelle.207</title>
			<path d="M0 205.34 L28.03 205.34" class="st5"/>
		</g>
		<g id="shape208-308" v:mID="208" v:groupContext="shape" transform="translate(167.98,-47.1984) rotate(32.1841)">
			<title>Tabelle.208</title>
			<path d="M0 205.34 L13.65 205.34" class="st5"/>
		</g>
		<g id="shape209-311" v:mID="209" v:groupContext="shape" transform="translate(95.1691,-50.6345)">
			<title>Tabelle.209</title>
			<desc>1044</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st28"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1044</text>		</g>
		<g id="shape210-314" v:mID="210" v:groupContext="shape" transform="translate(124.19,-45.4472)">
			<title>Tabelle.210</title>
			<desc>1043</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st28"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1043</text>		</g>
		<g id="shape211-317" v:mID="211" v:groupContext="shape" transform="translate(89.53,-18.0929)">
			<title>Tabelle.211</title>
			<desc>1045</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st28"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1045</text>		</g>
		<g id="shape212-320" v:mID="212" v:groupContext="shape" transform="translate(89.53,-36.7743)">
			<title>Tabelle.212</title>
			<desc>1042</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st28"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1042</text>		</g>
		<g id="shape213-323" v:mID="213" v:groupContext="shape" transform="translate(121.254,-28.7125)">
			<title>Tabelle.213</title>
			<desc>1041</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st28"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1041</text>		</g>
		<g id="group214-326" transform="translate(96.5952,-58.3171) rotate(2.6)" v:mID="214" v:groupContext="group">
			<title>Tabelle.214</title>
			<g id="shape215-327" v:mID="215" v:groupContext="shape" transform="translate(2.17326E-014,-0.922429)">
				<title>Tabelle.215</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
			<g id="shape216-329" v:mID="216" v:groupContext="shape" transform="translate(1.22991,0)">
				<title>Tabelle.216</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
		</g>
		<g id="shape217-331" v:mID="217" v:groupContext="shape" transform="translate(-44.2414,300.734) rotate(-140)">
			<title>Tabelle.217</title>
			<path d="M0 205.34 L5.51 205.34" class="st5"/>
		</g>
		<g id="shape218-334" v:mID="218" v:groupContext="shape" transform="translate(-36.4541,307.199) rotate(-140)">
			<title>Tabelle.218</title>
			<path d="M0 205.34 L5.51 205.34" class="st5"/>
		</g>
		<g id="group219-337" transform="translate(99.0487,-61.4249) rotate(2.6)" v:mID="219" v:groupContext="group">
			<title>Tabelle.219</title>
			<g id="shape220-338" v:mID="220" v:groupContext="shape" transform="translate(2.17326E-014,-0.922429)">
				<title>Tabelle.220</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
			<g id="shape221-340" v:mID="221" v:groupContext="shape" transform="translate(1.22991,0)">
				<title>Tabelle.221</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
		</g>
		<g id="shape222-342" v:mID="222" v:groupContext="shape" transform="translate(-41.6579,297.735) rotate(-140.047)">
			<title>Tabelle.222</title>
			<path d="M0 205.34 L6.22 205.34" class="st5"/>
		</g>
		<g id="shape223-345" v:mID="223" v:groupContext="shape" transform="translate(-31.3709,306.228) rotate(-140.373)">
			<title>Tabelle.223</title>
			<path d="M0 205.34 L7.56 205.34" class="st5"/>
		</g>
		<g id="shape224-348" v:mID="224" v:groupContext="shape" transform="translate(156.277,-45.4291) rotate(13.8266)">
			<title>Tabelle.224</title>
			<path d="M0 205.34 L17.96 205.34" class="st5"/>
		</g>
		<g id="shape225-351" v:mID="225" v:groupContext="shape" transform="translate(156.861,-49.102) rotate(13.6864)">
			<title>Tabelle.225</title>
			<path d="M0 205.34 L17.16 205.34" class="st5"/>
		</g>
		<g id="shape226-354" v:mID="226" v:groupContext="shape" transform="translate(269.668,269.993) rotate(124.158)">
			<title>Tabelle.226</title>
			<path d="M0 205.34 L8.74 205.34" class="st5"/>
		</g>
		<g id="shape227-357" v:mID="227" v:groupContext="shape" transform="translate(273.649,269.993) rotate(124.158)">
			<title>Tabelle.227</title>
			<path d="M0 205.34 L8.74 205.34" class="st5"/>
		</g>
		<g id="shape228-360" v:mID="228" v:groupContext="shape" transform="translate(326.76,215.845) rotate(105.814)">
			<title>Tabelle.228</title>
			<path d="M0 205.34 L10.5 205.34" class="st5"/>
		</g>
		<g id="shape229-363" v:mID="229" v:groupContext="shape" transform="translate(330.44,215.845) rotate(105.814)">
			<title>Tabelle.229</title>
			<path d="M0 205.34 L10.5 205.34" class="st5"/>
		</g>
		<g id="shape230-366" v:mID="230" v:groupContext="shape" transform="translate(301.818,168.562) rotate(90)">
			<title>Tabelle.230</title>
			<path d="M0 205.34 L12.05 205.34" class="st5"/>
		</g>
		<g id="shape231-369" v:mID="231" v:groupContext="shape" transform="translate(199.283,362.986) rotate(157.692)">
			<title>Tabelle.231</title>
			<path d="M0 205.34 L21.59 205.34" class="st5"/>
		</g>
		<g id="shape232-372" v:mID="232" v:groupContext="shape" transform="translate(200.963,365.812) rotate(157.576)">
			<title>Tabelle.232</title>
			<path d="M0 205.34 L21.48 205.34" class="st5"/>
		</g>
		<g id="group233-375" transform="translate(54.8311,-21.9206) rotate(-7.4)" v:mID="233" v:groupContext="group">
			<title>Tabelle.233</title>
			<g id="shape234-376" v:mID="234" v:groupContext="shape" transform="translate(2.14828E-014,-0.922429)">
				<title>Tabelle.234</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
			<g id="shape235-378" v:mID="235" v:groupContext="shape" transform="translate(1.22991,0)">
				<title>Tabelle.235</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
		</g>
		<g id="shape236-380" v:mID="236" v:groupContext="shape" transform="translate(-22.4912,355.566) rotate(-149.686)">
			<title>Tabelle.236</title>
			<path d="M0 205.34 L4.29 205.34" class="st5"/>
		</g>
		<g id="shape237-383" v:mID="237" v:groupContext="shape" transform="translate(-13.4914,360.718) rotate(-149.856)">
			<title>Tabelle.237</title>
			<path d="M0 205.34 L5.15 205.34" class="st5"/>
		</g>
		<g id="group238-386" transform="translate(56.7077,-25.4071) rotate(-7.4)" v:mID="238" v:groupContext="group">
			<title>Tabelle.238</title>
			<g id="shape239-387" v:mID="239" v:groupContext="shape" transform="translate(2.14828E-014,-0.922429)">
				<title>Tabelle.239</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
			<g id="shape240-389" v:mID="240" v:groupContext="shape" transform="translate(1.22991,0)">
				<title>Tabelle.240</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
		</g>
		<g id="shape241-391" v:mID="241" v:groupContext="shape" transform="translate(-19.48,352.738) rotate(-150.052)">
			<title>Tabelle.241</title>
			<path d="M0 205.34 L3.97 205.34" class="st5"/>
		</g>
		<g id="shape242-394" v:mID="242" v:groupContext="shape" transform="translate(-10.1284,358.101) rotate(-149.81)">
			<title>Tabelle.242</title>
			<path d="M0 205.34 L7.03 205.34" class="st5"/>
		</g>
		<g id="shape243-397" v:mID="243" v:groupContext="shape" transform="translate(209.13,91.787) rotate(110.75)">
			<title>Tabelle.243</title>
			<path d="M0 205.34 L9.24 205.34" class="st5"/>
		</g>
		<g id="shape244-400" v:mID="244" v:groupContext="shape" transform="translate(35.7909,-116.308)">
			<title>Tabelle.244</title>
			<desc>2031</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st25"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>2031</text>		</g>
		<g id="shape245-403" v:mID="245" v:groupContext="shape" transform="translate(12.5685,-113.693)">
			<title>Tabelle.245</title>
			<desc>2032</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st25"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>2032</text>		</g>
		<g id="group246-406" transform="translate(251.304,84.2796) rotate(92.6)" v:mID="246" v:groupContext="group">
			<title>Tabelle.246</title>
			<g id="shape247-407" v:mID="247" v:groupContext="shape" transform="translate(2.14828E-014,-0.922429)">
				<title>Tabelle.247</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
			<g id="shape248-409" v:mID="248" v:groupContext="shape" transform="translate(1.22991,0)">
				<title>Tabelle.248</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
		</g>
		<g id="shape249-411" v:mID="249" v:groupContext="shape" transform="translate(-106.493,-58.0367) rotate(-49.4589)">
			<title>Tabelle.249</title>
			<path d="M0 205.34 L5.16 205.34" class="st5"/>
		</g>
		<g id="shape250-414" v:mID="250" v:groupContext="shape" transform="translate(-114.009,-48.9771) rotate(-50.2677)">
			<title>Tabelle.250</title>
			<path d="M0 205.34 L4.26 205.34" class="st5"/>
		</g>
		<g id="shape251-417" v:mID="251" v:groupContext="shape" transform="translate(83.0613,-168.604)">
			<title>Tabelle.251</title>
			<desc>1021</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st25"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1021</text>		</g>
		<g id="shape252-420" v:mID="252" v:groupContext="shape" transform="translate(82.9874,-152.045)">
			<title>Tabelle.252</title>
			<desc>1022</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st25"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1022</text>		</g>
		<g id="group253-423" transform="translate(276.258,79.788) rotate(102.6)" v:mID="253" v:groupContext="group">
			<title>Tabelle.253</title>
			<g id="shape254-424" v:mID="254" v:groupContext="shape" transform="translate(2.14828E-014,-0.922429)">
				<title>Tabelle.254</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
			<g id="shape255-426" v:mID="255" v:groupContext="shape" transform="translate(1.22991,0)">
				<title>Tabelle.255</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
		</g>
		<g id="shape256-428" v:mID="256" v:groupContext="shape" transform="translate(-51.3914,-122.497) rotate(-39.4589)">
			<title>Tabelle.256</title>
			<path d="M0 205.34 L5.16 205.34" class="st5"/>
		</g>
		<g id="shape257-431" v:mID="257" v:groupContext="shape" transform="translate(-62.0395,-113.374) rotate(-41.0141)">
			<title>Tabelle.257</title>
			<path d="M0 205.34 L3.84 205.34" class="st5"/>
		</g>
		<g id="shape258-434" v:mID="258" v:groupContext="shape" transform="translate(292.822,36.7326) rotate(90)">
			<title>Tabelle.258</title>
			<path d="M0 205.34 L9.93 205.34" class="st5"/>
		</g>
		<g id="shape259-437" v:mID="259" v:groupContext="shape" transform="translate(296.911,36.7326) rotate(90)">
			<title>Tabelle.259</title>
			<path d="M0 205.34 L9.93 205.34" class="st5"/>
		</g>
		<g id="group260-440" transform="translate(245.663,-33.455) rotate(72.6)" v:mID="260" v:groupContext="group">
			<title>Tabelle.260</title>
			<g id="shape261-441" v:mID="261" v:groupContext="shape" transform="translate(2.14828E-014,-0.922429)">
				<title>Tabelle.261</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
			<g id="shape262-443" v:mID="262" v:groupContext="shape" transform="translate(1.22991,0)">
				<title>Tabelle.262</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
		</g>
		<g id="shape263-445" v:mID="263" v:groupContext="shape" transform="translate(-140.482,-41.3848) rotate(-70.4776)">
			<title>Tabelle.263</title>
			<path d="M0 205.34 L8.83 205.34" class="st5"/>
		</g>
		<g id="shape264-448" v:mID="264" v:groupContext="shape" transform="translate(-147.703,-20.6368) rotate(-70.8674)">
			<title>Tabelle.264</title>
			<path d="M0 205.34 L15.96 205.34" class="st5"/>
		</g>
		<g id="shape265-451" v:mID="265" v:groupContext="shape" transform="translate(12.0778,-153.517)">
			<title>Tabelle.265</title>
			<desc>1012</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st25"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1012</text>		</g>
		<g id="shape266-454" v:mID="266" v:groupContext="shape" transform="translate(36.8472,-152.045)">
			<title>Tabelle.266</title>
			<desc>1011</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st25"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1011</text>		</g>
		<g id="shape267-457" v:mID="267" v:groupContext="shape" transform="translate(5.69879,-133.889)">
			<title>Tabelle.267</title>
			<desc>1014</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st25"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1014</text>		</g>
		<g id="shape268-460" v:mID="268" v:groupContext="shape" transform="translate(29.2482,-132.476)">
			<title>Tabelle.268</title>
			<desc>1013</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="6.62835" cy="202.023" width="13.26" height="6.62835"/>
			<rect x="0" y="198.708" width="13.2567" height="6.62835" rx="3.31418" ry="3.31418" class="st25"/>
			<text x="0.63" y="203.52" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>1013</text>		</g>
		<g id="group269-463" transform="translate(228.638,47.1658) rotate(92.6)" v:mID="269" v:groupContext="group">
			<title>Tabelle.269</title>
			<g id="shape270-464" v:mID="270" v:groupContext="shape" transform="translate(2.14828E-014,-0.922429)">
				<title>Tabelle.270</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
			<g id="shape271-466" v:mID="271" v:groupContext="shape" transform="translate(1.22991,0)">
				<title>Tabelle.271</title>
				<ellipse cx="1.53738" cy="203.799" rx="1.53738" ry="1.53738" class="st18"/>
			</g>
		</g>
		<g id="shape272-468" v:mID="272" v:groupContext="shape" transform="translate(-129.16,-95.1505) rotate(-49.4589)">
			<title>Tabelle.272</title>
			<path d="M0 205.34 L5.16 205.34" class="st5"/>
		</g>
		<g id="shape273-471" v:mID="273" v:groupContext="shape" transform="translate(-136.675,-86.0909) rotate(-50.2677)">
			<title>Tabelle.273</title>
			<path d="M0 205.34 L4.26 205.34" class="st5"/>
		</g>
		<g id="shape274-474" v:mID="274" v:groupContext="shape" transform="translate(224.527,145.937) rotate(116.82)">
			<title>Tabelle.274</title>
			<path d="M0 205.34 L14.5 205.34" class="st5"/>
		</g>
		<g id="shape275-477" v:mID="275" v:groupContext="shape" transform="translate(229.127,145.94) rotate(116.82)">
			<title>Tabelle.275</title>
			<path d="M0 205.34 L14.5 205.34" class="st5"/>
		</g>
		<g id="shape276-480" v:mID="276" v:groupContext="shape" transform="translate(199.992,144.465) rotate(116.82)">
			<title>Tabelle.276</title>
			<path d="M0 205.34 L14.5 205.34" class="st5"/>
		</g>
		<g id="shape277-483" v:mID="277" v:groupContext="shape" transform="translate(204.081,144.465) rotate(116.82)">
			<title>Tabelle.277</title>
			<path d="M0 205.34 L14.5 205.34" class="st5"/>
		</g>
		<g id="shape278-486" v:mID="278" v:groupContext="shape" transform="translate(48.5909,-137.078) rotate(8.51935)">
			<title>Tabelle.278</title>
			<path d="M0 205.34 L11.75 205.34" class="st5"/>
		</g>
		<g id="shape279-489" v:mID="279" v:groupContext="shape" transform="translate(47.7656,-133.07) rotate(8.256)">
			<title>Tabelle.279</title>
			<path d="M0 205.34 L12.04 205.34" class="st5"/>
		</g>
		<g id="shape280-492" v:mID="280" v:groupContext="shape" transform="translate(10.986,-8.50394)">
			<title>Tabelle.280</title>
			<path d="M0 139.91 L26.17 139.91 L42.53 156.27 L42.53 205.34" class="st29"/>
		</g>
		<g id="shape281-495" v:mID="281" v:groupContext="shape" transform="translate(-14.7961,-115.327) rotate(-11.1697)">
			<title>Tabelle.281</title>
			<path d="M0 205.34 L11.59 205.34" class="st5"/>
		</g>
		<g id="shape282-498" v:mID="282" v:groupContext="shape" transform="translate(-13.1654,-111.356) rotate(-10.7441)">
			<title>Tabelle.282</title>
			<path d="M0 205.34 L11.95 205.34" class="st5"/>
		</g>
		<g id="shape284-501" v:mID="284" v:groupContext="shape" transform="translate(6.32738,-162)">
			<title>Tabelle.284</title>
			<path d="M30.04 171.04 L30.04 180.64 L6.85 205.34 L0 205.34" class="st29"/>
		</g>
		<g id="shape285-504" v:mID="285" v:groupContext="shape" transform="translate(3.32405,-195.49)">
			<title>Tabelle.285</title>
			<desc>External</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="14.4702" cy="202.452" width="28.95" height="5.77022"/>
			<rect x="0" y="199.567" width="28.9403" height="5.77022" class="st8"/>
			<text x="4.31" y="203.95" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>External</text>		</g>
		<g id="shape286-507" v:mID="286" v:groupContext="shape" transform="translate(64.9567,-141.631)">
			<title>Tabelle.286</title>
			<desc>North</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="10.073" cy="202.452" width="20.15" height="5.77022"/>
			<rect x="0" y="199.567" width="20.1461" height="5.77022" class="st8"/>
			<text x="3.07" y="203.95" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>North</text>		</g>
		<g id="shape287-510" v:mID="287" v:groupContext="shape" transform="translate(47.0986,-64.6233)">
			<title>Tabelle.287</title>
			<desc>Central</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="10.073" cy="202.452" width="20.15" height="5.77022"/>
			<rect x="0" y="199.567" width="20.1461" height="5.77022" class="st8"/>
			<text x="1.24" y="203.95" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>Central</text>		</g>
		<g id="shape288-513" v:mID="288" v:groupContext="shape" transform="translate(6.21611,-45.3543)">
			<title>Tabelle.288</title>
			<desc>South</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="10.073" cy="202.452" width="20.15" height="5.77022"/>
			<rect x="0" y="199.567" width="20.1461" height="5.77022" class="st8"/>
			<text x="3.07" y="203.95" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>South</text>		</g>
		<g id="shape166-516" v:mID="166" v:groupContext="shape" transform="translate(42.9139,-76.8907)">
			<title>Tabelle.166</title>
			<desc>4041</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4041</text>		</g>
		<g id="shape164-519" v:mID="164" v:groupContext="shape" transform="translate(52.7278,-130.926)">
			<title>Tabelle.164</title>
			<desc>4031</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st25"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4031</text>		</g>
		<g id="shape165-522" v:mID="165" v:groupContext="shape" transform="translate(85.4409,-130.926)">
			<title>Tabelle.165</title>
			<desc>4032</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st25"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4032</text>		</g>
		<g id="shape169-525" v:mID="169" v:groupContext="shape" transform="translate(89.53,-93.2472)">
			<title>Tabelle.169</title>
			<desc>4042</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4042</text>		</g>
		<g id="shape167-528" v:mID="167" v:groupContext="shape" transform="translate(69.0843,-64.6233)">
			<title>Tabelle.167</title>
			<desc>4044</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st27"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4044</text>		</g>
		<g id="shape187-531" v:mID="187" v:groupContext="shape" transform="translate(289.369,143.651) rotate(121.379)">
			<title>Tabelle.187</title>
			<path d="M0 205.34 L34.55 205.34" class="st5"/>
		</g>
		<g id="shape163-534" v:mID="163" v:groupContext="shape" transform="translate(108.469,-168.604)">
			<title>Tabelle.163</title>
			<desc>4021</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.17827" cy="201.248" width="16.36" height="8.17827"/>
			<rect x="0" y="197.159" width="16.3565" height="8.17827" rx="4.08913" ry="4.08913" class="st25"/>
			<text x="2.18" y="202.75" class="st26" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>4021</text>		</g>
		<g id="group361-537" transform="translate(-66.8252,-38.3889) rotate(-45)" v:mID="361" v:groupContext="group">
			<title>Tabelle.361</title>
			<g id="shape362-538" v:mID="362" v:groupContext="shape" transform="translate(200.321,157.303) rotate(77)">
				<title>Tabelle.362</title>
				<path d="M1.72 193.26 L0 200.16 L2.3 197.86 L0.57 205.34" class="st11"/>
			</g>
			<g id="shape363-541" v:mID="363" v:groupContext="shape">
				<title>Tabelle.363</title>
				<path d="M2.87 205.34 L0 204.04 L2.87 202.89" class="st11"/>
			</g>
		</g>
		<g id="group801-544" transform="translate(208.494,-30.5667)" v:mID="801" v:groupContext="group">
			<title>Tabelle.801</title>
			<g id="shape802-545" v:mID="802" v:groupContext="shape" transform="translate(210.292,181.431) rotate(90)">
				<title>Tabelle.802</title>
				<path d="M0 205.34 L9.91 205.34" class="st5"/>
			</g>
			<g id="shape803-548" v:mID="803" v:groupContext="shape" transform="translate(9.91019,396.678) rotate(180)">
				<title>Tabelle.803</title>
				<path d="M0 205.34 L9.91 205.34" class="st5"/>
			</g>
			<g id="shape804-551" v:mID="804" v:groupContext="shape" transform="translate(9.91019,400.565) rotate(180)">
				<title>Tabelle.804</title>
				<path d="M0 205.34 L9.91 205.34" class="st5"/>
			</g>
			<g id="shape805-554" v:mID="805" v:groupContext="shape" transform="translate(210.292,195.229) rotate(90)">
				<title>Tabelle.805</title>
				<path d="M0 205.34 L9.91 205.34" class="st5"/>
			</g>
			<g id="shape806-557" v:mID="806" v:groupContext="shape" transform="translate(2.4884,-5.68434E-014)">
				<title>Tabelle.806</title>
				<path d="M0 205.34 L4.93 205.34" class="st5"/>
			</g>
		</g>
		<g id="group808-560" transform="translate(236.126,328.483) rotate(180)" v:mID="808" v:groupContext="group">
			<title>Tabelle.808</title>
			<g id="shape809-561" v:mID="809" v:groupContext="shape" transform="translate(0,-4.85622)">
				<title>Tabelle.809</title>
				<ellipse cx="4.85622" cy="200.481" rx="4.85622" ry="4.85622" class="st18"/>
			</g>
			<g id="shape810-563" v:mID="810" v:groupContext="shape">
				<title>Tabelle.810</title>
				<ellipse cx="4.85622" cy="200.481" rx="4.85622" ry="4.85622" class="st18"/>
			</g>
		</g>
		<g id="shape811-565" v:mID="811" v:groupContext="shape" transform="translate(436.607,137.715) rotate(90)">
			<title>Tabelle.811</title>
			<path d="M0 205.34 L13.38 205.34" class="st5"/>
		</g>
		<g id="shape812-568" v:mID="812" v:groupContext="shape" transform="translate(436.611,111.875) rotate(90.2051)">
			<title>Tabelle.812</title>
			<path d="M0 205.34 L12.01 205.34" class="st5"/>
		</g>
		<g id="group814-571" transform="translate(255.662,364.304) rotate(180)" v:mID="814" v:groupContext="group">
			<title>Tabelle.814</title>
			<g id="shape815-572" v:mID="815" v:groupContext="shape" transform="translate(0,-4.85622)">
				<title>Tabelle.815</title>
				<ellipse cx="4.85622" cy="200.481" rx="4.85622" ry="4.85622" class="st18"/>
			</g>
			<g id="shape816-574" v:mID="816" v:groupContext="shape">
				<title>Tabelle.816</title>
				<ellipse cx="4.85622" cy="200.481" rx="4.85622" ry="4.85622" class="st18"/>
			</g>
		</g>
		<g id="shape817-576" v:mID="817" v:groupContext="shape" transform="translate(456.24,173.535) rotate(90)">
			<title>Tabelle.817</title>
			<path d="M0 205.34 L13.38 205.34" class="st5"/>
		</g>
		<g id="shape818-579" v:mID="818" v:groupContext="shape" transform="translate(456.23,151.826) rotate(90.2051)">
			<title>Tabelle.818</title>
			<path d="M0 205.34 L7.88 205.34" class="st5"/>
		</g>
		<g id="group819-582" transform="translate(248.73,-7.08661)" v:mID="819" v:groupContext="group">
			<title>Tabelle.819</title>
			<g id="shape343-583" v:mID="343" v:groupContext="shape" transform="translate(-203.163,200.615) rotate(-90)">
				<title>Tabelle.343</title>
				<path d="M0 205.34 L8.5 205.34" class="st5"/>
			</g>
			<g id="shape344-586" v:mID="344" v:groupContext="shape">
				<title>Tabelle.344</title>
				<path d="M0 199.9 L4.35 199.9 L2.17 205.34 L0 199.9 Z" class="st30"/>
			</g>
		</g>
		<g id="shape820-588" v:mID="820" v:groupContext="shape" transform="translate(213.449,-7.08661)">
			<title>Tabelle.820</title>
			<desc>PLL</desc>
			<v:textBlock v:margins="rect(1,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="8.50394" cy="201.415" width="17.01" height="7.84377"/>
			<rect x="0" y="197.493" width="17.0079" height="7.84377" class="st18"/>
			<text x="1.39" y="203.91" class="st9" v:langID="1031"><v:paragraph v:spLine="-1" v:horizAlign="1"/><v:tabList/>PLL</text>		</g>
		<g id="shape821-591" v:mID="821" v:groupContext="shape" transform="translate(239.669,387.288) rotate(180)">
			<title>Tabelle.821</title>
			<path d="M0 205.34 L17.72 205.34" class="st5"/>
		</g>
		<g id="shape822-594" v:mID="822" v:groupContext="shape" transform="translate(16.616,190.03) rotate(-90)">
			<title>Tabelle.822</title>
			<path d="M3.04 205.34 L3.4 205.34 L8.08 205.34" class="st31"/>
		</g>
		<g id="shape824-599" v:mID="824" v:groupContext="shape" transform="translate(243.957,399.779) rotate(180)">
			<title>Tabelle.824</title>
			<path d="M3.04 205.34 L3.4 205.34 L13.22 205.34" class="st31"/>
		</g>
		<g id="shape826-604" v:mID="826" v:groupContext="shape" transform="translate(229.039,-13.1888)">
			<title>Tabelle.826</title>
			<desc>θL</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="5.95005" cy="202.01" width="11.91" height="6.65368"/>
			<rect x="0" y="198.683" width="11.9001" height="6.65368" class="st22"/>
			<text x="3.73" y="204.41" class="st32" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>θ<tspan dy="-0.289em"
						class="st33" v:baseFontSize="6">L</tspan></text>		</g>
		<g id="shape827-608" v:mID="827" v:groupContext="shape" transform="translate(250.866,-24.0945)">
			<title>Tabelle.827</title>
			<desc>20 kV</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="10.6299" cy="202.361" width="21.26" height="5.95139"/>
			<rect x="0" y="199.385" width="21.2598" height="5.95139" class="st8"/>
			<text x="0.74" y="204.76" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>20 kV</text>		</g>
		<g id="shape828-611" v:mID="828" v:groupContext="shape" transform="translate(159.591,-28.7125)">
			<title>Tabelle.828</title>
			<desc>15 kV</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="11.1506" cy="202.361" width="22.31" height="5.95139"/>
			<rect x="0" y="199.385" width="22.3012" height="5.95139" class="st8"/>
			<text x="1.26" y="204.76" class="st9" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>15 kV</text>		</g>
		<g id="group830-614" transform="translate(234.422,-188.834)" v:mID="830" v:groupContext="group">
			<title>Tabelle.830</title>
			<g id="shape303-615" v:mID="303" v:groupContext="shape" transform="translate(205.337,191.824) rotate(90)">
				<title>Tabelle.303</title>
				<rect x="0" y="191.824" width="13.5132" height="13.5132" class="st18"/>
			</g>
			<g id="shape304-617" v:mID="304" v:groupContext="shape" transform="translate(158.708,346.671) rotate(135)">
				<title>Tabelle.304</title>
				<path d="M0 205.34 L5.46 205.34" class="st5"/>
			</g>
			<g id="shape305-620" v:mID="305" v:groupContext="shape" transform="translate(158.708,342.81) rotate(135)">
				<title>Tabelle.305</title>
				<path d="M0 205.34 L10.92 205.34" class="st5"/>
			</g>
			<g id="shape306-623" v:mID="306" v:groupContext="shape" transform="translate(158.708,338.949) rotate(135)">
				<title>Tabelle.306</title>
				<path d="M0 205.34 L16.38 205.34" class="st5"/>
			</g>
			<g id="shape307-626" v:mID="307" v:groupContext="shape" transform="translate(149.056,337.019) rotate(135)">
				<title>Tabelle.307</title>
				<path d="M0 205.34 L5.46 205.34" class="st5"/>
			</g>
			<g id="shape308-629" v:mID="308" v:groupContext="shape" transform="translate(152.917,337.019) rotate(135)">
				<title>Tabelle.308</title>
				<path d="M0 205.34 L10.92 205.34" class="st5"/>
			</g>
			<g id="shape309-632" v:mID="309" v:groupContext="shape" transform="translate(156.778,337.019) rotate(135)">
				<title>Tabelle.309</title>
				<path d="M0 205.34 L16.38 205.34" class="st5"/>
			</g>
			<g id="shape310-635" v:mID="310" v:groupContext="shape" transform="translate(-131.682,342.81) rotate(-135)">
				<title>Tabelle.310</title>
				<path d="M0 205.34 L8.19 205.34" class="st5"/>
			</g>
			<g id="shape311-638" v:mID="311" v:groupContext="shape" transform="translate(-131.682,346.671) rotate(-135)">
				<title>Tabelle.311</title>
				<path d="M0 205.34 L13.65 205.34" class="st5"/>
			</g>
			<g id="shape312-641" v:mID="312" v:groupContext="shape" transform="translate(-135.543,350.532) rotate(-135)">
				<title>Tabelle.312</title>
				<path d="M0 205.34 L13.65 205.34" class="st5"/>
			</g>
			<g id="shape313-644" v:mID="313" v:groupContext="shape" transform="translate(-131.682,350.532) rotate(-135)">
				<title>Tabelle.313</title>
				<path d="M0 205.34 L19.11 205.34" class="st5"/>
			</g>
			<g id="shape314-647" v:mID="314" v:groupContext="shape" transform="translate(-131.682,338.949) rotate(-135)">
				<title>Tabelle.314</title>
				<path d="M0 205.34 L2.73 205.34" class="st5"/>
			</g>
			<g id="shape315-650" v:mID="315" v:groupContext="shape" transform="translate(-139.404,350.532) rotate(-135)">
				<title>Tabelle.315</title>
				<path d="M0 205.34 L8.19 205.34" class="st5"/>
			</g>
			<g id="shape316-653" v:mID="316" v:groupContext="shape" transform="translate(-143.265,350.532) rotate(-135)">
				<title>Tabelle.316</title>
				<path d="M0 205.34 L2.73 205.34" class="st5"/>
			</g>
		</g>
		<g id="shape832-656" v:mID="832" v:groupContext="shape" transform="translate(238.911,-165.26)">
			<title>Tabelle.832</title>
			<rect x="0" y="196.549" width="4.53543" height="8.7874" class="st18"/>
		</g>
		<g id="shape833-658" v:mID="833" v:groupContext="shape" transform="translate(35.8422,49.0855) rotate(-90)">
			<title>Tabelle.833</title>
			<path d="M0 205.34 L9.01 205.34" class="st5"/>
		</g>
		<g id="shape834-661" v:mID="834" v:groupContext="shape" transform="translate(228.759,-179.016)">
			<title>Tabelle.834</title>
			<desc>v0</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="5.95005" cy="202.01" width="11.91" height="6.65368"/>
			<rect x="0" y="198.683" width="11.9001" height="6.65368" class="st22"/>
			<text x="3.11" y="204.41" class="st23" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/>v<tspan dy="-0.289em"
						class="st24" v:baseFontSize="6">0</tspan></text>		</g>
		<g id="shape835-665" v:mID="835" v:groupContext="shape" transform="translate(239.085,-181.843)">
			<title>Tabelle.835</title>
			<path d="M0 205.34 L4.19 205.34" class="st5"/>
		</g>
		<g id="shape837-668" v:mID="837" v:groupContext="shape" transform="translate(242.651,-167.244)">
			<title>Tabelle.837</title>
			<desc>zg</desc>
			<v:textBlock v:margins="rect(0,0,0,0)" v:tabSpace="42.5197"/>
			<v:textRect cx="5.95005" cy="202.01" width="11.91" height="6.65368"/>
			<rect x="0" y="198.683" width="11.9001" height="6.65368" class="st22"/>
			<text x="3.34" y="204.41" class="st23" v:langID="1031"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan class="st34">z</tspan><tspan
						dy="-0.289em" class="st24" v:baseFontSize="6">g</tspan></text>		</g>
		<g id="shape842-673" v:mID="842" v:groupContext="shape" transform="translate(350.471,4.64386) rotate(90)">
			<title>Tabelle.842</title>
			<path d="M0 205.34 L196.59 205.34" class="st35"/>
		</g>
		<g id="shape844-676" v:mID="844" v:groupContext="shape" transform="translate(123.874,-155.906)">
			<title>Tabelle.844</title>
			<path d="M-0 205.34 A30.066 28.3465 0 0 1 39.57 202.89 L39.84 203.12" class="st36"/>
		</g>
		<g id="shape847-682" v:mID="847" v:groupContext="shape" transform="translate(318.564,-114.75) rotate(28.0669)">
			<title>Tabelle.847</title>
			<path d="M0 205.34 L5.34 205.34" class="st38"/>
		</g>
	</g>
</svg>
Uploading NordicLTVS.svg…]()


### EMT implementation of the ANS

All files described here can be found in the folder ANS_EMT. It also contains instructions on how to start a simulation.

|  File | Description    |
|---|---|
|  **ANS_GFM_short_term.slx** | EMT Simulink implementation of the ANS for short-term voltage stability analyses.     |
|  **ANS_GFM_long_term.slx**  |  contains the same grid as for the shor-term analyses, but with modifications according to the detection of instability. |
| **init_ANS_GFM_short_term.m**  |  contains the code for the initialisation of the short-term model   |
|  **init_ANS_GFM_lomg_term.m** | contains the code for the initialisation of the long-term model (with some parameter adaptions)  |
|  **parallel_simulations_short_term.m** | contains the code for parallelising the simulations and deriving the short-term stability limit plots in the paper|
|  **parallel_simulations_long_term.m** | contains the code for parallelising the long-term simulations  |


Auxillary files:
|  File | Description    |
|---|---|
| **DetermineBoundary.m**| script to get the stability limit from the simulations|
| **next_ind.m**| internal function for DetermineBoundary.m|
| **calc_saturation.m**| function to calculate field current saturation for synchronous machines (not used here)|


### Phasor (RMS) implementation of the ANS

The folder 'ANS_RMS' contains the needed Julia-files for running a phasor simulation of the ANS written for the package PowerDynamics.jl. If you haven't worked with PowerDynamics.jl yet, please have a look at their Github page: https://github.com/JuliaEnergy/PowerDynamics.jl

The folder contains an overview of the files and instructions on how to start a simulation.

# Citation 

 In case the models and code provided here are used for research and publications, please acknowledge this by citing the following papers:

@ARTICLE{Liemann2024,
  author={Liemann, Sebastian and Rehtanz, Christian },
  journal={Power Systems Computation Conference (PSCC) 2024 (under review)}, 
  title={Voltage Stability Analysis of Grid-Forming Converters with Current Limitation}, 
  year={2024}}

@ARTICLE{Tayyebi2020,
  author={Tayyebi, Ali and Groß, Dominic and Anta, Adolfo and Kupzog, Friederich and Dörfler, Florian},
  journal={IEEE Journal of Emerging and Selected Topics in Power Electronics}, 
  title={Frequency Stability of Synchronous Machines and Grid-Forming Power Converters}, 
  year={2020},
  volume={8},
  number={2},
  pages={1004-1018},
  doi={10.1109/JESTPE.2020.2966524}}
