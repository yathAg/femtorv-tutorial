current_dir := ${CURDIR}
TOP := SOC
SOURCES := ${current_dir}/femtoRV.v

ifeq ($(TARGET),arty_35)
ifdef F4PGA_USE_DEPRECATED
  XDC := ${current_dir}/arty.xdc
else
build:
	f4pga -vv build --flow ./flow.json
endif
else ifeq ($(TARGET),arty_100)
  XDC := ${current_dir}/arty.xdc
else ifeq ($(TARGET),nexys4ddr)
  XDC := ${current_dir}/nexys4ddr.xdc
else ifeq ($(TARGET),zybo)
  XDC := ${current_dir}/zybo.xdc
  SOURCES:=${current_dir}/counter_zynq.v
else ifeq ($(TARGET),nexys_video)
  XDC := ${current_dir}/nexys_video.xdc
else ifeq ($(TARGET),basys3)
  XDC := ${current_dir}/basys3.xdc
endif

include ${current_dir}/includes/common.mk

clean_sim:
	rm -rf ./a.out

bench:
	iverilog -DBENCH -DSIM -DPASSTHROUGH_PLL -DBOARD_FREQ=10 -DCPU_FREQ=10 bench_iverilog.v ${SOURCES}

run_bench:
	vvp a.out
