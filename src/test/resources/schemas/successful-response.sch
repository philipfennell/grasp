<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns uri="http://www.oecd.org/eoi" prefix="eoi"/>
	<ns prefix="c"		uri="http://www.w3.org/ns/xproc-step"/>
	<ns prefix="http"	uri="http://www.w3.org/Protocols/rfc2616"/>
	<ns prefix="error"	uri="http://marklogic.com/xdmp/error"/>
	
	<pattern>
		<title>Check response status code</title>
		<rule context="/">
			<assert test="number(http:response/@status) ge 200 and number(http:response/@status) lt 300">The HTTP response code of '<value-of select="http:response/@status"/>' must be in the 200 range.</assert>
		</rule>
	</pattern>
</schema>