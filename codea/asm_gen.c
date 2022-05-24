#include "asm_gen.h"
#include <stdlib.h>

char *lts(long n)
{
    char *buffer = (char *)malloc(sizeof(long));
    sprintf(buffer, "%li", n);
    return buffer;
}

char *next_free_register(char *name)
{
    char *registers[] = {"rax", "r11", "r10", "r9", "r8", "rcx", "rdx", "rsi", "rdi"};

    if (name == (char *)NULL)
    {
        return registers[0];
    }

    for (int i = 0; i < 9; i++)
    {
        // This fires when strcmp compares two identical strings
        if (!strcmp(name, registers[i]))
        {
            return registers[i + 1];
        }
    }

    fprintf(stdout, "ERROR: Couldn't find next free register after '%s'.\n", name);
    exit(4);
}

char *lower_byte_of_register(char *name)
{
    char *registers[] = {"rax", "r11", "r10", "r9", "r8", "rcx", "rdx", "rsi", "rdi"};
    char *byte_registers[] = {"al", "r11b", "r10b", "r9b", "r8b", "cl", "dl", "sil", "dil"};

    if (name == (char *)NULL)
    {
        return byte_registers[0];
    }

    for (int i = 0; i < 9; i++)
    {
        if (!strcmp(name, registers[i]))
        {
            return byte_registers[i];
        }
    }

    fprintf(stdout, "ERROR: Couldn't find %s's lower byte register.\n", name);
    exit(4);
}

char *nth_param_register(int index)
{
    if (index > 5 || index < 0)
    {
        fprintf(stdout, "ERROR: functions must have 0-6 parameters, not: %i. \n", index);
        exit(4);
    }

    char *registers[] = {"rdi", "rsi", "rdx", "rcx", "r8", "r9"};
    return registers[index];
}

void export_function_label(char *function_name)
{
    printf(".globl %s\n", function_name);
    printf("\t.type %s, @function\n", function_name);
    printf("%s:\n", function_name);
}

void ret(void)
{
    printf("\tret\n");
}

void ret_val(char *reg)
{
    if (strcmp(reg, "rax") == 0)
    {
        ret();
        return;
    }
    mov(reg, "rax");
    ret();
}

void mov(char *first, char *dst)
{
    long conv = strtol(first, NULL, 10);

    if (conv || !strcmp(first, "0"))
    {
        printf("\tmovq\t$%li, %%%s\n", conv, dst);
        return;
    }

    printf("\tmovq\t%%%s, %%%s\n", first, dst);
}

void add(char *first, char *dst)
{
    long conv = strtol(first, NULL, 10);

    if (conv || !strcmp(first, "0"))
    {
        printf("\taddq\t$%li, %%%s\n", conv, dst);
        return;
    }

    printf("\taddq\t%%%s, %%%s\n", first, dst);
}

void mul(char *first, char *dst)
{
    long conv = strtol(first, NULL, 10);

    if (conv || !strcmp(first, "0"))
    {
        printf("\timulq\t$%li, %%%s\n", conv, dst);
        return;
    }

    printf("\timulq\t%%%s, %%%s\n", first, dst);
}

void and (char *first, char *snd)
{
    long conv = strtol(first, NULL, 10);

    if (conv || !strcmp(first, "0"))
    {
        printf("\tand\t$%li, %%%s\n", conv, snd);
        return;
    }

    printf("\tand\t%%%s, %%%s\n", first, snd);
}

void mov_addr_reg(char *first, char *dst)
{
    long conv = strtol(first, NULL, 10);

    if (conv || !strcmp(first, "0"))
    {
        printf("\tmovq ($%li), %s\n", conv, dst);
        return;
    }
    printf("\tmovq (%%%s), %%%s\n", first, dst);
}

void neg(char *reg)
{
    printf("\tnegq\t%%%s\n", reg);
}

void not(char *reg)
{
    printf("\tnotq\t%%%s\n", reg);
}

void eq(char *fst, char *snd, char *dst)
{
    printf("\tcmp\t%%%s, %%%s\n", fst, snd);
    printf("\tsete\t%%%s\n", lower_byte_of_register(dst));
    printf("\tand\t$1, %%%s\n", dst);
}

void eq_i(long value, char *second, char *dst)
{
    printf("\tcmp\t\t$%ld, %%%s\n", value, second);
    printf("\tsete\t%%%s\n", lower_byte_of_register(dst));
    printf("\tand\t\t$1, %%%s\n", dst);
}

void gt(char *first, char *second, char *dst)
{
    printf("\tcmp\t\t%%%s, %%%s\n", first, second);
    printf("\tsetg\t%%%s\n", lower_byte_of_register(dst));
    printf("\tand\t\t$1, %%%s\n", dst);
}

void gt_i(long value, char *second, char *dst)
{
    printf("\tcmp\t\t$%ld, %%%s\n", value, second);
    printf("\tsetg\t%%%s\n", lower_byte_of_register(dst));
    printf("\tand\t\t$1, %%%s\n", dst);
}

void array_access_index(char *array, char *index, char *dest)
{
    printf("\tmovq\t(%%%s, %%%s, 8), %%%s\n", array, index, dest);
}