#include <stdlib.h>

typedef struct burm_state *STATEPTR_TYPE;

typedef enum
{
    OP_RETURN = 0,
    OP_ARRAY_ACCESS,

    OP_ADD,
    OP_MUL,
    OP_AND,

    OP_GREATER,
    OP_EQUAL,

    OP_NOT,
    OP_MINUS,

    OP_NUM,
    OP_ID
} op_type_t;

typedef struct tree_t
{
    op_type_t operator;

    int par_index;
    char *name;
    long value;

    char *reg;

    struct tree_t *children[2];
    struct tree_t *parent;
    STATEPTR_TYPE state_label;

} tree_t;

/* macros for burg */
#define NODEPTR_TYPE tree_t *
#define OP_LABEL(p) ((p)->operator)
#define LEFT_CHILD(p) ((p)->children[0])
#define RIGHT_CHILD(p) ((p)->children[1])
#define STATE_LABEL(p) ((p)->state_label)
#define PANIC printf

/* Return a tree_t struct with given operator, left and right child */
tree_t *node(op_type_t operator, tree_t * left, tree_t *right);

/* Return a tree_t struct with the given name and par_index, and NULL children */
tree_t *id_leaf(char *name, int par_index);

/* Return a tree_t struct with the given value, and NULL children */
tree_t *num_leaf(long value);
