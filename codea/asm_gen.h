#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Returns the next register that should be filled after this one */
char *next_free_register(char *reg);

/* Returns the register that corresponds to the lower 8 bits of the input register */
char *lower_byte_of_register(char *reg);

/* Returns the register that corresponds to the parameter index according to calling conventions */
char *nth_param_register(int n);

/* Transforms long to string*/
char *lts(long n);
/***********************************************************************************************
   The following functions generate AMD64 instructions to stdout with the same name
***********************************************************************************************/

void export_function_label(char *function_name);

void ret_val(char *reg);

void neg(char *reg);

void not(char *reg);

void mov(char *first, char *dst);

void mov_addr_reg(char *first, char *dst);

void add(char *first, char *dst);

void mul(char *first, char *dst);

void and (char *first, char *snd);

void gt(char *first, char *snd, char *dst);

void gt_i(long first, char *snd, char *dst);

void eq (char *first, char *snd, char *dst);

void eq_i (long first, char *snd, char *dst);

void array_access_index(char *array, char *index, char *dest);

/***********************************************************************************************/
