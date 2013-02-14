<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all"
    version="2.0">
    
    <!-- Transform final step into HTML -->
    
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
                <title>SGA text view</title>
                <style type="text/css">
                    .pb {background-color:cyan}
                    .lg {}
                    .diag {background-color:yellow}
                    .hyphenated {}
                    .underline {text-decoration:underline}
                    .double-underline {border-bottom: 3px double;}
                    .bold {font-weight: bold}
                    .italic {font-style:italic}
                    .sup {vertical-align:super}
                </style>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <!-- Ignore all elements that conatin only metmark -->
    <xsl:template match="*[tei:metamark][count(*)=1]"/>    
    
    <xsl:template match="tei:pb">
        <span xmlns="http://www.w3.org/1999/xhtml" class="pb">[Page <xsl:value-of select="number(substring(comment(), string-length(comment())-5, 4))"/>]</span>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:lg">
        <p xmlns="http://www.w3.org/1999/xhtml" class="lg">
            <xsl:for-each select="tei:l">
                <xsl:apply-templates/><br/>
            </xsl:for-each>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <xsl:variable name="lv" select="count(ancestor::tei:div)+1"/>
        <xsl:element name="h{$lv}" namespace="http://www.w3.org/1999/xhtml" >
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <span xmlns="http://www.w3.org/1999/xhtml" class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- this will eventually be obsolete -->
    <xsl:template match="tei:resolved">
        <span xmlns="http://www.w3.org/1999/xhtml" class="diag">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:metamark"/>

        
</xsl:stylesheet>