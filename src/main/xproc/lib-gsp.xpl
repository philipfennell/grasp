<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:c="http://www.w3.org/ns/xproc-step" 
		xmlns:gsp="http://www.w3.org/TR/sparql11-http-rdf-update/"
		xmlns:http="http://www.w3.org/Protocols/rfc2616"
		xmlns:p="http://www.w3.org/ns/xproc"
	 	version="0.1"
		exclude-inline-prefixes="c">
	
	<p:documentation>Graph Store Protocol Step Library</p:documentation>
	
	
	
	
	<!-- === Private Steps. ================================================ -->
	
	<p:declare-step type="gsp:submission">
		<p:documentation>Request Submission</p:documentation>
		<p:output port="result"/>
		<p:option name="method" required="true"/>
		<p:option name="request-uri" required="true"/>
		<p:option name="media-type" required="false" select="'application/rdf+xml'"/>
		
		<p:identity>
			<p:input port="source">
				<p:inline>
<c:request detailed="true">
	<c:header name="accept"/>
	<c:header name="user-agent" value="xpl-graph-store-http-protocol-client/0.1"/>
</c:request>
				</p:inline>
			</p:input>
		</p:identity>
		
		<p:add-attribute match="c:request" attribute-name="method">
			<p:with-option name="attribute-value" select="$method"/>
		</p:add-attribute>
		
		<p:add-attribute match="c:request" attribute-name="href">
			<p:with-option name="attribute-value" select="$request-uri"/>
		</p:add-attribute>
		
		<p:add-attribute match="c:request/c:header[@name eq 'accept']" attribute-name="value">
			<p:with-option name="attribute-value" select="$media-type"/>
		</p:add-attribute>
	</p:declare-step>
	
	
	<p:declare-step name="graph-submission" type="gsp:graph-submission">
		<p:documentation>Request Submission with body</p:documentation>
		<p:input port="source" primary="true"/>
		<p:output port="result"/>
		<p:option name="method" required="true"/>
		<p:option name="request-uri" required="true"/>
		<p:option name="media-type" required="false" select="'application/rdf+xml'"/>
		
		<gsp:submission>
			<p:with-option name="method" select="$method"/>
			<p:with-option name="request-uri" select="$request-uri"/>
		</gsp:submission>
		
		<p:insert match="/c:request" position="last-child">
			<p:input port="insertion">
				<p:inline>
					<c:body content-type="application/rdf+xml"/>
				</p:inline>
			</p:input>
		</p:insert>
		
		<p:insert match="/c:request/c:body" position="last-child">
			<p:input port="insertion">
				<p:pipe port="source" step="graph-submission"/>
			</p:input>
		</p:insert>
	</p:declare-step>
	
	
	<p:declare-step type="gsp:http-request">
		<p:documentation>Extends p:http-request to change the name and namespace of the c:* elements to http:* elements.</p:documentation>
		<p:input port="source"/>
		<p:output port="result"/>
		<p:option name="byte-order-mark" select="'false'"/>
		<p:option name="cdata-section-elements" select="''"/>
		<p:option name="doctype-public" select="''"/>
		<p:option name="doctype-system" select="''"/>
		<p:option name="encoding" select="'UTF-8'"/>
		<p:option name="escape-uri-attributes" select="'false'"/>
		<p:option name="include-content-type" select="'true'"/>
		<p:option name="indent" select="'false'"/>
		<p:option name="media-type" select="'application/xml'"/>
		<p:option name="method" select="'xml'"/>
		<p:option name="normalization-form" select="'none'"/>
		<p:option name="omit-xml-declaration" select="'true'"/>
		<p:option name="standalone" select="'omit'"/>
		<p:option name="undeclare-prefixes" select="'false'"/>
		<p:option name="version" select="'1.0'"/>
		
		<p:http-request>
			<p:with-option name="byte-order-mark" select="$byte-order-mark"/>
			<p:with-option name="cdata-section-elements" select="$cdata-section-elements"/>
			<p:with-option name="doctype-public" select="$doctype-public"/>
			<p:with-option name="doctype-system" select="$doctype-system"/>
			<p:with-option name="encoding" select="$encoding"/>
			<p:with-option name="escape-uri-attributes" select="$escape-uri-attributes"/>
			<p:with-option name="include-content-type" select="$include-content-type"/>
			<p:with-option name="indent" select="$indent"/>
			<p:with-option name="media-type" select="$media-type"/>
			<p:with-option name="method" select="$method"/>
			<p:with-option name="normalization-form" select="$normalization-form"/>
			<p:with-option name="omit-xml-declaration" select="$omit-xml-declaration"/>
			<p:with-option name="standalone" select="$standalone"/>
			<p:with-option name="undeclare-prefixes" select="$undeclare-prefixes"/>
			<p:with-option name="version" select="$version"/>
		</p:http-request>
		
		<!-- remove the c: prefix from element names and change the namespace. -->
		<p:rename match="/c:response" new-name="response" new-namespace="http://www.w3.org/Protocols/rfc2616"/>
		<p:rename match="/http:response/c:header" new-name="header" new-namespace="http://www.w3.org/Protocols/rfc2616"/>
		<p:rename match="/http:response/c:body" new-name="body" new-namespace="http://www.w3.org/Protocols/rfc2616"/>
	</p:declare-step>
	
	
	
	
	<!-- === Public Steps. ================================================= -->
	
	<p:declare-step type="gsp:retrieve-metainfo">
		<p:documentation>Retrieve Metainformation</p:documentation>
		<p:output port="result"/>
		<p:option name="endpoint-uri" required="true"/>
		<p:option name="default-graph-uri" required="true"/>
		<p:option name="media-type" required="false" select="'application/rdf+xml'"/>
		
		<gsp:submission method="head">
			<p:with-option name="request-uri" select="concat($endpoint-uri, $default-graph-uri, '?default=')"/>
		</gsp:submission>
		
		<gsp:http-request/>
	</p:declare-step>
	
	
	<p:declare-step type="gsp:retrieve-graph">
		<p:documentation>Retrieve Graph</p:documentation>
		<p:output port="result"/>
		<p:option name="endpoint-uri" required="true"/>
		<p:option name="default-graph-uri" required="true"/>
		<p:option name="media-type" required="false" select="'application/rdf+xml'"/>
		
		<gsp:submission method="get">
			<p:with-option name="request-uri" select="concat($endpoint-uri, $default-graph-uri, '?default=')"/>
			<p:with-option name="media-type" select="$media-type"/>
		</gsp:submission>
		
		<gsp:http-request/>
	</p:declare-step>
	
	
	<p:declare-step type="gsp:merge-graph">
		<p:documentation>Merge Graph - merges current graph with submitted graph.</p:documentation>
		<p:input port="source"/>
		<p:output port="result"/>
		<p:option name="endpoint-uri" required="true"/>
		<p:option name="default-graph-uri" required="true"/>
		
		<gsp:graph-submission method="post">
			<p:with-option name="request-uri" select="concat($endpoint-uri, $default-graph-uri, '?default=')"/>
		</gsp:graph-submission>
		
		<gsp:http-request/>
	</p:declare-step>
	
	
	<p:declare-step type="gsp:update-graph">
		<p:documentation>Update Graph - replaces existing graph</p:documentation>
		<p:input port="source"/>
		<p:output port="result"/>
		<p:option name="endpoint-uri" required="true"/>
		<p:option name="default-graph-uri" required="true"/>
		
		<gsp:graph-submission method="put">
			<p:with-option name="request-uri" select="concat($endpoint-uri, $default-graph-uri, '?default=')"/>
		</gsp:graph-submission>
		
		<gsp:http-request/>
	</p:declare-step>
	
	
	<p:declare-step type="gsp:patch-graph">
		<p:documentation>Patch Graph</p:documentation>
		<p:input port="source"/>
		<p:output port="result"/>
		<p:option name="endpoint-uri" required="true"/>
		<p:option name="default-graph-uri" required="true"/>
		
		<gsp:graph-submission method="patch">
			<p:with-option name="request-uri" select="concat($endpoint-uri, $default-graph-uri, '?default=')"/>
		</gsp:graph-submission>
		
		<gsp:http-request/>
	</p:declare-step>
	
	
	<p:declare-step type="gsp:delete-graph">
		<p:documentation>Delete Graph</p:documentation>
		<p:output port="result"/>
		<p:option name="endpoint-uri" required="true"/>
		<p:option name="default-graph-uri" required="true"/>
		
		<gsp:submission method="delete">
			<p:with-option name="request-uri" select="concat($endpoint-uri, $default-graph-uri, '?default=')"/>
		</gsp:submission>
		
		<gsp:http-request/>
	</p:declare-step>
	
</p:library>