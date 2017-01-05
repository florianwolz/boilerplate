all: build rebuild

build:
	@mkdir build && mkdir bin && cd build && cmake .. && cd ..

rebuild:
	@cd build && make && cd ..

clean:
	@rm -rf build && rm -rf bin

update:
	git pull origin master
	make

test: build rebuild
	@cd build && make test && cd ..

.PHONY: test
