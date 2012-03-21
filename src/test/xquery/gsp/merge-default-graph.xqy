xquery version "1.0-ml" encoding "utf-8";

import module namespace gsp = "http://www.w3.org/TR/sparql11-http-rdf-update/" at
		"main/xquery/lib-gsp.xqy"; 

import module namespace test = "http://www.w3.org/TR/sparql11-protocol/test" at 
		"test/resources/xquery/test.xqy"; 

declare namespace st 	= "http://www.w3.org/2007/SPARQL/protocol-types#";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

(: Merges the passed graph into the default graph. :)
gsp:merge-default-graph(
	concat($test:SERVICE_URI, 'test/data'),
	<rdf:RDF xmlns:dc="http://purl.org/dc/elements/1.1/"
			xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
		<rdf:Description rdf:about="http://example.org/book/book3">
			<dc:date>1999-07-08</dc:date>
			<dc:publisher rdf:resource="http://live.dbpedia.org/page/Bloomsbury_Publishing"/>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book7">
			<dc:date>2001-07-21</dc:date>
			<dc:publisher rdf:resource="http://live.dbpedia.org/page/Bloomsbury_Publishing"/>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book2">
			<dc:date>1998-07-02</dc:date>
			<dc:publisher rdf:resource="http://live.dbpedia.org/page/Bloomsbury_Publishing"/>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book5">
			<dc:date>2003-06-21</dc:date>
			<dc:publisher rdf:resource="http://live.dbpedia.org/page/Bloomsbury_Publishing"/>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book4">
			<dc:date>2000-07-08</dc:date>
			<dc:publisher rdf:resource="http://live.dbpedia.org/page/Bloomsbury_Publishing"/>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book6">
			<dc:date>2005-07-16</dc:date>
			<dc:publisher rdf:resource="http://live.dbpedia.org/page/Bloomsbury_Publishing"/>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book1">
			<dc:date>2001-11-04</dc:date>
			<dc:publisher rdf:resource="http://live.dbpedia.org/page/Bloomsbury_Publishing"/>
		</rdf:Description>
	</rdf:RDF>
)
