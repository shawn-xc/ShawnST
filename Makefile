SHELL :=/bin/bash
curDir :=$(shell pwd)
scriptDir=${curDir}/script/sh

# 定义默认目标
.DEFAULT_GOAL := help

# 定义编译函数
define build_project
    @if [ -n "$(1)" ]; then \
        if [ -f "${scriptDir}/build_$(1).sh" ]; then \
            echo "正在编译项目 $(1) ..."; \
            bash ${scriptDir}/build_$(1).sh; \
        else \
            echo "未找到项目 $(1) 的编译脚本: ${scriptDir}/build_$(1).sh"; \
        fi; \
    else \
        echo "请指定要编译的项目(spike, systemc, c, d)"; \
    fi
endef

# 定义清除函数
define clear_project
    @if [ -n "$(1)" ]; then \
        if [ -f "${scriptDir}/clear_$(1).sh" ]; then \
            echo "正在clear项目 $(1) ..."; \
            bash ${scriptDir}/clear_$(1).sh; \
        else \
            echo "未找到项目 $(1) 的clear脚本: ${scriptDir}/clear_$(1).sh"; \
        fi; \
    else \
        echo "请指定要clear的项目(spike, systemc, c, d)"; \
    fi
endef

ifeq ($(project),all)
project_list=llvm spike systemc
endif

test:
	@echo "makefile test "

simulator:
	@echo "spike build"
	bash ${scriptDir}/build_spike.sh

systemc:
	bash ${scriptDir}/build_systemc.sh

build:
	$(call build_project,$(filter-out $@,$(MAKECMDGOALS)))

clear:
	$(call clear_project,$(filter-out $@,$(MAKECMDGOALS)))

# 忽略额外参数，避免 Makefile 报错
%:
	@true

help:
	@echo 'make build $$project : 项目编译    ，$$project可选参数为：llvm, spike, systemc'
	@echo 'make clear $$project : 项目编译清空，$$project可选参数：llvm, spike, systemc'
