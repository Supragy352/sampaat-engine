CC = gcc
CFLAGS = -Wall -std=c99 -D_DEFAULT_SOURCE -Wno-missing-braces -Wunused-result

SRC_DIR ?= ./src/
INCLUDE_DIR ?= ./include/
LIB_DIR ?= ./libs/
BUILD_DIR ?= ./build/

TO_BUILD_FILES ?= $(SRC_DIR)/main.c

PROJECT_NAME ?= main
RAYLIB_PATH = /home/callisto/Programs/raylib

INCLUDE_PATHS =	 -I$(RAYLIB_PATH)/src -I$(RAYLIB_PATH)/src/external 
INCLUDE_PATHS += -I$(INCLUDE_DIR)
INCLUDE_PATHS += -I$(RAYLIB_INCLUDE_PATH)

PYTHON_ENV += ./plotterenv/bin/

BUILD_MODE ?= RELEASE

ifeq ($(BUILD_MODE),DEBUG)
	CFLAGS += -g -D_DEBUG
else
	CFLAGS += -O2
endif


LDFLAGS = -L. -L$(RAYLIB_RELEASE_PATH) -L$(RAYLIB_PATH)/src

LDLIBS = -lraylib -lGL -lm -lpthread -ldl -lrt -lc -latomic

all: $(PROJECT_NAME)

$(PROJECT_NAME): $(TO_BUILD_FILES)
	$(CC) -o $(BUILD_DIR)$(PROJECT_NAME) $(TO_BUILD_FILES) $(INCLUDE_PATHS) $(CFLAGS) $(LDFLAGS) $(LDLIBS)

run: $(PROJECT_NAME)
	$(CC) -o $(BUILD_DIR)$(PROJECT_NAME) $(TO_BUILD_FILES) $(INCLUDE_PATHS) $(CFLAGS) $(LDFLAGS) $(LDLIBS) && $(BUILD_DIR)$(PROJECT_NAME)

plot:
	source $(PYTHON_ENV)activate && python $(SRC_DIR)plot.py && subl $(BUILD_DIR)simulation_plot.png

clean:
	rm -f $(BUILD_DIR)$(PROJECT_NAME) && rm -f $(BUILD_DIR)simulation_data.csv && rm -f $(BUILD_DIR)simulation_plot.png
