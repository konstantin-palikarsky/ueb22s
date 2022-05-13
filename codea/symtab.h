#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum
{
    LABEL,
    VARIABLE
} id_type_t;

typedef struct list_t
{
    char *id;
    short type;
    struct list_t *next;
} list_t;

/*Returns an empty list*/
list_t *empty_list();

/*Appends all nodes of first and second list to a new list and returns its root*/
list_t *merge_lists(list_t *first, list_t *second);

/*Merges first with second and then the returned list with third by using merge_lists() successively*/
list_t *merge_three_lists(list_t *first, list_t *second, list_t *third);

/*Creates and adds node to list*/
list_t *add_node(list_t *list, char *identifier, id_type_t type);

/*Checks if identifier of given type is visible in current list, error_exit on falsy evaluation*/
void visibility_check(list_t *list, char *identifier, id_type_t type);

void duplicate_check(list_t *current, char *identifier);
