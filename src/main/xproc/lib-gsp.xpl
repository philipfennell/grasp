<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:c="http://www.w3.org/ns/xproc-step" 
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:gsp="http://www.w3.org/TR/sparql11-http-rdf-update/"
		xmlns:http="http://www.w3.org/Protocols/rfc2616"
		xmlns:p="http://www.w3.org/ns/xproc"
	 	version="0.3"
		exclude-inline-prefixes="#all">
	
	<p:documentation>Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.</p:documentation>
	
	<p:documentation>Graph Store Protocol Step Library</p:documentation>
	
	<p:import href="library-1.0.xpl"/>
	
	
	<!-- === Private Steps. ================================================ -->
	
	<p:declare-step type="gsp:submission">
		<p:documentation>Request Submission</p:documentation>
		<p:output port="result"/>
		<p:option name="method" required="true"/>
		<p:option name="request-uri" required="true"/>
		<p:option name="media-type" required="false" select="'application/rdf+xml'"/>
		<p:option name="slug" required="false" select="''"/>
		
		<p:identity>
			<p:input port="source">
				<p:inline exclude-inline-prefixes="#all">
<c:request detailed="true">
	<c:header name="Accept"/>
	<c:header name="Slug"/>
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
		
		<p:add-attribute match="c:request/c:header[@name eq 'Accept']" attribute-name="value">
			<p:with-option name="attribute-value" select="$media-type"/>
		</p:add-attribute>
		
		<p:add-attribute match="c:request/c:header[@name eq 'Slug']" attribute-name="value">
			<p:with-option name="attribute-value" select="$slug"/>
		</p:add-attribute>
	</p:declare-step>
	
	
	<p:declare-step name="graph-submission" type="gsp:graph-submission">
		<p:documentation>Request Submission with body</p:documentation>
		<p:input port="source" primary="true"/>
		<p:output port="result"/>
		<p:option name="method" required="true"/>
		<p:option name="request-uri" required="true"/>
		<p:option name="content-type" required="true"/>
		<p:option name="slug" required="false" select="''"/>
		
		<gsp:submission>
			<p:with-option name="method" select="$method"/>
			<p:with-option name="request-uri" select="$request-uri"/>
			<p:with-option name="slug" select="$slug"/>
		</gsp:submission>
		
		<p:insert match="/c:request" position="last-child">
			<p:input port="insertion">
				<p:inline exclude-inline-prefixes="#all">
					<c:body content-type="application/rdf+xml"/>
				</p:inline>
			</p:input>
		</p:insert>
		
		<p:add-attribute match="/c:request/c:body" attribute-name="content-type">
			<p:with-option name="attribute-value" select="$content-type"/>
		</p:add-attribute>
		
		<gsp:insert-entity>
			<p:input port="entity">
				<p:pipe port="source" step="graph-submission"/>
			</p:input>
			<p:with-option name="content-type" select="$content-type"/>
		</gsp:insert-entity>
	</p:declare-step>
	
	
	<p:declare-step name="insert-entity" type="gsp:insert-entity">
		<p:documentation>Insert the payload entity into the request fragment.</p:documentation>
		<p:input port="source" primary="true"/>
		<p:input port="entity" primary="false"/>
		<p:output port="result"/>
		<p:option name="content-type" required="true"/>
		
		<p:choose>
			<p:when test="starts-with($content-type, 'text/')">
				<!--<p:string-replace match="/c:request/c:body/*">
					<p:with-option name="replace" select="$content-type"/>
				</p:string-replace>-->
				<p:replace match="/c:request/c:body">
					<p:input port="source">
						<p:pipe port="source" step="insert-entity"/>
					</p:input>
					<p:input port="relacement">
						<p:pipe port="entity" step="insert-entity"/>
					</p:input>
				</p:replace>
			</p:when>
			<p:otherwise>
				<p:insert match="/c:request/c:body" position="last-child">
					<p:input port="source">
						<p:pipe port="source" step="insert-entity"/>
					</p:input>
					<p:input port="insertion">
						<p:pipe port="entity" step="insert-entity"/>
					</p:input>
				</p:insert>
			</p:otherwise>
		</p:choose>
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
	
	
	<p:declare-step type="gsp:debug-submission">
		<p:documentation>Dumps the http request fragment to the console if debug == true.</p:documentation>
		<p:input port="source"/>
		<p:output port="result"/>
		<p:option name="debug" required="false" select="'false'"/>
		
		<p:choose>
			<p:when test="$debug eq 'true'">
				<p:identity name="request"/>
				
				<p:wrap match="/c:request" wrapper="message" />
				<p:escape-markup/>
				
				<cx:message>
					<p:with-option name="message" select="concat('[XProc][GSP] Request:&#10;', string(/message))"/>
				</cx:message>
				
				<p:identity>
					<p:input port="source">
						<p:pipe port="result" step="request"/>
					</p:input>
				</p:identity>
			</p:when>
			<p:otherwise>
				<p:identity/>
			</p:otherwise>
		</p:choose>
		
		<p:identity/>
	</p:declare-step>
	
	
	
	
	<!-- === Public Steps. ================================================= -->
	
	<p:declare-step type="gsp:retrieve-metainfo">
		<p:documentation>Retrieve Metainformation</p:documentation>
		<p:output port="result"/>
		<p:option name="uri" required="true"/>
		<p:option name="media-type" required="false" select="'application/rdf+xml'"/>
		<p:option name="default" required="false" select="'false'"/>
		<p:option name="graph" required="false" select="''"/>
		<!--<p:option name="debug" required="false" select="'false'"/>-->
		
		<p:variable name="params" select="string-join((if ($default eq 'true') then 'default' else (), if (string-length($graph) gt 0) then concat('graph=', encode-for-uri($graph)) else ()), '&amp;')"/>
		
		<gsp:submission method="head">
			<p:with-option name="request-uri" select="concat($uri, if (contains($uri, '?')) then '&amp;' else '?', $params)"/>
		</gsp:submission>
		
		<!--<gsp:debug-submission>
			<p:with-option name="debug" select="$debug"/>
		</gsp:debug-submission>-->
		
		<gsp:http-request/>
	</p:declare-step>
	
	
	<p:declare-step type="gsp:retrieve-graph">
		<p:documentation>Retrieve Graph</p:documentation>
		<p:output port="result"/>
		<p:option name="uri" required="true"/>
		<p:option name="default" required="false" select="'false'"/>
		<p:option name="graph" required="false" select="''"/>
		<p:option name="media-type" required="false" select="'application/rdf+xml'"/>
		<!--<p:option name="debug" required="false" select="'false'"/>-->
		
		<p:variable name="params" select="string-join((if ($default eq 'true') then 'default' else (), if (string-length($graph) gt 0) then concat('graph=', encode-for-uri($graph)) else ()), '&amp;')"/>
		
		<gsp:submission method="get">
			<p:with-option name="request-uri" select="concat($uri, if (contains($uri, '?')) then '&amp;' else '?', $params)"/>
			<p:with-option name="media-type" select="$media-type"/>
		</gsp:submission>
		
		<!--<gsp:debug-submission>
			<p:with-option name="debug" select="$debug"/>
		</gsp:debug-submission>-->
		
		<gsp:http-request/>
	</p:declare-step>
	
	
	<p:declare-step type="gsp:merge-graph">
		<p:documentation>Merge Graph - merges current graph with submitted graph.</p:documentation>
		<p:input port="source"/>
		<p:output port="result"/>
		<p:option name="uri" required="true"/>
		<p:option name="content-type" required="true"/>
		<p:option name="default" required="false" select="'false'"/>
		<p:option name="graph" required="false" select="''"/>
		<p:option name="slug" required="false" select="''"/>
		<!--<p:option name="debug" required="false" select="'false'"/>-->
		
		<p:variable name="params" select="string-join((if ($default eq 'true') then 'default' else (), if (string-length($graph) gt 0) then concat('graph=', encode-for-uri($graph)) else ()), '&amp;')"/>
		
		<gsp:graph-submission method="post">
			<p:with-option name="request-uri" select="concat($uri, if (contains($uri, '?')) then '&amp;' else '?', $params)"/>
			<p:with-option name="content-type" select="$content-type"/>
			<p:with-option name="slug" select="$slug"/>
		</gsp:graph-submission>
		
		<!--<gsp:debug-submission>
			<p:with-option name="debug" select="$debug"/>
		</gsp:debug-submission>-->
		
		<gsp:http-request/>
	</p:declare-step>
	
	
	<p:declare-step type="gsp:add-graph">
		<p:documentation>Add Graph - replaces existing graph</p:documentation>
		<p:input port="source"/>
		<p:output port="result"/>
		<p:option name="uri" required="true"/>
		<p:option name="content-type" required="true"/>
		<p:option name="default" required="false" select="'false'"/>
		<p:option name="graph" required="false" select="''"/>
		<!--<p:option name="debug" required="false" select="'false'"/>-->
		
		<p:variable name="params" select="string-join((if ($default eq 'true') then 'default' else (), if (string-length($graph) gt 0) then concat('graph=', encode-for-uri($graph)) else ()), '&amp;')"/>
		
		<gsp:graph-submission method="put">
			<p:with-option name="request-uri" select="concat($uri, if (contains($uri, '?')) then '&amp;' else '?', $params)"/>
			<p:with-option name="content-type" select="$content-type"/>
		</gsp:graph-submission>
		
		<!--<gsp:debug-submission>
			<p:with-option name="debug" select="$debug"/>
		</gsp:debug-submission>-->
		
		<gsp:http-request/>
	</p:declare-step>
	
	
	<!-- PATCH is not implemented in Calabash at present.
	<p:declare-step type="gsp:patch-graph">
		<p:documentation>Patch Graph</p:documentation>
		<p:input port="source"/>
		<p:output port="result"/>
		<p:option name="uri" required="true"/>
		<p:option name="default" required="false" select="'false'"/>
		<p:option name="graph" required="false" select="''"/>
		<p:option name="debug" required="false" select="'false'"/>
		
		<p:variable name="params" select="string-join((if ($default eq 'true') then 'default' else (), if (string-length($graph) gt 0) then concat('graph=', encode-for-uri($graph)) else ()), '&amp;')"/>
		
		<gsp:graph-submission method="patch">
			<p:with-option name="request-uri" select="concat($uri, if (contains($uri, '?')) then '&amp;' else '?', $params)"/>
		</gsp:graph-submission>
		
		<gsp:debug-submission>
			<p:with-option name="debug" select="$debug"/>
		</gsp:debug-submission>
		
		<gsp:http-request/>
	</p:declare-step>
	-->
	
	
	<p:declare-step type="gsp:retieve-service-description">
		<p:documentation>Retrieve the Graph Store's Service Description</p:documentation>
		<p:output port="result"/>
		<p:option name="uri" required="true"/>
		<p:option name="media-type" required="false" select="'application/rdf+xml'"/>
		<p:option name="debug" required="false" select="'false'"/>
		
		<gsp:submission method="get">
			<p:with-option name="request-uri" select="$uri"/>
			<p:with-option name="media-type" select="$media-type"/>
		</gsp:submission>
		
		<gsp:debug-submission>
			<p:with-option name="debug" select="$debug"/>
		</gsp:debug-submission>
		
		<gsp:http-request/>
	</p:declare-step>
	
	
	<p:declare-step type="gsp:delete-graph">
		<p:documentation>Delete Graph</p:documentation>
		<p:output port="result"/>
		<p:option name="uri" required="true"/>
		<p:option name="default" required="false" select="'false'"/>
		<p:option name="graph" required="false" select="''"/>
		<!--<p:option name="debug" required="false" select="'false'"/>-->
		
		<p:variable name="params" select="string-join((if ($default eq 'true') then 'default' else (), if (string-length($graph) gt 0) then concat('graph=', encode-for-uri($graph)) else ()), '&amp;')"/>
		
		<gsp:submission method="delete">
			<p:with-option name="request-uri" select="concat($uri, if (contains($uri, '?')) then '&amp;' else '?', $params)"/>
		</gsp:submission>
		
		<!--<gsp:debug-submission>
			<p:with-option name="debug" select="$debug"/>
		</gsp:debug-submission>-->
		
		<gsp:http-request/>
	</p:declare-step>
	
</p:library>