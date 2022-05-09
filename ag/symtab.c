#include <string.h>
#include "symtab.h"

/* internal function to malloc list_t pointers*/
list_t *create_node()
{
    // fprintf(stdout, "segfault: for '%s\n'", "create_node");

    return (list_t *)malloc(sizeof(list_t));
}

void duplicate_check(list_t *current, char *identifier)
{
    // fprintf(stdout, "segfault: for '%s' \n", "duplicate_check");

    // if not a duplicate return
    if (strcmp(current->id, identifier) != 0)
    {
        return;
    }

    fprintf(stdout, "Duplicate identifier definition detected for '%s'.\n", identifier);
    exit(3);
}

list_t *empty_list()
{
    // fprintf(stdout, "segfault: for '%s' \n", "empty_list");

    return (list_t *)NULL;
}

list_t *merge_lists(list_t *first, list_t *second)
{
    // fprintf(stdout, "segfault: for '%s' \n", "merge_lists");

    list_t *new = empty_list();
    list_t *current_first = first;
    list_t *current_second = second;

    while (current_first != NULL)
    {
        new = add_node(new, current_first->id, current_first->type);
        current_first = current_first->next;
    }

    while (current_second != NULL)
    {
        new = add_node(new, current_second->id, current_second->type);
        current_second = current_second->next;
    }

    return new;
}

list_t *merge_three_lists(list_t *first, list_t *second, list_t *third)
{
    return merge_lists(merge_lists(first, second), third);
}

list_t *add_node(list_t *list, char *identifier, id_type_t type)
{
    list_t *current = list;

    // appending to empty list
    if (current == NULL)
    {
        current = create_node();
        current->id = strdup(identifier);
        current->type = type;
        current->next = NULL;

        return current;
    }
    // check if identifier is duplicate for root
    duplicate_check(current, identifier);

    // check if list contains duplicate identifier and sets currrent to last node in list as a side effect
    while (current->next != NULL)
    {
        current = current->next;
        duplicate_check(current, identifier);
    }

    list_t *new = create_node();
    new->id = strdup(identifier);
    new->type = type;
    new->next = NULL;
    current->next = new;

    // return original root pointer
    return list;
}

void visibility_check(list_t *list, char *identifier, id_type_t type)
{
    // fprintf(stdout, "segfault: for '%s' \n", "visibility_check");

    if (list == NULL)
    {
        fprintf(stderr, "Error: visibility check for identifier '%s' on empty list", identifier);
        exit(3);
    }

    list_t *current = list;

    while (current != NULL)
    {
        // if the identifier of given type is found check succeeds
        if (strcmp(current->id, identifier) == 0 && current->type == type)
        {
            return;
        }
        current = current->next;
    }

    fprintf(stderr, "Error: visibility check for identifier '%s' failed, identifier is not visible in this context", identifier);
    exit(3);
}
