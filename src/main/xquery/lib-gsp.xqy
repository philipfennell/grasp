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
 : This library provides functions for accessing and managing RDF Graph Stores
 : that implement the W3C's Graph Store HTTP Protocol:
 : <http://www.w3.org/TR/sparql11-http-rdf-update/>
 : @author Philip A. R. Fennell
 : @version 0.2
 :)

module namespace gsp = "http://www.w3.org/TR/sparql11-http-rdf-update/";

import module namespace impl = "http://www.marklogic.com/http" at
		"lib-ml.xqy"; 

declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare namespace http = "http://www.w3.org/Protocols/rfc2616"; 

(:~ User-agent string. :) 
declare variable $USER_AGENT	as xs:string := "xqy-graph-store-http-protocol-client/0.2";

(:~ MIME-Types. :)
declare variable $RDF_XML 		as xs:string := "application/rdf+xml";
declare variable $NTRIPLES 		as xs:string := "text/plain";
declare variable $TURTLE 		as xs:string := "text/turtle";


(:~
 : Retrieve the default graph's metainformation. 
 : @param $uri the URL of the target Graph Store end-point.
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:retrieve-default-graph-metainfo($uri as xs:string) 
		as element(http:response)
{
	gsp:retrieve-graph-metainfo($uri, true(), ())
};


(:~
 : Retrieve the named graph's metainformation. 
 : @param $uri the URL of the target Graph Store end-point.
 : @param $graphURI the named graph URIs
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:retrieve-named-graph-metainfo($uri as xs:string, 
		$graphURI as xs:string?) 
				as element(http:response)
{
	gsp:retrieve-graph-metainfo($uri, (), $graphURI)
};


(:~
 : Retrieve a graph's metainformation. 
 : @param $uri the URL of the target Graph Store end-point.
 : @param $default selects the 'default' graph.
 : @param $graphURI the named graph URIs
 : @return an http:response element contains HTTP metainfo.
 :)
declare (: private :) function gsp:retrieve-graph-metainfo($uri as xs:string, 
		$default as xs:boolean?, $graphURI as xs:string?) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request(gsp:submission('HEAD', $uri, 
					$default, $graphURI, $RDF_XML, ())))
};


(:~
 : Retrieve the default graph as application/rdf+xml serialisation.
 : @param $uri the URL of the target Graph Store end-point.
 : @return an http:response element contains HTTP metainfo and response body.
 :)
declare function gsp:retrieve-default-graph($uri as xs:string) 
						as element(http:response)
{
	gsp:retrieve-graph($uri, true(), (), $RDF_XML)
};


(:~
 : Retrieve the default graph as requested serialisation.
 : @param $uri the URL of the target Graph Store end-point.
 : @param $mediaType the content-type that will be acceptable to the client.
 : @return an http:response element contains HTTP metainfo and response body.
 :)
declare function gsp:retrieve-default-graph($uri as xs:string, 
		$mediaType as xs:string) 
						as element(http:response)
{
	gsp:retrieve-graph($uri, true(), (), $mediaType)
};


(:~
 : Retrieve the default graph as application/rdf+xml serialisation.
 : @param $uri the URL of the target Graph Store end-point.
 : @param $graphURI the named graph URIs
 : @return an http:response element contains HTTP metainfo and response body.
 :)
declare function gsp:retrieve-named-graph($uri as xs:string, 
		$graphURI as xs:string) 
				as element(http:response)
{
	gsp:retrieve-graph($uri, (), $graphURI, $RDF_XML)
};


(:~
 : Retrieve the default graph as requested serialisation.
 : @param $uri the URL of the target Graph Store end-point.
 : @param $graphURI the named graph URIs
 : @param $mediaType the content-type that will be acceptable to the client.
 : @return an http:response element contains HTTP metainfo and response body.
 :)
declare function gsp:retrieve-named-graph($uri as xs:string, 
		$graphURI as xs:string, $mediaType as xs:string) 
				as element(http:response)
{
	gsp:retrieve-graph($uri, (), $graphURI, $mediaType)
};


(:~
 : Retrieve a graph specifiying the required serialisation. 
 : @param $uri the URL of the target Graph Store end-point.
 : @param $default selects the 'default' graph.
 : @param $graphURI the named graph URIs
 : @param $mediaType the content-type that will be acceptable to the client.
 : @return an http:response element contains HTTP metainfo and response body.
 :)
declare (: private :) function gsp:retrieve-graph($uri as xs:string, 
		$default as xs:boolean?, $graphURI as xs:string?, 
				$mediaType as xs:string) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request(gsp:submission('GET', $uri, $default, $graphURI, 
					$mediaType, ())))
};


(:~
 : Merge the default graph - merges the context graph with submitted graph. 
 : @param $uri the URL of the target Graph Store end-point.
 : @param $graphContent the graph.
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:merge-default-graph($uri as xs:string, 
		$graphContent as item()) 
				as element(http:response)
{
	gsp:merge-graph($uri, true(), (), $graphContent)
};


(:~
 : Merge the default graph - merges the context graph with submitted graph. 
 : @param $uri the URL of the target Graph Store end-point.
 : @param $graphURI the named graph URIs.
 : @param $graphContent the graph.
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:merge-named-graph($uri as xs:string, 
		$graphURI as xs:string, $graphContent as item()) 
				as element(http:response)
{
	gsp:merge-graph($uri, (), $graphURI, $graphContent)
};


(:~
 : Merge Graph - merges current graph with submitted graph. 
 : @param $uri the URL of the target Graph Store end-point.
 : @param $default selects the 'default' graph.
 : @param $graphURI the named graph URIs.
 : @param $graphContent the graph.
 : @return an http:response element contains HTTP metainfo.
 :)
declare (: private :) function gsp:merge-graph($uri as xs:string, $default as xs:boolean?, 
		$graphURI as xs:string?, $graphContent as item()) 
				as element(http:response)
{
	impl:normalise-response(
			impl:http-request(gsp:submission('POST', $uri, $default, $graphURI, 
					$RDF_XML, $graphContent)))
};


(:~
 : Add Graph - replaces current default graph with the submitted graph. 
 : @param $uri the URL of the target Graph Store end-point.
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:add-default-graph($uri as xs:string, 
		$graphContent as item()) 
				as element(http:response)
{
	gsp:add-graph($uri, true(), (), $graphContent)
};


(:~
 : Add Graph - replaces the named graph with the submitted graph. 
 : @param $uri the URL of the target Graph Store end-point.
 : @param $graphURI the named graph URIs
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:add-named-graph($uri as xs:string, 
		$graphURI as xs:string, $graphContent as item()) 
				as element(http:response)
{
	gsp:add-graph($uri, (), $graphURI, $graphContent)
};


(:~
 : Add Graph - replaces the current graph with the submitted graph. 
 : @param $uri the URL of the target Graph Store end-point.
 : @return an http:response element containing HTTP metainfo.
 :)
declare (: private :) function gsp:add-graph($uri as xs:string, 
		$default as xs:boolean?, $graphURI as xs:string?, 
				$graphContent as item()) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request(gsp:submission('PUT', $uri, $default, $graphURI, 
					$RDF_XML, $graphContent)))
};


(:~
 : Delete the default graph. 
 : @param $uri the URL of the target Graph Store end-point.
 : @param $default selects the 'default' graph.
 : @param $graphURI the named graph URIs
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:delete-default-graph($uri as xs:string) 
				as element(http:response)
{
	gsp:delete-graph($uri, true(), ())
};


(:~
 : Delete the named graph. 
 : @param $uri the URL of the target Graph Store end-point.
 : @param $graphURI the named graph URIs
 : @return an http:response element containing HTTP metainfo.
 :)
declare function gsp:delete-named-graph($uri as xs:string, 
		$graphURI as xs:string) 
				as element(http:response)
{
	gsp:delete-graph($uri, (), $graphURI)
};


(:~
 : Delete a graph. 
 : @param $uri the URL of the target Graph Store end-point.
 : @param $default selects the 'default' graph.
 : @param $graphURI the named graph URIs
 : @return an http:response element contains HTTP metainfo.
 :)
declare (: private :) function gsp:delete-graph($uri as xs:string, $default as xs:boolean?, 
		$graphURI as xs:string?) 
				as element(http:response)
{
	impl:normalise-response(
			impl:http-request(gsp:submission('DELETE', $uri, $default, 
					$graphURI, $RDF_XML, ())))
};


(:~
 : Extracts the content of the response body or throws an error if the response
 : XML fragment indicates an error response from the Graph Store. 
 : @param $response the HTTP response fragment.
 : @return either an XML fragment or a string depending upon the response 
 : content-type.
 : @throws GSP002 - Graph Store Reports an Error.
 :)
declare function gsp:data($response as element(http:response))
	as item()*
{
	(: 
	 : If the response status code is less than 400 then assume all is well, 
	 : otherwise throw an exception with the response message in it. 
	 :)
	if (number($response/@status) lt 400) then 
		typeswitch ($response/http:body/(* | text())) 
		case $body as text() 
		return 
			string($response/http:body/text())
		default 
		return
			$response/http:body/*
	else
		error(
			xs:QName('GSP002'), 
			'Graph Store Reports an Error.',
			string($response/http:body/text())
		)
};




(:~
 : Builds an XML fragment that carries the request details.
 : @param $method HTTP method (HEAD|GET|POST|PUT|DELETE)
 : @param $uri the URL of the target Graph Store end-point. 
 : @param $default selects the 'default' graph.
 : @param $graphURI the named graph URIs
 : @param $mediaType Media MIME-Type for the HTTP accpet header
 : @param $graphContent An RDF graph.
 : @throws GSP001 - The default and graph parameters cannot be used together.
 : @return the HTTP request XML fragment.
 :)
declare (: private :) function gsp:submission($method as xs:string, $uri as xs:string, $default as xs:boolean?, 
		$graphURI as xs:string*, $mediaType as xs:string, $graphContent as item()?) as 
				element(http:request) 
{
	let $defaultParam as xs:string? := if ($default) then 'default' else ()
	let $namedGraphParam as xs:string? := if (string-length($graphURI) gt 0) then concat('graph=', $graphURI) else ()
	let $requestParams as xs:string := string-join(($defaultParam, $namedGraphParam), '&amp;')
	return
		if (matches($requestParams, 'default') and matches($requestParams, 'graph')) then 
			error(
				xs:QName('GSP001'), 
				'The default and graph parameters cannot be used together.'
			)
		else
			<request xmlns="http://www.w3.org/Protocols/rfc2616" method="{$method}" 
					href="{concat($uri, if (exists($requestParams)) then concat('?', $requestParams) else '')}">
				<header name="accept" value="{$mediaType}"/>
				<header name="user-agent" value="{$USER_AGENT}"/>
				<header name="content-type" value="{$RDF_XML}"/>
				<header name="encoding" value="UTF-8"/>
				{
					if (exists($graphContent)) then  
						<body xmlns="http://www.w3.org/Protocols/rfc2616" 
								content-type="{$RDF_XML}">{$graphContent}</body>
					else
						()
				}
			</request>
}; 
