.DEFAULT_GOAL := q
.PHONY: install preview q clean

GM ?= gm
OUTPUT_DIR ?= output
LAYOUT ?= assets/archive/layout-reference.miff
SOURCE ?= assets/archive/contact-sheet-source.pcd
PROFILE ?= assets/color/archive-profile.miff
PREVIEW ?= $(OUTPUT_DIR)/legacy-pcd-compatibility.png

install: preview

preview:
	@/bin/mkdir -p "$(OUTPUT_DIR)"
	@/bin/rm -f "$(PREVIEW)"
	@"$(GM)" montage \
		-geometry 1536x1024+0+0 \
		-tile 4x1 \
		-background white \
		"$(LAYOUT)" \
		"$(SOURCE)" \
		"$(PROFILE)" \
		"PNG:$(PREVIEW)"
	@/bin/test -s "$(PREVIEW)"

q:
	@set -eu; \
	check_asset() { \
		qa_file=$$1; qa_crc=$$2; qa_bytes=$$3; \
		[ -f "$$qa_file" ] && [ ! -L "$$qa_file" ]; \
		qa_sum=$$(/usr/bin/cksum < "$$qa_file"); \
		set -- $$qa_sum; \
		[ "$$#" -eq 2 ] && [ "$$1" = "$$qa_crc" ] && [ "$$2" = "$$qa_bytes" ]; \
	}; \
	check_asset assets/archive/contact-sheet-source.pcd 1703488786 798720; \
	check_asset assets/archive/layout-reference.miff 1996849985 945920; \
	check_asset assets/color/archive-profile.miff 3122310940 481; \
	[ ! -L output ]; \
	if [ ! -d output ]; then /bin/mkdir output; fi; \
	[ -d output ] && [ ! -L output ]; \
	/bin/rm -f output/archive-qa.txt; \
	umask 077; \
	{ \
		printf '%s\n' 'photo-cd-archive-qa=1'; \
		printf '%s\n' 'asset=assets/archive/contact-sheet-source.pcd cksum=1703488786 bytes=798720'; \
		printf '%s\n' 'asset=assets/archive/layout-reference.miff cksum=1996849985 bytes=945920'; \
		printf '%s\n' 'asset=assets/color/archive-profile.miff cksum=3122310940 bytes=481'; \
		printf '%s\n' 'status=ok'; \
	} > output/archive-qa.txt; \
	[ -f output/archive-qa.txt ] && [ ! -L output/archive-qa.txt ]

clean:
	@/bin/rm -f "$(PREVIEW)"
	@if [ -d output ] && [ ! -L output ]; then /bin/rm -f output/archive-qa.txt; fi

