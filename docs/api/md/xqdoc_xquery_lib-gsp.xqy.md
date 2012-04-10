# library module: http://www.w3.org/TR/sparql11-http-rdf-update/


## Table of Contents

* Variables: [$USER_AGENT](#var_USER_AGENT), [$RDF_XML](#var_RDF_XML), [$NTRIPLES](#var_NTRIPLES), [$TURTLE](#var_TURTLE)
* Functions: [gsp:retrieve-default-graph-metainfo\#1](#func_gsp_retrieve-default-graph-metainfo_1), [gsp:retrieve-named-graph-metainfo\#2](#func_gsp_retrieve-named-graph-metainfo_2), [gsp:retrieve-graph-metainfo\#3](#func_gsp_retrieve-graph-metainfo_3), [gsp:retrieve-default-graph\#1](#func_gsp_retrieve-default-graph_1), [gsp:retrieve-default-graph\#2](#func_gsp_retrieve-default-graph_2), [gsp:retrieve-named-graph\#2](#func_gsp_retrieve-named-graph_2), [gsp:retrieve-named-graph\#3](#func_gsp_retrieve-named-graph_3), [gsp:retrieve-graph\#4](#func_gsp_retrieve-graph_4), [gsp:merge-default-graph\#2](#func_gsp_merge-default-graph_2), [gsp:merge-named-graph\#3](#func_gsp_merge-named-graph_3), [gsp:merge-graph\#4](#func_gsp_merge-graph_4), [gsp:add-default-graph\#2](#func_gsp_add-default-graph_2), [gsp:add-named-graph\#3](#func_gsp_add-named-graph_3), [gsp:add-graph\#4](#func_gsp_add-graph_4), [gsp:delete-default-graph\#1](#func_gsp_delete-default-graph_1), [gsp:delete-named-graph\#2](#func_gsp_delete-named-graph_2), [gsp:delete-graph\#3](#func_gsp_delete-graph_3), [gsp:data\#1](#func_gsp_data_1), [gsp:submission\#6](#func_gsp_submission_6)


## Variables

### <a name="var_USER_AGENT"/> $USER_AGENT
```xquery
$USER_AGENT as  xs:string
```
 User-agent string. 


### <a name="var_RDF_XML"/> $RDF_XML
```xquery
$RDF_XML as  xs:string
```
 MIME-Types. 


### <a name="var_NTRIPLES"/> $NTRIPLES
```xquery
$NTRIPLES as  xs:string
```

### <a name="var_TURTLE"/> $TURTLE
```xquery
$TURTLE as  xs:string
```



## Functions

### <a name="func_gsp_retrieve-default-graph-metainfo_1"/> gsp:retrieve-default-graph-metainfo\#1
```xquery
gsp:retrieve-default-graph-metainfo($uri as xs:string
) as  element(http:response)
```
  Retrieve the default graph's metainformation.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo.

### <a name="func_gsp_retrieve-named-graph-metainfo_2"/> gsp:retrieve-named-graph-metainfo\#2
```xquery
gsp:retrieve-named-graph-metainfo($uri as xs:string, 
		$graphURI as xs:string?
) as  element(http:response)
```
  Retrieve the named graph's metainformation.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $graphURI as  xs:string? the named graph URIs


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo.

### <a name="func_gsp_retrieve-graph-metainfo_3"/> gsp:retrieve-graph-metainfo\#3
```xquery
gsp:retrieve-graph-metainfo($uri as xs:string, 
		$default as xs:boolean?, $graphURI as xs:string?
) as  element(http:response)
```
  Retrieve a graph's metainformation.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $default as  xs:boolean? selects the 'default' graph.

* $graphURI as  xs:string? the named graph URIs


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo.

### <a name="func_gsp_retrieve-default-graph_1"/> gsp:retrieve-default-graph\#1
```xquery
gsp:retrieve-default-graph($uri as xs:string
) as  element(http:response)
```
  Retrieve the default graph as application/rdf+xml serialisation.  


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo and response body.

### <a name="func_gsp_retrieve-default-graph_2"/> gsp:retrieve-default-graph\#2
```xquery
gsp:retrieve-default-graph($uri as xs:string, 
		$mediaType as xs:string
) as  element(http:response)
```
  Retrieve the default graph as requested serialisation.  


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $mediaType as  xs:string the content-type that will be acceptable to the client.


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo and response body.

### <a name="func_gsp_retrieve-named-graph_2"/> gsp:retrieve-named-graph\#2
```xquery
gsp:retrieve-named-graph($uri as xs:string, 
		$graphURI as xs:string
) as  element(http:response)
```
  Retrieve the default graph as application/rdf+xml serialisation.  


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $graphURI as  xs:string the named graph URIs


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo and response body.

### <a name="func_gsp_retrieve-named-graph_3"/> gsp:retrieve-named-graph\#3
```xquery
gsp:retrieve-named-graph($uri as xs:string, 
		$graphURI as xs:string, $mediaType as xs:string
) as  element(http:response)
```
  Retrieve the default graph as requested serialisation.  


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $graphURI as  xs:string the named graph URIs

* $mediaType as  xs:string the content-type that will be acceptable to the client.


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo and response body.

### <a name="func_gsp_retrieve-graph_4"/> gsp:retrieve-graph\#4
```xquery
gsp:retrieve-graph($uri as xs:string, 
		$default as xs:boolean?, $graphURI as xs:string?, 
				$mediaType as xs:string
) as  element(http:response)
```
  Retrieve a graph specifiying the required serialisation.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $default as  xs:boolean? selects the 'default' graph.

* $graphURI as  xs:string? the named graph URIs

* $mediaType as  xs:string the content-type that will be acceptable to the client.


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo and response body.

### <a name="func_gsp_merge-default-graph_2"/> gsp:merge-default-graph\#2
```xquery
gsp:merge-default-graph($uri as xs:string, 
		$graphContent as item()
) as  element(http:response)
```
  Merge the default graph - merges the context graph with submitted graph.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $graphContent as  item() the graph.


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo.

### <a name="func_gsp_merge-named-graph_3"/> gsp:merge-named-graph\#3
```xquery
gsp:merge-named-graph($uri as xs:string, 
		$graphURI as xs:string, $graphContent as item()
) as  element(http:response)
```
  Merge the default graph - merges the context graph with submitted graph.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $graphURI as  xs:string the named graph URIs.

* $graphContent as  item() the graph.


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo.

### <a name="func_gsp_merge-graph_4"/> gsp:merge-graph\#4
```xquery
gsp:merge-graph($uri as xs:string, $default as xs:boolean?, 
		$graphURI as xs:string?, $graphContent as item()
) as  element(http:response)
```
  Merge Graph - merges current graph with submitted graph.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $default as  xs:boolean? selects the 'default' graph.

* $graphURI as  xs:string? the named graph URIs.

* $graphContent as  item() the graph.


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo.

### <a name="func_gsp_add-default-graph_2"/> gsp:add-default-graph\#2
```xquery
gsp:add-default-graph($uri as xs:string, 
		$graphContent as item()
) as  element(http:response)
```
  Add Graph - replaces current default graph with the submitted graph.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $graphContent as  item()


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo.

### <a name="func_gsp_add-named-graph_3"/> gsp:add-named-graph\#3
```xquery
gsp:add-named-graph($uri as xs:string, 
		$graphURI as xs:string, $graphContent as item()
) as  element(http:response)
```
  Add Graph - replaces the named graph with the submitted graph.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $graphURI as  xs:string the named graph URIs

* $graphContent as  item()


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo.

### <a name="func_gsp_add-graph_4"/> gsp:add-graph\#4
```xquery
gsp:add-graph($uri as xs:string, 
		$default as xs:boolean?, $graphURI as xs:string?, 
				$graphContent as item()
) as  element(http:response)
```
  Add Graph - replaces the current graph with the submitted graph.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $default as  xs:boolean?

* $graphURI as  xs:string?

* $graphContent as  item()


#### Returns
*  element(http:response): an http:response element containing HTTP metainfo.

### <a name="func_gsp_delete-default-graph_1"/> gsp:delete-default-graph\#1
```xquery
gsp:delete-default-graph($uri as xs:string
) as  element(http:response)
```
  Delete the default graph.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo.

### <a name="func_gsp_delete-named-graph_2"/> gsp:delete-named-graph\#2
```xquery
gsp:delete-named-graph($uri as xs:string, 
		$graphURI as xs:string
) as  element(http:response)
```
  Delete the named graph.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $graphURI as  xs:string the named graph URIs


#### Returns
*  element(http:response): an http:response element containing HTTP metainfo.

### <a name="func_gsp_delete-graph_3"/> gsp:delete-graph\#3
```xquery
gsp:delete-graph($uri as xs:string, $default as xs:boolean?, 
		$graphURI as xs:string?
) as  element(http:response)
```
  Delete a graph.   


#### Params

* $uri as  xs:string the URL of the target Graph Store end-point.

* $default as  xs:boolean? selects the 'default' graph.

* $graphURI as  xs:string? the named graph URIs


#### Returns
*  element(http:response): an http:response element contains HTTP metainfo.

### <a name="func_gsp_data_1"/> gsp:data\#1
```xquery
gsp:data($response as element(http:response)
) as  item()*
```
  Extracts the content of the response body or throws an error if the response  XML fragment indicates an error response from the Graph Store.   

 GSP002 - Graph Store Reports an Error. 
#### Params

* $response as  element(http:response) the HTTP response fragment.


#### Returns
*  item()\*: either an XML fragment or a string depending upon the response content-type.

### <a name="func_gsp_submission_6"/> gsp:submission\#6
```xquery
gsp:submission($method as xs:string, $uri as xs:string, $default as xs:boolean?, 
		$graphURI as xs:string*, $mediaType as xs:string, $graphContent as item()?
) as  
				element(http:request)
```
  Builds an XML fragment that carries the request details.  

 GSP001 - The default and graph parameters cannot be used together.  
#### Params

* $method as  xs:string HTTP method (HEAD|GET|POST|PUT|DELETE)

* $uri as  xs:string the URL of the target Graph Store end-point.

* $default as  xs:boolean? selects the 'default' graph.

* $graphURI as  xs:string\* the named graph URIs

* $mediaType as  xs:string Media MIME-Type for the HTTP accpet header

* $graphContent as  item()? An RDF graph.


#### Returns
*  
				element(http:request): the HTTP request XML fragment.





*Generated by [xquerydoc](https://github.com/xquery/xquerydoc)*
