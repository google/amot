OUTDIR?=$(CURDIR)/out
SRCDIR?=$(CURDIR)/src
RESDIR?=$(CURDIR)/res

AMOTFILE ?=$(OUTDIR)/amot
AMOTFILE_TEMP ?=$(OUTDIR)/amot_temp

all: amot

.PHONY: amot

amot:
	mkdir -p $(OUTDIR)
	echo "" > $(AMOTFILE)

	# Parse the key code defaults.
	cat $(RESDIR)/codes/*.sh >> "$(AMOTFILE)"

	# Load in all the UI utilities.
	cat $(SRCDIR)/ui/ui_utils.sh >> "$(AMOTFILE)"
	cat $(SRCDIR)/ui/ui_strings.sh >> "$(AMOTFILE)"
	cat $(SRCDIR)/ui/ui_interface.sh >> "$(AMOTFILE)"

	# We can then cleanly do shell setup.
	cat $(SRCDIR)/shell/argument_parsing.sh >> "$(AMOTFILE)"
	cat $(SRCDIR)/shell/shell_env_check.sh >> "$(AMOTFILE)"
	cat $(SRCDIR)/shell/shell_env_init.sh >> "$(AMOTFILE)"

	# After we've validated the shell, we want to query for a serial number.
	cat $(SRCDIR)/serial/serial_picker.sh >> "$(AMOTFILE)"
	cat $(SRCDIR)/serial/serial_init.sh >> "$(AMOTFILE)"

	# Load the code for parsing the key map file.
	cat $(SRCDIR)/parsing/*.sh >> "$(AMOTFILE)"

	# Load the code for each individual mode.
	cat $(SRCDIR)/modes/*.sh >> "$(AMOTFILE)"

	# Load the execution loop that actually makes things happen.
	cat $(SRCDIR)/execution_loop.sh >> "$(AMOTFILE)"

	# Remove comments/shebangs.
	if [ "$(shell uname -s)" = "Darwin" ]; then\
		sed -e '/^[ \t]*\#/d' "$(AMOTFILE)";\
	else\
		sed -i -e '/^[ \t]*\#/d' "$(AMOTFILE)";\
	fi

	# Add one shebang and the copyright notice.
	# We need a temp file since cat can't do it in-place.
	cat $(RESDIR)/header/amot_header.txt $(AMOTFILE)  > $(AMOTFILE_TEMP)

	# Undo the temp file swap
	mv -f $(AMOTFILE_TEMP) $(AMOTFILE)

	# Grant execution permission.
	chmod +rx $(AMOTFILE)

.PHONY: clean

clean:
	[ -e $(OUTDIR) ] && rm -r $(OUTDIR) || true
