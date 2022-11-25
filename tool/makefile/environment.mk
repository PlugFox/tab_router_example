
PLATFORM := $(shell arch)
ifeq ($(PLATFORM),x86_64)
else ifeq ($(PLATFORM),arm64)
else
endif

ifeq ($(OS),Windows_NT)
	OS := win
else
    _detected_OS := $(shell uname -s)
    ifeq ($(_detected_OS),Linux)
		OS := lin
    else ifeq ($(_detected_OS),Darwin)
		OS := mac
    endif
endif
