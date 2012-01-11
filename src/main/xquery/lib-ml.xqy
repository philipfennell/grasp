xquery version "1.0-ml" encoding "utf-8";

(:~
 : This library module provides MarkLogic spcific XQuery implementation features
 : such as HTTP GET and POST requests and XML parsing.
 : @author Philip A. R. Fennell
 :)

module namespace impl = "http://www.marklogic.com/http";

declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/Protocols/rfc2616"; 

declare namespace http = "http://www.w3.org/Protocols/rfc2616"; 
declare namespace xhttp = "xdmp:http";

(:~ URL encoding for HTTP requests. :)
declare variable $URL_ENCODED 	as xs:string := "application/x-www-form-urlencoded";


(:~
 : The HTTP binding for query operation.
 : @param $request
 : @return the normalised response.
 :)
declare function impl:http-request($request as element(http:request))
				as item()*
{
	let $requestURI as xs:string := $request/@href
	let $method as xs:string := $request/@method
	let $log := xdmp:log(concat('[XQuery] Request: ', upper-case($method), ' ', $requestURI), 'info')
	let $response as item()* := 
		xdmp:apply(
			xdmp:function(xs:QName(concat('xdmp:http-', lower-case($method)))), 
			$requestURI, 
			impl:build-request-options($request)
		)
	return
		$response
};


(:~
 : Converts the implementation specific representation of the HTTP response into
 : a generic HTTP representation which uses the same structure as XProc's c:response element.
 : @param $response
 : @return an http:response element
 :)
declare function impl:normalise-response($response as item()*) 
	as element(http:response) 
{
	<response status="{string(impl:get-response-head($response)/xhttp:code)}">{
		(for $header in impl:get-response-head($response)/xhttp:headers/xhttp:*
		return
			<header name="{local-name($header)}" value="{string($header)}"/>),
		if (exists(impl:get-response-body($response))) then 
			<body content-type="{subsequence(tokenize(string(impl:get-response-head($response)/xhttp:headers/xhttp:content-type), ';'), 1, 1)}">{
				impl:get-response-body($response)
			}</body>
		else
			()
	}</response>
}; 


(:~
 : Parses a string as XML, returning one or more document nodes.
 : @param $string Input to be unquoted.
 : @return an XML document node. 
 :)
declare function impl:unquote($string as xs:string) 
		as document-node() 
{
	xdmp:unquote($string)
}; 


(:~
 : Parses a string as XML, returning one or more document nodes.
 : @param $string Input to be unquoted.
 : @return an XML document node. 
 :)
declare function impl:quote($node as node()) 
		as xs:string 
{
	xdmp:quote($node)
}; 



(:~
 : Creates the HTTP Request options XML fragment
 : @param $accept the HTTP Accept header content-type.
 : @return options element
 :)
declare function impl:build-request-options($request as element(http:request)) 
		as element(xhttp:options) 
{
	<options xmlns="xdmp:http">
		<headers>{
			for $header in $request//http:header
			return
				element {QName('xdmp:http', string($header/@name))} {text {string($header/@value)}}
		}</headers>
		<format xmlns="xdmp:document-get">text</format>
		{
		if (exists($request/http:body)) then 
			<data xmlns="xdmp:http">{xdmp:quote($request/http:body/*)}</data>
		else
			()
		}
	</options>
};


(:~
 : Extract the head of the HTTP resonse data.
 : @param $response
 : @return the head of the HTTP response data.
 :)
declare function impl:get-response-head($response as item()*) 
		as element(xhttp:response)
{
	subsequence($response, 1, 1)
};


(:~
 : Extract the body of the HTTP resonse data.
 : @param $response
 : @return a sequence of zero or more HTTP response body items.
 :)
declare function impl:get-response-body($response as item()*) 
		as item()?
{
	if (ends-with(string(impl:get-response-head($response)/xhttp:headers/xhttp:content-type), '+xml')) then
		xdmp:unquote(subsequence($response, 2))
	else
		subsequence($response, 2, 1)
};

