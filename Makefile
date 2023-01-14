
# on Debian you need:
# apt install make libreoffice unoconv pandoc pdfjam pdftk texlive texlive-lang-french

OUT=	manual_en.pdf manual_fr.pdf \


all: $(OUT)

%.pdf: %.md
	sed 's/\.png /\.pdf /g' < $< | pandoc - -o $@

clean:
	rm $(OUT)
