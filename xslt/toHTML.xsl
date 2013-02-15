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
                    .lb { color:grey }
                </style>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:teiHeader//tei:titleStmt/tei:title">
      <h1 class="page-title">
        <xsl:apply-templates/>
      </h1>
    </xsl:template>
  
    <xsl:template match="tei:title/tei:title">
      <span class="italic">
        <xsl:apply-templates/>
      </span>
    </xsl:template>
  
    <!-- Ignore all elements that contain only metamark -->
  <xsl:template match="*[exists(tei:metamark) and empty((*|text()[normalize-space()]) except tei:metamark)]"/>    
    
    <xsl:template match="tei:pb">
        <span class="pb">[Page <xsl:value-of select="number(substring(comment(), string-length(comment())-5, 4))"/>]</span>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:lg">
        <p class="lg">
            <xsl:for-each select="tei:l">
                <xsl:apply-templates/><br/>
            </xsl:for-each>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <xsl:variable name="lv" select="count(ancestor::tei:div)+1"/>
        <xsl:element name="h{$lv}" >
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <span class="{string-join((@rend,'hi'),' ')}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- this will eventually be obsolete -->
    <xsl:template match="tei:add[@source]">
        <span class="diag">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:lb">
      <span class="lb">|</span>
    </xsl:template>
  
    <xsl:template match="tei:metamark"/>

        
</xsl:stylesheet>