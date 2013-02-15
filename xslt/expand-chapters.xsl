<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="http://www.tei-c.org/ns/1.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="xs"
  version="2.0">
  
<!-- Expands ptr elements with file targets -->
 
  <xsl:param name="file-path" as="xs:string"/>
  
  <xsl:template match="* | @*">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="teiHeader/fileDesc/titleStmt">
    <titleStmt>
      <title>Abinger MS to <title>Frankenstein</title>: reading version</title>
    </titleStmt>
  </xsl:template>
  
  <xsl:template match="teiHeader/fileDesc/sourceDesc">
    <sourceDesc>
      <p>Generated programmatically from TEI Genetic Edition encoding.</p>
    </sourceDesc>
  </xsl:template>
  
  <xsl:template match="ptr[not(starts-with(@target,'#'))]">
    <xsl:variable name="target-path" select="string-join(($file-path,@target),'/')"/>
    <xsl:copy-of select="document($target-path)/*"/>
  </xsl:template>

</xsl:stylesheet>