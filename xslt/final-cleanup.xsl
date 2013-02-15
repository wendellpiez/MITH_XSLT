<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:f="http://sga.mith.org/sga/xslt/util"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="#all">

<!-- Final cleanup pass -->
  
  <!--<xsl:strip-space elements="p resolved"/>-->

  <xsl:template match="/">
    <xsl:processing-instruction name="xml-model">
      <xsl:text>href="tei_lite.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
    </xsl:processing-instruction>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="div[@type='chapter']">
    <xsl:copy-of select=".//pb[f:first-pb(.)]"/>
    <xsl:next-match/>
  </xsl:template>
  
  <!-- head inside p is spurious, left behind from paragraph promotion -->
  <xsl:template match="p/head"/>

  <!-- Promoting pb elements at the front and end of paragraphs to be
       next to, not inside them. -->
  <xsl:template match="p">
    <xsl:next-match/>
    <xsl:copy-of select="pb[empty(following-sibling::*)]"/>
  </xsl:template>

  <!-- Dropping any spurious paragraphs holding no elements but a head or pb
       (text content should be in 'line' elements). -->
  <xsl:template match="p[empty(* except (head|pb))]">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- Except for paragraphs in the header. -->
  <xsl:template match="teiHeader//p" priority="5">
    <xsl:apply-templates select="." mode="copy"/>
  </xsl:template>
  
  <!-- Dropping a p/pb if it appears at the end of its parent. -->
  <xsl:template match="p/pb[empty(following-sibling::*)]"/>

  <!-- or if it's the first one in its chapter-->
  <xsl:template match="pb[f:first-pb(.)]" priority="1"/> 
  
  <!-- This could be simplified ... -->
  <xsl:function name="f:first-pb" as="xs:boolean">
    <!-- Returns true for a pb appearing first in its div[@type='chapter'] -->
    <xsl:param name="pb" as="element(pb)"/>
    <xsl:variable name="chapter" select="$pb/ancestor::div[@type='chapter'][1]"/>
    <xsl:sequence select="empty(
        ($chapter//* except ($chapter//head | $pb/parent::p))[. &lt;&lt; $pb]
        (: all elements inside the chapter except any head or the pb's parent p,
           appearing before this pb :) )"/>
  </xsl:function>

  <xsl:template match="line">
    <!--<xsl:text> </xsl:text>-->
    <lb/>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="milestone[@unit='tei:p']"/>
  
  <xsl:template match="node() | @*" mode="copy #default">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
  <!--
    These elements aren't valid in the TEI Lite target ... 
    <xsl:template match="metamark | space | rewrite | damage | restore"/>-->
  
</xsl:stylesheet>