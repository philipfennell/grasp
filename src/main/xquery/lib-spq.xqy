xquery version "1.0" encoding "utf-8";

(:
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 :     http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :)
 
(:~
 : This library provides functions for querying RDF Graph Stores
 : that implement the W3C's SPARQL Protocol:
 : <http://www.w3.org/TR/sparql11-protocol/>
 : @author Philip A. R. Fennell
 :)

module namespace spq = "http://www.w3.org/TR/sparql11-protocol/";

import module namespace impl = "http://www.marklogic.com/http" at
		"lib-ml.xqy"; 

declare namespace http	= "http://www.w3.org/Protocols/rfc2616"; 
declare namespace sr 	= "http://www.w3.org/2005/sparql-results#"; 

declare default function namespace "http://www.w3.org/2005/xpath-functions";

(:~ Request encodings. :)
declare variable $SPARQL_RESULTS_XML	as xs:string := "application/sparql-results+xml";
declare variable $RDF_XML 				as xs:string := "application/rdf+xml";

(:~ User-agent string. :) 
declare variable $USER_AGENT	as xs:string := "xqy-sparql-protocol-client/0.3";


(:~
 : The HTTP GET binding for query operation. Assumes the default Accept header
 : for the SPARQL XML Results format.
 : @param $endPointURI the URL of the target SPARQL end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $query the SPARQL query to be sent.
 : @return the query response wrapped in an query-result element that carries 
 : the response content type.
 :)
declare function spq:query-get($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string) 
						as element(http:response)
{
	spq:query-get($endPointURI, $defaultGraphURIs, $namedGraphURIs, 
			$SPARQL_RESULTS_XML, $query)
};


(:~
 : The HTTP GET binding for query operation. 
 : @param $endPointURI the URL of the target SPARQL end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $mediaType the Media MIME-Type for the HTTP accept header.
 : @param $query the SPARQL query to be sent.
 : @return the query response wrapped in an query-result element that carries 
 : the response content type.
 :)
declare function spq:query-get($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$mediaType as xs:string, $query as xs:string) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request( 
					spq:submission('GET', $endPointURI, $defaultGraphURIs, 
							$namedGraphURIs, $mediaType, $query))
	)
};


(:~
 : The HTTP GET binding for query operation. Assumes the default Accept header
 : for the SPARQL XML Results format.
 : @param $endPointURI the URL of the target SPARQL end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $query the SPARQL query to be sent.
 : @return the query response wrapped in an query-result element that carries 
 : the response content type.
 :)
declare function spq:query-post($endPointURI as xs:string,
		$defaultGraphURIs as xs:string*, 
				$namedGraphURIs as xs:string*, $query as xs:string) 
						as element(http:response)
{
	spq:query-post($endPointURI, $defaultGraphURIs, $namedGraphURIs,
			$SPARQL_RESULTS_XML, $query)
};


(:~
 : The HTTP GET binding for query operation. Assumes the default Accept header
 : for the SPARQL XML Results format.
 : @param $endPointURI the URL of the target SPARQL end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $mediaType the Media MIME-Type for the HTTP accept header.
 : @param $query the SPARQL query to be sent.
 : @return the query response wrapped in an query-result element that carries 
 : the response content type.
 :)
declare function spq:query-post($endPointURI as xs:string,
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$mediaType as xs:string, $query as xs:string) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request( 
					spq:submission('POST', $endPointURI, $defaultGraphURIs, 
							$namedGraphURIs, $mediaType, $query))
	)
};


(:~
 : Builds an XML fragment that carries the request details.
 : @param $method HTTP method (GET|POST)
 : @param $endPointURI the URL of the target Graph Store end-point. 
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $mediaType Media MIME-Type for the HTTP accpet header
 : @param $query An RDF graph.
 : @return the HTTP request XML fragment.
 :)
declare function spq:submission($method as xs:string, $endpoitURI as xs:string, $defaultGraphURIs as xs:string*, 
		$namedGraphURIs as xs:string*, $mediaType as xs:string, $query as item()?) as 
				element(http:request) 
{
	let $queryParam as xs:string := concat('query=', encode-for-uri($query))
	let $defaultGraphUriParams as xs:string* := for $uri in $defaultGraphURIs return concat('default=', $uri)
	let $namedGraphUriParams as xs:string* := for $uri in $namedGraphURIs return concat('graph=', $uri)
	let $requestParams as xs:string := 
			concat('?', string-join(($queryParam, $defaultGraphUriParams, $namedGraphUriParams), '&amp;'))
	return
		<request xmlns="http://www.w3.org/Protocols/rfc2616" method="{$method}" 
				href="{concat($endpoitURI, if (exists($requestParams)) then $requestParams else '')}">
			<header name="accept" value="{$mediaType}"/>
			<header name="user-agent" value="{$USER_AGENT}"/>
			<header name="content-type" value="application/x-www-form-urlencoded"/>
			<header name="encoding" value="UTF-8"/>
		</request>
};
