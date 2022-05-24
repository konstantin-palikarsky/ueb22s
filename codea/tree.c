#include "tree.h"

tree_t *null_tree()
{
    return (tree_t *)NULL;
}

tree_t *new_tree(tree_t *left, tree_t *right, op_type_t operator, char * name, int par_index, long value)
{
    tree_t *new = (tree_t *)malloc(sizeof(tree_t));

    new->children[0] = left;
    new->children[1] = right;
    new->operator= operator;
    new->name = name;
    new->par_index = par_index;
    new->value = value;

    return new;
}

tree_t *node(op_type_t operator, tree_t * left, tree_t *right)
{
    return new_tree(left, right, operator,(char *) NULL, -1, -1);
}

tree_t *id_leaf(char *name, int par_index)
{
    return new_tree(null_tree(), null_tree(), OP_ID, name, par_index, -1);
}

tree_t *num_leaf(long value)
{
    return new_tree(null_tree(), null_tree(), OP_NUM, (char *)NULL, -1, value);
}
