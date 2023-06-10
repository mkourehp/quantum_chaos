import os
from loguru import logger
from time import perf_counter


def compile_fortran():
    logger.info("Compiling FORTRAN")
    os.system("gfortran src/*F90 -o executable -llapack -g -O3")
    logger.success("Compiling FORTRAN Done!")


def execute_fortran():
    t0 = perf_counter()
    logger.info("executing FORTRAN")
    os.system("./executable")
    logger.success(f"Executing FORTRAN Done in {perf_counter() - t0}" + "\n" + 100 * "-")


def compile_and_execute():
    compile_fortran()
    execute_fortran()
