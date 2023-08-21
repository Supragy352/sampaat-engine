CC = gcc
CFLAGS = -Wall -std=c99 -D_DEFAULT_SOURCE -Wno-missing-braces -Wunused-result

PROJECT_NAME ?= main
RAYLIB_PATH = /home/callisto/Programs/raylib

INCLUDE_PATHS = -I. -I$(RAYLIB_PATH)/src -I$(RAYLIB_PATH)/src/external
INCLUDE_PATHS += -I$(RAYLIB_INCLUDE_PATH)

BUILD_MODE ?= RELEASE

ifeq ($(BUILD_MODE),DEBUG)
	CFLAGS += -g -D_DEBUG
else
	CFLAGS += -O2
endif


LDFLAGS = -L. -L$(RAYLIB_RELEASE_PATH) -L$(RAYLIB_PATH)/src

LDLIBS = -lraylib -lGL -lm -lpthread -ldl -lrt -lc -latomic

all: $(PROJECT_NAME)

$(PROJECT_NAME): main.c
	$(CC) -o $(PROJECT_NAME) main.c $(INCLUDE_PATHS) $(CFLAGS) $(LDFLAGS) $(LDLIBS)

run: $(PROJECT_NAME)
	$(CC) -o $(PROJECT_NAME) main.c $(INCLUDE_PATHS) $(CFLAGS) $(LDFLAGS) $(LDLIBS) && ./$(PROJECT_NAME)

plot:
	source ./plotterenv/bin/activate && python plot.py && subl ./simulation_plot.png

clean:
	rm -f $(PROJECT_NAME) && rm -f simulation_data.csv
