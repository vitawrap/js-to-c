build: js-build/js-to-c.js out/runtime.so out/prelude.so

js-build/js-to-c.js: src/*.ts
	tsc

out/runtime.so: runtime/*.c
	./runtime/scripts/compile-so

out/prelude.so: js-build/js-to-c.js runtime/prelude.js out/runtime.so
	./compile-js-lib prelude runtime/prelude.js out/prelude.so

.PHONY: clean
clean:
	rm -rf out/* js-build/*


.PHONY: install
install:
	npm install && cd runtime && make libs

.PHONY: test
test: install
	npm test && cd runtime && make test
