# library module: http://www.w3.org/TR/sparql11-protocol/


## Table of Contents

* Variables: [$SPARQL_RESULTS_XML](#var_SPARQL_RESULTS_XML), [$SPARQL_RESULTS_JSON](#var_SPARQL_RESULTS_JSON), [$RDF_XML](#var_RDF_XML), [$TSV](#var_TSV), [$CSV](#var_CSV), [$USER_AGENT](#var_USER_AGENT), [$MAX_REQUEST_URI_LENGTH](#var_MAX_REQUEST_URI_LENGTH)
* Functions: [spq:data\#1](#func_spq_data_1), [spq:query\#5](#func_spq_query_5), [spq:query\#4](#func_spq_query_4), [spq:query-get\#4](#func_spq_query-get_4), [spq:query-get\#5](#func_spq_query-get_5), [spq:query-post\#4](#func_spq_query-post_4), [spq:query-post\#5](#func_spq_query-post_5), [(: private :) spq:submission\#6](#func_(_ private _) spq_submission_6)


## Variables

### <a name="var_SPARQL_RESULTS_XML"/> $SPARQL_RESULTS_XML
```xquery
$SPARQL_RESULTS_XML as  xs:string
```
 Request encodings. 


### <a name="var_SPARQL_RESULTS_JSON"/> $SPARQL_RESULTS_JSON
```xquery
$SPARQL_RESULTS_JSON as  xs:string
```

### <a name="var_RDF_XML"/> $RDF_XML
```xquery
$RDF_XML as  xs:string
```

### <a name="var_TSV"/> $TSV
```xquery
$TSV as  xs:string
```

### <a name="var_CSV"/> $CSV
```xquery
$CSV as  xs:string
```

### <a name="var_USER_AGENT"/> $USER_AGENT
```xquery
$USER_AGENT as  xs:string
```
 User-agent string. 


### <a name="var_MAX_REQUEST_URI_LENGTH"/> $MAX_REQUEST_URI_LENGTH
```xquery
$MAX_REQUEST_URI_LENGTH as  xs:integer
```
 Maximum request URI length. 




## Functions

### <a name="func_spq_data_1"/> spq:data\#1
```xquery
spq:data($response as element(http:response)
) as  item()*
```
  Extracts the content of the response body or throws an error if the response  XML fragment indicates an error response from the Graph Store.   

 GSP002 - Graph Store Reports an Error. 
#### Params

* $response as  element(http:response) the HTTP response fragment.


#### Returns
*  item()\*: either an XML fragment or a string depending upon the response content-type.

### <a name="func_spq_query_5"/> spq:query\#5
```xquery
spq:query($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string, $mediaType as xs:string
) as  element(http:response)
```
  The HTTP binding for query operation. If the requests length is greater than   the predefined threshold the POST is used instead of GET.  


#### Params

* $endPointURI as  xs:string the URL of the target SPARQL end-point.

* $defaultGraphURIs as  xs:string\* the default graph URIs

* $namedGraphURIs as  xs:string\* the named graph URIs

* $query as  xs:string the SPARQL query to be sent.

* $mediaType as  xs:string the Media MIME-Type for the HTTP accept header.


#### Returns
*  element(http:response): 

### <a name="func_spq_query_4"/> spq:query\#4
```xquery
spq:query($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string
) as  element(http:response)
```
  The HTTP binding for query operation. Assumes the default Accept header  for the SPARQL XML Results format. If the requests length is greater than   the predefined threshold the POST is used instead of GET.  


#### Params

* $endPointURI as  xs:string the URL of the target SPARQL end-point.

* $defaultGraphURIs as  xs:string\* the default graph URIs

* $namedGraphURIs as  xs:string\* the named graph URIs

* $query as  xs:string the SPARQL query to be sent.


#### Returns
*  element(http:response): the query response wrapped in an query-result element that carries the response content type.

### <a name="func_spq_query-get_4"/> spq:query-get\#4
```xquery
spq:query-get($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string
) as  element(http:response)
```
  The HTTP GET binding for query operation. Assumes the default Accept header  for the SPARQL XML Results format.  


#### Params

* $endPointURI as  xs:string the URL of the target SPARQL end-point.

* $defaultGraphURIs as  xs:string\* the default graph URIs

* $namedGraphURIs as  xs:string\* the named graph URIs

* $query as  xs:string the SPARQL query to be sent.


#### Returns
*  element(http:response): the query response wrapped in an query-result element that carries the response content type.

### <a name="func_spq_query-get_5"/> spq:query-get\#5
```xquery
spq:query-get($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string, $mediaType as xs:string
) as  element(http:response)
```
  The HTTP GET binding for query operation.   


#### Params

* $endPointURI as  xs:string the URL of the target SPARQL end-point.

* $defaultGraphURIs as  xs:string\* the default graph URIs

* $namedGraphURIs as  xs:string\* the named graph URIs

* $query as  xs:string the SPARQL query to be sent.

* $mediaType as  xs:string the Media MIME-Type for the HTTP accept header.


#### Returns
*  element(http:response): the query response wrapped in an query-result element that carries the response content type.

### <a name="func_spq_query-post_4"/> spq:query-post\#4
```xquery
spq:query-post($endPointURI as xs:string,
		$defaultGraphURIs as xs:string*, 
				$namedGraphURIs as xs:string*, $query as xs:string
) as  element(http:response)
```
  The HTTP GET binding for query operation. Assumes the default Accept header  for the SPARQL XML Results format.  


#### Params

* $endPointURI as  xs:string the URL of the target SPARQL end-point.

* $defaultGraphURIs as  xs:string\* the default graph URIs

* $namedGraphURIs as  xs:string\* the named graph URIs

* $query as  xs:string the SPARQL query to be sent.


#### Returns
*  element(http:response): the query response wrapped in an query-result element that carries the response content type.

### <a name="func_spq_query-post_5"/> spq:query-post\#5
```xquery
spq:query-post($endPointURI as xs:string,
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string, $mediaType as xs:string
) as  element(http:response)
```
  The HTTP GET binding for query operation. Assumes the default Accept header  for the SPARQL XML Results format.  


#### Params

* $endPointURI as  xs:string the URL of the target SPARQL end-point.

* $defaultGraphURIs as  xs:string\* the default graph URIs

* $namedGraphURIs as  xs:string\* the named graph URIs

* $query as  xs:string the SPARQL query to be sent.

* $mediaType as  xs:string the Media MIME-Type for the HTTP accept header.


#### Returns
*  element(http:response): the query response wrapped in an query-result element that carries the response content type.

### <a name="func_(_ private _) spq_submission_6"/> (: private :) spq:submission\#6
```xquery
(: private :) spq:submission($method as xs:string, $endpoitURI as xs:string, $defaultGraphURIs as xs:string*, 
		$namedGraphURIs as xs:string*, $query as item()?, $mediaType as xs:string
) as  
				element(http:request)
```
  Builds an XML fragment that carries the request details.  


#### Params

* $method as  xs:string HTTP method (GET|POST)

* $endpoitURI as  xs:string

* $defaultGraphURIs as  xs:string\* the default graph URIs.

* $namedGraphURIs as  xs:string\* the named graph URIs.

* $query as  item()? An RDF graph.

* $mediaType as  xs:string Media MIME-Type for the HTTP accpet header.


#### Returns
*  
				element(http:request): the HTTP request XML fragment.





*Generated by [xquerydoc](https://github.com/xquery/xquerydoc)*
