<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:gsp="http://www.w3.org/TR/sparql11-http-rdf-update/"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:test="http://www.w3.org/ns/xproc/test"
		xml:base="../../../"
		exclude-inline-prefixes="gsp"
	 	version="1.0">
	
	<p:output port="result"/>
	
	<p:serialization port="result" encoding="UTF-8" indent="true" media-type="application/xml" method="xml"/>
	
	<p:import href="main/xproc/lib-gsp.xpl"/>
	<p:import href="test/resources/xproc/test.xpl"/>
	
	
	<gsp:patch-graph endpoint-uri="http://localhost:3030" default-graph-uri="/test/data">
		<p:input port="source">
			<p:inline>
				<rdf:Description xmlns:dc="http://purl.org/dc/elements/1.1/"
						xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
						rdf:about="http://example.org/book/book1">
					<dc:date>2012-12-02</dc:date>
				</rdf:Description>
			</p:inline>
		</p:input>
	</gsp:patch-graph>
	
</p:declare-step>