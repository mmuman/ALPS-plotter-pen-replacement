# on Debian you need:
# apt install make libreoffice unoconv pandoc pdfjam pdftk texlive texlive-lang-french imagemagick

OUT=	alps_plotter_pen.stl \
	alps_plotter_pen_cutting_jig.stl \
	alps_plotter_pen_manual_steps.png \
	$(DOCS_IMAGES) \
	manual_en.pdf manual_fr.pdf \

DOCS_STEPS := 00 01 02 03 04 05 06 07 08

DOCS_IMAGES = \
	$(foreach n,$(DOCS_STEPS),alps_plotter_pen_manual_$(n).png)

DOCS_ANIMS = \
	$(foreach n,$(DOCS_STEPS),alps_plotter_pen_manual_$(n).gif)

DOCS_OPENSCAD_ARGS = \
	--autocenter \
	--viewall \
	--imgsize=2000,2000 \
	--projection=ortho \
	--colorscheme=Nature

all: $(OUT)

%.stl: %.scad
	openscad -o $@ $<

$(DOCS_IMAGES): alps_plotter_pen_manual.scad
	openscad $(DOCS_OPENSCAD_ARGS) \
		-DSTEP=$(patsubst alps_plotter_pen_manual_%.png,%,$@) \
		-o $@ $<
# This only works for 1 to 20 - and montage needs a font that includes them
	mogrify -transparent '#fafafa' -trim -label "$(shell echo -en '\xE2\x91\x$(shell printf '%02x' $$((0xA0-1+$(patsubst 0%,%,$(patsubst alps_plotter_pen_manual_%.png,%,$@)))))')" $@
#	mogrify -transparent '#fafafa' -trim -label "($(patsubst 0%,%,$(patsubst alps_plotter_pen_manual_%.png,%,$@)))" $@

alps_plotter_pen_manual_steps.png: $(DOCS_IMAGES)
	montage -verbose $(wordlist 2,100,$^) -geometry '2000x1000+50+100' -font "VL-Gothic-Regular" -pointsize 200 $@

alps_plotter_pen_manual_steps_small.png: $(DOCS_IMAGES)
	montage -verbose $(wordlist 2,100,$^) -geometry '200x100+5+10' -font "VL-Gothic-Regular" -pointsize 20 $@


# Works but generates huge GIFs. Maybe APNG?
$(DOCS_ANIMS): alps_plotter_pen_manual.scad
	openscad $(DOCS_OPENSCAD_ARGS) \
		-DSTEP=$(patsubst alps_plotter_pen_manual_%.gif,%,$@) \
		--animate=10 \
		-o $(patsubst %.gif,%_anim_.png,$@) $<
	ffmpeg -r 1 \
		-i $(patsubst %.gif,%_anim_,$@)'%05d.png' \
		$@
	rm $(patsubst %.gif,%_anim_,$@)*.png


%.png: %.scad
	echo $(patsubst alps_%.png,%,$@) openscad $(DOCS_OPENSCAD_ARGS) -o $@ $<

%.pdf: %.md alps_plotter_pen_manual_steps.png
	sed 's/\_small.png/\.png/g;s,(images/,(,g' < $< | pandoc --pdf-engine=lualatex -H pandoc_headers.tex - -o $@

clean:
	rm $(OUT)
