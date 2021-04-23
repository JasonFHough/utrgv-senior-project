test:  # Run tests
	python -m pytest --capture=tee-sys

test-verbose:  # Run tests verbosely (captures output)
	python -m pytest -v --capture=tee-sys

test-specific:  # Run a single specific test verbosely
	# $(test) = Input to specify what test to run
	# Sample Execution: make test-specific test=test_sample
	python -m pytest -v --capture=tee-sys -k '$(test)'