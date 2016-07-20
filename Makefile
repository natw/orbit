MAIN=src/Main.elm
OUTPUT=build/orbit.js

default: src
	elm make $(MAIN) --output=$(OUTPUT)
