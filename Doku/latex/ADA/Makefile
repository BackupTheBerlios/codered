FILE = ada
TMP = $(shell find . )
TEX = $(wildcard *.tex)

all: clean ps pdf clear

clear:
	@echo Lösche alle temporären Dateien
	@for delete in `ls $(FILE).[^p]*`; do case $$delete in $(FILE).*tex) ;; *) rm $$delete;; esac; done
clean:
	@echo Lösche temporäre Dateieen und alte Arbeitsergebnisse
	@for delete in `ls $(FILE).[^p]*`; do case $$delete in $(FILE).*tex) ;; *) rm $$delete;; esac; done
	@for delete in `ls $(FILE).pdf $(FILE).ps`; do rm $$delete; done
%.ps: $(FILE).idx $(FILE).dvi
	@echo "PS $(FILE).ps wird generiert"
	@dvips $(FILE).dvi
	@echo PS - fertig
ps: ADA-Unterweisung.ps
pdf:
	@echo "PDF $(FILE).pdf wird generiert"
	@pdflatex $(FILE).tex
	@makeindex $(FILE).glo
	@pdflatex $(FILE).tex
	@makeindex $(FILE).idx
	@pdflatex $(FILE).tex
	@echo PDF - fertig
%.idx: %.dvi
	@echo IDX - Index wird generiert...
	@makeindex $@
	@latex $(@:.idx=.tex)
	@echo IDX -fertig
%.dvi: $(TEX)
	@echo DVI - Roh-DVI $@ wird erzeugt
	@latex $(@:.dvi=.tex)
	@latex $(@:.dvi=.tex)
	@echo DVI - fertig

