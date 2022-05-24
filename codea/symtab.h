#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>


typedef enum
{
    LABEL,
    VARIABLE
} id_type_t;

typedef struct list_t
{
    char *id;
    id_type_t type;
    bool param;
    struct list_t *next;
} list_t;


/* Creates a list containing 1 node with given id that has param set to true */
list_t *param_node(char *identifier);

/* Find the index of given string key in the list searching through the nodes with param set to true
   Results should be 0-5 */
int find_param_index(list_t *list, char *key);

/* Returns an empty list */
list_t *empty_list();

/* Appends all nodes of first and second list to a new list and returns its root,
   error_exit if both lists contain the same identifier */
list_t *merge_lists(list_t *first, list_t *second);

/* Merges first with second and then the returned list with third by using merge_lists() successively,
   error_exit if any of the three lists contains the same identifier */
list_t *merge_three_lists(list_t *first, list_t *second, list_t *third);

/* Creates and adds node to list,
   error_exit if the node is a duplicate */
list_t *add_node(list_t *list, char *identifier, id_type_t type);

/* Checks if identifier of given type is visible in current list,
   error_exit on falsy evaluation */
void visibility_check(list_t *list, char *identifier, id_type_t type);

/* Checks if identifier is visible in current list,
   error_exit on truthy evaluation */
void duplicate_check(list_t *current, char *identifier);
