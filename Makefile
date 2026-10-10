NAME := RICE_unofficial
TITLE := RICE Unofficial Update
VERSION := 1.20.0
SRC := RICE

.PHONY: tiger
tiger:
	cd $(SRC) && ck3-tiger --no-color descriptor.mod > ck3-tiger.out
	cat $(SRC)/ck3-tiger.out

.PHONY: build
build: clean
	mkdir -p tmp/$(NAME)
	rsync -r --prune-empty-dirs --exclude=".*" --exclude=ck3-tiger.conf --exclude=ck3-tiger.out $(SRC)/ tmp/$(NAME)
	cp thumbnail_unofficial.png tmp/$(NAME)/thumbnail.png
	sed -i -e 's/^version=.*/version="$(VERSION)"/' -e 's/^name=.*/name="$(TITLE)"/' -e '/^remote_file_id=/d' tmp/$(NAME)/descriptor.mod
	cp tmp/$(NAME)/descriptor.mod tmp/$(NAME).mod
	echo "path=\"mod/$(NAME)\"" >> tmp/$(NAME).mod
	cd tmp && zip -qr $(NAME)-$(VERSION).zip . && cd ..

.PHONY: clean
clean:
	rm -rf tmp
	rm -f $(SRC)/ck3-tiger.out
