<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  queryBinding="xslt2">
  
  <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
  <ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
  
  <let name="file-id" value="/tei:surface/tokenize(@xml:id,'_')[3]"/>
  
  <let name="id-regex" value="concat('^',$file-id,'\.\d\d+$')"/>
  
  <!-- Various ad-hoc tests to confirm the conformance of the data set
       to implicit contracts assumed by the stylesheets. -->

  <pattern>
    <rule context="tei:zone[@type='main']">
      <report test="exists(text()[normalize-space()])">Text content found directly inside zone[@type='main']</report>
    </rule>
  </pattern>
  
  <pattern>
    <!-- This one doesn't really matter (until it does): there is a naming convention for @xml:id
         values, not always followed. -->
    <rule context="tei:surface//tei:*[@xml:id]">
      <assert test="matches(@xml:id,$id-regex)"><name/>/@xml:id
        does not conform to pattern '<value-of select="$id-regex"/>'</assert></rule>
  </pattern>
  
  <pattern>
    <!-- Again, the transformations don't really care, but this will catch noise in the data.  -->
    <rule context="tei:anchor">
      <assert test="exists(//*[@spanTo=concat('#',current()/@xml:id)])"><name/> appears
        with nothing spanning to it.</assert>
    </rule>
  </pattern>
  
  <pattern>
    <rule context="tei:*[@spanTo]">
      <let name="targetID" value="replace(current()/@spanTo,'^#','')"/>
      <assert test="exists(id($targetID))"><name/>/@spanTo not resolved (in the same file)</assert>
      <assert test="empty(id($targetID)) or id($targetID) >> current()">Target
      of @spanTo '<value-of select="@spanTo"/>' is not after the @spanTo</assert>
    </rule>
  </pattern>
  
  <pattern>
    <rule context="tei:*[@target]">
      <let name="targetID" value="replace(current()/@target,'^#','')"/>
      <assert test="exists(id($targetID))"><name/>/@target not resolved in the same file</assert></rule>
  </pattern>
  
  <pattern>
    <rule context="tei:*[@next]">
      <let name="targetID" value="replace(current()/@next,'^#','')"/>
      <assert test="exists(id($targetID))"><name/>/@next not resolved in the same file</assert>
    <assert test="empty(id($targetID)) or id($targetID) >> current()">Target
      of @next '<value-of select="@next"/>' is not after the @next</assert>
    </rule>
  </pattern>
  
  <pattern>
    <rule context="tei:addSpan">
    <!-- An addSpan's target must be a following sibling. -->
      <let name="target" value="id(replace(@spanTo,'^#',''))"/>
      <assert test="$target intersect following-sibling::*">addSpan's target not found among its following siblings.</assert>
    </rule>
  </pattern>
  
  <!--<pattern>
    <rule context="tei:ptr">
      <report test="true()">Found a ptr.</report>
    </rule>
  </pattern>-->
</schema>