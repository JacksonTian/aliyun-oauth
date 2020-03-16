TESTS = $(shell ls -S `find test -type f -name "*.test.js" -print`)
REPORTER = spec
TIMEOUT = 3000
MOCHA_OPTS =

clean:
	@rm -rf node_modules

install:
	@PYTHON=`which python2.6` npm install

test:
	@NODE_ENV=test ./node_modules/.bin/mocha \
		--harmony \
		--reporter $(REPORTER) \
		--require co-mocha \
		--timeout $(TIMEOUT) \
		$(MOCHA_OPTS) \
		$(TESTS)

test-cov:
	@NODE_ENV=test node --harmony \
		node_modules/.bin/istanbul cover --report html \
		./node_modules/.bin/_mocha -- \
		--reporter $(REPORTER) \
		--require co-mocha \
		--timeout $(TIMEOUT) \
		$(MOCHA_OPTS) \
		$(TESTS)

debug:
	@NODE_ENV=test \
		node-debug --nodejs --harmony \
		./node_modules/.bin/_mocha \
		--reporter $(REPORTER) \
		--require co-mocha \
		--timeout $(TIMEOUT) \
		$(MOCHA_OPTS) \
		$(TESTS)

.PHONY: test
