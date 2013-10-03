# *************************************************************
#  
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#  
#    http://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing,
#  software distributed under the License is distributed on an
#  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#  KIND, either express or implied.  See the License for the
#  specific language governing permissions and limitations
#  under the License.
#  
# *************************************************************
# unroll begin

.IF "$(SRS1NAME)"!=""

$(MISC)/$(TARGET).$(SRS1NAME).dprr: $(LOCALIZE_ME_DEST)

$(MISC)/$(TARGET).$(SRS1NAME).dprr: $(SRC1FILES)
	@echo "Making: (SRS1NAME.dprr)  " $(@:f)
	@@-$(RM) $(MISC)/$(TARGET).$(SRS1NAME).dprr
	$(COMMAND_ECHO)$(RSC) $(VERBOSITY) $(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) -I$(INCLOCPRJ)  -I$(INCLOCAL) -I$(INC) -I$(INCCOM) $(RSCDEFS) $(RSCUPDVERDEF) -fp={$(SRS)/$(SRS1NAME).srs} -fo=$@ -p=$(TARGET) $(SRC1FILES)

.IF "$(WITH_LANG)"!=""

$(foreach,i,$(SRC1FILES) $(COMMONMISC)/$(TARGET)/$i) : $$(@:f)
	@echo "Making: (SRS Localize)   " $(@:f)
	$(COMMAND_ECHO)-$(MKDIR) $(@:d)
    $(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)-$(MKDIRHIER)  $(COMMONMISC)$/$(PRJNAME)
        $(SOLARBINDIR)/genLang merge $(PRJNAME) $(SRC_ROOT)/languages/source "$(WITH_LANG)" -t  $(COMMONMISC)/$(TARGET) -v -f $<
#	$(COMMAND_ECHO)$(WRAPCMD) $(TRANSEX) -p $(PRJNAME) -i $(@:f) -o $(@).$(INPATH) -m $(LOCALIZESDF) -l all

$(SRS)/$(SRS1NAME).srs: $(LOCALIZE_ME_DEST)

$(SRS)/$(SRS1NAME).srs: $(foreach,i,$(SRC1FILES) $(COMMONMISC)/$(TARGET)/$i)
.ELSE			# "$(WITH_LANG)"!=""
$(SRS)/$(SRS1NAME).srs: $(SRC1FILES)
.ENDIF			# "$(WITH_LANG)"!=""
	@echo "Making: (.src)  " $(@:f)
	$(COMMAND_ECHO)$(RSC) -presponse $(VERBOSITY) @$(mktmp \
		$(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) \
		$(INCLUDE) $(RSCDEFS) $(RSCUPDVERDEF) \
		-fp=$@.$(INPATH) \
		$< \
	)
	$(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
	$(COMMAND_ECHO)-$(RM) $@.$(INPATH)

.ENDIF          # "$(SRS1NAME)"!=""

# unroll begin

.IF "$(SRS2NAME)"!=""

$(MISC)/$(TARGET).$(SRS2NAME).dprr: $(LOCALIZE_ME_DEST)

$(MISC)/$(TARGET).$(SRS2NAME).dprr: $(SRC2FILES)
	@echo "Making: (SRS2NAME.dprr)   " $(@:f)
	@@-$(RM) $(MISC)/$(TARGET).$(SRS2NAME).dprr
	$(COMMAND_ECHO)$(RSC) $(VERBOSITY) $(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) -I$(INCLOCPRJ)  -I$(INCLOCAL) -I$(INC) -I$(INCCOM) $(RSCDEFS) $(RSCUPDVERDEF) -fp={$(SRS)/$(SRS2NAME).srs} -fo=$@ -p=$(TARGET) $(SRC2FILES)

.IF "$(WITH_LANG)"!=""

$(foreach,i,$(SRC2FILES) $(COMMONMISC)/$(TARGET)/$i) : $$(@:f)
	@echo "Making: (SRC LOCALIZE2)   " $(@:f)
	$(COMMAND_ECHO)-$(MKDIR) $(@:d)
    $(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)-$(MKDIRHIER)  $(COMMONMISC)$/$(PRJNAME)
        $(SOLARBINDIR)/genLang merge $(PRJNAME) $(SRC_ROOT)/languages/source "$(WITH_LANG)" -t  $(COMMONMISC)/$(TARGET) -v -f $<
#	$(COMMAND_ECHO)$(WRAPCMD) $(TRANSEX) -p $(PRJNAME) -i $(@:f) -o $(@).$(INPATH) -m $(LOCALIZESDF) -l all
    $(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
    $(COMMAND_ECHO)-$(RM) $@.$(INPATH)

$(SRS)/$(SRS2NAME).srs: $(LOCALIZE_ME_DEST)

$(SRS)/$(SRS2NAME).srs: $(foreach,i,$(SRC2FILES) $(COMMONMISC)/$(TARGET)/$i)
.ELSE			# "$(WITH_LANG)"!=""
$(SRS)/$(SRS2NAME).srs: $(SRC2FILES)
.ENDIF			# "$(WITH_LANG)"!=""
	@echo "Making: (2.src)   " $(@:f)
	$(COMMAND_ECHO)$(RSC) -presponse $(VERBOSITY) @$(mktmp \
		$(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) \
		$(INCLUDE) $(RSCDEFS) $(RSCUPDVERDEF) \
		-fp=$@.$(INPATH) \
		$< \
	)
	$(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
	$(COMMAND_ECHO)-$(RM) $@.$(INPATH)

.ENDIF          # "$(SRS2NAME)"!=""

# unroll begin

.IF "$(SRS3NAME)"!=""

$(MISC)/$(TARGET).$(SRS3NAME).dprr: $(LOCALIZE_ME_DEST)

$(MISC)/$(TARGET).$(SRS3NAME).dprr: $(SRC3FILES)
	@echo "Making: (SRS3NAME.dprr)  " $(@:f)
	@@-$(RM) $(MISC)/$(TARGET).$(SRS3NAME).dprr
	$(COMMAND_ECHO)$(RSC) $(VERBOSITY) $(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) -I$(INCLOCPRJ)  -I$(INCLOCAL) -I$(INC) -I$(INCCOM) $(RSCDEFS) $(RSCUPDVERDEF) -fp={$(SRS)/$(SRS3NAME).srs} -fo=$@ -p=$(TARGET) $(SRC3FILES)

.IF "$(WITH_LANG)"!=""

$(foreach,i,$(SRC3FILES) $(COMMONMISC)/$(TARGET)/$i) : $$(@:f)
	@echo "Making: (SRC3 Localize)   " $(@:f)
	$(COMMAND_ECHO)-$(MKDIR) $(@:d)
    $(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)-$(MKDIRHIER)  $(COMMONMISC)$/$(PRJNAME)
        $(SOLARBINDIR)/genLang merge $(PRJNAME) $(SRC_ROOT)/languages/source "$(WITH_LANG)" -t  $(COMMONMISC)/$(TARGET) -v -f $<
#	$(COMMAND_ECHO)$(WRAPCMD) $(TRANSEX) -p $(PRJNAME) -i $(@:f) -o $(@).$(INPATH) -m $(LOCALIZESDF) -l all
    $(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
    $(COMMAND_ECHO)-$(RM) $@.$(INPATH)

$(SRS)/$(SRS3NAME).srs: $(LOCALIZE_ME_DEST)

$(SRS)/$(SRS3NAME).srs: $(foreach,i,$(SRC3FILES) $(COMMONMISC)/$(TARGET)/$i)
.ELSE			# "$(WITH_LANG)"!=""
$(SRS)/$(SRS3NAME).srs: $(SRC3FILES)
.ENDIF			# "$(WITH_LANG)"!=""
	@echo "Making: (SRC3sec)   " $(@:f)
	$(COMMAND_ECHO)$(RSC) -presponse $(VERBOSITY) @$(mktmp \
		$(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) \
		$(INCLUDE) $(RSCDEFS) $(RSCUPDVERDEF) \
		-fp=$@.$(INPATH) \
		$< \
	)
	$(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
	$(COMMAND_ECHO)-$(RM) $@.$(INPATH)

.ENDIF          # "$(SRS3NAME)"!=""

# unroll begin

.IF "$(SRS4NAME)"!=""

$(MISC)/$(TARGET).$(SRS4NAME).dprr: $(LOCALIZE_ME_DEST)

$(MISC)/$(TARGET).$(SRS4NAME).dprr: $(SRC4FILES)
	@echo "Making: (SRS4NAME.dprr)   " $(@:f)
	@@-$(RM) $(MISC)/$(TARGET).$(SRS4NAME).dprr
	$(COMMAND_ECHO)$(RSC) $(VERBOSITY) $(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) -I$(INCLOCPRJ)  -I$(INCLOCAL) -I$(INC) -I$(INCCOM) $(RSCDEFS) $(RSCUPDVERDEF) -fp={$(SRS)/$(SRS4NAME).srs} -fo=$@ -p=$(TARGET) $(SRC4FILES)

.IF "$(WITH_LANG)"!=""

$(foreach,i,$(SRC4FILES) $(COMMONMISC)/$(TARGET)/$i) : $$(@:f)
	@echo "Making: (SRC4 localize)   " $(@:f)
	$(COMMAND_ECHO)-$(MKDIR) $(@:d)
    $(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)-$(MKDIRHIER)  $(COMMONMISC)$/$(PRJNAME)
        $(SOLARBINDIR)/genLang merge $(PRJNAME) $(SRC_ROOT)/languages/source "$(WITH_LANG)" -t  $(COMMONMISC)/$(TARGET) -v -f $<
#	$(COMMAND_ECHO)$(WRAPCMD) $(TRANSEX) -p $(PRJNAME) -i $(@:f) -o $(@).$(INPATH) -m $(LOCALIZESDF) -l all
    $(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
    $(COMMAND_ECHO)-$(RM) $@.$(INPATH)

$(SRS)/$(SRS4NAME).srs: $(LOCALIZE_ME_DEST)

$(SRS)/$(SRS4NAME).srs: $(foreach,i,$(SRC4FILES) $(COMMONMISC)/$(TARGET)/$i)
.ELSE			# "$(WITH_LANG)"!=""
$(SRS)/$(SRS4NAME).srs: $(SRC4FILES)
.ENDIF			# "$(WITH_LANG)"!=""
	@echo "Making: (SRC4sec)  " $(@:f)
	$(COMMAND_ECHO)$(RSC) -presponse $(VERBOSITY) @$(mktmp \
		$(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) \
		$(INCLUDE) $(RSCDEFS) $(RSCUPDVERDEF) \
		-fp=$@.$(INPATH) \
		$< \
	)
	$(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
	$(COMMAND_ECHO)-$(RM) $@.$(INPATH)

.ENDIF          # "$(SRS4NAME)"!=""

# unroll begin

.IF "$(SRS5NAME)"!=""

$(MISC)/$(TARGET).$(SRS5NAME).dprr: $(LOCALIZE_ME_DEST)

$(MISC)/$(TARGET).$(SRS5NAME).dprr: $(SRC5FILES)
	@echo "Making: (SRS5NAME.dprr)   " $(@:f)
	@@-$(RM) $(MISC)/$(TARGET).$(SRS5NAME).dprr
	$(COMMAND_ECHO)$(RSC) $(VERBOSITY) $(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) -I$(INCLOCPRJ)  -I$(INCLOCAL) -I$(INC) -I$(INCCOM) $(RSCDEFS) $(RSCUPDVERDEF) -fp={$(SRS)/$(SRS5NAME).srs} -fo=$@ -p=$(TARGET) $(SRC5FILES)

.IF "$(WITH_LANG)"!=""

$(foreach,i,$(SRC5FILES) $(COMMONMISC)/$(TARGET)/$i) : $$(@:f)
	@echo "Making: (SRC5 localize)   " $(@:f)
	$(COMMAND_ECHO)-$(MKDIR) $(@:d)
    $(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)-$(MKDIRHIER)  $(COMMONMISC)$/$(PRJNAME)
        $(SOLARBINDIR)/genLang merge $(PRJNAME) $(SRC_ROOT)/languages/source "$(WITH_LANG)" -t  $(COMMONMISC)/$(TARGET) -v -f $<
#	$(COMMAND_ECHO)$(WRAPCMD) $(TRANSEX) -p $(PRJNAME) -i $(@:f) -o $(@).$(INPATH) -m $(LOCALIZESDF) -l all
    $(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
    $(COMMAND_ECHO)-$(RM) $@.$(INPATH)

$(SRS)/$(SRS5NAME).srs: $(LOCALIZE_ME_DEST)

$(SRS)/$(SRS5NAME).srs: $(foreach,i,$(SRC5FILES) $(COMMONMISC)/$(TARGET)/$i)
.ELSE			# "$(WITH_LANG)"!=""
$(SRS)/$(SRS5NAME).srs: $(SRC5FILES)
.ENDIF			# "$(WITH_LANG)"!=""
	@echo "Making: (SRC5sec)   " $(@:f)
	$(COMMAND_ECHO)$(RSC) -presponse $(VERBOSITY) @$(mktmp \
		$(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) \
		$(INCLUDE) $(RSCDEFS) $(RSCUPDVERDEF) \
		-fp=$@.$(INPATH) \
		$< \
	)
	$(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
	$(COMMAND_ECHO)-$(RM) $@.$(INPATH)

.ENDIF          # "$(SRS5NAME)"!=""

# unroll begin

.IF "$(SRS6NAME)"!=""

$(MISC)/$(TARGET).$(SRS6NAME).dprr: $(LOCALIZE_ME_DEST)

$(MISC)/$(TARGET).$(SRS6NAME).dprr: $(SRC6FILES)
	@echo "Making: (SRS6NAME.dprr)   " $(@:f)
	@@-$(RM) $(MISC)/$(TARGET).$(SRS6NAME).dprr
	$(COMMAND_ECHO)$(RSC) $(VERBOSITY) $(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) -I$(INCLOCPRJ)  -I$(INCLOCAL) -I$(INC) -I$(INCCOM) $(RSCDEFS) $(RSCUPDVERDEF) -fp={$(SRS)/$(SRS6NAME).srs} -fo=$@ -p=$(TARGET) $(SRC6FILES)

.IF "$(WITH_LANG)"!=""

$(foreach,i,$(SRC6FILES) $(COMMONMISC)/$(TARGET)/$i) : $$(@:f)
	@echo "Making: (SRC6 localize)   " $(@:f)
	$(COMMAND_ECHO)-$(MKDIR) $(@:d)
    $(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)-$(MKDIRHIER)  $(COMMONMISC)$/$(PRJNAME)
        $(SOLARBINDIR)/genLang merge $(PRJNAME) $(SRC_ROOT)/languages/source "$(WITH_LANG)" -t  $(COMMONMISC)/$(TARGET) -v -f $<
#	$(COMMAND_ECHO)$(WRAPCMD) $(TRANSEX) -p $(PRJNAME) -i $(@:f) -o $(@).$(INPATH) -m $(LOCALIZESDF) -l all
    $(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
    $(COMMAND_ECHO)-$(RM) $@.$(INPATH)

$(SRS)/$(SRS6NAME).srs: $(LOCALIZE_ME_DEST)

$(SRS)/$(SRS6NAME).srs: $(foreach,i,$(SRC6FILES) $(COMMONMISC)/$(TARGET)/$i)
.ELSE			# "$(WITH_LANG)"!=""
$(SRS)/$(SRS6NAME).srs: $(SRC6FILES)
.ENDIF			# "$(WITH_LANG)"!=""
	@echo "Making: (SRS6sec)   " $(@:f)
	$(COMMAND_ECHO)$(RSC) -presponse $(VERBOSITY) @$(mktmp \
		$(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) \
		$(INCLUDE) $(RSCDEFS) $(RSCUPDVERDEF) \
		-fp=$@.$(INPATH) \
		$< \
	)
	$(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
	$(COMMAND_ECHO)-$(RM) $@.$(INPATH)

.ENDIF          # "$(SRS6NAME)"!=""

# unroll begin

.IF "$(SRS7NAME)"!=""

$(MISC)/$(TARGET).$(SRS7NAME).dprr: $(LOCALIZE_ME_DEST)

$(MISC)/$(TARGET).$(SRS7NAME).dprr: $(SRC7FILES)
	@echo "Making: (SRC7NAME.dprr)   " $(@:f)
	@@-$(RM) $(MISC)/$(TARGET).$(SRS7NAME).dprr
	$(COMMAND_ECHO)$(RSC) $(VERBOSITY) $(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) -I$(INCLOCPRJ)  -I$(INCLOCAL) -I$(INC) -I$(INCCOM) $(RSCDEFS) $(RSCUPDVERDEF) -fp={$(SRS)/$(SRS7NAME).srs} -fo=$@ -p=$(TARGET) $(SRC7FILES)

.IF "$(WITH_LANG)"!=""

$(foreach,i,$(SRC7FILES) $(COMMONMISC)/$(TARGET)/$i) : $$(@:f)
	@echo "Making: (SRC7 localize)   " $(@:f)
	$(COMMAND_ECHO)-$(MKDIR) $(@:d)
    $(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)-$(MKDIRHIER)  $(COMMONMISC)$/$(PRJNAME)
        $(SOLARBINDIR)/genLang merge $(PRJNAME) $(SRC_ROOT)/languages/source "$(WITH_LANG)" -t  $(COMMONMISC)/$(TARGET) -v -f $<
#	$(COMMAND_ECHO)$(WRAPCMD) $(TRANSEX) -p $(PRJNAME) -i $(@:f) -o $(@).$(INPATH) -m $(LOCALIZESDF) -l all
    $(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
    $(COMMAND_ECHO)-$(RM) $@.$(INPATH)

$(SRS)/$(SRS7NAME).srs: $(LOCALIZE_ME_DEST)

$(SRS)/$(SRS7NAME).srs: $(foreach,i,$(SRC7FILES) $(COMMONMISC)/$(TARGET)/$i)
.ELSE			# "$(WITH_LANG)"!=""
$(SRS)/$(SRS7NAME).srs: $(SRC7FILES)
.ENDIF			# "$(WITH_LANG)"!=""
	@echo "Making: (SRC7sec)   " $(@:f)
	$(COMMAND_ECHO)$(RSC) -presponse $(VERBOSITY) @$(mktmp \
		$(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) \
		$(INCLUDE) $(RSCDEFS) $(RSCUPDVERDEF) \
		-fp=$@.$(INPATH) \
		$< \
	)
	$(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
	$(COMMAND_ECHO)-$(RM) $@.$(INPATH)

.ENDIF          # "$(SRS7NAME)"!=""

# unroll begin

.IF "$(SRS8NAME)"!=""

$(MISC)/$(TARGET).$(SRS8NAME).dprr: $(LOCALIZE_ME_DEST)

$(MISC)/$(TARGET).$(SRS8NAME).dprr: $(SRC8FILES)
	@echo "Making: (SRS8NAME.dprr)   " $(@:f)
	@@-$(RM) $(MISC)/$(TARGET).$(SRS8NAME).dprr
	$(COMMAND_ECHO)$(RSC) $(VERBOSITY) $(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) -I$(INCLOCPRJ)  -I$(INCLOCAL) -I$(INC) -I$(INCCOM) $(RSCDEFS) $(RSCUPDVERDEF) -fp={$(SRS)/$(SRS8NAME).srs} -fo=$@ -p=$(TARGET) $(SRC8FILES)

.IF "$(WITH_LANG)"!=""

$(foreach,i,$(SRC8FILES) $(COMMONMISC)/$(TARGET)/$i) : $$(@:f)
	@echo "Making: (SRC8 localize)   " $(@:f)
	$(COMMAND_ECHO)-$(MKDIR) $(@:d)
    $(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)-$(MKDIRHIER)  $(COMMONMISC)$/$(PRJNAME)
        $(SOLARBINDIR)/genLang merge $(PRJNAME) $(SRC_ROOT)/languages/source "$(WITH_LANG)" -t  $(COMMONMISC)/$(TARGET) -v -f $<
#	$(COMMAND_ECHO)$(WRAPCMD) $(TRANSEX) -p $(PRJNAME) -i $(@:f) -o $(@).$(INPATH) -m $(LOCALIZESDF) -l all
    $(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
    $(COMMAND_ECHO)-$(RM) $@.$(INPATH)

$(SRS)/$(SRS8NAME).srs: $(LOCALIZE_ME_DEST)

$(SRS)/$(SRS8NAME).srs: $(foreach,i,$(SRC8FILES) $(COMMONMISC)/$(TARGET)/$i)
.ELSE			# "$(WITH_LANG)"!=""
$(SRS)/$(SRS8NAME).srs: $(SRC8FILES)
.ENDIF			# "$(WITH_LANG)"!=""
	@echo "Making: (SRS8sec)   " $(@:f)
	$(COMMAND_ECHO)$(RSC) -presponse $(VERBOSITY) @$(mktmp \
		$(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) \
		$(INCLUDE) $(RSCDEFS) $(RSCUPDVERDEF) \
		-fp=$@.$(INPATH) \
		$< \
	)
	$(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
	$(COMMAND_ECHO)-$(RM) $@.$(INPATH)

.ENDIF          # "$(SRS8NAME)"!=""

# unroll begin

.IF "$(SRS9NAME)"!=""

$(MISC)/$(TARGET).$(SRS9NAME).dprr: $(LOCALIZE_ME_DEST)

$(MISC)/$(TARGET).$(SRS9NAME).dprr: $(SRC9FILES)
	@echo "Making: (SRS9NAME.dprr)   " $(@:f)
	@@-$(RM) $(MISC)/$(TARGET).$(SRS9NAME).dprr
	$(COMMAND_ECHO)$(RSC) $(VERBOSITY) $(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) -I$(INCLOCPRJ)  -I$(INCLOCAL) -I$(INC) -I$(INCCOM) $(RSCDEFS) $(RSCUPDVERDEF) -fp={$(SRS)/$(SRS9NAME).srs} -fo=$@ -p=$(TARGET) $(SRC9FILES)

.IF "$(WITH_LANG)"!=""

$(foreach,i,$(SRC9FILES) $(COMMONMISC)/$(TARGET)/$i) : $$(@:f)
	@echo "Making: (SRC9 localize)   " $(@:f)
	$(COMMAND_ECHO)-$(MKDIR) $(@:d)
    $(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)-$(MKDIRHIER)  $(COMMONMISC)$/$(PRJNAME)
        $(SOLARBINDIR)/genLang merge $(PRJNAME) $(SRC_ROOT)/languages/source "$(WITH_LANG)" -t  $(COMMONMISC)/$(TARGET) -v -f $<
#	$(COMMAND_ECHO)$(WRAPCMD) $(TRANSEX) -p $(PRJNAME) -i $(@:f) -o $(@).$(INPATH) -m $(LOCALIZESDF) -l all
    $(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
    $(COMMAND_ECHO)-$(RM) $@.$(INPATH)

$(SRS)/$(SRS9NAME).srs: $(LOCALIZE_ME_DEST)

$(SRS)/$(SRS9NAME).srs: $(foreach,i,$(SRC9FILES) $(COMMONMISC)/$(TARGET)/$i)
.ELSE			# "$(WITH_LANG)"!=""
$(SRS)/$(SRS9NAME).srs: $(SRC9FILES)
.ENDIF			# "$(WITH_LANG)"!=""
	@echo "Making: (SRS9sec)   " $(@:f)
	$(COMMAND_ECHO)$(RSC) -presponse $(VERBOSITY) @$(mktmp \
		$(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) \
		$(INCLUDE) $(RSCDEFS) $(RSCUPDVERDEF) \
		-fp=$@.$(INPATH) \
		$< \
	)
	$(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
	$(COMMAND_ECHO)-$(RM) $@.$(INPATH)

.ENDIF          # "$(SRS9NAME)"!=""

# unroll begin

.IF "$(SRS10NAME)"!=""

$(MISC)/$(TARGET).$(SRS10NAME).dprr: $(LOCALIZE_ME_DEST)

$(MISC)/$(TARGET).$(SRS10NAME).dprr: $(SRC10FILES)
	@echo "Making: (SRS10NAME.dprr)   " $(@:f)
	@@-$(RM) $(MISC)/$(TARGET).$(SRS10NAME).dprr
	$(COMMAND_ECHO)$(RSC) $(VERBOSITY) $(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) -I$(INCLOCPRJ)  -I$(INCLOCAL) -I$(INC) -I$(INCCOM) $(RSCDEFS) $(RSCUPDVERDEF) -fp={$(SRS)/$(SRS10NAME).srs} -fo=$@ -p=$(TARGET) $(SRC10FILES)

.IF "$(WITH_LANG)"!=""

$(foreach,i,$(SRC10FILES) $(COMMONMISC)/$(TARGET)/$i) : $$(@:f)
	@echo "Making: (SRC10 localize)   " $(@:f)
	$(COMMAND_ECHO)-$(MKDIR) $(@:d)
    $(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)-$(MKDIRHIER)  $(COMMONMISC)$/$(PRJNAME)
        $(SOLARBINDIR)/genLang merge $(PRJNAME) $(SRC_ROOT)/languages/source "$(WITH_LANG)" -t  $(COMMONMISC)/$(TARGET) -v -f $<
#	$(COMMAND_ECHO)$(WRAPCMD) $(TRANSEX) -p $(PRJNAME) -i $(@:f) -o $(@).$(INPATH) -m $(LOCALIZESDF) -l all
    $(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
    $(COMMAND_ECHO)-$(RM) $@.$(INPATH)

$(SRS)/$(SRS10NAME).srs: $(LOCALIZE_ME_DEST)

$(SRS)/$(SRS10NAME).srs: $(foreach,i,$(SRC10FILES) $(COMMONMISC)/$(TARGET)/$i)
.ELSE			# "$(WITH_LANG)"!=""
$(SRS)/$(SRS10NAME).srs: $(SRC10FILES)
.ENDIF			# "$(WITH_LANG)"!=""
	@echo "Making: (SRS10sec)  " $(@:f)
	$(COMMAND_ECHO)$(RSC) -presponse $(VERBOSITY) @$(mktmp \
		$(SRSDEFAULT) $(RSC_SRS_CHARSET) $(RSCFLAGS) -I$(RSCEXTINC) \
		$(INCLUDE) $(RSCDEFS) $(RSCUPDVERDEF) \
		-fp=$@.$(INPATH) \
		$< \
	)
	$(COMMAND_ECHO)-$(RM) $@
	$(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
	$(COMMAND_ECHO)-$(RM) $@.$(INPATH)

.ENDIF          # "$(SRS10NAME)"!=""

