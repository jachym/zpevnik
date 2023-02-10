files := $(wildcard sources/*/*.md)
images := $(wildcard sources/*/*.png)
.PHONY: default

default: build/zpevnik.pdf

clean:
	@rm -rf build


build/zpevnik.md: $(files)
	@mkdir -p build
	@cat main.md > build/zpevnik.md

	@for i in $(images); do \
		cp $${i} build/; \
	done

	@for f in $(files); do \
		cat $${f} >> build/zpevnik.md; \
		echo '\pagebreak' >> build/zpevnik.md; \
		echo "\n" >> build/zpevnik.md; \
	done


build/zpevnik.pdf: build/zpevnik.md

	@pandoc -V papersize:a5 -o build/zpevnik.pdf build/zpevnik.md
	@pdfbook2 --paper=a4 build/zpevnik.pdf
